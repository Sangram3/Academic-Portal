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



CREATE OR REPLACE FUNCTION AddEntriesByCSVGrades(
	IN address text
)
RETURNS void
LANGUAGE plpgsql
SECURITY definer
AS
$$
DECLARE S varchar;
	BEGIN	
		EXECUTE format('COPY Grades FROM ''%s'' WITH(FORMAT CSV);',
					   address);
	END;
$$;

SElECT AddEntriesByCSVGrades('C:\Users\ACER\Desktop\Sem 5\CS 517\Labs\2019CSB1091_PA1\Grade.csv');
