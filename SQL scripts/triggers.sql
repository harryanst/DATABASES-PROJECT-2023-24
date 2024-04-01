USE etaireia_aksiologisis;

DELIMITER $
DROP TRIGGER IF EXISTS validateApplicationDate$
CREATE TRIGGER validateApplicationDate
AFTER INSERT ON applies
FOR EACH ROW
BEGIN
    DECLARE applicationDate DATE;
    DECLARE startDate DATE;
    DECLARE diff INT;

    SELECT job.start_date INTO startDate
    FROM job
    WHERE job.id = NEW.job_id;
    
    SELECT application_date INTO applicationDate
    FROM applies
    WHERE applies.application_date=NEW.application_date;

    SET diff = DATEDIFF(startDate, applicationDate);

    IF (diff<15) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Invalid application date! Must be at least 15 days before the start date of the job';
    END IF;
END$
DELIMITER ;

DELIMITER $
DROP TRIGGER IF EXISTS validateApplicationDateCancel$
CREATE TRIGGER validateApplicationDateCancel
BEFORE UPDATE ON applies
FOR EACH ROW
BEGIN
    DECLARE applicationDate DATE;
    DECLARE startDate DATE;
    DECLARE diff INT;

    SELECT start_date INTO startDate
    FROM job
    WHERE id = NEW.job_id;

    SELECT application_date INTO applicationDate
    FROM applies
    WHERE applies.application_date=NEW.application_date;

    SET diff = DATEDIFF(startDate, applicationDate);

    IF diff < 10 AND NEW.state='canceled' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Invalid application cancel! Must be within 10 days before the start date of the job';
    END IF;
END$
DELIMITER ;

DELIMITER $
DROP TRIGGER IF EXISTS validateApplicationInsert$
CREATE TRIGGER validateApplicationInsert
BEFORE INSERT ON applies
FOR EACH ROW
BEGIN
DECLARE numOfActive INT;
SELECT COUNT(*) INTO numOfActive
FROM applies
WHERE applies.cand_usrname=NEW.cand_usrname
AND state='active';
IF numOfActive>=3 THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'Invalid application. The employee already has at least 3 active applications';
END IF;
END$
DELIMITER ;

DELIMITER $
DROP TRIGGER IF EXISTS validateApplicationUpdate$
CREATE TRIGGER validateApplicationUpdate
BEFORE UPDATE ON applies
FOR EACH ROW
BEGIN
DECLARE numOfActive INT;
SELECT COUNT(*) INTO numOfActive
FROM applies
WHERE applies.cand_usrname=NEW.cand_usrname
AND state='active';
IF numOfActive>=3 THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'Invalid application. The employee already has at least 3 active applications';
END IF;
END$
DELIMITER ;

DELIMITER $
DROP TRIGGER IF EXISTS evaluationGrade$
CREATE TRIGGER evaluationGrade
BEFORE INSERT ON evaluation
FOR EACH ROW
BEGIN
    DECLARE Grade1 INT;
    DECLARE Grade2 INT;

    SELECT evaluation.grade1 INTO Grade1
    FROM evaluation
    WHERE evaluation.evaluated_user = NEW.evaluated_user;

    SELECT evaluation.grade2 INTO Grade2
    FROM evaluation
    WHERE evaluation.evaluated_user = NEW.evaluated_user;   

    IF (Grade1 < 1 OR Grade1 > 20) OR (Grade2 < 1 OR Grade2 > 20) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'The grade has to be between 1 and 20.';
    END IF;
END$
DELIMITER ;



DELIMITER $
DROP TRIGGER IF EXISTS application_logGrade$
CREATE TRIGGER application_logGrade
BEFORE INSERT ON application_log
FOR EACH ROW
BEGIN
    DECLARE Grade INT;

    SELECT application_log.finalGrade INTO Grade
    FROM application_log
    WHERE application_log.e_username = NEW.application_log.e_username;

   
    IF (Grade < 1 OR Grade > 20)  THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'The grade is not between 1 and 20.';
    END IF;
END$
DELIMITER ;


DELIMITER $
DROP TRIGGER IF EXISTS job_insert$
CREATE TRIGGER job_insert AFTER INSERT ON job
FOR EACH ROW 
BEGIN 
DECLARE job_id INT(11);
DECLARE current_datetime DATETIME;
DECLARE active_admin VARCHAR(30);
DECLARE event TEXT(256);
SELECT MAX(job.id) INTO job_id FROM job;
SET current_datetime = NOW();
SELECT active_admin.username INTO active_admin FROM active_admin LIMIT 1;
SET event = CONCAT('The job with id ', job_id, ' has just been inserted by the administrator ', active_admin);
INSERT INTO administrator_log VALUES (active_admin, current_datetime, event);
END$
DELIMITER;


DELIMITER $
DROP TRIGGER IF EXISTS job_delete$
CREATE TRIGGER job_delete BEFORE DELETE ON job
FOR EACH ROW 
BEGIN 
DECLARE job_id INT(11);
DECLARE current_datetime DATETIME ;
DECLARE active_admin VARCHAR(30);
DECLARE event TEXT(256);
SET current_datetime = NOW();
SELECT id INTO job_id FROM job
WHERE id = OLD.id;
SELECT active_admin.username INTO active_admin FROM active_admin LIMIT 1;
SET event = CONCAT('The job with id ', job_id, ' has just been deleted by the administrator ', active_admin);
INSERT INTO administrator_log VALUES (active_admin, current_datetime, event);
END$
DELIMITER;

DELIMITER $
DROP TRIGGER IF EXISTS job_update$
CREATE TRIGGER job_update BEFORE UPDATE ON job
FOR EACH ROW 
BEGIN 
DECLARE job_id INT(11);
DECLARE current_datetime DATETIME ;
DECLARE active_admin VARCHAR(30);
DECLARE event TEXT(256);
SELECT id INTO job_id FROM job
WHERE id = OLD.id;
SET current_datetime = NOW();
SELECT active_admin.username INTO active_admin FROM active_admin LIMIT 1;
SET event = CONCAT('The job with id ', job_id, ' has just been updated by the administrator ', active_admin);
INSERT INTO administrator_log VALUES (active_admin, current_datetime, event);
END$
DELIMITER;


DELIMITER $
DROP TRIGGER IF EXISTS degree_insert$
CREATE TRIGGER degree_insert AFTER INSERT ON degree
FOR EACH ROW 
BEGIN 
DECLARE d_titlos VARCHAR(150);
DECLARE d_idryma VARCHAR (140);
DECLARE active_admin VARCHAR(30);
DECLARE event TEXT(256);
SELECT titlos, idryma INTO d_titlos, d_idryma FROM degree
WHERE titlos = NEW.titlos AND idryma = NEW.idryma;
SELECT active_admin.username INTO active_admin FROM active_admin LIMIT 1;
SET event = CONCAT('The degree with title ', d_titlos, 'and idryma ', d_idryma, ' has just been inserted by the administrator ', active_admin);
INSERT INTO administrator_log VALUES (active_admin, NOW(), event);
END$
DELIMITER;

DELIMITER $
DROP TRIGGER IF EXISTS degree_update$
CREATE TRIGGER degree_update BEFORE UPDATE ON degree
FOR EACH ROW 
BEGIN 
DECLARE d_titlos VARCHAR(150);
DECLARE d_idryma VARCHAR (140);
DECLARE active_admin VARCHAR(30);
DECLARE event TEXT(256);
SELECT titlos, idryma INTO d_titlos, d_idryma FROM degree
WHERE titlos = OLD.titlos AND idryma = OLD.idryma;
SELECT active_admin.username INTO active_admin FROM active_admin LIMIT 1;
SET event = CONCAT('The degree with title ', d_titlos, 'and idryma ', d_idryma, ' has just been updated by the administrator ', active_admin);
INSERT INTO administrator_log VALUES (active_admin, NOW(), event);
END$
DELIMITER;

DELIMITER $
DROP TRIGGER IF EXISTS degree_delete$
CREATE TRIGGER degree_delete BEFORE DELETE ON degree
FOR EACH ROW 
BEGIN 
DECLARE d_titlos VARCHAR(150);
DECLARE d_idryma VARCHAR (140);
DECLARE active_admin VARCHAR(30);
DECLARE event TEXT(256);
SELECT titlos, idryma INTO d_titlos, d_idryma FROM degree
WHERE titlos = OLD.titlos AND idryma = OLD.idryma;
SELECT active_admin.username INTO active_admin FROM active_admin LIMIT 1;
SET event = CONCAT('The degree with title ', d_titlos, 'and idryma ', d_idryma, ' has just been deleted by the administrator ', active_admin);
INSERT INTO administrator_log VALUES (active_admin, NOW(), event);
END$
DELIMITER;

DELIMITER $
DROP TRIGGER IF EXISTS user_insert$
CREATE TRIGGER user_insert AFTER INSERT ON user 
FOR EACH ROW 
BEGIN 
DECLARE t_username VARCHAR(30);
DECLARE active_admin VARCHAR(30);
DECLARE event TEXT(256);
SELECT username INTO t_username FROM user
WHERE username = NEW.username;
SELECT active_admin.username INTO active_admin FROM active_admin LIMIT 1;
SET event = CONCAT('The user with username ', t_username, ' has just been inserted by the administrator ', active_admin);
INSERT INTO administrator_log VALUES (active_admin, NOW(), event);
END$
DELIMITER;

DELIMITER $
DROP TRIGGER IF EXISTS user_update$
CREATE TRIGGER user_update BEFORE UPDATE ON user 
FOR EACH ROW 
BEGIN 
DECLARE t_username VARCHAR(30);
DECLARE active_admin VARCHAR(30);
DECLARE event TEXT(256);
SELECT username INTO t_username FROM user
WHERE username = OLD.username;
SELECT active_admin.username INTO active_admin FROM active_admin LIMIT 1;
SET event = CONCAT('The user with username ', t_username, ' has just been updated by the administrator ', active_admin);
INSERT INTO administrator_log VALUES (active_admin, NOW(), event);
END$
DELIMITER;

DELIMITER $
DROP TRIGGER IF EXISTS user_delete$
CREATE TRIGGER user_delete BEFORE DELETE ON user 
FOR EACH ROW 
BEGIN
DECLARE t_username VARCHAR(30);
DECLARE active_admin VARCHAR(30);
DECLARE event TEXT(256);
SELECT username INTO t_username FROM user
WHERE username = OLD.username;
SELECT active_admin.username INTO active_admin FROM active_admin LIMIT 1; 
SET event = CONCAT('The user with username ', t_username, ' has just been deleted by the administrator ', active_admin);
INSERT INTO administrator_log VALUES (active_admin, NOW(), event);
END$
DELIMITER ;
