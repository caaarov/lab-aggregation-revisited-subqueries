use sakila;

#Select the first name, last name, and email address of all the customers who have rented a movie.

Select distinct c.first_name, c.last_name, c.email from customer as c
join rental as r
using (customer_id);

#What is the average payment made by each customer (display the customer id, customer name (concatenated), and the average payment made).
Select distinct customer_id, concat(c.first_name," ", c.last_name) as name, round(avg(p.amount),2) as avg_payment from customer as c
join payment as p
using (customer_id)
group by customer_id;

#Select the name and email address of all the customers who have rented the "Action" movies.
# 1) Write the query using multiple join statements

Select distinct customer_id, concat(c.first_name," ", c.last_name) as name, c.email, ca.name from customer as c
join rental as r
using (customer_id)
join inventory as i
using (inventory_id)
join film_category as f
using (film_id)
join category as ca
using (category_id)
where name in ("Action");

# 2) Write the query using sub queries with multiple WHERE clause and IN condition

select distinct customer_id, concat(first_name," ", last_name) as name, email from customer
where customer_id in (

	select customer_id from rental
    where inventory_id in (
    
		select inventory_id from inventory
        where  film_id in (
        
			select film_id from film_category
			where category_id in (select category_id from category where name in ("Action")))));
            
#Use the case statement to create a new column classifying existing columns as either or high value transactions based on the amount of payment. 
#If the amount is between 0 and 2, label should be low and if the amount is between 2 and 4, the label should be medium, and if it is more than 4, then it should be high.

select payment_id,
case 
    when amount<=2 then 'LOW'
    when amount>4 then 'HIGH'
    when amount between 2 and 4 then'MEDIUM' 
    end as classification, 
amount from sakila.payment;

