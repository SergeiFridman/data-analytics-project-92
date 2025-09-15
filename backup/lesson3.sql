SELECT
    Class.name AS class,
    Student.first_name,
    Student.last_name
FROM Class
INNER JOIN Student_in_class
    ON Class.id = Student_in_class.class
INNER JOIN Student
    ON Student_in_class.student = Student.id
ORDER BY Class.id