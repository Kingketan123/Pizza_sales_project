select * from order_details;
select * from orders;
select * from pizza_types;
select * from pizzas;

-- q-1-Retrieve the total number of orders placed.
select count(`order_id`) as "total_order" from orders;

-- q-2-Calculate the total revenue generated from pizza sales.
select sum(order_details.quantity * pizzas.price) as "total_Sales"
from order_details join pizzas
on pizzas.pizza_id = order_details.pizza_id;

-- q-3-Identify the highest-priced pizza.
select pizza_types.name,pizzas.price from pizza_types join pizzas
on pizza_types.pizza_type_id  = pizzas.pizza_type_id
order by pizzas.price desc limit 1;

-- q-4-Identify the most common pizza size ordered.
select pizzas.size,count(order_details.order_details_id) as "total_orders" from order_details 
join pizzas on order_details.pizza_id = pizzas.pizza_id
group by pizzas.size;

-- q-5-List the top 5 most ordered pizza types along with their quantities.
select pizza_types.name,
sum(order_details.quantity) as "Total_quantity"
from pizza_types join pizzas
on pizza_types.pizza_type_id = pizzas.pizza_type_id
join order_details
on order_details.pizza_id = pizzas.pizza_id
group by pizza_types.name order by Total_quantity desc limit 5;


-- q-6-Join the necessary tables to find the total quantity of each pizza category ordered.
select pizza_types.category,
sum(order_details.quantity) as "Total_quantity"
from pizza_types join pizzas
on pizza_types.pizza_type_id = pizzas.pizza_type_id
join order_details
on order_details.pizza_id = pizzas.pizza_id
group by pizza_types.category;

-- q-7-Determine the distribution of orders by hour of the day.
SELECT 
    HOUR(order_time) AS 'hour', COUNT(order_id) AS 'order_count'
FROM
    orders
GROUP BY HOUR(order_time);

-- q-8-Join relevant tables to find the category-wise distribution of pizzas.

select `category`,count(`name`) as "total_count"from pizza_types
group by `category`;

-- q-9-Group the orders by date and calculate the average number of pizzas ordered per day

select round(avg(quantity_sum),0) as "avg_quantity_sum" from 
(select orders.order_date,sum(order_details.quantity) as "quantity_sum"
from orders join order_details
on orders.order_id = order_details.order_id
group by orders.order_date) as order_quantity ;

-- q-10-Determine the top 3 most ordered pizza types based on revenue
select pizza_types.name,sum(order_details.quantity * pizzas.price) as "total_Revenve"
from order_details join pizzas
on pizzas.pizza_id = order_details.pizza_id
join pizza_types on 
pizza_types.pizza_type_id = pizzas.pizza_type_id
group by pizza_types.name order by total_Revenve desc limit 3;

-- q-11-Calculate the percentage contribution of each pizza type to total revenue.
-- 52:30
