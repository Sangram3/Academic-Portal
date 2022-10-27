-- Whenever there is entry in CourseOffering table a table is created dynamically to 
-- store the grades of that offering


-- Dynamic tables will make the schema complicated but as the information is stored 
-- in separated tables functioning will be fast.

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
		EXECUTE S; -- Execute query
		RETURN NULL;

	END;
$$;


CREATE TRIGGER CreateCourseGrades 				-- create the trigger
AFTER INSERT ON CourseOfferings 				-- on occurence of this event
FOR EACH ROW  									-- affected rows
EXECUTE PROCEDURE CreateCourseGradesTable(); 	-- execute this stored procedure


-- Function to enter the grade entries to the table directly from the csv file.
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
