# DM_medical_dataset: Open Drug Knowledge Graph

This project was carried out by Group 25 for the frist two assignments of the course of Data Management for Data Science from the Master's degree in Data science at Sapienza University of Rome.
Thr group was composed by:
| NAME and SURNAME | MATRICOLA | EMAIL |
| --- | --- | --- |
| Sofia Noemi Crobeddu | 2130389 | crobeddu.2130389@studenti.uniroma1.it | 
| Stefano Rinaldi | 1945551 | rinaldi.1945551@studenti.uniroma1.it |

## PURPOSE

The aim of this project is to create a database about medical drugs and products, extracting their information through queries. After this first implementation, it was also performed the optimization of tables and queries in order to veloize the process of extraction.

## REPOSITORIES

The repositories are 2:
- **data**: it contains the csv files with the original datasets.

- **script**: it contains the sql files with the instructions performing the task. The files inside are the following ones:

`tables.sql`
> The SQL code of the initial tables;

`queries.sql`
> The SQL code of the initial queries;

`optimized_tables.sql`
> The SQL code of the optimized tables (with primary keys and other modifications);

`optimized_queries.sql`
> The SQL code of the optimized queries (through indeces for example);

## LOGICAL MODEL

The logical model which establishes the structure of data and their relationships is the following one:

| ENTITY          | ATTRIBUTES                                                                                      | FOREIGN KEY                                      |
|-----------------|-------------------------------------------------------------------------------------------------|--------------------------------------------------|
| `Product`       | :key: **id** <br> :small_blue_diamond: source_id <br> :small_blue_diamond: drug_id <br> :small_blue_diamond: name <br> :small_blue_diamond: url <br> :small_blue_diamond: type <br> :small_blue_diamond: n_reviews <br> :small_blue_diamond: manufacturer_id | :link: manufacturer_id (Ref. *`Manufacturer`: id*) |
| `Drug`          | :key: **id** <br> :small_blue_diamond: name <br> :small_blue_diamond: wiki_url <br> :small_blue_diamond: drugbank_url          |   /                                              |
| `Price`         | :key: **id** <br> :small_blue_diamond: product_id <br> :small_blue_diamond: store_id <br> :small_blue_diamond: type <br> :small_blue_diamond: price <br> :small_blue_diamond: url | :link: product_id (Ref. *`Product`: id*) <br> :link: store_id (Ref. *`Store`: id*) |
| `Condition`     | :key: **id** <br> :small_blue_diamond: name <br> :small_blue_diamond: source_id <br> :small_blue_diamond: url                  |   /                                              |
| `Treatment`     | :key: **id** <br> :small_blue_diamond: source_id <br> :small_blue_diamond: condition_id <br> :small_blue_diamond: drug_id       | :link: condition_id (Ref. *`Condition`: id*) <br> :link: drug_id (Ref. *`Drug`: id*) |
| `Store`         | :key: **id** <br> :small_blue_diamond: name                                                     |   /                                              |
| `Manufacturer`  | :key: **id** <br> :small_blue_diamond: name                                                     |   /                                              |

### Relationships

- **Product** references **Manufacturer** via `manufacturer_id`
- **Price** references **Product** via `product_id` and **Store** via `store_id`
- **Treatment** references **Condition** via `condition_id` and **Drug** via `drug_id`.


## DATA

Database is builded from the following tables:

1. Brands
> The brands table stores the brand’s information of bikes, for example, Electra, Haro, and Heller.

2. Categories
> The categories table stores the bike’s categories such as children bicycles, comfort bicycles, and electric bikes.

3. Customers
> The customers table stores customer’s information including first name, last name, phone, email, street, city, state and zip code.

4. Order_items
> The order_items table stores the line items of a sales order. Each line item belongs to a sales order specified by the order_id column. A sales order line item includes product, order quantity, list price, and discount. Order_status= 1: Pending, 2: Processing, 3: Rejected, 4: Completed

5. Orders
> The orders table stores the sales order’s header information including customer, order status, order date, required date, shipped date. It also stores the information on where the sales transaction was created (store) and who created it (staff). Each sales order has a row in the sales_orders table. A sales order has one or many line items stored in the order_items table.

6. Products
> The products table stores the product’s information such as name, brand, category, model year, and list price. Each product belongs to a brand specified by the brand_id column. Hence, a brand may have zero or many products. Each product also belongs a category specified by the category_id column. Also, each category may have zero or many products.

7. Staffs
> The staffs table stores the essential information of staffs including first name, last name. It also contains the communication information such as email and phone. A staff works at a store specified by the value in the store_id column. A store can have one or more staffs. A staff reports to a store manager specified by the value in the manager_id column. If the value in the manager_id is null, then the staff is the top manager. If a staff no longer works for any stores, the value in the active column is set to zero.

8. Stocks
> The stocks table stores the inventory information i.e. the quantity of a particular product in a specific store.

9. Stores
> The stores table includes the store’s information. Each store has a store name, contact information such as phone and email, and an address including street, city, state, and zip code.

