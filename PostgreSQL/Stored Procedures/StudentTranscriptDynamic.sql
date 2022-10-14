-- Created a trigger which invokes the below function whenever there is new entry in
-- student table and generates a transcript table dynamically to store the grades of that student

CREATE OR REPLACE FUNCTION CreateStudentTranscrptTable()
RETURNS TRIGGER
LANGUAGE plpgsql
SECURITY definer
AS $$
DECLARE 
S varchar;
cond integer;

BEGIN
S = CONCAT('CREATE TABLE IF NOT EXISTS StudentTranscript',
		   New.student_id ,
		   '(course_id text PRIMARY KEY, course_name text , grade integer )');
		   
EXECUTE S;
RETURN NULL;
END;
$$;


CREATE TRIGGER CreateStudentTranscript
	AFTER INSERT ON Students
	FOR EACH ROW 
	EXECUTE PROCEDURE CreateStudentTranscrptTable();



CREATE OR REPLACE FUNCTION StudentTranscriptUpdate(
	IN student_id_ integer
)
RETURNS void
LANGUAGE plpgsql
SECURITY definer
AS
$$
DECLARE S varchar;
	BEGIN	
		EXECUTE FORMAT( 'INSERT INTO StudentTranscript%s SELECT g.course_id , g.grade FROM
					   Grades as g WHERE g.student_id = %s' , student_id_ , student_id_);
		
	END;
$$;
