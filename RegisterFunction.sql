DROP FUNCTION IF EXISTS Register;

CREATE OR REPLACE FUNCTION Register(
	IN student_id_ integer,
	IN course_id_ text,
	IN year_ integer,
	IN semester_ integer,
	IN section_ integer,
	IN slot_id_ integer
)

RETURNS integer
LANGUAGE plpgsql
AS $$

DECLARE 
	count_rows integer;
	count_prerequisites_passed integer;
	count_total_prerequisites integer;
	credits real;
	this_course_credits real;
	instructor_id integer;
	
BEGIN
	--------------------------------------------------------------------
	-- find the credits for input course_id
	SELECT cc.C FROM CourseCatalogue as cc
	WHERE cc.course_id = course_id_
	INTO this_course_credits;
	--------------------------------------------------------------------
	
	--------------------------------------------------------------------
	-- check this slot is already there in the StudentRegistration table
	SELECT COUNT(srt.slot_id) FROM StudentRegistrationTable AS srt
	where srt.student_id = student_id_ 
	and srt.year = year_ 
	and srt.semester = semester_ 
	and srt.slot_id = slot_id_ INTO count_rows;
	--------------------------------------------------------------------
	--------------------------------------------------------------------
	-- check for credit limits
	SELECT SUM(cc.C) FROM CourseCatalogue as cc 
		WHERE cc.course_id IN
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
			   and  g.grade >= 6  -- passing criteria
	)
	INTO count_prerequisites_passed;
	
	-- counting total distinct prerequisites for the given course
	SELECT COUNT(DISTINCT cc.prerequisite) FROM CourseCatalogue as cc
	WHERE cc.course_id = course_id_ 
	INTO count_total_prerequisites;
	--------------------------------------------------------------------
	
	
	--------------------------------------------------------------------
	-- find instructor id who is offering thise course this year,semester,section
	SElECT co.instructor_id FROM
	CourseOfferings AS co
	WHERE co.course_id = course_id_
	and   co.year = year_
	and   co.semester = semester_
	and   co.section = section_
	INTO instructor_id;
	
	--------------------------------------------------------------------
	
	--------------------------------------------------------------------
	IF count_rows = 1 OR count_total_prerequisites > count_prerequisites_passed
		THEN RETURN 0;
	ELSIF credits + this_course_credits > 5
			THEN
			INSERT INTO 
			TicketTable(student_id,instructor_id,semester,year,course_id,section,slot_id,status)
			VALUES(
				student_id_,
				instructor_id, -- yet not found
				semester_,
				year_,
				course_id_,
				section_,
				slot_id_,
				'Pending'
			);
			RETURN 0;
	ELSE 
		INSERT INTO StudentRegistrationTable VALUES(
			 student_id_ ,
			 course_id_,
			 semester_,
			 year_,
			 section_,
			 slot_id_ );
	END IF;
	--------------------------------------------------------------------
	
	RETURN 1;
END;
$$;


-- TESTCASE
INSERT INTO Students(student_name , year_joined) VALUES('Sangram',2019);

INSERT INTO CourseCatalogue VALUES('CS201','DSA',1 , 2 , 3 ,4 ,3);

INSERT INTO CourseCatalogue VALUES('CS202','DSA',1 , 2 , 3 ,4 ,5);

INSERT INTO Instructors(instructor_name) VALUES('Puneet Goyal');

INSERT INTO TimeTableSlots(week_day , start_time , end_time) VALUES('Sunday', 12 ,1);

INSERT INTO TimeTableSlots(week_day , start_time , end_time) VALUES('Sunday', 1 ,2);

INSERT INTO CourseOfferings(course_id,instructor_id,year,semester,section,slot_id) 

VALUES('CS202',1 , 2019 , 1 ,2 ,2);
SELECT Register(1 , 'CS201' , 1 , 2019 , 3,1);

SELECT Register(1 , 'CS202' , 1 , 2019 , 2,2);

update tickettable
set status = 'Accepted' where ticket_id = 1

select * from tickettable;
select * from studentRegistrationtable

