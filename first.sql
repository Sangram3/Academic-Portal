
CREATE TABLE StudentRegistrationTable(
	student_id integer NOT NULL,
	course_id text NOT NULL,
	semester integer NOT NULL,
	year integer NOT NULL,
	section integer NOT NULL,
	slot text NOT NULL
);

-- INSERT INTO StudentRegistrationTable VALUES(
-- 	12,'CS201',1,2021,1,'s1'
-- );
-- INSERT INTO StudentRegistrationTable VALUES(
-- 	13,'CS201',1,2021,1,'s4'
-- );
-- INSERT INTO StudentRegistrationTable VALUES(
-- 	12,'CS204',1,2021,1,'s1'
-- );
-- INSERT INTO StudentRegistrationTable VALUES(
-- 	12,'CS204',1,2020,1,'s1'
-- );


-- select * from StudentRegistrationTable;
DROP FUNCTION Register;

CREATE OR REPLACE FUNCTION Register(
	IN student_id integer,
	IN course_id text,
	IN year integer,
	IN semester integer,
	IN section integer,
	IN slot text
)

RETURNS integer
LANGUAGE plpgsql
AS $$

DECLARE count_rows integer;

BEGIN
	
	-- check this slot is already there in the StudentRegistration table
	SELECT COUNT(*) FROM StudentRegistrationTable AS SRT
	
	WHERE SRT.
	RETURN semester;
	
END;


$$;


select Register('sangram',2021 , 1,3,'s1');
