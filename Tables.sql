DROP TABLE Grades;
Grades (course_id , student_id , semester , year , grade )

CREATE TABLE Grades(
	course_id text,
	student_id integer,
	year integer,
	semester integer,
	grade integer -- in the format 1,2,...,10 and not A+ A-
)

DROP TABLE StudentRegistrationTable

CREATE TABLE StudentRegistrationTable(
	student_id integer NOT NULL,
	course_id text NOT NULL,
	semester integer NOT NULL,
	year integer NOT NULL,
	section integer NOT NULL,
	slot text NOT NULL
);

INSERT INTO StudentRegistrationTable VALUES(
	12,'CS201',1,2021,1,'s1'
);
INSERT INTO StudentRegistrationTable VALUES(
	13,'CS201',1,2021,1,'s4'
);
INSERT INTO StudentRegistrationTable VALUES(
	12,'CS204',1,2021,1,'s2'
);
INSERT INTO StudentRegistrationTable VALUES(
	12,'CS208',1,2020,1,'s3'
);


CREATE TABLE CourseCatalogue(
	course_id text,
	course_name text,
	L integer,
	T integer,
	P integer,
	S integer,
	C real,
	prerequisite text -- course_id
	
);
