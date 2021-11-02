-- When a certain course is offered then new table is created to store the grades of the students
-- taking that course

-- Course Grade table
CREATE OR REPLACE FUNCTION AddEntriesByCSVCourseGrade(
	IN address text,
	IN course_id_ text,
	IN year_ integer,
	IN semester_ integer,
	IN section_ integer
)
RETURNS void
LANGUAGE plpgsql
SECURITY definer
AS
$$
DECLARE S varchar;
	BEGIN
		EXECUTE format('COPY CourseGrades%sYear%sSemester%sSection%s FROM ''%s'' WITH(FORMAT CSV);',
					   course_id_ , year_ , semester_,section_,address);
	END;
$$;



-- Grades table	
CREATE OR REPLACE FUNCTION AddEntriesByCSVGrades(
	IN address text, 
)
RETURNS void
LANGUAGE plpgsql
SECURITY definer
AS
$$
DECLARE S varchar;
	BEGIN
		S = CONCAT( 'COPY grades from ''',address,''' WITH (FORMAT csv)' );
		EXECUTE S;
	END;
$$;
