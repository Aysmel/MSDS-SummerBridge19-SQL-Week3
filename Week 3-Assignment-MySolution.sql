-- MSDS Summer Bridge 2019
-- Week 3 Assignment: Build a Relational Database Management System
-- Aysmel Aguasvivas Velazquez
-- July 29, 2019

-- 1. An organization grants key-card access to rooms based on groups that key-card holders belong to. You may assume that
-- users below to only one group. Your job is to design the database that supports the key-card system.
-- There are six users, and four groups. Modesto and Ayine are in group “I.T.” Christopher and Cheong woo are in group
-- “Sales”. There are four rooms: “101”, “102”, “Auditorium A”, and “Auditorium B”. Saulat is in group
-- “Administration.” Group “Operations” currently doesn’t have any users assigned. I.T. should be able to access Rooms
-- 101 and 102. Sales should be able to access Rooms 102 and Auditorium A. Administration does not have access to any
-- rooms. Heidy is a new employee, who has not yet been assigned to any group.

-- After you determine the tables any relationships between the tables (One to many? Many to one? Many to many?), you
-- should create the tables and populate them with the information indicated above..

-- Create table for groups
DROP TABLE IF EXISTS secGroups;

CREATE TABLE secGroups (
  grpID integer NOT NULL,
  grpName varchar(100) NOT NULL,
  PRIMARY KEY (grpID)
  );

-- Insert values into secGroups table  
INSERT INTO secGroups
VALUES (1, 'I.T.'),
	(2, 'Sales'),
    (3, 'Administration'),
    (4, 'Operations');

-- Create table for employees
DROP TABLE IF EXISTS employees;

CREATE TABLE employees (
  empID integer NOT NULL,
  empName varchar(100) NOT NULL,
  empGroup integer,
  PRIMARY KEY (empID),
  FOREIGN KEY (empGroup) REFERENCES secGroups(grpID)
  );
  
-- Insert values into employees table  
INSERT INTO employees
VALUES (101, 'Modesto', 1),
	(102, 'Ayine', 1),
    (103, 'Christopher', 2),
    (104, 'Cheong Woo', 2),
    (105, 'Saulat', 3),
    (106, 'Heidy', NULL);
  
 -- Create table for rooms
DROP TABLE IF EXISTS rooms;

CREATE TABLE rooms (
  rmsID integer NOT NULL,
  rmsName varchar(100) NOT NULL,
  PRIMARY KEY (rmsID)
  ); 
  
-- Insert values into rooms table  
INSERT INTO rooms
VALUES (11, '101'),
	(12, '102'),
    (13, 'Auditorium A'),
    (14, 'Auditorium B');
  
 -- Create table for room access
DROP TABLE IF EXISTS roomAccess;

CREATE TABLE roomAccess (
  rmaRoomID integer NOT NULL,
  rmaGroupID integer NOT NULL,
  PRIMARY KEY (rmaRoomID, rmaGroupID),
  FOREIGN KEY (rmaRoomID) REFERENCES rooms(rmsID),
  FOREIGN KEY (rmaGroupID) REFERENCES secGroups(grpID)
  );
  
-- Insert values into roomAccess table  
INSERT INTO roomAccess
VALUES (11, 1),
	(12, 1),
    (12, 2),
    (13, 2);
  
-- Next, write SELECT statements that provide the following information:
-- All groups, and the users in each group. A group should appear even if there are no users assigned to the group.

SELECT grpID,
	grpName,
    empID,
    empName
FROM secGroups
	LEFT JOIN employees
	ON empGroup = grpID;

-- All rooms, and the groups assigned to each room. The rooms should appear even if no groups have been assigned to them.

SELECT rmsID,
    rmsName,
    grpID,
	grpName
FROM roomAccess
	RIGHT JOIN rooms
		ON rmaRoomID = rmsID
    LEFT JOIN secGroups
		ON rmaGroupID = grpID;

-- A list of users, the groups that they belong to, and the rooms to which they are assigned. This should be sorted
-- alphabetically by user, then by group, then by room.

SELECT empID,
    empName,
	grpName,
    rmsName
FROM employees
	LEFT JOIN secGroups
		ON empGroup = grpID
    LEFT JOIN roomAccess
		ON rmaGroupID = grpID
	LEFT JOIN rooms
		ON rmaRoomID = rmsID
ORDER BY empName,
	grpName,
    rmsName;