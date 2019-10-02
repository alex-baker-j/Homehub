DROP DATABASE IF EXISTS HomeHub;

CREATE DATABASE HomeHub;

USE HomeHub;

CREATE TABLE Tasks (
    taskDesc VARCHAR(50) NOT NULL
);

INSERT INTO Tasks (taskDesc) VALUES 
	("Buy Groceries"), 
    ("Vaccum"),
    ("Take Out Trash"),
    ("Wash Dishes"),
    ("Water Plants"),
    ("Dust Cabinets"),
    ("Wash Communal Towels"),
    ("Clean Garage");
    

CREATE TABLE Users (
	email VARCHAR(50) PRIMARY KEY,
    profilePic VARCHAR(200),
    fullName VARCHAR (60),
    houseName VARCHAR(30)
);
