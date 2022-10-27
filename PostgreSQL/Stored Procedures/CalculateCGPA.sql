
--Test Using This
-- INSERT INTO CourseCatalogue VALUES('CS201','DSA',1,2,3,4,4.5,'CS200')
-- INSERT INTO CourseCatalogue VALUES('CS204','CA',1,2,3,4,3.5,'CS201')

-- INSERT INTO Grades VALUES('CS201',12,2020,1,9)
-- INSERT INTO Grades VALUES('CS204',12,2020,1,8)
-- SELECT CalculateCGPA(12)


-- Stored Procedure to calculate the CGPA of a student, provided Student ID.

CREATE OR REPLACE FUNCTION CalculateCGPA(
	IN student_id_ integer -- Input : Student ID
)
-- Return type should be floating type number
RETURNS real
LANGUAGE plpgsql
SECURITY definer -- SECURITY DEFINER : specifies that the function is to be executed with the privileges of the user that owns it.
AS
$$
	-- temporary variables : total_score, total_credits

	DECLARE total_score real;
			total_credits real;
		
	BEGIN
		-- Logic : store total credits obtained by the student in total_credits and total grades achieved into total_score
		-- 		   variables. Then return division of them as GPA.

		SELECT SUM(cc.C) FROM CourseCatalogue as cc
		WHERE cc.course_id in
		(
			SELECT g.course_id From Grades as g
			WHERE g.student_id = student_id_
		)
		INTO total_credits;
		
		SELECT SUM(cc.C * g.grade) FROM CourseCatalogue as cc,Grades as g
		WHERE cc.course_id = g.course_id
		and g.student_id = student_id_
		INTO total_score;
		
		RETURN total_score/total_credits;

	END;
$$;
