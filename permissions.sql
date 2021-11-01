-- create role  boys with user sangram,harsh,john;
-- grant boys to sangram;
-- GRANT SELECT 
-- ON gg 
-- TO boys;


CREATE ROLE Students;
CREATE ROLE Faculty;
CREATE ROLE BatchAdvisor;
CREATE ROLE DeanFA;


--Register Function
GRANT ALL ON FUNCTION Register TO Students;
GRANT ALL ON FUNCTION CalculateCGPA TO Faculty, DeanFA;
GRANT ALL ON FUNCTION CheckGrades TO Students, Faculty, BatchAdvisor, DeanFA;
GRANT ALL ON FUNCTION CreateCourseGradesTable TO Students, Faculty, BatchAdvisor, DeanFA;
GRANT ALL ON FUNCTION AddEntriesByCsv TO Students, Faculty, BatchAdvisor, DeanFA;
GRANT ALL ON FUNCTION CreateStudent TO Students, Faculty, BatchAdvisor, DeanFA;
GRANT ALL ON FUNCTION CreateFaculty TO Students, Faculty, BatchAdvisor, DeanFA;
GRANT ALL ON FUNCTION CreateDeanFA TO Students, Faculty, BatchAdvisor, DeanFA;
GRANT ALL ON FUNCTION CreateStudentTranscrptTable TO Students, Faculty, BatchAdvisor, DeanFA;
GRANT ALL ON FUNCTION RegisterTicket TO Students, Faculty, BatchAdvisor, DeanFA;

