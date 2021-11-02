-- when there is entry in CourseOffering table a table is created dynamically to store the grades of that offering

CREATE OR REPLACE FUNCTION CreateCourseGradesTable()
RETURNS TRIGGER
LANGUAGE plpgsql
SECURITY definer
AS $$
DECLARE 
S varchar;
cond integer;

BEGIN
S = CONCAT('CREATE TABLE IF NOT EXISTS CourseGrades_',
		   NEW.course_id,
		   'Year',NEW.year ,
		   'Semester',NEW.semester,
		   'Section',NEW.section,
		   '(student_id integer PRIMARY KEY , grade integer )');	   
EXECUTE S;
RETURN NULL;
END;
$$;

CREATE TRIGGER CreateCourseGrades
	AFTER INSERT ON CourseOfferings
	FOR EACH ROW 
	EXECUTE PROCEDURE CreateCourseGradesTable();
