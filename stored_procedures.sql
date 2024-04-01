USE etaireia_aksiologisis;

DELIMITER $
DROP PROCEDURE IF EXISTS gradeCorrection$
CREATE PROCEDURE gradeCorrection(IN candidate_username VARCHAR(30))
BEGIN

DECLARE numLang INT;
DECLARE numProj INT;
DECLARE numBSc INT;
DECLARE numMSc INT;
DECLARE numPhD INT;

DECLARE corrected_grade INT;

DECLARE evaluator_1 VARCHAR(30);
DECLARE evaluator_2 VARCHAR(30);

DECLARE grade_1 INT;
DECLARE grade_2 INT;

SELECT COUNT(*) INTO numLang FROM languages
WHERE candidate_username=languages.candid;

SELECT COUNT(*) INTO numProj FROM project
WHERE candidate_username=project.candid;

SELECT COUNT(*) INTO numBSc FROM degree
INNER JOIN has_degree
ON degree.titlos=has_degree.degr_title
AND degree.idryma=has_degree.degr_idryma
WHERE candidate_username=has_degree.cand_usrname
AND degree.bathmida='BSc';

SELECT COUNT(*) INTO numMSc FROM degree
INNER JOIN has_degree
ON degree.titlos=has_degree.degr_title
AND degree.idryma=has_degree.degr_idryma
WHERE candidate_username=has_degree.cand_usrname
AND degree.bathmida='MSc';

SELECT COUNT(*) INTO numPhD FROM degree
INNER JOIN has_degree
ON degree.titlos=has_degree.degr_title
AND degree.idryma=has_degree.degr_idryma
WHERE candidate_username=has_degree.cand_usrname
AND degree.bathmida='PhD';

SET corrected_grade = numLang+numProj+numBSc+2*numMSc+3*numPhD;

SELECT evaluator1 INTO evaluator_1
FROM evaluation
WHERE evaluation.evaluated_user=candidate_username;

IF evaluator_1 IS NULL THEN
UPDATE evaluation
SET grade1 = corrected_grade
WHERE evaluation.evaluated_user=candidate_username;
END IF;

SELECT evaluator2 INTO evaluator_2
FROM evaluation
WHERE evaluation.evaluated_user=candidate_username;

IF evaluator_2 IS NULL THEN
UPDATE evaluation
SET grade2 = corrected_grade                                            
WHERE evaluation.evaluated_user=candidate_username;
END IF;

UPDATE evaluation
SET final_grade=(grade1+grade2)/2
WHERE evaluation.evaluated_user=candidate_username;

END$
DELIMITER ;

DELIMITER $
DROP PROCEDURE IF EXISTS positionEvaluation$
CREATE PROCEDURE positionEvaluation(IN ejob_id INT)
BEGIN
    DECLARE candidate_username VARCHAR(30);
    DECLARE evaluator_1 VARCHAR(30);
    DECLARE evaluator_2 VARCHAR(30);
    DECLARE finishedFlag INT;
    
    DECLARE gradeCorrectionCursor CURSOR FOR
    SELECT applies.cand_usrname FROM applies
    WHERE applies.job_id = ejob_id AND applies.state = 'active';
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET finishedFlag = 1;
    
    SET finishedFlag = 0;
    
    OPEN gradeCorrectionCursor;
    
    WHILE (finishedFlag) = 0 DO
    FETCH gradeCorrectionCursor INTO candidate_username;
    CALL gradeCorrection(candidate_username);
    END WHILE;
    
    CLOSE gradeCorrectionCursor;
    
    SELECT applies.cand_usrname, evaluation.evaluator1, evaluation.evaluator2
    INTO candidate_username, evaluator_1, evaluator_2
	FROM applies
	INNER JOIN evaluation ON applies.cand_usrname = evaluation.evaluated_user
	WHERE applies.job_id = ejob_id AND applies.state = 'active'
	ORDER BY evaluation.final_grade DESC, applies.application_date ASC
    LIMIT 1;
    
    DELETE FROM applies
	WHERE applies.cand_usrname = candidate_username AND applies.job_id = ejob_id;

IF EXISTS (SELECT * FROM applies WHERE state = 'canceled' AND cand_usrname = candidate_username
	    AND job_id = ejob_id) THEN 
	INSERT INTO application_log (e_username, e_evaluator1, e_evaluator2, positionID, a_state, finalGrade)
	SELECT candidate_username, evaluator_1, evaluator_2, ejob_id, 'completed', '0'
	FROM evaluation
	WHERE evaluation.evaluated_user = candidate_username;
	END IF;

    INSERT INTO application_log (e_username, e_evaluator1, e_evaluator2, positionID, a_state, finalGrade)
	SELECT candidate_username, evaluator_1, evaluator_2, ejob_id, 'completed', evaluation.final_grade
	FROM evaluation
	WHERE evaluation.evaluated_user = candidate_username;
    
    IF EXISTS (SELECT * FROM has_position WHERE jobid = ejob_id) THEN
    UPDATE has_position
	SET employee_username = candidate_username
	WHERE jobid = ejob_id;
    ELSE
    INSERT INTO has_position
    VALUES (candidate_username, ejob_id);
    END IF;
END$

DELIMITER ;



DELIMITER $
DROP PROCEDURE IF EXISTS generateRandomRecords$
CREATE PROCEDURE generateRandomRecords()
BEGIN
    DECLARE i INT;
    SET i = 0;

    WHILE i < 60001 DO
        INSERT INTO application_log
        VALUES (
            CONCAT('user_', i),
            CONCAT('evaluator1_', i),
            CONCAT('evaluator2_', i),
            i MOD 500 + 1,
            'completed', 
            (i MOD 20) + 1
        );
        SET i = i + 1;
    END WHILE;
END $
DELIMITER ;
#Edit->Preferences->SQL Editor (all the timers in MySQL session to be set to 3600)

DELIMITER $
CREATE INDEX idx_evaluator ON application_log(e_evaluator1, e_evaluator2)$

DROP PROCEDURE IF EXISTS searchByEval$
CREATE PROCEDURE searchByEval(IN eval_username VARCHAR(30))
BEGIN
SELECT e_username, positionID
FROM application_log
WHERE e_evaluator1=eval_username OR e_evaluator2=eval_username;
END$
DELIMITER ;

DELIMITER $
CREATE INDEX idx_empljob ON application_log(finalGrade)$

DROP PROCEDURE IF EXISTS searchByGradeRange$
CREATE PROCEDURE searchByGradeRange(IN low INT(11), IN high INT(11))
BEGIN
SELECT application_log.e_username, application_log.positionID, application_log.finalGrade 
FROM application_log 
WHERE application_log.finalGrade BETWEEN low AND high; 
END$
DELIMITER ;

DELIMITER $
DROP PROCEDURE IF EXISTS applicationManagement$
CREATE PROCEDURE applicationManagement (empl_usrname VARCHAR(30), jobId INT(11), identifier ENUM ('i', 'c', 'a'))
BEGIN 
DECLARE applDate DATE;
DECLARE eva1 VARCHAR(30);
DECLARE eva2 VARCHAR (30);
DECLARE empl VARCHAR(30);
DECLARE job INT(11);
DECLARE sameFirm CHAR(9);
 
SET applDate = CURDATE();
 
IF (identifier = 'i') THEN
 
    IF (NOT EXISTS(SELECT employee.username FROM employee WHERE employee.username=empl_usrname) OR NOT EXISTS (SELECT job.id FROM job WHERE job.id=jobId))
      THEN
      SIGNAL SQLSTATE '45000'
	  SET MESSAGE_TEXT = 'There is no such employee or job';
	END IF;
  SELECT evaluation.evaluator1 INTO eva1 FROM evaluation
  INNER JOIN employee ON evaluation.evaluated_user = employee.username 
  INNER JOIN applies ON employee.username = applies.cand_usrname
  WHERE evaluation.evaluated_user = empl_usrname AND applies.job_id = jobId;

  SELECT evaluation.evaluator2 INTO eva2 FROM evaluation 
  INNER JOIN employee ON evaluation.evaluated_user = employee.username 
  INNER JOIN applies ON applies.cand_usrname = employee.username
  WHERE evaluation.evaluated_user = empl_usrname AND applies.job_id = jobId;
  
    IF (eva1 IS NULL) THEN 
      SELECT evaluator.username INTO eva1 FROM evaluator 
      INNER JOIN job ON evaluator.username=job.evaluator
      INNER JOIN applies ON job.id=applies.job_id
      INNER JOIN employee ON applies.cand_usrname=employee.username
      WHERE employee.username = empl_usrname AND applies.job_id = jobId;
      UPDATE evaluation
      SET evaluation.evaluator1=eva1
      WHERE evaluation.evaluated_user=empl_usrname;
	END IF;
    
    IF(eva2 IS NULL) THEN
    
      SELECT evaluator.firm INTO sameFirm FROM evaluator
      INNER JOIN evaluation ON evaluator.username=evaluation.evaluator1
      WHERE evaluation.evaluator1 = eva1;
      
	  SELECT evaluator.username INTO eva2 FROM evaluator  
      WHERE evaluator.firm=sameFirm
      LIMIT 1;
      UPDATE evaluation
      SET evaluation.evaluator2=eva2
      WHERE evaluation.evaluated_user=empl_usrname;
	END IF;
      
      INSERT INTO applies VALUES (empl_usrname, jobId, applDate, 'active');

	
 ELSEIF (identifier = 'c') THEN 
    IF EXISTS ( SELECT * FROM applies WHERE empl_usrname = cand_usrname AND jobId = job_id) THEN
	  
      UPDATE applies
      SET applies.state = 'canceled'
      WHERE applies.cand_usrname = empl_usrname AND applies.job_id = jobId;
	  SIGNAL SQLSTATE '45000'
	  SET MESSAGE_TEXT = 'The application has been canceled';
	ELSE 
      SIGNAL SQLSTATE '45000'
	  SET MESSAGE_TEXT = 'There is not any application or the application has already been canceled';
	END IF;

 ELSEIF (identifier = 'a') THEN
    IF EXISTS ( SELECT * FROM applies WHERE applies.cand_usrname = empl_usrname  AND applies.job_id = jobId AND applies.state='canceled' ) THEN
	  UPDATE applies 
      SET applies.state = 'active'
      WHERE applies.cand_usrname = empl_usrname AND applies.job_id = jobId;
	  SIGNAL SQLSTATE '45000'
	  SET MESSAGE_TEXT = 'The application has been activated';
	ELSE 
	  SIGNAL SQLSTATE '45000'
	  SET MESSAGE_TEXT = 'There is not any application or the application has already been activated';	
	END IF;
    
END IF;
 
END$
DELIMITER ;

DELIMITER $
DROP PROCEDURE IF EXISTS checkIfEvaluated$
CREATE PROCEDURE checkIfEvaluated(IN eval_username VARCHAR(30), IN empl_username VARCHAR(30), IN job_id INT(11), OUT result INT(11))
BEGIN

DECLARE grade1 INT(11);
DECLARE grade2 INT(11);
DECLARE eval1 VARCHAR(11);
DECLARE eval2 VARCHAR(11);

IF NOT EXISTS(
SELECT evaluator.username, employee.username, job.id
FROM evaluator
INNER JOIN job ON evaluator.username=job.evaluator
INNER JOIN applies ON job.id=applies.job_id
INNER JOIN employee ON applies.cand_usrname=employee.username
WHERE evaluator.username=eval_username
AND employee.username=empl_username
AND job.id=job_id)
THEN
SET result=0;

ELSE


SELECT evaluator1 INTO eval1 FROM evaluation WHERE evaluator1 = eval_username;
IF (eval1 IS NOT NULL)
THEN
SELECT evaluation.grade1 INTO grade1
FROM evaluation
INNER JOIN employee ON evaluation.evaluated_user=employee.username
WHERE evaluation.evaluator1=eval_username
AND evaluation.evaluated_user=empl_username;
IF grade1 IS NOT NULL
THEN 
SET result=grade1;
ELSE
CALL gradeCorrection(empl_username);
END IF; 
END IF;

SELECT evaluator2 INTO eval2 FROM evaluation WHERE evaluator2 = eval_username;
IF (eval2 IS NOT NULL)
THEN
SELECT evaluation.grade2 INTO grade2
FROM evaluation
INNER JOIN employee ON evaluation.evaluated_user=employee.username
WHERE evaluation.evaluator2=eval_username
AND evaluation.evaluated_user=empl_username;
IF grade2 IS NOT NULL
THEN
SET result=grade2;
ELSE
CALL gradeCorrection(empl_username);
END IF; 
END IF;

END IF;
END$

DELIMITER ;


DELIMITER $
DROP PROCEDURE IF EXISTS checkPositionOccupied$
CREATE PROCEDURE checkPositionOccupied(IN job_id VARCHAR(30))
BEGIN
IF EXISTS(SELECT * FROM has_position WHERE jobid=job_id)
THEN
SELECT emp_username, jobid
FROM has_position
WHERE jobid=job_id;
ELSE
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'No evaluation has taken place for this job. Please call procedure positionEvaluation first';
END IF;
END$
DELIMITER ;
