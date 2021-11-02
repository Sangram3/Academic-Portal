CREATE OR REPLACE FUNCTION CreateStudent( 
	IN name_ text,
	IN password_ text
)
RETURNS void
LANGUAGE plpgsql
SECURITY definer
AS
$$
DECLARE S text;
BEGIN
	S = CONCAT('CREATE USER ',
		   name_, ' WITH PASSWORD ' , '''  password_ ''' );
	EXECUTE S;
	S = CONCAT('GRANT Students TO ',name_);
	EXECUTE S;  
END;
$$





CREATE OR REPLACE FUNCTION CreateFaculty( 
	IN name_ text,
	IN password_ text
)
RETURNS void
LANGUAGE plpgsql
SECURITY definer
AS
$$
DECLARE S text;
BEGIN
	S = CONCAT('CREATE USER ',
		   name_, ' WITH PASSWORD ' , '''  password_ ''' );
	EXECUTE S;
	S = CONCAT('GRANT Faculty TO ',name_);
	EXECUTE S;  
END;
$$

CREATE OR REPLACE FUNCTION CreateDeanFA( 
	IN name_ text,
	IN password_ text
)
RETURNS void
LANGUAGE plpgsql
SECURITY definer
AS
$$
DECLARE S text;
BEGIN
	S = CONCAT('CREATE USER ',
		   name_, ' WITH PASSWORD ' , '''  password_ ''' );
	EXECUTE S;
	S = CONCAT('GRANT DeanFA TO ',name_);
	EXECUTE S;  
END;
$$

CREATE OR REPLACE FUNCTION CreateBatchAdvisor( 
	IN name_ text,
	IN password_ text
)
RETURNS void
LANGUAGE plpgsql
SECURITY definer
AS
$$
DECLARE S text;
BEGIN
	S = CONCAT('CREATE USER ',
		   name_, ' WITH PASSWORD ' , '''  password_ ''' );
	EXECUTE S;
	S = CONCAT('GRANT BatchAdvisor TO ',name_);
	EXECUTE S;  
END;
$$