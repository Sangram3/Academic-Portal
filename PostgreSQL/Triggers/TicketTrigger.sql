-- When there is update in ticket table trigger invokes this function
----------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION RegisterTicket()
RETURNS TRIGGER 
LANGUAGE plpgsql
SECURITY definer
AS
$$

BEGIN
	IF NEW.status = 'Accepted'  THEN
		INSERT INTO StudentRegistrationTable VALUES(
			 OLD.student_id ,
			 OLD.course_id,
			 OLD.semester,
			 OLD.year,
			 OLD.section,
			 OLD.slot_id );
	ELSE
		DELETE FROM TicketTable ;
	
	END IF;
	RETURN NEW;
END;
$$;
----------------------------------------------------------------------------
--Instructor Ticket Update
CREATE OR REPLACE FUNCTION InstructorTicketUpdate(
	IN ticket_id_ integer,
	IN status_ text
)
RETURNS void
LANGUAGE plpgsql
SECURITY DEFINER

AS $$
BEGIN 
UPDATE TicketTable
SET status = status_
WHERE ticket_id = ticket_id_;
END;
$$;

----------------------------------------------------------------------------
--BatchAdvisor Ticket Update
CREATE OR REPLACE FUNCTION BATicketUpdate(
	IN ticket_id_ integer,
	IN status_ text
)
RETURNS void
LANGUAGE plpgsql
SECURITY DEFINER

AS $$
BEGIN 
UPDATE TicketTable
SET status = status_
WHERE ticket_id = ticket_id_;
END;
$$;

----------------------------------------------------------------------------
--DeanFA Ticket Update
CREATE OR REPLACE FUNCTION DeanFATicketUpdate(
	IN ticket_id_ integer,
	IN status_ text
)
RETURNS void
LANGUAGE plpgsql
SECURITY DEFINER

AS $$
BEGIN 

UPDATE TicketTable
SET status = status_ , DeanUpdate = 'YES'
WHERE ticket_id = ticket_id_;
END;
$$;

----------------------------------------------------------------------------
CREATE TRIGGER RecordTicketTable
	AFTER UPDATE ON TicketTable
	FOR EACH ROW
	WHEN ( (NEW.status ='Accepted' OR NEW.status='Rejected') AND NEW.DeanUpdate = 'YES' )
	EXECUTE function RegisterTicket();
----------------------------------------------------------------------------


