DROP TABLE IF EXISTS Grades CASCADE;
DROP TABLE IF EXISTS CourseCatalogue CASCADE;
DROP TABLE IF EXISTS StudentRegistrationTable CASCADE;
DROP TABLE IF EXISTS TicketTable CASCADE;
DROP TABLE IF EXISTS Students CASCADE;
DROP TABLE IF EXISTS Instructors CASCADE;
DROP TABLE IF EXISTS FacultyAdvisors CASCADE;
DROP TABLE IF EXISTS DeanFA CASCADE;
DROP TABLE IF EXISTS TimeTableSlots CASCADE;
DROP TABLE IF EXISTS CourseOfferings CASCADE;

CREATE TABLE Students(
	student_id integer PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
	student_name text NOT NULL,
	year_joined integer NOT NULL
);

CREATE TABLE Instructors(
	instructor_id integer PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
	instructor_name text NOT NULL
);

CREATE TABLE FacultyAdvisors(
	fa_id integer PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
	fa_name text NOT NULL
);

CREATE TABLE DeanFA(
	dean_id integer PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
	dean_name text NOT NULL
);

CREATE TABLE TimeTableSlots(
	slot_id integer PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
	week_day text NOT NULL,
	start_time time NOT NULL,
	end_time time NOT NULL
);

CREATE TABLE CourseCatalogue(
	course_id text PRIMARY KEY,
	course_name text NOT NULL,
	L integer,
	T integer,
	P integer,
	S integer,
	C real NOT NULL,
	prerequisite text -- course_id	
);

CREATE TABLE CourseOfferings(
	course_id text NOT NULL,
	instructor_id integer NOT NULL,
	year integer NOT NULL,
	semester integer NOT NULL,
	section integer NOT NULL,
	slot_id integer NOT NULL,
	cgpa_cutoff real,
	branch text,
	
	FOREIGN KEY(course_id) 
	REFERENCES CourseCatalogue(course_id)
	ON DELETE CASCADE,
	
	FOREIGN KEY(slot_id) 
	REFERENCES TimeTableSlots(slot_id)
	ON DELETE CASCADE,
	
	FOREIGN KEY(instructor_id) 
	REFERENCES Instructors(instructor_id)
	ON DELETE CASCADE
);

CREATE TABLE Grades(
	course_id text NOT NULL,
	student_id integer NOT NULL,
	year integer NOT NULL,
	semester integer NOT NULL,
	grade integer NOT NULL,
	
	FOREIGN KEY(course_id) 
	REFERENCES CourseCatalogue(course_id)
	ON DELETE CASCADE,
	
	FOREIGN KEY(student_id) 
	REFERENCES Students(student_id)
	ON DELETE CASCADE
);

CREATE TABLE StudentRegistrationTable(
	student_id integer NOT NULL,
	course_id text NOT NULL,
	semester integer NOT NULL,
	year integer NOT NULL,
	section integer NOT NULL,
	slot_id integer NOT NULL,
	
	FOREIGN KEY(student_id) 
	REFERENCES Students(student_id)
	ON DELETE CASCADE,
	
	FOREIGN KEY(course_id) 
	REFERENCES CourseCatalogue(course_id)
	ON DELETE CASCADE,
	
	FOREIGN KEY(slot_id) 
	REFERENCES TimeTableSlots(slot_id)
	ON DELETE CASCADE
	
);

CREATE TABLE TicketTable(
	ticket_id integer PRIMARY KEY,
	student_id integer,
	instructor_id integer,
	semester integer,
	year integer,
	course_id text,
	status text ,-- 'Accepted' , 'Pending' , 'Rejected' 
	
	FOREIGN KEY(student_id) 
	REFERENCES Students(student_id)
	ON DELETE CASCADE,
	
	FOREIGN KEY(instructor_id) 
	REFERENCES Instructors(instructor_id)
	ON DELETE CASCADE,
	
	FOREIGN KEY(course_id) 
	REFERENCES CourseCatalogue(course_id)
	ON DELETE CASCADE
);

