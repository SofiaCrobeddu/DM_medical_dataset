# DM_medical_dataset: Open Drug Knowledge Graph

This project was carried out by Group 25 for the frist two assignments of the course of Data Management for Data Science from the Master's degree in Data science at Sapienza University of Rome.
Thr group was composed by:
| NAME and SURNAME | MATRICOLA | EMAIL |
| --- | --- | --- |
| Sofia Noemi Crobeddu | 2130389 | crobeddu.2130389@studenti.uniroma1.it | 
| Stefano Rinaldi | 1945551 | rinaldi.1945551@studenti.uniroma1.it |

## PURPOSE

The aim of this project is to create a database about medical drugs and products, extracting their information through queries. After this first implementation, it was also performed the optimization of tables and queries in order to improve performance and enable efficient data retrieval from the database.

## REPOSITORIES

The repositories are two:
- **data**: it contains the csv files with the original datasets. The files inside are the following ones:
  - `condition.csv`: contains the health conditions. Each condition has an id, a name and an url link. It is also connected to an other csv files through the column source_id.
  - `drug.csv`: contains the healthcare drug's information. Each drug has an id, a name, a specific url link and a link to the drugbank.
  - `interaction.csv`: contains the interactions between drugs. Each interaction has an id and it is connected to an others csv files through the columns source_drug_id and target_drug_id.
  - `manufacturer.csv`: contains the manufacturer information. Each manufacturer has an id and a name.
  - `price.csv`: contains the medical product's price. Each price has an id, the value indicated by the column "price", a specific type and an url link. It is also connected to the others csv files through the columns product_id and store_id.
  - `product.csv`: contains the medical product's information. Each product has an id, a name, a type, an url link, the number of reviews. It is also connected to the others csv files through the columns source_id, drug_id and manufacturer_id.
  - `source.csv`: contains the source of information. Each source has an id a name (such as Wikidata, Drugbank, etc...) and the correspondent url. This dataset was not actually used and it is just put here for completeness.
  - `store.csv`: contains the store information. Each store has an id and a name.
  - `treatement.csv`: contains the treatements' information. Each treatment has an id, and it is connected to the others csv files through the columns source_id, drug_id and condition_id.

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
