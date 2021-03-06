CREATE TABLE Hospitations (ID SERIAL NOT NULL, UserID_fk int4 NOT NULL, ClassID_fk int4 NOT NULL, ScheduleID_fk int4 NOT NULL, Date date NOT NULL, Commission int[] NOT NULL, ProtocolCreated boolean NOT NULL);
CREATE TABLE Protocols (ID SERIAL NOT NULL, UserID_fk int4 NOT NULL, HospitationID_fk int4 NOT NULL, CreationDate date NOT NULL, Rating TEXT[] NOT NULL, Appeal boolean NOT NULL);
CREATE TABLE Subjects_cards (ID SERIAL NOT NULL, ClassID_fk int4 NOT NULL, Course varchar(255) NOT NULL, Content varchar(255) NOT NULL);
CREATE TABLE Classes (ID SERIAL NOT NULL, ClassName varchar(255) NOT NULL, ClassCode varchar(10) NOT NULL, Building varchar(255) NOT NULL, Room varchar(255) NOT NULL, ClassTime varchar(50) NOT NULL, Form varchar(30) NOT NULL, StudentsNum int4 NOT NULL);
CREATE TABLE Users (ID SERIAL NOT NULL, Name varchar(255) NOT NULL, Surname varchar(255) NOT NULL, Pesel varchar(255) NOT NULL, Password varchar(255) NOT NULL, Email varchar(255) NOT NULL, LastHospitation date, Degree varchar(20), Wzhz boolean, Cathedral varchar(255), Discriminator varchar(255) NOT NULL, CHECK (Discriminator LIKE 'teacher' or Discriminator LIKE 'headOfDep'));
CREATE TABLE Schedules (ID SERIAL NOT NULL, CreationDate date NOT NULL, SemesterID_fk int4 NOT NULL);
CREATE TABLE Semesters (ID SERIAL NOT NULL, StartDate date NOT NULL, EndDate date NOT NULL);
CREATE TABLE Hospitations_Users (HospitationID_fk int4 NOT NULL, UserID_fk int4 NOT NULL);
CREATE TABLE Users_Classes (UserID_fk int4 NOT NULL, ClassID_fk int4 NOT NULL);

ALTER TABLE Hospitations ADD PRIMARY KEY (ID);
ALTER TABLE Protocols ADD PRIMARY KEY (ID);
ALTER TABLE Subjects_cards ADD PRIMARY KEY (ID);
ALTER TABLE Classes ADD PRIMARY KEY (ID);
ALTER TABLE Users ADD PRIMARY KEY (ID);
ALTER TABLE Schedules ADD PRIMARY KEY (ID);
ALTER TABLE Semesters ADD PRIMARY KEY (ID);
ALTER TABLE Hospitations_Users ADD PRIMARY KEY (HospitationID_fk, UserID_fk);
ALTER TABLE Users_Classes ADD PRIMARY KEY (UserID_fk, ClassID_fk);

ALTER TABLE Subjects_cards ADD CONSTRAINT subject_card_class_con FOREIGN KEY (ClassID_fk) REFERENCES Classes (ID);
ALTER TABLE Hospitations_Users ADD CONSTRAINT hosp_user_hosp_con FOREIGN KEY (HospitationID_fk) REFERENCES Hospitations (ID);
ALTER TABLE Hospitations_Users ADD CONSTRAINT hosp_user_user_con FOREIGN KEY (UserID_fk) REFERENCES Users (ID);
ALTER TABLE Users_Classes ADD CONSTRAINT user_class_user_con FOREIGN KEY (UserID_fk) REFERENCES Users (ID);
ALTER TABLE Users_Classes ADD CONSTRAINT user_class_class_con FOREIGN KEY (ClassID_fk) REFERENCES Classes (ID);
ALTER TABLE Hospitations ADD CONSTRAINT hospitation_schedule_con FOREIGN KEY (ScheduleID_fk) REFERENCES Schedules (ID);
ALTER TABLE Protocols ADD CONSTRAINT protocol_hosp_con FOREIGN KEY (HospitationID_fk) REFERENCES Hospitations (ID);
ALTER TABLE Protocols ADD CONSTRAINT protocol_user_con FOREIGN KEY (UserID_fk) REFERENCES Users (ID);
ALTER TABLE Hospitations ADD CONSTRAINT protocol_class_con FOREIGN KEY (ClassID_fk) REFERENCES Classes (ID);
ALTER TABLE Schedules ADD CONSTRAINT semester_schedule_con FOREIGN KEY (SemesterID_fk) REFERENCES Semesters (ID);
ALTER TABLE Hospitations ADD CONSTRAINT hosp_user_con FOREIGN KEY (UserID_fk) REFERENCES Users (ID);

INSERT INTO protocols (UserID_fk, HospitationID_fk, CreationDate, Rating, Appeal) VALUES (16, 32, '1993-11-12', {'5', '4.5', '5.5', '4', '3.5', 'Nie dotyczy', '4', '4', '5'}, f);