-- DROP TABLE Grades;
-- Grades (course_id , student_id , semester , year , grade )

-- CREATE TABLE Grades(
-- 	course_id text,
-- 	student_id integer,
-- 	year integer,
-- 	semester integer,
-- 	grade integer -- in the format 1,2,...,10 and not A+ A-
-- )

-- DROP TABLE StudentRegistrationTable

-- CREATE TABLE StudentRegistrationTable(
-- 	student_id integer NOT NULL,
-- 	course_id text NOT NULL,
-- 	semester integer NOT NULL,
-- 	year integer NOT NULL,
-- 	section integer NOT NULL,
-- 	slot text NOT NULL
-- );

-- INSERT INTO StudentRegistrationTable VALUES(
-- 	12,'CS201',1,2021,1,'s1'
-- );
-- INSERT INTO StudentRegistrationTable VALUES(
-- 	13,'CS201',1,2021,1,'s4'
-- );
-- INSERT INTO StudentRegistrationTable VALUES(
-- 	12,'CS204',1,2021,1,'s2'
-- );
-- INSERT INTO StudentRegistrationTable VALUES(
-- 	12,'CS208',1,2020,1,'s3'
-- );


-- CREATE TABLE CourseCatalogue(
-- 	course_id text,
-- 	course_name text,
-- 	L integer,
-- 	T integer,
-- 	P integer,
-- 	S integer,
-- 	C real,
-- 	prerequisite text -- course_id
	
-- );



-- select * from StudentRegistrationTable;
DROP FUNCTION Register;

CREATE OR REPLACE FUNCTION Register(
	IN student_id_ integer,
	IN course_id_ text,
	IN year_ integer,
	IN semester_ integer,
	IN section_ integer,
	IN slot_ text
)

RETURNS integer
LANGUAGE plpgsql
AS $$

DECLARE count_rows integer;
		count_prerequisites_passed integer;
		count_total_prerequisites integer;
		credits numeric;
		
BEGIN
	--------------------------------------------------------------------
	-- check this slot is already there in the StudentRegistration table
	SELECT COUNT(srt.slot) FROM StudentRegistrationTable AS srt
	where srt.student_id = student_id_ 
	and srt.year = year_ 
	and srt.semester = semester_ 
	and srt.slot = slot_ INTO count_rows;
	--------------------------------------------------------------------
	--------------------------------------------------------------------
	-- check for credit limits
	SELECT SUM(CourseCatalogue.C) FROM CourseCatalogue  
		WHERE CourseCatalogue.course_id IN
		(
			SELECT srt.course_id FROM StudentRegistrationTable AS srt
			where srt.student_id = student_id_ 
				and srt.year = year_ 
				and srt.semester = semester_ 
		) 
		INTO credits;
	--------------------------------------------------------------------
	
	--------------------------------------------------------------------
	--counting total distinct prerequisites passed by the student 
	SELECT COUNT(DISTINCT cc.prerequisite) FROM CourseCatalogue as cc
	WHERE cc.course_id = course_id_ 
	and cc.prerequisite IN 
	(
		SELECT g.course_id FROM Grades AS g 
		WHERE  g.student_id = student_id_ 
			   and  g.grade >= 6  -- passing criterion
	)
	INTO count_prerequisites_passed;
	
	-- counting total distinct prerequisites for the given course
	SELECT COUNT(DISTINCT cc.prerequisite) FROM CourseCatalogue as cc
	WHERE cc.course_id = course_id_ 
	INTO count_total_prerequisites;
	--------------------------------------------------------------------
	
	--------------------------------------------------------------------
	IF count_rows = 1 OR count_total_prerequisites > count_prerequisites_passed
		THEN RETURN 0;
	ELSIF credits + 2.5 > 5
			-- RAISE TICKET
			THEN RETURN 0;

	END IF;
	
	--------------------------------------------------------------------
	
	RETURN count_rows;
END;
$$;

SELECT Register(12 , 'CS201', 2021 , 1 ,3,'s1');

select * from StudentRegistrationTable;
