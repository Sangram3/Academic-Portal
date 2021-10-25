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
		credits real;
		this_course_credits real;
		
BEGIN
	--------------------------------------------------------------------
		SELECT cc.C FROM CourseCatalogue as cc
		WHERE cc.course_id = course_id_
		INTO this_course_credits;
	--------------------------------------------------------------------
	

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
	ELSIF credits + this_course_credits > 5
			-- RAISE TICKET
			THEN RETURN 0;

	END IF;
	--------------------------------------------------------------------
	
	RETURN count_rows;
END;
$$;
