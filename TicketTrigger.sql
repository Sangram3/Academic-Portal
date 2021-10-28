-- When there is update in ticket table trigger invokes this function

CREATE OR REPLACE FUNCTION RegisterTicket()
RETURNS TRIGGER 
LANGUAGE plpgsql
AS
$$

BEGIN
	IF NEW.status = 'Accepted' THEN
		INSERT INTO StudentRegistrationTable VALUES(
			 OLD.student_id ,
			 OLD,course_id,
			 OLD.semester,
			 OLD.year,
			 OLD.section,
			 OLD.slot );
	ELSE
		DELETE FROM TicketTable WHERE id = OLD.id;
	
	END IF;
	RETURN NEW;
END;
$$;

----------------------------------------------------------------------------
CREATE TRIGGER RecordTicketTable
	
	AFTER UPDATE ON TicketTable
	FOR EACH ROW
	WHEN (NEW.status ='Accepted' OR NEW.status='Rejected' )
	EXECUTE function RegisterTicket();
