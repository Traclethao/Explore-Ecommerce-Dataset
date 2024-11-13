# Explore Ecommerce Dataset

## **I. Introduction**

This project contains an AdventureWorks2019 dataset that I will SQL on Google BigQuery to solve problems such as data mining and data exploration, joining data from separate spreadsheets on Ecommerce data. I was given task to find answers for the following questions related to Adventure Works database.

## **II. Requirements**

- [Google Cloud Platform account](https://cloud.google.com/)
- Project on Google Cloud Platform
- [Google BigQuery API](https://cloud.google.com/bigquery/docs/enable-transfer-service#:~:text=Enable%20the%20BigQuery%20Data%20Transfer%20Service,-Before%20you%20can&text=Open%20the%20BigQuery%20Data%20Transfer,Click%20the%20ENABLE%20button.) enabled
- [SQL query editor](https://cloud.google.com/monitoring/mql/query-editor) or IDE

## **III. Dataset Access**

The eCommerce dataset is stored in a public Google BigQuery dataset. To access the dataset, follow these steps:

- Log in to your Google Cloud Platform account and create a new project.
- Navigate to the BigQuery console and select your newly created project.
- In the navigation panel, select "Add Data" and then "Star a project by name".
- Enter the project name **"adventureworks2019"** and click "Enter".

## **IV. Exploring the Dataset**

In this project, I will write 08 query in Bigquery base on Adventureworks2019 in Google Analytics dataset. 

### **Query 01: calculate total visit, pageview, transaction for Jan, Feb and March 2017 (order by month).** 

- SQL code
![1](https://github.com/user-attachments/assets/446dcb48-b8be-49f6-841e-55b61ca635e8) 
- Query results

### **Query 02: Bounce rate per traffic source in July 2017 (Bounce_rate = num_bounce/total_visit) (order by total_visit DESC).** 

- SQL code

- Query results

### **Query 3: Revenue by traffic source by week, by month in June 2017.** 

- SQL code

- Query results

### **Query 04: Average number of pageviews by purchaser type (purchasers vs non-purchasers) in June, July 2017.**

- SQL code

- Query results

### **Query 05: Average number of transactions per user that made a purchase in July 2017.** 

- SQL code

- Query results

### **Query 06: Average amount of money spent per session. Only include purchaser data in July 2017.** 

- SQL code

- Query results

### **Query 07: Other products purchased by customers who purchased product "YouTube Men's Vintage Henley" in July 2017. Output should show product name and the quantity was ordered.**

- SQL code

- Query results

### **Query 08: Calculate cohort map from product view to addtocart to purchase in Jan, Feb and March 2017. For example, 100% product view then 40% add_to_cart and 10% purchase. Add_to_cart_rate = number product  add to cart/number product view. Purchase_rate = number product purchase/number product view. The output should be calculated in product level.**

- SQL code

- Query results
