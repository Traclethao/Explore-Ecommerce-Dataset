--Query 1 
SELECT
  FORMAT_DATE("%Y%m", PARSE_DATE("%Y%m%d", date)) AS month,
  SUM(totals.visits) AS visits,
  SUM(totals.pageviews) AS pageviews,
  SUM(totals.transactions) AS transactions,
FROM `bigquery-public-data.google_analytics_sample.ga_sessions_2017*`
WHERE _TABLE_SUFFIX BETWEEN '0101' AND '0331'
GROUP BY 1
ORDER BY 1; 


--Query 2 
with visits_count as (
   SELECT 
      trafficSource.source,
      COUNT(trafficSource.source) AS total_visits,
   FROM `bigquery-public-data.google_analytics_sample.ga_sessions_201707*`
   GROUP BY trafficSource.source
),
bounces_count as (
   SELECT 
      trafficSource.source,
      COUNT(totals.bounces) AS total_no_of_bounces,
   FROM `bigquery-public-data.google_analytics_sample.ga_sessions_201707*`
   WHERE totals.bounces is not null 
   GROUP BY trafficSource.source
)
SELECT 
  a.source,
  total_visits,
  total_no_of_bounces,
  ROUND((total_no_of_bounces/total_visits)*100,3) AS bounce_rate
FROM visits_count AS a
LEFT JOIN bounces_count AS b 
ON a.source = b.source 
ORDER BY total_visits DESC;


--Query 3 
with month_data as(
  SELECT
    "Month" AS time_type,
    FORMAT_DATE("%Y%m", PARSE_DATE("%Y%m%d", date)) as month,
    trafficSource.source AS source,
    SUM(p.productRevenue)/1000000 AS revenue
  FROM `bigquery-public-data.google_analytics_sample.ga_sessions_201706*`,
    unnest(hits) hits,
    unnest(product) p
  WHERE p.productRevenue is not null
  GROUP BY 1,2,3
  ORDER BY revenue DESC
),
week_data as(
  SELECT
    "Week" as time_type,
    FORMAT_DATE("%Y%W", PARSE_DATE("%Y%m%d", date)) as week,
    trafficSource.source AS source,
    SUM(p.productRevenue)/1000000 AS revenue
  FROM `bigquery-public-data.google_analytics_sample.ga_sessions_201706*`,
    unnest(hits) hits,
    unnest(product) p
  WHERE p.productRevenue is not null
  GROUP BY 1,2,3
  ORDER BY revenue DESC
)
SELECT * 
FROM month_data
UNION ALL
SELECT * FROM week_data
ORDER BY time_type, revenue DESC;


--Query 4 
with list_pur as (
  SELECT 
     FORMAT_DATE('%Y%m', PARSE_DATE('%Y%m%d', date)) as month, 
     fullVisitorId, 
     totals.pageviews 
  FROM `bigquery-public-data.google_analytics_sample.ga_sessions_2017*`,
     UNNEST (hits) hits,
     UNNEST (hits.product) product
  WHERE _table_suffix between '0601'and '0731'
    and totals.transactions >=1
    and productRevenue is not null
),
num_pur as (
  SELECT 
     month,
     sum(pageviews) as total_pur,
     count(distinct fullVisitorId) as num_user_pur 
  FROM list_pur 
  GROUP BY month 
),
list_non_pur as (
  SELECT 
     FORMAT_DATE('%Y%m', PARSE_DATE('%Y%m%d', date)) as month, 
     fullVisitorId, 
     totals.pageviews 
  FROM `bigquery-public-data.google_analytics_sample.ga_sessions_2017*`,
     UNNEST (hits) hits,
     UNNEST (hits.product) product
  WHERE _table_suffix between '0601'and '0731'
    and totals.transactions IS NULL
    and product.productRevenue is null
),
num_non_pur as (
  SELECT 
     month,
     sum(pageviews) as total_non_pur,
     count(distinct fullVisitorId) as num_user_non_pur 
  FROM list_non_pur 
  GROUP BY month 
)
SELECT 
   n1.month,
   round((n1.total_pur  / n1.num_user_pur),8) as avg_pageviews_purchase,
   round((n2.total_non_pur / n2.num_user_non_pur),8)  as avg_pageviews_non_purchase 
FROM num_pur as n1
FULL JOIN num_non_pur as n2 
ON n1.month = n2.month 
GROUP BY month, avg_pageviews_purchase, avg_pageviews_non_purchase
ORDER BY month;


--Query 5 
with total_transactions_m7 as (
  SELECT 
     date,
     fullVisitorId, 
     totals.transactions
  FROM `bigquery-public-data.google_analytics_sample.ga_sessions_201707*`,
     UNNEST (hits) hits,
     UNNEST (hits.product) product
  WHERE totals.transactions >=1
     and productRevenue is not null 
)
SELECT 
   FORMAT_DATE('%Y%m', PARSE_DATE('%Y%m%d', date)) as Month,
   round((sum(transactions) / count(distinct fullVisitorId)), 9) as Avg_total_transactions_per_user  
FROM total_transactions_m7
GROUP BY Month;


--Query 6 
with shorten_revenue_m7 as (
 SELECT 
     date,
     fullVisitorId, 
     totals.transactions,
     productRevenue/1000000 as revenue 
  FROM `bigquery-public-data.google_analytics_sample.ga_sessions_201707*`,
     UNNEST (hits) hits,
     UNNEST (hits.product) product
  WHERE totals.transactions IS NOT NULL
     and product.productRevenue is NOT NULL 
 )
SELECT 
     FORMAT_DATE('%Y%m', PARSE_DATE('%Y%m%d', date)) as Month,
     round((sum(revenue) / count(fullVisitorId)), 2) as avg_revenue_by_user_per_visit
  FROM shorten_revenue_m7
GROUP BY Month;  


--Query 7 
with user_purchase as (
  SELECT 
     fullVisitorId,
     v2ProductName,
     product.productQuantity
  FROM `bigquery-public-data.google_analytics_sample.ga_sessions_201707*`,
     UNNEST (hits) hits,
     UNNEST (hits.product) product
  WHERE productRevenue is not null 
),
list_user_purchase_YM as (
  SELECT 
     distinct fullVisitorId 
  FROM user_purchase 
  WHERE v2ProductName = "YouTube Men's Vintage Henley"
), 
products_other as (
  SELECT 
     a.v2ProductName,
     a.productQuantity
  FROM user_purchase as a 
  INNER JOIN list_user_purchase_YM as b 
    ON a.fullVisitorId = b.fullVisitorId 
    AND  v2ProductName <> "YouTube Men's Vintage Henley"
)
SELECT 
     v2ProductName AS other_purchased_products,
     SUM(productQuantity) AS quantity 
FROM products_other
GROUP BY v2ProductName
ORDER BY quantity  desc; 


--Query 8 
with list_action_type as (
  SELECT 
     date,
     fullVisitorId,  
     case when eCommerceAction.action_type = '2' then 1 else 0 end as product_view,
     case when eCommerceAction.action_type = '3' then 1 else 0 end as addtocart,
     case when eCommerceAction.action_type = '6' and product.productRevenue is not null then 1 else 0 end as purchase
  FROM `bigquery-public-data.google_analytics_sample.ga_sessions_2017*`,
     UNNEST (hits) hits,
     UNNEST (hits.product) product 
  WHERE _table_suffix between '0101'and '0331'
),
num_action_type as (
  SELECT 
     FORMAT_DATE('%Y%m', PARSE_DATE('%Y%m%d', date)) as month, 
     SUM(product_view) as num_product_view, 
     SUM(addtocart) as num_addtocart,
     SUM(purchase) as num_purchase 
  FROM list_action_type
  GROUP BY month 
  ORDER BY month 
)
SELECT 
   month,
   num_product_view,
   num_addtocart,
   num_purchase,
   ROUND((num_addtocart/num_product_view)*100,2) as add_to_cart_rate,
   ROUND((num_purchase/num_product_view)*100,2) as purchase_rate 
FROM num_action_type
ORDER BY month;
