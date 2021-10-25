
CREATE OR REPLACE FUNCTION CalculateCGPA(
	IN student_id_ integer
)
RETURNS real
LANGUAGE plpgsql

AS
$$
	DECLARE total_score real;
		total_credits real;
		
	BEGIN
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
