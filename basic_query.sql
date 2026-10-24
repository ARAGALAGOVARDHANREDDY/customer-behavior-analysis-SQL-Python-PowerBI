-- A. Sales and revenue analysis

-- 1. What is the total revenue generated from all purchases?
-- 2. What is the average purchase amount?
-- 3. How many unique customers are in the dataset?
-- 4. Which product categories generate the highest revenue?
-- 5. Which individual products have the highest average purchase amount?
-- 6. What is the minimum and maximum purchase amount?

select
	sum(purchase_amount) as total_revenue,
    round(avg(purchase_amount),3) as avg_amount,
    count(distinct customer_id) as unique_customers
	from customer;
select
	category,
    sum(purchase_amount) as total_revenue,
    round(avg(purchase_amount),3) as avg_amount
    from customer
    group by category 
    order by total_revenue desc;
select 
	item_purchased, 
    sum(purchase_amount) as total_revenue,
    round(avg(purchase_amount),3) as avg_amount
    from customer 
    group by item_purchased
    order by avg_amount desc
    limit 6;
select 
	min(purchase_amount) as min_amount,
    max(purchase_amount) as min_amount
    from customer;
    
-- B. Customer behavior analysis

-- 7. Which age group spends the most?
-- 8. Which gender has the highest average purchase amount?
-- 9. Which customers have made more than 20 previous purchases?
-- 10. What percentage of customers have a subscription?
-- 11. Which customers purchase most frequently?
-- 12. Which age groups prefer different product categories?

select 
	age_group ,
    sum(purchase_amount)as total_spent
    from customer
    group by age_group
    order by total_spent;
select 
	gender,
    sum(purchase_amount)as total_spent
    from customer
    group by gender
    order by total_spent;
SELECT
   count(*) as customers_over_20_purchases
FROM customer
WHERE previous_purchases > 20;
select 
	subscription_status,
    ROUND(
        COUNT(*) * 100.0 / (SELECT COUNT(*) FROM customer),
        2
    ) AS percentage
    from customer
    group by subscription_status
    order by percentage desc;
select 
	 frequency_of_purchases,
     count(*) as total_customers
     from customer
     group by frequency_of_purchases
     order by total_customers;
select 
	age_group ,
    category,
    count(*) as total_customers
    from customer
    group by age_group,category
    order by category;
-- C. Discount and promotion analysis

-- 13. Do customers who use discounts have a different average purchase amount from those who do not?
-- 14. Which product categories have the highest discount usage?
-- 15. What percentage of customers use discounts?
-- 16. Which age group uses discounts most often?
-- 17. Are subscribers more likely to use discounts than non-subscribers?
select
    discount_applied,
    count(*) as total_customers,
    round(avg(purchase_amount), 2) as avg_purchase_amount
from customer
group by discount_applied;
select
    category,
    count(*) as total_customers,
    sum(case when discount_applied = 'Yes' then 1 else 0 end)
        as discounted_purchases,
    round(
        100.0 * sum(case when discount_applied = 'Yes' then 1 else 0 end)
        / count(*), 2
    ) as discount_percentage
from customer
group by category
order by discount_percentage desc;
select
    count(*) as total_customers,
    sum(case when discount_applied = 'Yes' then 1 else 0 end)
        as customers_using_discounts,
    round(
        100.0 * sum(case when discount_applied = 'Yes' then 1 else 0 end)
        / count(*), 2
    ) as discount_usage_percentage
from customer;
select
    age_group,
    count(*) as total_customers,
    sum(case when discount_applied = 'Yes' then 1 else 0 end)
        as discounted_customers,
    round(
        100.0 * sum(case when discount_applied = 'Yes' then 1 else 0 end)
        / count(*), 2
    ) as discount_percentage
from customer
group by age_group
order by discount_percentage desc;
select
    subscription_status,
    count(*) as total_customers,
    sum(case when discount_applied = 'Yes' then 1 else 0 end)
        as discounted_customers,
    round(
        100.0 * sum(case when discount_applied = 'Yes' then 1 else 0 end)
        / count(*), 2
    ) as discount_percentage
from customer
group by subscription_status
order by discount_percentage desc;
-- D. Shipping and payment analysis

-- 18. Which shipping method is most popular?
-- 19. Which shipping method has the highest average purchase amount?
-- 20. What is the most frequently used payment method?
-- 21. Which payment method is associated with the highest average purchase amount?
-- 22. Which shipping methods are most popular among subscribers?
select shipping_type,count(*) as total_customer,sum(purchase_amount) as total_amount,round(avg(purchase_amount),3) as avg_amount
 from customer group by shipping_type  order by total_customer desc;
 select payment_method,count(*) as total,sum(purchase_amount) as total_amount,round(avg(purchase_amount),3) as avg_amount
 from customer group by payment_method order by total desc;
 select shipping_type ,count(*) as total_customer
 from customer where subscription_status ='yes' group by shipping_type;
--  E. Customer satisfaction analysis

-- 23. What is the average review rating?
-- 24. Which product categories receive the highest ratings?
-- 25. Which products have ratings below 3.5?
-- 26. Do customers who purchase frequently give higher ratings?
-- 27. Which categories have the most low-rated reviews?
select round(avg(review_rating),3) as avg_review from customer;
select category,round(avg(review_rating), 2) as average_rating,count(*) as total_reviews
from customer group by category order by average_rating desc;
select item_purchased,count(*) as low_rated_reviews,round(avg(review_rating), 2) as avg_low_rating
from customer where review_rating < 3.5 group by item_purchased order by avg_low_rating asc;
select frequency_of_purchases ,round(avg(review_rating),2) as total 
from customer group by frequency_of_purchases order by total desc;
select category, round(avg(review_rating),2) as total 
from customer where review_rating < 3.5 group by category order by total desc;
-- F. Product and seasonal insights

-- 28. Which products are most popular in each season?
-- 29. Which product categories have the highest average purchase amount in each season?
-- 30. Which colors and sizes are most commonly purchased?
-- 31. Which locations have the highest total purchase amount?
-- 32. Which product category is most popular among each age group?
select item_purchased ,season,count(*) total,round(avg(purchase_amount),2)as avg_amount from customer
group by item_purchased,season order by item_purchased,season;
select color,size,count(*) total from customer group by color,size order by color,size;
select location ,sum(purchase_amount) as total_amount from customer group by location order by total_amount desc;
select category ,age_group ,count(*) as total from customer group by category,age_group order by category,age_group;
