# dbt-e-commerce-analysis

In this project, I...

## TheLook Fake E-Commerce Data

[TheLook](https://console.cloud.google.com/marketplace/product/bigquery-public-data/thelook-ecommerce?project=e-commerce-392014) is a dataset that describes a fake clothing site. The dataset has information regarding users, orders, web events, etc.

The dataset has 7 tables:
1. distribution_centers
2. events
3. inventory_items
4. order_items
5. orders
6. products
7. users

There are 50 unique product names and 9 unique product categories. There are 6 types of events.

The flow for a user can be described as...
1. Account signup
    * User information stored in **users** table
2. Visiting the site
    * Interacting with the website generates events in the **events** table
3. Making a purchase
    * Purchase information is stored in the **orders** table
    * An order can have one or more items. The items in an order are stored in the **order_items** table. This table is linked to the **orders** table through the property: *order_id*. 
    * The **products** table stores information about the products ordered. **order_items** links to **products** via the *product_id* property.
    * The **inventory_items** table stores information about specific products. **order_items** links to **inventory_items** through the property: *inventory_item_id*.
    * **inventory_items** and **products** have associated **distribution_centers**, linked by the property: *product_distribution_center_id*.

The flow for inventory can be described as...
1. A

This dataset is provided for free by Google's [Looker](https://cloud.google.com/looker?hl=en_US&_gl=1*8j4ktp*_ga*MTAzOTc1NDMzLjE2ODg2NTQxMzU.*_ga_WH2QY8WWF5*MTY4ODY1NDEzNC4xLjEuMTY4ODY2MTA1My4wLjAuMA..&_ga=2.252384649.-103975433.1688654135) team.

## Data Build Tool (dbt)

[Data Build Tool](https://docs.getdbt.com/docs/introduction) is a useful tool that puts the T in ETL (Transform in Extract, Transform, Load). It allows you to transform data in your warehouse by writing SQL code. The SQL code is written in a modular way, so that you can reuse code and build upon it. Additionally, dbt allows you to test code and document your SQL code. It provides a single source of truth for your data.

For more information on why to use dbt, see [The dbt Viewpoint](https://docs.getdbt.com/community/resources/viewpoint).

## Analyses


## Dataset Details


## Resources Used

**Papers**
* [Big data analytics in E-commerce: a systematic review and agenda for future research](https://link.springer.com/article/10.1007/s12525-016-0219-0#Abs1)

**Articles**
* [Data Analytics in E-commerce Retail](https://towardsdatascience.com/data-analytics-in-e-commerce-retail-7ea42b561c2f)
* [Jinja + SQL](https://towardsdatascience.com/jinja-sql-%EF%B8%8F-7e4dff8d8778)

**Websites**
* [dbt BI Reporting](https://www.getdbt.com/analytics-engineering/use-cases/bi-reporting/)
* [dbt Data Science Use Case](https://www.getdbt.com/analytics-engineering/use-cases/data-science/)
