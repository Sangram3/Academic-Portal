-- When a certain course is offered then new table is created to store the grades of the students
-- taking that course



CREATE OR REPLACE FUNCTION AddEntriesByCsv(
	IN address text
)

RETURNS TABLE(
	course_id text  ,
	student_id integer  ,
	year integer  ,
	semester integer  ,
	grade integer 
)
LANGUAGE plpgsql
SECURITY definer
AS
$$
	BEGIN
		RETURN COPY grades FROM address WITH (FORMAT csv);
	END;
$$;

