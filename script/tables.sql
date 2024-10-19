-- Data Management for Data Science: Homework 1-2
-- GROUP 25: Stefano Rinaldi (mtr. 1945551) and Sofia Noemi Crobeddu (mtr. 2130389)
-- Dataset: Open Drug Knowledge Graph

1)
CREATE TABLE product (
id INT, 
source_id INT, 
drug_id CHAR(7), 
name VARCHAR(200), 
url VARCHAR(200),
type VARCHAR(10), 
n_reviews INT, 
manufacturer_id INT);


2)
CREATE TABLE drug (
id CHAR(7), 
name VARCHAR(200), 
wiki_url VARCHAR(200), 
drugbank_url VARCHAR(200) );


3)
CREATE TABLE price (
id INT, 
product_id INT, 
store_id INT, 
type VARCHAR(10), 
price FLOAT, 
url VARCHAR(700) );


4)
CREATE TABLE condition (
id INT, 
name VARCHAR(100), 
source_id INT, 
url VARCHAR(200) );


5)
CREATE TABLE treatment (
id INT, 
source_id INT, 
condition_id INT, 
drug_id CHAR(7) );


6)
CREATE TABLE store (
id INT, 
name VARCHAR(100) );


7)
CREATE TABLE manufacturer (
id INT, 
name VARCHAR(100) );