INSERT INTO students(student_name , year_joined,branch, cgpa) VALUES('Sangram Jagadale',2019,'CSE', 4);
INSERT INTO students(student_name , year_joined,branch, cgpa) VALUES('Jaglike Makkar',2019,'CSE', 8);
INSERT INTO students(student_name , year_joined,branch, cgpa) VALUES('Harshwardhan Kumar',2019,'CSE' , 7);
INSERT INTO students(student_name , year_joined,branch, cgpa) VALUES('Mihir Dalal',2019,'EE' , 7);
INSERT INTO students(student_name , year_joined,branch, cgpa) VALUES('Kedar Swami',2019,'ME' , 7.4);
INSERT INTO students(student_name , year_joined,branch, cgpa) VALUES('Mihir Swami',2019,'EE' , 9);
INSERT INTO students(student_name , year_joined,branch, cgpa) VALUES('Kedar Dalal',2019,'ME' , 4);

INSERT INTO CourseCatalogue(course_id , course_name , l, t , p , s , c , prerequisite)
VALUES( 'CS301' , 'ABC' , 1 , 2 , 3 , 4 , 3.5, 'CS201' );

INSERT INTO CourseCatalogue(course_id , course_name , l, t , p , s , c , prerequisite)
VALUES( 'CS303' , 'ABC' , 1 , 2 , 3 , 4 , 2.5, 'CS203' );

INSERT INTO CourseCatalogue(course_id , course_name , l, t , p , s , c , prerequisite)
VALUES( 'CS302' , 'ABC' , 1 , 2 , 3 , 4 , 4.5, 'CS202' );

INSERT INTO CourseCatalogue(course_id , course_name , l, t , p , s , c )
VALUES( 'CS201' ,'DSA', 1 , 2 , 3 , 4 , 4.5 );

INSERT INTO CourseCatalogue(course_id , course_name , l, t , p , s , c )
VALUES( 'CS203' , 'ABC' , 1 , 2 , 3 , 4 , 4.5 );

INSERT INTO CourseCatalogue(course_id , course_name , l, t , p , s , c )
VALUES( 'CS202' ,'CBA', 1 , 2 , 3 , 4 , 1.5 );

INSERT INTO CourseCatalogue(course_id , course_name , l, t , p , s , c )
VALUES( 'Dummy1' ,'CBA', 1 , 2 , 3 , 1 , 10 );
--Slots

INSERT INTO TimeTableSlots(week_day , start_time , end_time)
VALUES('Sat' , 12 , 1);

INSERT INTO TimeTableSlots(week_day , start_time , end_time)
VALUES('Sat' , 1 , 2);

INSERT INTO TimeTableSlots(week_day , start_time , end_time)
VALUES('Fri' , 9 , 10);

INSERT INTO TimeTableSlots(week_day , start_time , end_time)
VALUES('Thu' , 8 , 9);

INSERT INTO TimeTableSlots(week_day , start_time , end_time)
VALUES('Mon' , 10 , 11);

INSERT INTO TimeTableSlots(week_day , start_time , end_time)
VALUES('Tue' , 10 , 11);

-- Instructors
INSERT INTO Instructors(instructor_name)
VALUES('Puneet Goyal');

INSERT INTO Instructors(instructor_name)
VALUES('TV Kalyan');

INSERT INTO Instructors(instructor_name)
VALUES('Surjeet Sehgal');

-- Course Offerings

INSERT INTO CourseOfferings(course_id , instructor_id ,year, semester, section , slot_id , cgpa_cutoff,branch )
VALUES( 'CS301' , 1 , 2019, 1 , 1 , 2 , 7.5 , 'CSE');
INSERT INTO CourseOfferings(course_id , instructor_id ,year, semester, section , slot_id , cgpa_cutoff,branch )
VALUES( 'CS301' , 1 , 2019, 1 , 1 , 2 , 7.5 , 'EE');

INSERT INTO CourseOfferings(course_id , instructor_id ,year, semester, section , slot_id , cgpa_cutoff,branch )
VALUES( 'CS303' , 2 , 2019, 1 , 1 , 1 , 0 , 'CSE');

INSERT INTO CourseOfferings(course_id , instructor_id ,year, semester, section , slot_id , cgpa_cutoff,branch )
VALUES( 'CS302' , 3 , 2019, 1 , 1 , 3 , 0 , 'CSE');

INSERT INTO CourseOfferings(course_id , instructor_id ,year, semester, section , slot_id , cgpa_cutoff,branch )
VALUES( 'CS302' , 3 , 2019, 1 , 1 , 3 , 0 , 'EE');

INSERT INTO CourseOfferings(course_id , instructor_id ,year, semester, section , slot_id , cgpa_cutoff,branch )
VALUES( 'CS302' , 3 , 2019, 1 , 1 , 3 , 0 , 'ME');

INSERT INTO CourseOfferings(course_id , instructor_id ,year, semester, section , slot_id , cgpa_cutoff,branch )
VALUES( 'Dummy1' , 3 , 2019, 1 , 1 , 3 , 0 , 'CSE');
-- Batch Advisors

INSERT INTO BatchAdvisors(ba_name)
VALUES('Puneet');

INSERT INTO BatchAdvisors(ba_name)
VALUES('TV');

INSERT INTO BatchAdvisors(ba_name)
VALUES('Surjeet');

-- Dean of Academics
INSERT INTO DeanFA(dean_name)
VALUES('Neeraj Goyal');

SElECT AddEntriesByCSVGrades('C:\Users\ACER\Desktop\Sem 5\CS 517\Labs\2019CSB1091_PA1\Grade.csv');






