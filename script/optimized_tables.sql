-- Our modifications of the schema to optimize tables, are the following:
1)
CREATE TABLE product (
id INT PRIMARY KEY, 
source_id INT, 
drug_id CHAR(7) NOT NULL, 
name VARCHAR(200), 
url VARCHAR(200),
type VARCHAR(10), 
n_reviews INT, 
manufacturer_id INT NOT NULL);


2)
CREATE TABLE drug (
id CHAR(7) PRIMARY KEY, 
name VARCHAR(200), 
wiki_url VARCHAR(200), 
drugbank_url VARCHAR(200) );


3)
CREATE TABLE price (
id INT PRIMARY KEY, 
product_id INT NOT NULL, 
store_id INT NOT NULL, 
type VARCHAR(10), 
price FLOAT, 
url VARCHAR(700) );


4)
CREATE TABLE condition (
id INT PRIMARY KEY, 
name VARCHAR(100), 
source_id INT, 
url VARCHAR(200) );


5)
CREATE TABLE treatment (
id INT PRIMARY KEY, 
source_id INT, 
condition_id INT NOT NULL, 
drug_id CHAR(7) NOT NULL);


6)
CREATE TABLE store (
id INT PRIMARY KEY, 
name VARCHAR(100) );


7)
CREATE TABLE manufacturer (
id INT PRIMARY KEY, 
name VARCHAR(100) );