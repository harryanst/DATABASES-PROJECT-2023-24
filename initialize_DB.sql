USE etaireia_aksiologisis;

DELIMITER $

DROP TRIGGER IF EXISTS autoIncrementProject$

CREATE TRIGGER autoIncrementProject
BEFORE INSERT ON project
FOR EACH ROW
BEGIN
    DECLARE pnum TINYINT(4);
    SELECT MAX(num) INTO pnum
    FROM project
    WHERE candid = NEW.candid;
    
    IF pnum IS NULL THEN
        SET pnum = 0;
    END IF;

    SET NEW.num = pnum + 1;
END$

DELIMITER ;

INSERT INTO etaireia (AFM, DOY, name, tel, street, num, city, country)
VALUES
('111234798', 'ATHENS', 'Zerocom', '2102625215', '	Androutsou', 13, 'Athens', 'Greece'),
('234987234', 'PATRAS', 'Interday', '2610102343', 'Karaiskaki', 90, 'Patras', 'Greece'),
('890345879', 'KALAMATA', 'Tranzitzone', '2763098765', 'Eleftherias', 101, 'Kalamata', 'Greece'),
('784512369', 'PATRAS', 'ConnectWave Communications', '2610123456', 'Androutsou', 58, 'Patras', 'Greece'),
('630974182', 'THEBES', 'SwiftLink TeleSystems', '2262032550', 'Amfionos', 15, 'Thebes', 'Greece'),
('215689347', 'THESSALONIKI', 'NexusNet Telecom Technologies', '2310123456', 'Egnatia', 88, 'Thessaloniki', 'Greece'),
('10AM56789', 'ATHENS', 'PEPSI', '2102516782', 'Ermou', 7, 'Athens', 'Greece'),
('10AM62718', 'PATRAS', 'NIKE', '2610827165', 'Ermou', 27, 'Patras', 'Greece'),
('10AM32176', 'KOZANI', 'ADIDAS', '2461022516', 'Nikolaou', 17, 'Kozani', 'Greece');

INSERT INTO user (username, password, name, lastname, reg_date, email)
VALUES
('maria123', 'sidufhnjsdf', 'Maria', 'Alexopoulou', '2023-01-15 08:30:00', 'maria123@gmail.com'),
('giorgospet', '93hg98grh', 'Giorgos', 'Petropoulos', '2023-02-20 10:45:00', 'georgepetropoulos@gmail.com'),
('mark_ion', '3908ifdjfh', 'Markos', 'Ioannou', '2023-03-25 12:15:00', 'mark.j@gmail.com'),
('sara84', '1234567890', 'Sara', 'Andreou', '2023-04-30 14:00:00', 'sara.999@gmail.com'),
('peter_wilson', 'lolokoko', 'Peter', 'Wilson', '2023-05-05 16:20:00', 'peterwil@gmail.com'),
('egwdean', '0irfje9rifj', 'Kostas', 'Anastasopoulos', '2023-06-10 18:00:00', 'egwegw@gmail.com'),
('anastasis9090', 'lmlmlma88yu', 'Anastasis', 'Kyriakopoulos', '2023-07-15 20:30:00', 'anast.kyre@gmail.com'),
('tzinaaa', 'foegoeirjg', 'Tzina', 'Lykourgou', '2023-08-20 22:45:00', 'tzinlyk@gmail.com'),
('michalis123', 'aa890890', 'Michalis', 'Mpikos', '2023-09-25 00:15:00', 'michalis123@gmail.com'),
('nicnic', 'aaaaakokokok', 'Nicole', 'Aslanidi', '2023-10-30 02:00:00', 'nicoleaslanidi@gmail.com'),
('manos1978', 'p9ifrje9ruifj', 'Manos', 'Asioglou', '2023-11-05 04:20:00', 'manos123@gmail.com'),
('emma_ross', 'woeidjweoidjioej', 'Emma', 'Ross', '2023-12-10 06:00:00', 'emma.ross@gmail.com'),
('emily_johnson84', 'duyfgwuef78', 'Emily', 'Johnson', '2023-03-13 14:00:00', 'emily_johnson84@gmail.com'),
('alex_smithson22', 'hduwdh6786', 'Alex', 'Smithson', '2023-04-26 18:45:00', 'alexsmithson@gmail.com'),
('olivia_brown92', '3748jdscsj', 'Olivia', 'Brown', '2023-05-01 15:35:00', 'oliviabrown@gmail.com'),
('jack_robinson77', '556783420', 'Jack', 'Robinson', '2023-07-28 19:31:00', 'jackrobinson@gmail.com'),
('chloe_davis89', 'grinder567', 'Chloe', 'Davis', '2023-07-05 09:20:00', 'chloedav@gmail.com'),
('ethan_miller64', 'isyoboy3434', 'Ethan', 'Miller', '2023-06-19 11:26:00', 'ethanmiller@gmail.com'),
('lily_wilson78', 'grgerg454', 'Lily', 'Wilson', '2023-07-05 21:13:00', 'lily_wilson@gmail.com'),
('noah_thompson55', 'fgeft4t545', 'Noah', 'Thompson', '2023-07-04 19:45:00', 'noah_thompson@gmail.com'),
('ava_harrison86', 'aaoiokjin458', 'Ava', 'Harrison', '2023-08-16 14:15:00', 'ava_harrison@gmail.com'),
('james_mitchell71', 'isoiswni798', 'James', 'Mitchell', '2023-09-28 01:00:00', 'james_mitchell@gmail.com'),
('sophia_baker79', 'osideienkscn90', 'Sophia', 'Baker', '2023-10-01 03:43:00', 'sophia_baker@gmail.com'),
('daniel_parker88', 'weywureosxcn870', 'Daniel', 'Parker', '2023-10-15 09:00:00', 'daniel_parker@gmail.com'),
('user1','gsjhahgsa','Giorgos','Papadopoulos','2023-12-30 07:27:00','us1@email.com'),
('user2','gsjhaadqw','Kostas','Papadopoulos','2023-09-27 09:29:00','us2@email.com'),
('user3','gswwwgsa','Roula','Gogka','2023-04-21 11:17:00','us3@email.com'),
('user4','yauagdahgsa','Maki','Toge','2023-03-30 13:02:00','us4@email.com'),
('user5','QAWJSgsa','Itadori','Yugi','2022-11-08 20:20:00','us5@email.com'),
('user6','gshagshhgsa','Gojo','Satoru','2023-12-28 14:21:00','us6@email.com'),
('user7','hahahhgsa','Mei','Zenin','2022-09-30 11:27:00','us7@email.com'),
('user8','hahahsaahgsa','Foivos','Delivorias','2023-01-01 01:27:00','us8@email.com'),
('user9','gsjhhjjaaGG','Despoina','Vndi','2023-09-02 11:30:00','us9@email.com'),
('user10','1999wwzz','Lionel','Messi','2023-07-29 08:13:00','us10@email.com'),
('user11','goat10hgsa','Cristiano','Ronaldo','2022-11-27 17:27:00','us11@email.com'),
('user12','netflix2121','Nina','Simone','2023-12-11 07:27:00','us12@email.com');

INSERT INTO evaluator (username, exp_years, firm)
VALUES
('maria123', 5, '111234798'),
('giorgospet', 3, '234987234'),
('mark_ion', 8, '890345879'),
('sara84', 6, '111234798'),
('peter_wilson', 4, '234987234'),
('egwdean', 7, '890345879'),
('emily_johnson84', 4, '784512369'),
('alex_smithson22', 2, '630974182'),
('olivia_brown92', 5, '215689347'),
('jack_robinson77', 9, '784512369'),
('chloe_davis89', 3, '630974182'),
('ethan_miller64', 4, '215689347'),
('user1', 3, '10AM56789'),
('user2', 7, '10AM56789'),
('user3', 2, '10AM62718'),
('user4', 8, '10AM62718'),
('user5', 5, '10AM32176'),
('user6', 9, '10AM32176');

INSERT INTO employee (username, bio, sistatikes, certificates)
VALUES
('anastasis9090', 'Experienced software engineer with a focus on web development.', 'Web development', 'Bachelor of Computer Science'),
('tzinaaa', 'Passionate about data analysis and machine learning.', 'Data analysis, Machine learning', 'Master of Data Science'),
('michalis123', 'Results-driven project manager with a proven track record.', 'Project management', 'Master of Business Administration'),
('nicnic', 'Creative graphic designer with expertise in branding.', 'Graphic design, Branding', 'Bachelor of Fine Arts'),
('manos1978', 'Skilled network administrator with a strong IT background.', 'Network administration', 'Bachelor of Information Technology'),
('emma_ross', 'Dynamic marketing specialist with experience in digital campaigns.', 'Digital marketing', 'Bachelor of Marketing'),
('lily_wilson78', 'A proficient network engineer adept at navigating the intricate tapestry of connectivity. Dedicated to optimizing network efficiency and resolving complexities.', 'Network Engineering', 'Bachelor of Computer Science'),
('noah_thompson55', 'An astute data analyst adept at deciphering vast datasets to extract pivotal insights shaping the telecommunications landscape. Proficient in data analytics.', 'Data analysis', 'Master of Data Science'),
('ava_harrison86', 'A dedicated customer support specialist adept at bridging the technical intricacies of telecommunications with user-friendly assistance.', 'Customer Relationship Management', 'Bachelor of Business Administration'),
('james_mitchell71', 'An unwavering cybersecurity specialist dedicated to fortifying digital landscapes against evolving threats.', 'Master of Network Security', 'Bachelor of Computer Science'),
('sophia_baker79', 'A seasoned telecommunications engineer adept at architecting robust and scalable network infrastructures.', 'Telecommunications Engineering', 'Bachelor of Telecommunications'),
('daniel_parker88', 'A forward-thinking technology strategist specializing in telecommunications. Proficient in devising strategic roadmaps that align with organizational goals.', 'Bachelor of Technology', 'Digital marketing'),
('user7', 'this is text', 'sistatiki1', 'BSc Physics'),
('user8', 'this is text', 'sistatiki2', 'BSc Mathematics'),
('user9', 'this is text', 'sistatiki3', 'BSc Data Analysis'),
('user10', 'this is text', 'sistatiki4', 'MSc Physics'),
('user11', 'this is text', 'sistatiki5', 'BSc Computer Science'),
('user12', 'this is text', 'sistatiki6', 'PhD Computer Architecture');

INSERT INTO languages (candid, lang)
VALUES
('anastasis9090', 'EN'),
('anastasis9090', 'FR'),
('tzinaaa', 'FR'),
('michalis123', 'SP'),
('lily_wilson78', 'EN'),
('james_mitchell71', 'FR'),
('james_mitchell71', 'SP'),
('daniel_parker88', 'GE'),
('user8', 'EN'),
('user12', 'FR'),
('user9', 'SP'),
('user7', 'EN');


INSERT INTO project (candid, num, descr, url)
VALUES
('anastasis9090', 0, 'E-commerce Website', 'https://www.ecomweb123.com'),
('tzinaaa', 0, 'Blog Platform', 'https://www.bigblog1.com'),
('michalis123', 0, 'Data Analysis Tool', 'https://www.dataanalysisnow.com'),
('manos1978', 0, 'Project Management System', 'https://www.proj.man.com'),
('tzinaaa', 0, 'Brand Identity Redesign', 'https://www.edegign.name.com'),
('emma_ross', 0, 'Network Infrastructure Upgrade', 'https://www.infranet12.com'),
('anastasis9090', 0, 'Digital Marketing Campaign', 'https://www.marketing123.com'),
('lily_wilson78', 0, 'OptiLink: Enhancing Network Efficiency and Scalability', 'https://www.optilink.com'),
('noah_thompson55', 0, 'DataSift: Unraveling Insights to Shape Telecom Trends', 'https://www.datasift.com'),
('ava_harrison86', 0, 'ClientConnect: Elevating Customer Interaction Experience', 'https://www.clientconnect.com'),
('james_mitchell71', 0, 'CyberShield: Fortifying Telecom Networks Against Threats', 'https://www.cybershield.com'),
('sophia_baker79', 0, 'NetArchitect: Designing Resilient Network Infrastructures', 'https://www.infranet.com'),
('daniel_parker88', 0, 'TechVista: Charting Future Telecom Strategies', 'https://www.telstrategist.com'),
('lily_wilson78', 0, 'DataFlow Nexus: Optimizing Network Bandwidth and Stability', 'https://www.dataflownexus.com'),
('user7', 0, '2s Numbers Multiplier', 'https://www.arduino/toge.com'),
('user8', 0, '2s Numbers Adder', 'https://www.arduino/egot.com'),
('user9', 0, 'DFA to NFA', 'https://www.doityourselfNfaDfa.com'),
('user10', 0, 'CSV reader', 'https://www.CsvREAD/toge.com'),
('user11', 0, 'Sound Redesign', 'https://www.flstudio/toge.com'),
('user12', 0, 'CAD simulator', 'https://www.VerilogLover/toge.com');

INSERT INTO job (id, start_date, salary, position, edra, evaluator, announce_date, submission_date)
VALUES
(NULL, '2023-01-15', 80000, 'Software Engineer', 'Metropolis', 'maria123', '2023-01-01 08:30:00', '2023-01-31'),
(NULL, '2023-02-20', 90000, 'Data Analyst', 'Cityville', 'maria123', '2023-02-01 10:45:00', '2023-02-28'),
(NULL, '2023-03-25', 100000, 'Project Manager', 'Innovation City', 'giorgospet', '2023-03-01 12:15:00', '2023-03-31'),
(NULL, '2023-04-30', 75000, 'Graphic Designer', 'Techland', 'giorgospet', '2023-04-01 14:00:00', '2023-04-30'),
(NULL, '2023-05-15', 85000, 'Network Administrator', 'Global City', 'peter_wilson', '2023-05-01 16:20:00', '2023-05-31'),
(NULL, '2023-06-20', 95000, 'Marketing Specialist', 'Data City', 'mark_ion', '2023-06-01 18:00:00', '2023-06-30'),
(NULL, '2023-07-25', 90000, 'Software Developer', 'Inno Lane', 'sara84', '2023-07-01 20:30:00', '2023-07-31'),
(NULL, '2023-08-30', 110000, 'IT Manager', 'Globe Avenue', 'egwdean', '2023-08-01 22:45:00', '2023-08-31'),
(NULL, '2023-01-10', 100000, 'Senior Network Engineer', 'Silicon Valley', 'emily_johnson84', '2023-01-01 08:30:00', '2023-01-31'),
(NULL, '2023-02-10', 70000, 'Data Analyst', 'London', 'emily_johnson84', '2023-02-01 10:45:00', '2023-02-28'),
(NULL, '2023-03-15', 60000, 'Customer Support Manager', 'Singapore', 'alex_smithson22', '2023-03-01 12:15:00', '2023-03-31'),
(NULL, '2023-04-15', 75000, 'Project Manager', 'Dubai', 'alex_smithson22', '2023-04-01 14:00:00', '2023-04-30'),
(NULL, '2023-05-20', 90000, 'Telecommunications Systems Architect', 'Tokyo', 'olivia_brown92', '2023-05-01 16:20:00', '2023-05-31'),
(NULL, '2023-06-20', 70000, 'Security Analyst', 'Tokyo', 'jack_robinson77', '2023-06-01 18:00:00', '2023-06-30'),
(NULL, '2023-07-25', 80000, 'Technology Strategist', 'Sydney', 'chloe_davis89', '2023-07-01 20:30:00', '2023-07-31'),
(NULL, '2023-08-30', 110000, 'Software Engineer', 'Toronto', 'ethan_miller64', '2023-08-01 22:45:00', '2023-08-31'),
(NULL, '2023-02-17', 70000, 'Sound Designer', 'Oakland', 'user1', '2023-08-02 09:30:00', '2023-11-20'),
(NULL, '2023-03-17', 90000, 'Sofware Engineer', 'Windows', 'user2', '2023-09-02 10:30:00', '2023-11-21'),
(NULL, '2023-02-21', 70500, 'Designer', 'Oakland', 'user3', '2023-10-02 09:40:00', '2023-01-20'),
(NULL, '2023-11-17', 170000, 'Tester', 'New Transistors', 'user4', '2023-10-02 09:30:00', '2023-11-20'),
(NULL, '2023-02-17', 100000, 'Data Analyst', 'Analyst', 'user5', '2023-08-02 09:30:00', '2023-09-20'),
(NULL, '2023-02-17', 75000, 'Sound Designer', 'Oakland', 'user6', '2023-08-02 19:30:00', '2023-03-20');

INSERT INTO applies (cand_usrname, job_id, application_date)
VALUES
('anastasis9090', 1, '2023-01-05'),
('tzinaaa', 2, '2023-02-15'),
('michalis123', 3, '2023-03-25'),
('nicnic', 4, '2023-04-10'),
('manos1978', 5, '2023-05-12'),
('emma_ross', 6, '2023-06-20'),
('lily_wilson78', 1, '2023-07-02'),
('noah_thompson55', 2, '2023-08-18'),
('ava_harrison86', 3, '2023-09-05'),
('james_mitchell71', 4, '2023-10-14'),
('sophia_baker79', 5, '2023-11-22'),
('daniel_parker88', 6, '2023-12-01'),
('user7', 1, '2023-01-27'),
('user8', 2, '2023-02-08'),
('user9', 3, '2023-03-11'),
('user10', 4, '2023-04-30'),
('user11', 5, '2023-05-19'),
('user12', 6, '2023-06-07');

INSERT INTO degree (titlos, idryma, bathmida)
VALUES
('Bachelor of Computer Engineering', 'University of Patras', 'BSc'),
('Master of Data Science', 'University of Peloponesse', 'MSc'),
('Master of Business Administration', 'University of Patras', 'MSc'),
('Bachelor of Fine Arts', 'Aristotle University of Thessaloniki', 'BSc'),
('Bachelor of Information Technology', 'University of Patras', 'BSc'),
('Bachelor of Marketing', 'University of Pireaus', 'PhD'),
('Bachelor of Computer Science', 'University of Patras', 'BSc'),
('Master of Data Science', 'University of Patras', 'MSc'),
('Bachelor of Business Administration', 'University of Thessaloniki', 'BSc'),
('Master of Network Security', 'Aristotle University of Thessaloniki', 'MSc'),
('Bachelor of Telecommunications Engineering', 'University of Piraeus', 'BSc'),
('Bachelor of Technology Innovation and Strategy', 'Kapodistrian University of Athens', 'BSc'),
('Bachelor of Physics', 'Harvard University', 'BSc'),
('Bachelor of Mathematics', 'Oxford University', 'BSc'),
('Master of Computer Engineering', 'University of Patras', 'MSc'),
('Bachelor of Physics', 'Warwick University', 'BSc'),
('Bachelor of Computer Science', 'Athens University', 'BSc'),
('PhD of Computer Architecture', 'Harvard University', 'PhD');

INSERT INTO has_degree (degr_title, degr_idryma, cand_usrname, etos, grade)
VALUES
('Bachelor of Computer Science', 'University of Patras', 'anastasis9090', 2019, 5.5),
('Master of Data Science', 'University of Peloponesse', 'tzinaaa', 2021, 9.0),
('Master of Business Administration', 'University of Patras', 'michalis123', 2020, 7.5),
('Bachelor of Fine Arts', 'Aristotle University of Thessaloniki', 'emma_ross', 2018, 6.5),
('Bachelor of Computer Science', 'University of Patras', 'lily_wilson78', 2020, 8),
('Master of Data Science', 'University of Patras', 'noah_thompson55', 2021, 7),
('Bachelor of Business Administration', 'University of Thessaloniki', 'ava_harrison86', 2019, 8.5),
('Master of Network Security', 'Aristotle University of Thessaloniki', 'james_mitchell71', 2017, 6.5),
('Bachelor of Physics', 'Harvard University', 'user7', 2020, 8.5),
('Bachelor of Mathematics', 'Oxford University', 'user8', 2018, 7),
('Master of Computer Engineering', 'University of Patras', 'user9', 2020, 7.5),
('PhD of Computer Architecture', 'Harvard University', 'user12', 2017, 9);

INSERT INTO subject (title, descr, belongs_to)
VALUES
('Programming Fundamentals', 'Introduction to programming concepts and problem-solving.', NULL),
('Data Analysis', 'Exploratory data analysis and statistical techniques.', NULL),
('Project Management', 'Principles and practices of project management.', NULL),
('Graphic Design Principles', 'Fundamental principles of graphic design.', NULL),
('Computer Networks', 'Fundamentals of computer networking.', 'Programming Fundamentals'),
('Digital Marketing Strategies', 'Strategies for effective digital marketing campaigns.', 'Programming Fundamentals'),
('Advanced Data Structures', 'In-depth study of advanced data structures.', 'Data Analysis'),
('Business Analytics', 'Application of statistical analysis to business data for decision-making.', 'Data Analysis'),
('Advanced Algorithms', 'Exploring complex algorithms and advanced data structures used in optimizing computational processes and problem-solving.', NULL),
('Machine Learning', 'Investigating the principles and applications of machine learning and AI techniques in developing intelligent systems and algorithms.', NULL),
('Network Security', 'Understanding cryptographic principles and network security protocols to protect information and ensure secure communication over networks.', NULL),
('Wireless Networking', 'Studying wireless communication technologies and protocols alongside mobile networking architectures and their applications in modern communication systems.', NULL),
('Ethical Hacking', 'Exploring the methods and tools used by ethical hackers to identify vulnerabilities and conduct penetration tests to secure networks and systems.', NULL),
('Incident Response', 'Investigating procedures for incident handling, digital evidence collection, and forensic analysis to respond effectively to cybersecurity incidents.', NULL),
('Digital Marketing', 'Analyzing digital marketing strategies, tools, and analytics methods to optimize campaigns and drive effective online marketing initiatives.', NULL),
('Vulnerability Assessment', 'Assessing vulnerabilities in systems, networks, and applications while managing and mitigating risks associated with potential security threats.', 'Ethical Hacking'),
('Micro Electronics', 'Introduction to the study and manufacture of very small electronic designs and components', NULL),
('Linear Algebra', 'Introduction to vector spaces and linear transformations', NULL),
('Computer Architecture', 'Hardware', NULL),
('Logic Design', 'Basic organization of the circuitry of a digital computer', 'Computer Architecture'),
('Signal and Systems', 'Basic description of signals and systems', NULL),
('Matrices', 'Basic tool of Linear Algebra', 'Linear Algebra'),
('Programming', 'Basic analysis of higher level languages', NULL),
('C Programming', 'C higher level language', 'Programming');

INSERT INTO requires (job_id, subject_title)
VALUES
(1, 'Programming Fundamentals'),
(2, 'Data Analysis'),
(3, 'Project Management'),
(4, 'Graphic Design Principles'),
(5, 'Computer Networks'),
(6, 'Digital Marketing Strategies'),
(7, 'Advanced Data Structures'),
(8, 'Business Analytics'),
(1, 'Advanced Algorithms'),
(2, 'Machine Learning'),
(3, 'Network Security'),
(4, 'Wireless Networking'),
(5, 'Ethical Hacking'),
(6, 'Incident Response'),
(7, 'Digital Marketing'),
(8, 'Vulnerability Assessment'),
(1, 'Micro Electronics'),
(2, 'Linear Algebra'),
(3, 'Computer Architecture'),
(4, 'Logic Design'),
(5, 'Signal and Systems'),
(6, 'Matrices'),
(7, 'Programming'),
(8, 'C Programming');

INSERT INTO evaluation (evaluator1, evaluator2, evaluated_user, grade1, grade2)
VALUES
('maria123', 'giorgospet', 'anastasis9090', 15, 8),
('mark_ion', NULL, 'tzinaaa', 18, 1),
('sara84', 'peter_wilson', 'michalis123', 12, 16),
('egwdean', NULL, 'nicnic', 10, 1),
('emily_johnson84', 'alex_smithson22', 'manos1978', 14, 5),
('olivia_brown92', NULL, 'emma_ross', 17, 1),
('user1', NULL, 'lily_wilson78', 8, 19),
('user2', NULL, 'noah_thompson55', 13, 1),
('jack_robinson77', 'chloe_davis89', 'ava_harrison86', 20, 2),
('ethan_miller64', NULL, 'james_mitchell71', 16, 1),
('user3', NULL, 'sophia_baker79', 9, 14),
('user4', NULL, 'daniel_parker88', 11, 1),
('user5', 'maria123', 'user7', 7, 18),
('user6', NULL, 'user8', 1, 1),
('user1', 'mark_ion', 'user9', 6, 20),
('user2', NULL, 'user10', 1, 1),
('user3', 'sara84', 'user11', 5, 11),
(NULL, NULL, 'user12', 1, 1);

INSERT INTO user (username, password, name, lastname, reg_date, email)
VALUES
('jimmynew', 'wifundsc', 'Dimitris', 'Andreou', '2023-01-15 10:20:00', 'jimmynew@gmail.com'),
('maria9090', '93ofveijfnv', 'Maria', 'Alexiou', '2023-02-20 10:45:00', 'maria9090@gmail.com');

INSERT INTO administrator (admin_name, start_date, end_date)
VALUES
('jimmynew', '2023-01-15', NULL),
('maria9090', '2023-02-20', '2023-10-20');

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
CALL generateRandomRecords();
