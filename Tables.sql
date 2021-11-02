DROP TABLE IF EXISTS Grades CASCADE;
DROP TABLE IF EXISTS CourseCatalogue CASCADE;
DROP TABLE IF EXISTS StudentRegistrationTable CASCADE;
DROP TABLE IF EXISTS TicketTable CASCADE;
DROP TABLE IF EXISTS Students CASCADE;
DROP TABLE IF EXISTS Instructors CASCADE;
DROP TABLE IF EXISTS BatchAdvisors CASCADE;
DROP TABLE IF EXISTS DeanFA CASCADE;
DROP TABLE IF EXISTS TimeTableSlots CASCADE;
DROP TABLE IF EXISTS CourseOfferings CASCADE;

CREATE TABLE Students(
	student_id integer PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
	student_name text ,
	year_joined integer ,
	branch text,
	cgpa real
);

CREATE TABLE Instructors(
	instructor_id integer PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
	instructor_name text  
);

CREATE TABLE BatchAdvisors(
	ba_id integer PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
	ba_name text  
);

CREATE TABLE DeanFA(
	dean_id integer PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
	dean_name text  
);

CREATE TABLE TimeTableSlots(
	slot_id integer PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
	week_day text  ,
	start_time integer  ,
	end_time integer 
);

CREATE TABLE CourseCatalogue(
	course_id text PRIMARY KEY,
	course_name text  ,
	L integer,
	T integer,
	P integer,
	S integer,
	C real  ,
	prerequisite text -- course_id	
);

CREATE TABLE CourseOfferings(
	course_id text  ,
	instructor_id integer  ,
	year integer  ,
	semester integer  ,
	section integer  ,
	slot_id integer  ,
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
	course_id text  ,
	student_id integer  ,
	year integer  ,
	semester integer  ,
	grade integer  ,
	
	FOREIGN KEY(course_id) 
	REFERENCES CourseCatalogue(course_id)
	ON DELETE CASCADE,
	
	FOREIGN KEY(student_id) 
	REFERENCES Students(student_id)
	ON DELETE CASCADE
);

CREATE TABLE StudentRegistrationTable(
	student_id integer  ,
	course_id text  ,
	semester integer  ,
	year integer  ,
	section integer  ,
	slot_id integer  ,
	
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
	ticket_id integer PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
	student_id integer,
	instructor_id integer,
	semester integer,
	year integer,
	course_id text,
	section integer,
	slot_id integer,
	status text ,-- 'Accepted' , 'Pending' , 'Rejected' 
	DeanUpdate text,
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
-------------------------------------------------------------------------------------
