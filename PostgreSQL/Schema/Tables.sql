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

-- This table contains basic information of students required for the registraion of the courses
CREATE TABLE Students(
	student_id integer PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
	student_name text ,
	year_joined integer ,
	branch text,
	cgpa real
);

-- This table contains basic information of proffesors required for the registraion of the courses
CREATE TABLE Instructors(
	instructor_id integer PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
	instructor_name text  
);

-- This table contains basic information of batch advisors required for the registraion of the courses
CREATE TABLE BatchAdvisors(
	ba_id integer PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
	ba_name text  
);

-- Dean of academics
CREATE TABLE DeanFA(
	dean_id integer PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
	dean_name text  
);

-- This table contains all the slots with unique id assigned to them
CREATE TABLE TimeTableSlots(
	slot_id integer PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
	week_day text  ,
	start_time integer  ,
	end_time integer 
);


-- Course Catalogue contains all the information related to the course
-- This includes its L-T-P-S-C structure, name and prerequisites.
-- Follows 1NF for prerequisites column, as prerequisities are not multivalued
CREATE TABLE CourseCatalogue(
	course_id text PRIMARY KEY,
	course_name text  ,
	L integer,
	T integer,
	P integer,
	S integer,
	C real  ,
	prerequisite text -- course_id e.g CS201	
);

-- CourseOfferings contains information related to the courses which are offered in a particular semester
-- Foreign Key Constraints are applied on course_id, instructor_id and slot_id.
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

-- This table includes grades of the students in a particular course offering.
-- Foreign Key Constraint is applied on course_id and student_id
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

-- This table includes details of the students who has registered in a particular offering semester.
-- Foreigh Key Constraints are applied on student_id, course_id and slot_id.
-- Student cannot register for the courses in the same slot.
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

-- This table keeps track of all the tickets raised by the students and status of the ticket
-- Foreign Key Constraints are imposed on course_id, student_id and instructor_id

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
