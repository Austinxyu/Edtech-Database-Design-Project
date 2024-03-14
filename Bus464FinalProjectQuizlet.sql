drop schema if exists quizlet;
create schema quizlet;
use quizlet;

-- User Table
CREATE TABLE User (
    UserID INT PRIMARY KEY,
    Username VARCHAR(255),
    Email VARCHAR(255),
    Pass VARCHAR(255),
    MonthsSinceActive INT
    -- Add other columns as needed
);

-- Login Times table
CREATE TABLE LoginTimes (
    UserID INT,
    HourTime INT,
    Datenum DATE,
    DayofWeek INT,
    MinutesSpent INT,
    PRIMARY KEY (UserID, HourTime, Datenum),
    FOREIGN KEY (UserID) REFERENCES User(UserID)
    -- Add other columns as needed
);

-- Subject Table (Subjects data from Harvard/Mit Online course offerings)
CREATE TABLE SubjectType (
    TypeName varchar(255) PRIMARY KEY,
    Popularity INT
    -- Add other columns as needed
);

-- Flashcard Set Table
CREATE TABLE FlashcardSet (
    Flashcard_Set_ID INT PRIMARY KEY,
    Title VARCHAR(255),
    CreatedBy INT,
    SubjectName VARCHAR(255),
    FOREIGN KEY (SubjectName) REFERENCES SubjectType(TypeName), 
    FOREIGN KEY (CreatedBy) REFERENCES User(UserID)
    -- Add other columns as needed
);

-- Flashcard History Table
CREATE TABLE FlashcardHistory (
    UserID INT,
    DateAccessed DATE,
    Flashcard_Set_ID INT,
    PRIMARY KEY (UserID, DateAccessed, Flashcard_Set_ID),
    FOREIGN KEY (UserID) REFERENCES User(UserID),
    FOREIGN KEY (Flashcard_Set_ID) REFERENCES FlashcardSet(Flashcard_Set_ID)
    -- Add other columns as needed
);

-- User Preferences Table
CREATE TABLE UserPreferences (
    UserID INT,
    SubjectName VARCHAR(255),
    Date_Modified TIMESTAMP,
    PRIMARY KEY (UserID, SubjectName),
    FOREIGN KEY (UserID) REFERENCES User(UserID),
    FOREIGN KEY (SubjectName) REFERENCES SubjectType(TypeName)
    -- Add other columns as needed
);



-- Flashcard Table
CREATE TABLE Flashcard (
    Title VARCHAR(255),
    Flashcard_Set_ID INT,
    Content TEXT,
    PRIMARY KEY (Title, Flashcard_Set_ID),
    FOREIGN KEY (Flashcard_Set_ID) REFERENCES FlashcardSet(Flashcard_Set_ID)
    -- Add other columns as needed
);

-- AI Generated Flashcard Set Table
CREATE TABLE AIGeneratedFlashcardSet (
    Flashcard_Set_ID INT PRIMARY KEY,
    DateCreated DATE,
    FOREIGN KEY (Flashcard_Set_ID) REFERENCES FlashcardSet(Flashcard_Set_ID)
    -- Add other columns as needed
);

-- AI Generated Set Mapping Table
CREATE TABLE AIGeneratedSetMapping (
    Generated_Set_ID INT,
    Original_Set_ID INT,
    PRIMARY KEY (Generated_Set_ID, Original_Set_ID),
    FOREIGN KEY (Generated_Set_ID) REFERENCES AIGeneratedFlashcardSet(Flashcard_Set_ID),
    FOREIGN KEY (Original_Set_ID) REFERENCES FlashcardSet(Flashcard_Set_ID)
    -- Add other columns as needed
);

-- Quiz Table
CREATE TABLE Quiz (
    QuizID INT PRIMARY KEY,
    SubjectName VARCHAR(255),
    FOREIGN KEY (SubjectName) REFERENCES SubjectType(TypeName)
    -- Add other columns as needed
);

CREATE TABLE AIGeneratedQuiz (
    Flashcard_Set_ID INT PRIMARY KEY,
    UserID INT,
    QuizID Int,
    DateCreated DATE,
    -- FOREIGN KEY (Flashcard_Set_ID) REFERENCES FlashcardSet(Flashcard_Set_ID)
    FOREIGN KEY (Flashcard_Set_ID) REFERENCES FlashcardSet(Flashcard_Set_ID),
    FOREIGN KEY (QuizID) REFERENCES Quiz(QuizID),
    FOREIGN KEY (UserID) REFERENCES User(UserID)
    -- Add other columns as needed
);

-- Quiz Session Table
CREATE TABLE QuizSession (
    SessionID INT PRIMARY KEY,
    QuizID INT,
    Difficulty VARCHAR(50),
    IsCompleted bool,
    MinutesSpent INT,
    SubjectName VARCHAR(255),
    Datenum DATE,
    FOREIGN KEY (QuizID) REFERENCES Quiz(QuizID),
    FOREIGN KEY (SubjectName) REFERENCES SubjectType(TypeName)
    -- Add other columns as needed
);

-- Quiz History Table
CREATE TABLE QuizHistory (
    UserID INT,
    DateAccessed DATE,
    SessionID INT,
    PRIMARY KEY (UserID, DateAccessed, SessionID),
    FOREIGN KEY (UserID) REFERENCES User(UserID),
    FOREIGN KEY (SessionID) REFERENCES QuizSession(SessionID)
    -- Add other columns as needed
);

-- Quiz Question Table
CREATE TABLE QuizQuestion (
    QuestionID INT PRIMARY KEY,
    Title VARCHAR(255),
    Question_Type VARCHAR(100),
    Answer VARCHAR(255),
    QuizID INT,
    FOREIGN KEY (QuizID) REFERENCES Quiz(QuizID)
    -- Add other columns as needed
);

-- Quiz Feedback Table
CREATE TABLE QuizFeedback (
    SessionID INT PRIMARY KEY,
    UserID INT, 
    QuizID INT, 
    Score DECIMAL(5, 2),
    FOREIGN KEY (QuizID) REFERENCES Quiz(QuizID),
    FOREIGN KEY (SessionID) REFERENCES QuizSession (SessionID),
    FOREIGN KEY (UserID) REFERENCES User(UserID)
    -- Add other columns as needed
);

-- Study Performance Dashboard Table
CREATE TABLE StudyPerformanceDashboard (
    UserID INT PRIMARY KEY,
    OverallScore DECIMAL(5, 2),
    PerformanceRating VARCHAR(50),
    Feedback TEXT,
    LastUpdated TIMESTAMP,
    FOREIGN KEY (UserID) REFERENCES User(UserID)
    -- Add other columns as needed
);

INSERT INTO User (UserID, Username, Email, Pass, MonthsSinceActive)
VALUES
    (1, 'john_doe', 'john@example.com', 'password123',0),
    (2, 'jane_smith', 'jane@example.com', 'password456',0),
    (3, 'alice_jones', 'alice@example.com', 'password789',0),
    (4, 'bob_jackson', 'bob@example.com', 'pass123word',1),
    (5, 'emma_brown', 'emma@example.com', 'securepass',1),
    (6, 'david_clark', 'david@example.com', 'p@ssw0rd',1),
    (7, 'sarah_miller', 'sarah@example.com', 'userpass',3),
    (8, 'lucas_wilson', 'lucas@example.com', '123456',5),
    (9, 'olivia_taylor', 'olivia@example.com', 'qwerty',0),
    (10, 'noah_thomas', 'noah@example.com', 'password',0),
    (11, 'mia_anderson', 'mia@example.com', 'pass123',0),
    (12, 'ethan_martin', 'ethan@example.com', 'example123',10),
    (13, 'ava_garcia', 'ava@example.com', 'letmein',1),
    (14, 'william_hernandez', 'william@example.com', 'testpass',1),
    (15, 'isabella_young', 'isabella@example.com', 'abc123',3),
    (16, 'mason_miller', 'mason@example.com', 'p@ssword',4),
    (17, 'sophia_thompson', 'sophia@example.com', 'password!',1),
    (18, 'logan_lee', 'logan@example.com', 'pa$$w0rd',0),
    (19, 'harper_gonzalez', 'harper@example.com', 'pass1234',1),
    (20, 'ayden_rodriguez', 'ayden@example.com', 'examplepass',1);
    INSERT INTO User (UserID, Username, Email, Pass)
VALUES (9999, 'JohnDoe123', 'john.doe@example.com', 'secure_password123');

    INSERT INTO LoginTimes (UserID, HourTime, Datenum, DayofWeek, MinutesSpent)
VALUES
    (1, 8, '2023-11-01', 2, 45),
    (1, 14, '2023-11-02', 3, 30),
    (2, 9, '2023-11-03', 4, 60),
    (2, 12, '2023-11-04', 5, 20),
    (3, 10, '2023-11-05', 6, 40),
    (3, 16, '2023-11-06', 7, 55),
    (4, 11, '2023-11-07', 1, 25),
    (4, 13, '2023-11-08', 2, 70),
    (5, 15, '2023-11-09', 3, 45),
    (5, 18, '2023-11-10', 4, 35),
    (6, 17, '2023-11-11', 5, 50),
    (6, 20, '2023-11-12', 6, 60),
    (7, 8, '2023-11-13', 7, 30),
    (7, 10, '2023-11-14', 1, 40),
    (8, 12, '2023-11-15', 2, 55),
    (8, 14, '2023-11-16', 3, 20),
    (9, 16, '2023-11-17', 4, 45),
    (9, 18, '2023-11-18', 5, 70),
    (10, 19, '2023-11-19', 6, 30),
    (10, 21, '2023-11-20', 7, 50);

    INSERT INTO SubjectType (TypeName, Popularity)
VALUES
    ('Computer Science', 30),
    ('Science', 91),
    ('Technology', 91),
    ('Engineering', 91),
    ('Mathematics', 91),
    ('Humanities', 94),
    ('History', 94),
    ('Design', 94),
    ('Religion', 94),
    ('Education', 94),
    ('Government', 75),
    ('Health', 75),
    ('Social Science', 75);
    
    INSERT INTO FlashcardSet (Flashcard_Set_ID, Title, CreatedBy, SubjectName)
VALUES
    (1, 'Biology Basics', 1, 'Science'),
    (2, 'Algebra Fundamentals', 2, 'Mathematics'),
    (3, 'Introduction to Programming', 3, 'Technology'),
    (4, 'Mechanical Engineering Concepts', 4, 'Engineering'),
    (5, 'Art History Masterpieces', 5, 'Humanities'),
    (6, 'World War II Events', 6, 'History'),
    (7, 'Graphic Design Principles', 7, 'Design'),
    (8, 'Religious Studies: Christianity', 8, 'Religion'),
    (9, 'Education Psychology Fundamentals', 9, 'Education'),
    (10, 'Government and Politics Essentials', 10, 'Government'),
    (11, 'Healthcare Management Principles', 1, 'Health'),
    (12, 'Introduction to Sociology', 2, 'Social Science'),
    (13, 'Computer Science Algorithms', 3, 'Computer Science'),
    (14, 'Chemistry Concepts', 4, 'Science'),
    (15, 'Web Development Basics', 5, 'Technology'),
    (16, 'Civil Engineering Principles', 6, 'Engineering'),
    (17, 'Advanced Mathematics Topics', 7, 'Mathematics'),
    (18, 'Literature Analysis Techniques', 8, 'Humanities'),
    (19, 'Ancient Civilization Studies', 9, 'History'),
    (20, 'Interior Design Fundamentals', 10, 'Design');
    
    INSERT INTO FlashcardHistory (UserID, DateAccessed, Flashcard_Set_ID)
VALUES
    (1, '2023-11-01', 1),
    (1, '2023-11-03', 3),
    (2, '2023-11-05', 5),
    (2, '2023-11-07', 7),
    (3, '2023-11-09', 9),
    (3, '2023-11-11', 11),
    (4, '2023-11-13', 13),
    (4, '2023-11-15', 15),
    (5, '2023-11-17', 17),
    (5, '2023-11-19', 19),
    (6, '2023-11-21', 2),
    (6, '2023-11-23', 4),
    (7, '2023-11-25', 6),
    (7, '2023-11-27', 8),
    (8, '2023-11-29', 10),
    (8, '2023-12-01', 12),
    (9, '2023-12-03', 14),
    (9, '2023-12-05', 16),
    (10, '2023-12-07', 18),
    (10, '2023-12-09', 20);
    
    INSERT INTO FlashcardHistory (UserID, DateAccessed, Flashcard_Set_ID)
VALUES
    (9999, '2023-11-01', 1),
    (9999, '2023-11-02', 2),
    (9999, '2023-11-03', 3),
    (9999, '2023-11-04', 4),
    (9999, '2023-11-05', 5),
    (9999, '2023-11-14', 1),
    (9999, '2023-11-13', 2),
    (9999, '2023-11-12', 5),
    (9999, '2023-11-11', 1),
    (9999, '2023-11-15', 2),
    (9999, '2023-11-16', 5),
    (9999, '2023-11-17', 1),
    (9999, '2023-11-18', 2),
    (9999, '2023-11-19', 3),
    (9999, '2023-11-20', 4),
    (9999, '2023-11-21', 5);

    
    INSERT INTO UserPreferences (UserID, SubjectName, Date_Modified)
VALUES
    (1, 'Science', '2023-11-01 08:00:00'),
    (1, 'Mathematics', '2023-11-03 09:15:00'),
    (2, 'Technology', '2023-11-05 10:30:00'),
    (2, 'Engineering', '2023-11-07 11:45:00'),
    (3, 'Humanities', '2023-11-09 13:00:00'),
    (3, 'History', '2023-11-11 14:15:00'),
    (4, 'Design', '2023-11-13 15:30:00'),
    (4, 'Religion', '2023-11-15 16:45:00'),
    (5, 'Education', '2023-11-17 18:00:00'),
    (5, 'Government', '2023-11-19 19:15:00'),
    (6, 'Health', '2023-11-21 20:30:00'),
    (6, 'Social Science', '2023-11-23 21:45:00'),
    (7, 'Computer Science', '2023-11-25 23:00:00'),
    (7, 'Science', '2023-11-27 00:15:00'),
    (8, 'Technology', '2023-11-29 01:30:00'),
    (8, 'Engineering', '2023-12-01 02:45:00'),
    (9, 'Mathematics', '2023-12-03 04:00:00'),
    (9, 'Humanities', '2023-12-05 05:15:00'),
    (10, 'History', '2023-12-07 06:30:00'),
    (10, 'Design', '2023-12-09 07:45:00');
    
    INSERT INTO Flashcard (Title, Flashcard_Set_ID, Content)
VALUES
    ('Photosynthesis', 1, 'The process by which green plants and some other organisms use sunlight to synthesize foods with the help of chlorophyll.'),
    ('Quadratic Equation', 1, 'An equation of the second degree with the standard form ax^2 + bx + c = 0 where a ≠ 0.'),
    ('Binary Code', 2, 'A representation of computer processor instructions or data using binary digits (0s and 1s).'),
    ('Newton''s Laws of Motion', 2, 'Three fundamental laws that describe the behavior of objects and the forces acting upon them.'),
    ('Artificial Intelligence', 3, 'The simulation of human intelligence processes by machines, especially computer systems.'),
    ('World War II Timeline', 3, 'A chronological list of events that occurred during the Second World War from 1939 to 1945.'),
    ('Graphic Design Principles', 4, 'Fundamental concepts and guidelines governing effective visual communication.'),
    ('Religious Beliefs', 4, 'A set of beliefs concerning the cause, nature, and purpose of the universe.'),
    ('Pedagogical Theories', 5, 'Various theories and strategies related to teaching methods and educational principles.'),
    ('Political Systems', 5, 'Different systems of governance and the institutions that regulate societal affairs.'),
    ('Human Anatomy', 6, 'The study of the structure and function of the human body and its parts.'),
    ('Industrial Revolution', 6, 'A period of profound social, economic, and technological changes in the late 18th and early 19th centuries.'),
    ('Computer Algorithms', 7, 'Step-by-step procedures or formulas for solving problems using a finite sequence of instructions.'),
    ('Chemical Reactions', 7, 'Processes that lead to the transformation of one set of chemical substances to another.'),
    ('Web Development Basics', 8, 'Foundational concepts and practices involved in creating web applications.'),
    ('Structural Engineering Concepts', 8, 'The principles and techniques applied in the design and construction of structures.'),
    ('Calculus Fundamentals', 9, 'The branch of mathematics focused on rates of change and accumulation.'),
    ('Literature Analysis Techniques', 9, 'Methods for critically examining and interpreting literary works.'),
    ('Ancient Civilization Studies', 10, 'Exploration and examination of historical cultures and societies from ancient times.'),
    ('Interior Design Principles', 10, 'Fundamental concepts governing the aesthetics and functionality of interior spaces.');
    
    
INSERT INTO AIGeneratedFlashcardSet (Flashcard_Set_ID, DateCreated)
VALUES
    (1, '2023-11-01'),
    (2, '2023-11-03'),
    (3, '2023-11-05'),
    (4, '2023-11-07'),
    (5, '2023-11-09'),
    (6, '2023-11-11'),
    (7, '2023-11-13'),
    (8, '2023-11-15'),
    (9, '2023-11-17'),
    (10, '2023-11-19');


INSERT INTO AIGeneratedSetMapping (Generated_Set_ID, Original_Set_ID)
VALUES
    (1, 1),   -- AI Set 1 composed of Original Set 1
    (1, 2),   -- AI Set 1 also composed of Original Set 2
    (2, 3),   -- AI Set 2 composed of Original Set 3
    (2, 4),   -- AI Set 2 also composed of Original Set 4
    (3, 5),   -- AI Set 3 composed of Original Set 5
    (3, 6),   -- AI Set 3 also composed of Original Set 6
    (4, 7),   -- AI Set 4 composed of Original Set 7
    (5, 8),   -- AI Set 5 composed of Original Set 8
    (5, 9),   -- AI Set 5 also composed of Original Set 9
    (5, 10),  -- AI Set 5 also composed of Original Set 10
    (6, 11),  -- AI Set 6 composed of Original Set 11
    (7, 12),  -- AI Set 7 composed of Original Set 12
    (7, 13),  -- AI Set 7 also composed of Original Set 13
    (8, 14),  -- AI Set 8 composed of Original Set 14
    (8, 15),  -- AI Set 8 also composed of Original Set 15
    (9, 16),  -- AI Set 9 composed of Original Set 16
    (9, 17),  -- AI Set 9 also composed of Original Set 17
    (9, 18),  -- AI Set 9 also composed of Original Set 18
    (10, 19), -- AI Set 10 composed of Original Set 19
    (10, 20); -- AI Set 10 also composed of Original Set 20
    
    INSERT INTO Quiz (QuizID, SubjectName)
VALUES
    (1, 'Computer Science'),
    (2, 'Science'),
    (3, 'Technology'),
    (4, 'Engineering'),
    (5, 'Mathematics'),
    (6, 'Humanities'),
    (7, 'History'),
    (8, 'Design'),
    (9, 'Religion'),
    (10, 'Education'),
    (11, 'Government'),
    (12, 'Health'),
    (13, 'Social Science'),
    (14, 'Computer Science'),
    (15, 'Science'),
    (16, 'Technology'),
    (17, 'Engineering'),
    (18, 'Mathematics'),
    (19, 'Humanities'),
    (20, 'History');

    INSERT INTO QuizSession (SessionID, QuizID, Difficulty, IsCompleted, MinutesSpent, SubjectName, Datenum)
VALUES
    (1, 1, 'Intermediate', TRUE, 45, 'Science', '2023-11-01'),
    (2, 2, 'Advanced', TRUE, 60, 'Mathematics', '2023-11-02'),
    (3, 3, 'Beginner', TRUE, 30, 'Technology', '2023-11-03'),
    (4, 4, 'Intermediate', TRUE, 50, 'Engineering', '2023-11-04'),
    (5, 5, 'Advanced', FALSE, 55, 'Humanities', '2023-11-05'),
    (6, 6, 'Intermediate', TRUE, 40, 'History', '2023-11-06'),
    (7, 7, 'Beginner', FALSE, 35, 'Design', '2023-11-07'),
    (8, 8, 'Advanced', TRUE, 75, 'Religion', '2023-11-08'),
    (9, 9, 'Intermediate', TRUE, 60, 'Education', '2023-11-09'),
    (10, 10, 'Beginner', TRUE, 45, 'Government', '2023-11-10'),
    (11, 11, 'Advanced', FALSE, 55, 'Health', '2023-11-11'),
    (12, 12, 'Intermediate', TRUE, 50, 'Social Science', '2023-11-12'),
    (13, 13, 'Beginner', TRUE, 40, 'Computer Science', '2023-11-13'),
    (14, 14, 'Advanced', TRUE, 65, 'Science', '2023-11-14'),
    (15, 15, 'Intermediate', FALSE, 50, 'Technology', '2023-11-15'),
    (16, 16, 'Beginner', TRUE, 45, 'Engineering', '2023-11-16'),
    (17, 17, 'Advanced', TRUE, 70, 'Mathematics', '2023-11-17'),
    (18, 18, 'Intermediate', TRUE, 55, 'Humanities', '2023-11-18'),
    (19, 19, 'Beginner', FALSE, 35, 'History', '2023-11-19'),
    (20, 20, 'Advanced', TRUE, 80, 'Design', '2023-11-20');
    
    INSERT INTO QuizHistory (UserID, DateAccessed, SessionID)
VALUES
    (1, '2023-11-01', 1),
    (2, '2023-11-02', 2),
    (3, '2023-11-03', 3),
    (4, '2023-11-04', 4),
    (5, '2023-11-05', 5),
    (6, '2023-11-06', 6),
    (7, '2023-11-07', 7),
    (8, '2023-11-08', 8),
    (9, '2023-11-09', 9),
    (10, '2023-11-10', 10),
    (1, '2023-11-11', 11),
    (2, '2023-11-12', 12),
    (3, '2023-11-13', 13),
    (4, '2023-11-14', 14),
    (5, '2023-11-15', 15),
    (6, '2023-11-16', 16),
    (7, '2023-11-17', 17),
    (8, '2023-11-18', 18),
    (9, '2023-11-19', 19),
    (10, '2023-11-20', 20);

INSERT INTO QuizQuestion (QuestionID, Title, Question_Type, Answer, QuizID)
VALUES
    (1, 'What is the capital of France?', 'Multiple Choice', 'Paris', 1),
    (2, 'Is the Earth round?', 'True/False', 'True', 1),
    (3, 'Who painted the Mona Lisa?', 'Multiple Choice', 'Leonardo da Vinci', 2),
    (4, 'Is water composed of two hydrogen atoms and one oxygen atom?', 'True/False', 'True', 2),
    (5, 'What is the largest planet in the solar system?', 'Multiple Choice', 'Jupiter', 3),
    (6, 'Is the Sun a star?', 'True/False', 'True', 3),
    (7, 'Which continent is the least populated?', 'Multiple Choice', 'Antarctica', 4),
    (8, 'Is the moon larger than Earth?', 'True/False', 'False', 4),
    (9, 'What is the chemical symbol for gold?', 'Multiple Choice', 'Au', 5),
    (10, 'Is lightning hotter than the surface of the sun?', 'True/False', 'True', 5),
    (11, 'Who wrote "Romeo and Juliet"?', 'Multiple Choice', 'William Shakespeare', 6),
    (12, 'Is the Atlantic Ocean the largest ocean on Earth?', 'True/False', 'False', 6),
    (13, 'What is the largest mammal on Earth?', 'Multiple Choice', 'Blue whale', 7),
    (14, 'Is Antarctica the driest continent on Earth?', 'True/False', 'True', 7),
    (15, 'Which gas makes up the majority of Earth’s atmosphere?', 'Multiple Choice', 'Nitrogen', 8),
    (16, 'Is the Great Wall of China visible from space?', 'True/False', 'False', 8),
    (17, 'Who discovered penicillin?', 'Multiple Choice', 'Alexander Fleming', 9),
    (18, 'Is Mount Everest the tallest mountain on Earth?', 'True/False', 'True', 9),
    (19, 'Which planet is known as the "Red Planet"?', 'Multiple Choice', 'Mars', 10),
    (20, 'Is the Pacific Ocean the smallest ocean?', 'True/False', 'False', 10);

INSERT INTO QuizFeedback (SessionID, UserID, QuizID, Score)
VALUES
    (1, 1, 1, 85.50),
    (2, 2, 2, 92.75),
    (3, 3, 3, 78.00),
    (4, 4, 4, 90.25),
    (5, 5, 5, 87.00),
    (6, 6, 6, 80.75),
    (7, 7, 7, 95.00),
    (8, 8, 8, 89.50),
    (9, 9, 9, 75.25),
    (10, 10, 10, 93.00),
    (11, 1, 11, 88.25),
    (12, 2, 12, 82.50),
    (13, 3, 13, 90.75),
    (14, 4, 14, 85.00),
    (15, 5, 15, 91.25),
    (16, 6, 16, 79.50),
    (17, 7, 17, 94.75),
    (18, 8, 18, 87.00),
    (19, 9, 19, 76.25),
    (20, 10, 20, 92.50);

INSERT INTO StudyPerformanceDashboard (UserID, OverallScore, PerformanceRating, Feedback, LastUpdated)
VALUES
    (1, 87.50, 'Good', 'Showing consistent improvement in quizzes.', '2023-11-01 09:30:00'),
    (2, 91.25, 'Excellent', 'Impressive performance across various subjects.', '2023-11-02 10:15:00'),
    (3, 80.00, 'Satisfactory', 'Could benefit from more focused studying.', '2023-11-03 11:20:00'),
    (4, 89.75, 'Very Good', 'Demonstrating strong understanding of topics.', '2023-11-04 12:45:00'),
    (5, 86.00, 'Good', 'Needs to work on time management during quizzes.', '2023-11-05 14:00:00'),
    (6, 82.75, 'Satisfactory', 'Showing improvement but needs more practice.', '2023-11-06 15:30:00'),
    (7, 94.00, 'Excellent', 'Consistently achieving high scores.', '2023-11-07 16:45:00'),
    (8, 88.50, 'Very Good', 'Strong understanding but could review certain areas.', '2023-11-08 18:00:00'),
    (9, 77.25, 'Fair', 'Could improve in understanding certain subjects.', '2023-11-09 19:20:00'),
    (10, 92.00, 'Excellent', 'Exceptional performance in quizzes.', '2023-11-10 20:30:00'),
    (11, 89.25, 'Very Good', 'Maintaining a steady performance overall.', '2023-11-11 09:45:00'),
    (12, 81.50, 'Satisfactory', 'Could benefit from additional practice.', '2023-11-12 11:00:00'),
    (13, 90.75, 'Excellent', 'Showing remarkable progress in quizzes.', '2023-11-13 12:15:00'),
    (14, 84.00, 'Good', 'Improving steadily but needs more focus.', '2023-11-14 13:30:00'),
    (15, 91.25, 'Excellent', 'Consistently achieving high scores.', '2023-11-15 14:45:00'),
    (16, 78.50, 'Fair', 'Requires more effort to enhance performance.', '2023-11-16 16:00:00'),
    (17, 95.75, 'Excellent', 'Exceptional performance in all quizzes.', '2023-11-17 17:15:00'),
    (18, 87.00, 'Very Good', 'Strong understanding but could review certain topics.', '2023-11-18 18:30:00'),
    (19, 76.25, 'Fair', 'Needs more practice to improve understanding.', '2023-11-19 19:45:00'),
    (20, 93.50, 'Excellent', 'Achieving consistently high scores.', '2023-11-20 20:00:00');









