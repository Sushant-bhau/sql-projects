-- Initialize School Management System Schema
DROP SCHEMA IF EXISTS school_management CASCADE;
CREATE SCHEMA IF NOT EXISTS school_management;

-- User Accounts Table
DROP TABLE IF EXISTS school_management.user_accounts;
CREATE TABLE IF NOT EXISTS school_management.user_accounts (
    user_id TEXT PRIMARY KEY,
    password TEXT,
    first_name TEXT,
    last_name TEXT,
    signup_date DATE,
    email TEXT,
    role TEXT -- Role to specify if user is an admin, teacher, student, etc.
);

-- Parent Information Table
DROP TABLE IF EXISTS school_management.parent_info;
CREATE TABLE IF NOT EXISTS school_management.parent_info (
    parent_id TEXT PRIMARY KEY,
    father_first_name TEXT,
    father_last_name TEXT,
    father_email TEXT,
    father_phone TEXT,
    father_job TEXT,
    mother_first_name TEXT,
    mother_last_name TEXT,
    mother_email TEXT,
    mother_phone TEXT,
    mother_job TEXT
);

-- Teacher Information Table
DROP TABLE IF EXISTS school_management.teachers;
CREATE TABLE IF NOT EXISTS school_management.teachers (
    teacher_id TEXT PRIMARY KEY,
    first_name TEXT,
    last_name TEXT,
    dob DATE,
    email TEXT,
    phone TEXT,
    hire_date DATE,
    employee_id TEXT UNIQUE
);

-- Class Information Table
DROP TABLE IF EXISTS school_management.classes;
CREATE TABLE IF NOT EXISTS school_management.classes (
    class_id TEXT PRIMARY KEY,
    class_teacher TEXT REFERENCES school_management.teachers (teacher_id),
    academic_year TEXT
);

-- Student Details Table
DROP TABLE IF EXISTS school_management.students;
CREATE TABLE IF NOT EXISTS school_management.students (
    student_id TEXT PRIMARY KEY,
    first_name TEXT,
    last_name TEXT,
    dob DATE,
    class_id TEXT REFERENCES school_management.classes (class_id),
    roll_number TEXT,
    email TEXT,
    parent_id TEXT REFERENCES school_management.parent_info (parent_id),
    enrollment_date DATE,
    student_id_number TEXT UNIQUE
);

-- Subject Information Table
DROP TABLE IF EXISTS school_management.subjects;
CREATE TABLE IF NOT EXISTS school_management.subjects (
    subject_id TEXT PRIMARY KEY,
    name TEXT,
    academic_year TEXT,
    head_teacher TEXT REFERENCES school_management.teachers (teacher_id)
);

-- Subject Tutors Table
DROP TABLE IF EXISTS school_management.subject_teachers;
CREATE TABLE IF NOT EXISTS school_management.subject_teachers (
    id SERIAL PRIMARY KEY,
    subject_id TEXT REFERENCES school_management.subjects (subject_id),
    teacher_id TEXT REFERENCES school_management.teachers (teacher_id),
    class_id TEXT REFERENCES school_management.classes (class_id)
);

-- Attendance Table
DROP TABLE IF EXISTS school_management.attendance;
CREATE TABLE IF NOT EXISTS school_management.attendance (
    attendance_id SERIAL PRIMARY KEY,
    student_id TEXT REFERENCES school_management.students (student_id),
    class_id TEXT REFERENCES school_management.classes (class_id),
    date DATE,
    status TEXT -- e.g., 'Present', 'Absent', 'Late'
);

-- Grades Table
DROP TABLE IF EXISTS school_management.grades;
CREATE TABLE IF NOT EXISTS school_management.grades (
    grade_id SERIAL PRIMARY KEY,
    student_id TEXT REFERENCES school_management.students (student_id),
    subject_id TEXT REFERENCES school_management.subjects (subject_id),
    class_id TEXT REFERENCES school_management.classes (class_id),
    grade TEXT -- e.g., 'A', 'B+', 'C'
);

-- Extra-Curricular Activities Table
DROP TABLE IF EXISTS school_management.activities;
CREATE TABLE IF NOT EXISTS school_management.activities (
    activity_id SERIAL PRIMARY KEY,
    activity_name TEXT,
    description TEXT,
    start_date DATE,
    end_date DATE
);

-- Student Activity Enrollment Table
DROP TABLE IF EXISTS school_management.student_activities;
CREATE TABLE IF NOT EXISTS school_management.student_activities (
    enrollment_id SERIAL PRIMARY KEY,
    student_id TEXT REFERENCES school_management.students (student_id),
    activity_id TEXT REFERENCES school_management.activities (activity_id),
    enrollment_date DATE
);

-- Library Books Table
DROP TABLE IF EXISTS school_management.library_books;
CREATE TABLE IF NOT EXISTS school_management.library_books (
    book_id TEXT PRIMARY KEY,
    title TEXT,
    author TEXT,
    genre TEXT,
    publication_year DATE,
    isbn TEXT UNIQUE
);

-- Fees Table
DROP TABLE IF EXISTS school_management.fees;
CREATE TABLE IF NOT EXISTS school_management.fees (
    fee_id SERIAL PRIMARY KEY,
    student_id TEXT REFERENCES school_management.students (student_id),
    fee_amount FLOAT,
    due_date DATE,
    paid BOOLEAN,
    payment_date DATE
);

-- Timetable Table
DROP TABLE IF EXISTS school_management.timetable;
CREATE TABLE IF NOT EXISTS school_management.timetable (
    timetable_id SERIAL PRIMARY KEY,
    class_id TEXT REFERENCES school_management.classes (class_id),
    subject_id TEXT REFERENCES school_management.subjects (subject_id),
    teacher_id TEXT REFERENCES school_management.teachers (teacher_id),
    day_of_week TEXT, -- e.g., 'Monday'
    start_time TIME,
    end_time TIME
);
