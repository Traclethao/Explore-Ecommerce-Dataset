# Website Performance Analysis In Ecommerce 

## **I. Introduction**

This project contains an AdventureWorks2019 dataset that I will SQL on Google BigQuery to solve problems such as data mining and data exploration, joining data from separate spreadsheets on Ecommerce data. I was given a task to find answers for the following questions related to the AdventureWorks database.

## **II. Dataset Access**

The eCommerce dataset is stored in a public Google BigQuery dataset. To access the dataset, follow these steps:

- Log in to your Google Cloud Platform account and create a new project.
- Navigate to the BigQuery console and select your newly created project.
- In the navigation panel, select "Add Data" and then "Start a project by name".
- Enter the project name **"adventureworks2019"** and click "Enter".

## **III. Exploring the Dataset**

In this project, I will write 08 queries in Bigquery based on Adventureworks2019 in Google Analytics dataset. 

### **Query 01: calculate total visit, pageview, transaction for Jan, Feb and March 2017 (order by month).** 

- SQL code

  ![1](https://github.com/user-attachments/assets/446dcb48-b8be-49f6-841e-55b61ca635e8) 

- Query results

  ![Result 1](https://github.com/user-attachments/assets/64c0961d-6deb-435c-9274-5367e2eb58ee)

### **Query 02: Bounce rate per traffic source in July 2017 (Bounce_rate = num_bounce/total_visit) (order by total_visit DESC).** 

- SQL code

  ![2](https://github.com/user-attachments/assets/657eca34-d8d1-4ea3-be25-6e79dd693847)

- Query results

  ![Result 2](https://github.com/user-attachments/assets/0ab8adc9-f1c3-4cea-819a-9d95a67bb763)

### **Query 3: Revenue by traffic source by week, by month in June 2017.** 

- SQL code

  ![3](https://github.com/user-attachments/assets/b89dd16a-03fc-4072-8214-63ac12f026dc)

- Query results

  ![Result 3](https://github.com/user-attachments/assets/27eb59c6-a32d-4c20-80ef-c7d11cd58cc5)

### **Query 04: Average number of pageviews by purchaser type (purchasers vs non-purchasers) in June, July 2017.**

- SQL code

  ![4 1](https://github.com/user-attachments/assets/1f0a35fa-62a8-41ac-afc4-dd8654c907b6)

  ![4 2](https://github.com/user-attachments/assets/2d97b6a3-1a19-44a2-a066-1905a9276233)

- Query results

  ![Result 4](https://github.com/user-attachments/assets/e22dfeb0-ee0d-4696-85c3-3dad6aaa28d2) 

### **Query 05: Average number of transactions per user that made a purchase in July 2017.** 

- SQL code

  ![5](https://github.com/user-attachments/assets/ba091d14-dbc2-4e5b-baec-53f12e365c59)

- Query results

  ![Result 5](https://github.com/user-attachments/assets/342e09e2-4c14-4815-9d26-2996b7a3a272)

### **Query 06: Average amount of money spent per session. Only include purchaser data in July 2017.** 

- SQL code

  ![6](https://github.com/user-attachments/assets/05af1711-4d76-4751-8cbc-8cbaf5aad002)

- Query results

  ![Result 6](https://github.com/user-attachments/assets/a6d1ed20-9597-47c3-9d08-15548e2513b9)

### **Query 07: Other products purchased by customers who purchased product "YouTube Men's Vintage Henley" in July 2017. Output should show product name and the quantity was ordered.**

- SQL code

  ![7](https://github.com/user-attachments/assets/733303a1-26e0-41de-990d-39a1ab466234)

- Query results

  ![Result 7](https://github.com/user-attachments/assets/4bdf0adf-d06e-49c1-b896-8319ce444918)

### **Query 08: Calculate cohort map from product view to addtocart to purchase in Jan, Feb and March 2017.**

- SQL code

  ![8](https://github.com/user-attachments/assets/a1d51135-d80f-4997-845d-d5b22f767a19)

- Query results

  ![Result 8](https://github.com/user-attachments/assets/e2ab0deb-e2db-43b4-89d1-3a180d269aae)

## **IV. Conclusion**

- By exploring eCommerce dataset, I have gained valuable information about total visits, pageview, transaction, bounce rate per traffic source, revenue by traffic source by week and by month, average number of pageviews by purchaser type, and average amount of money spent per session.... which could inform future business decisions. 
- **Overall**, This project has demonstrated the power of using SQL and big data tools like Google BigQuery to gain insights into large datasets.
