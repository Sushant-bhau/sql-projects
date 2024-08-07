-- Initialize Library Management System Schema
DROP SCHEMA IF EXISTS lib_management CASCADE;
CREATE SCHEMA IF NOT EXISTS lib_management;

-- User Credentials Table with Role
DROP TABLE IF EXISTS lib_management.user_credentials;
CREATE TABLE lib_management.user_credentials (
    user_id VARCHAR(255) PRIMARY KEY,
    password VARCHAR(255),
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    registration_date DATE,
    email VARCHAR(255),
    role VARCHAR(50) -- Added role for different types of users (e.g., admin, member)
);

-- Publisher Information Table
DROP TABLE IF EXISTS lib_management.publishers;
CREATE TABLE lib_management.publishers (
    publisher_id VARCHAR(255) PRIMARY KEY,
    name VARCHAR(255),
    distributor_name VARCHAR(255),
    total_releases INT,
    latest_release DATE
);

-- Author Details Table
DROP TABLE IF EXISTS lib_management.authors;
CREATE TABLE lib_management.authors (
    author_id VARCHAR(255) PRIMARY KEY,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    total_publications INT
);

-- Book Categories Table
DROP TABLE IF EXISTS lib_management.book_categories;
CREATE TABLE lib_management.book_categories (
    category_id VARCHAR(255) PRIMARY KEY,
    category_name VARCHAR(255)
);

-- Books Inventory Table with Category
DROP TABLE IF EXISTS lib_management.books_inventory;
CREATE TABLE lib_management.books_inventory (
    book_id VARCHAR(255) PRIMARY KEY,
    code VARCHAR(255),
    title VARCHAR(255),
    author_id VARCHAR(255),
    publisher_id VARCHAR(255),
    version VARCHAR(255),
    release_date DATE,
    available_since DATE,
    is_available BOOLEAN,
    category_id VARCHAR(255), -- Added category reference
    FOREIGN KEY (author_id) REFERENCES lib_management.authors (author_id),
    FOREIGN KEY (publisher_id) REFERENCES lib_management.publishers (publisher_id),
    FOREIGN KEY (category_id) REFERENCES lib_management.book_categories (category_id)
);

-- Library Staff Table
DROP TABLE IF EXISTS lib_management.library_staff;
CREATE TABLE lib_management.library_staff (
    staff_id VARCHAR(255) PRIMARY KEY,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    role VARCHAR(255),
    start_date DATE,
    end_date DATE,
    currently_active BOOLEAN,
    shift_start TIME,
    shift_end TIME
);

-- Library Patrons Table
DROP TABLE IF EXISTS lib_management.patrons;
CREATE TABLE lib_management.patrons (
    patron_id VARCHAR(255) PRIMARY KEY,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    registration_date DATE,
    total_books_issued INT,
    books_issued_now INT,
    has_current_issues BOOLEAN,
    last_issued_date DATE,
    accumulated_fine FLOAT,
    current_fine FLOAT
);

-- Book Transactions Table
DROP TABLE IF EXISTS lib_management.book_transactions;
CREATE TABLE lib_management.book_transactions (
    transaction_id SERIAL PRIMARY KEY,
    book_id VARCHAR(255),
    patron_id VARCHAR(255),
    issue_date DATE,
    return_date DATE,
    outstanding_fine FLOAT,
    fine_paid BOOLEAN,
    payment_id VARCHAR(255),
    FOREIGN KEY (book_id) REFERENCES lib_management.books_inventory (book_id),
    FOREIGN KEY (patron_id) REFERENCES lib_management.patrons (patron_id)
);

-- Book Reviews Table
DROP TABLE IF EXISTS lib_management.book_reviews;
CREATE TABLE lib_management.book_reviews (
    review_id SERIAL PRIMARY KEY,
    book_id VARCHAR(255),
    reviewer_id VARCHAR(255), -- Could be a patron or staff member
    review_date DATE,
    rating INT CHECK (rating >= 1 AND rating <= 5),
    review_text TEXT,
    FOREIGN KEY (book_id) REFERENCES lib_management.books_inventory (book_id),
    FOREIGN KEY (reviewer_id) REFERENCES lib_management.user_credentials (user_id)
);

-- Settings Table
DROP TABLE IF EXISTS lib_management.settings;
CREATE TABLE lib_management.settings (
    max_books_per_patron INT,
    daily_fine FLOAT,
    return_period_days INT
);

-- Transaction History Table
DROP TABLE IF EXISTS lib_management.transaction_history;
CREATE TABLE lib_management.transaction_history (
    history_id SERIAL PRIMARY KEY,
    transaction_id INT,
    transaction_date DATE,
    transaction_type VARCHAR(50), -- e.g., issue, return, fine payment
    amount FLOAT,
    FOREIGN KEY (transaction_id) REFERENCES lib_management.book_transactions (transaction_id)
);
