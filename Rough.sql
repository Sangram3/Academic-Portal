  create role  boys with user sangram,harsh,john;
grant boys to sangram;
GRANT SELECT 
ON gg 
TO boys;


CREATE ROLE Students;
CREATE ROLE Faculty;
CREATE ROLE BatchAdvisor;
CREATE ROLE DeanFA;


--Register Function
GRANT ALL ON FUNCTION Register TO Students;
GRANT ALL ON FUNCTION CalculateCGPA TO Faculty, DeanFA;


