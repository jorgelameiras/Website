CREATE DATABASE IF NOT EXISTS furreverHomeDB;
USE furreverHomeDB;

-- for testing
DROP TABLE IF EXISTS Preferred_Pets;
DROP TABLE IF EXISTS Pet;
DROP TABLE IF EXISTS Shelter;
DROP TABLE IF EXISTS Admin_Account;
DROP TABLE IF EXISTS Adopter;
--

-- Adopter table to store adopter-specific information
CREATE TABLE IF NOT EXISTS Adopter (
    Adopter_ID INT AUTO_INCREMENT PRIMARY KEY,   -- Identifier for each adopter
    User_Password VARCHAR(255) NOT NULL,         -- Adopter's password (hashed)
    Email VARCHAR(255) NOT NULL UNIQUE,          -- Adopter's email, must be unique
    Phone_Number VARCHAR(20),                    -- Adopter's phone number
    Zipcode VARCHAR(10)                          -- Adopter's ZIP code
);

-- Admin_Account table to store admin-specific information
CREATE TABLE IF NOT EXISTS Admin_Account (
    Admin_ID INT AUTO_INCREMENT PRIMARY KEY,   -- Identifier for each admin
    User_Password VARCHAR(255) NOT NULL,       -- Admin's password (hashed)
    Email VARCHAR(255) NOT NULL UNIQUE,        -- Admin's email, must be unique
    Phone_Number VARCHAR(20),                  -- Admin's phone number
    Permissions TEXT                           -- Permissions granted to the admin (can be JSON format in the future)
);

-- Shelter table to store shelter information
CREATE TABLE IF NOT EXISTS Shelter (
    Shelter_ID INT AUTO_INCREMENT PRIMARY KEY, -- identifier for each shelter
    Shelter_Name VARCHAR(255) NOT NULL,        -- Name of the shelter
    Address VARCHAR(255),                      -- Address of the shelter
    Shelter_Description TEXT,                  -- Description of the shelter
    Logo VARCHAR(255),                         -- URL or path to the shelters logo
    Website_Link VARCHAR(255),                 -- Link to the shelter's website
    Hours_Of_Operation VARCHAR(255),           -- Hours of operation for the shelter
    Email VARCHAR(255) NOT NULL UNIQUE,        -- Shelter's contact email, must be unique
    Phone_Number VARCHAR(20)                   -- Shelter's contact phone number
);

-- Pet table to store information about pets
CREATE TABLE IF NOT EXISTS Pet (
    Pet_ID INT AUTO_INCREMENT PRIMARY KEY,  -- Identifier for each pet
    Shelter_ID INT NOT NULL,                -- (foreign key)
    Pet_Name VARCHAR(100) NOT NULL,         -- Pet's name
    Pet_Description TEXT,                   -- Description of the pet
    Image VARCHAR(255),                     -- URL or path to the pet's image
    Breed VARCHAR(100),                     -- Pet's breed
    Species ENUM('Dog', 'Cat') NOT NULL,    -- Species of the pet
    Gender ENUM('Male', 'Female') NOT NULL, -- Pet's gender
    Age INT,                                -- Pet's age in years
    Size VARCHAR(50),                       -- Pet's size (e.g., small, medium, large)
    Date_Of_Arrival DATE,                   -- Date when the pet arrived at the shelter
    Availability_Status ENUM('Available', 'Adopted', 'Processing') NOT NULL DEFAULT 'Processing', -- Current availability status
    FOREIGN KEY (Shelter_ID) REFERENCES Shelter(Shelter_ID) ON DELETE CASCADE -- If shelter is deleted this deletes too
);

-- Preferred_Pets table to track pets that adopters are interested in
CREATE TABLE IF NOT EXISTS Preferred_Pets (
    Adopter_ID INT NOT NULL,     -- (foreign key)
    Pet_ID INT NOT NULL,         -- (foreign key)
    PRIMARY KEY (Adopter_ID, Pet_ID), -- Composite primary key to ensure uniqueness for each Adopter-Pet preference
    FOREIGN KEY (Adopter_ID) REFERENCES Adopter(Adopter_ID) ON DELETE CASCADE, -- If adopter is deleted this is too
    FOREIGN KEY (Pet_ID) REFERENCES Pet(Pet_ID) ON DELETE CASCADE -- " " 
);

-- Populate tables for testing
INSERT INTO Adopter (User_Password, Email, Phone_Number, Zipcode)
VALUES ('$2b$10$E5H8yT94.JspOjIEO2gq7uq09i1/OMgv5qghz6Kkp8aaWZ8u8N0iG', 'adopter1@example.com', '123-456-7890', '32801');
-- 
INSERT INTO Admin_Account (User_Password, Email, Phone_Number, Permissions)
VALUES ('$2b$10$F3x4lH4q5IE9xoO9IRtgu.Qo3L7Ek71rFZ.PzlmTeh/9hXLvV5J4K', 'admin1@example.com', '987-654-3210', '["manage_shelters", "manage_users", "view_reports"]');
-- 
INSERT INTO Shelter (Shelter_Name, Address, Shelter_Description, Logo, Website_Link, Hours_Of_Operation, Email, Phone_Number)
VALUES ('Happy Tails Shelter', '123 Main St, Orlando, FL', 'A community-driven animal shelter helping pets find loving homes.', 'logo.png', 'http://www.happytails.org', 'Mon-Fri 9am-5pm', 'info@happytails.org', '321-555-1234');
--
INSERT INTO Pet (Shelter_ID, Pet_Name, Pet_Description, Image, Breed, Species, Gender, Age, Size, Date_Of_Arrival, Availability_Status)
VALUES (1, 'Buddy', 'Friendly Labrador retriever who loves playing fetch.', 'buddy.png', 'Labrador Retriever', 'Dog', 'Male', 3, 'Medium', '2024-05-10', 'Available');
--
INSERT INTO Preferred_Pets (Adopter_ID, Pet_ID)
VALUES (1, 1);
-- Print
SELECT * FROM Adopter;
SELECT * FROM Admin_Account;
SELECT * FROM Shelter;
SELECT * FROM Pet;
SELECT * FROM Preferred_Pets;