

CREATE OR REPLACE FUNCTION CheckGrades(
	IN student_id_ integer,
	IN year_ integer,
	IN semester_ integer
)

RETURNS TABLE(
	course_id text,
	grade integer
)
LANGUAGE plpgsql
SECURITY definer
AS
$$
	BEGIN
		RETURN QUERY
		SELECT g.course_id ,g.grade FROM Grades AS g
		WHERE g.year = year 
		and g.semester = semester_
		and g.student_id = student_id_;
	
	END;
$$;


