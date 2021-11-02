-- create role  boys with user sangram,harsh,john;
-- grant boys to sangram;
-- GRANT SELECT 
-- ON gg 
-- TO boys;


CREATE ROLE Students;
CREATE ROLE Faculty;
CREATE ROLE BatchAdvisor;
CREATE ROLE DeanFA;

GRANT ALL ON FUNCTION Register TO Students;
GRANT ALL ON FUNCTION CalculateCGPA TO Faculty, DeanFA;
GRANT ALL ON FUNCTION AddEntriesByCSVCourseGrade TO Faculty;
GRANT ALL ON FUNCTION CreateCourseGradesTable TO Faculty;
GRANT ALL ON FUNCTION StudentTranscriptUpdate TO DeanFA;
GRANT ALL ON FUNCTION CreateStudent TO  DeanFA;
GRANT ALL ON FUNCTION CreateFaculty TO DeanFA;
GRANT ALL ON FUNCTION CreateDeanFA TO DeanFA;
GRANT ALL ON FUNCTION CreateStudentTranscriptTable TO Students, Faculty, BatchAdvisor, DeanFA;
GRANT ALL ON FUNCTION RegisterTicket TO  DeanFA;

