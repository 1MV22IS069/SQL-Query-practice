use company;

CREATE TABLE Customers ( 
    customer_id INT PRIMARY KEY, 
    customer_name VARCHAR(50), 
    city VARCHAR(30) 
);

INSERT INTO Customers VALUES 
(101,'Amit','Delhi'), 
(102,'Priya','Bangalore'), 
(103,'Rahul','Mumbai'), 
(104,'Sneha','Hyderabad'), 
(105,'Karan','Pune');

CREATE TABLE Orders ( 
    order_id INT PRIMARY KEY, 
    customer_id INT, 
    order_date DATE, 
    amount DECIMAL(10,2) 
); 
 
INSERT INTO Orders VALUES 
(1001,101,'2026-07-01',4500), 
(1002,102,'2026-07-03',1200), 
(1003,101,'2026-07-05',800), 
(1004,104,'2026-07-08',2500);

CREATE TABLE Products ( 
    product_id INT PRIMARY KEY, 
    product_name VARCHAR(50), 
    price DECIMAL(10,2) 
); 
 
INSERT INTO Products VALUES 
(1,'Laptop',65000), 
(2,'Mouse',500), 
(3,'Keyboard',1200), 
(4,'Monitor',15000); 

CREATE TABLE Order_Items ( 
    order_id INT, 
    product_id INT, 
    quantity INT 
); 
 
INSERT INTO Order_Items VALUES 
(1001,1,1), 
(1001,2,2), 
(1002,3,1), 
(1003,2,1), 
(1004,4,2); 

CREATE TABLE Employees ( 
    emp_id INT PRIMARY KEY, 
    emp_name VARCHAR(40), 
    manager_id INT 
); 
 
INSERT INTO Employees VALUES 
(1,'John',NULL), 
(2,'David',1), 
(3,'Alice',1), 
(4,'Mark',2), 
(5,'Sophia',2);

select c.customer_name, o.order_id
from customers c
inner join orders o
on c.customer_id = o.customer_id;

select c.customer_name, o.order_date, o.amount
from customers c
inner join orders o
on c.customer_id = o.customer_id;

select o.order_id, p.product_name
from orders o
inner join order_items oi
on o.order_id = oi.order_id
inner join products p
on oi.product_id = p.product_id;

select oi.order_id, p.product_name, oi.quantity, p.price
from order_items oi
inner join products p
on oi.product_id = p.product_id;

select oi.order_id, p.product_name, oi.quantity, p.price, (oi.quantity * p.price) as total_value
from order_items oi
inner join products p
on oi.product_id = p.product_id;

select c.customer_name, o.order_id
from customers c
left join orders o
on c.customer_id = o.customer_id;

select c.customer_name
from customers c
left join orders o
on c.customer_id = o.customer_id
where o.order_id is null;

select c.customer_name, count(o.order_id) as total_orders
from customers c
left join orders o
on c.customer_id = o.customer_id
group by c.customer_name;

select c.customer_name, o.amount
from customers c
left join orders o
on c.customer_id = o.customer_id;

select c.city
from customers c
left join orders o
on c.customer_id = o.customer_id
where o.order_id is null;

select o.order_id, c.customer_name
from customers c
right join orders o
on c.customer_id = o.customer_id;

select o.order_id
from customers c
right join orders o
on c.customer_id = o.customer_id
where c.customer_id is null;

select o.order_id, c.customer_name, o.amount
from customers c
right join orders o
on c.customer_id = o.customer_id;

select c.customer_name, p.product_name
from customers c
cross join products p;

select count(*) as total_combinations
from customers
cross join products;

-- select c.customer_name, p.product_name
-- from customers c
-- cross join products
-- limit 10;

select e.emp_name as employee, m.emp_name as manager
from employees e
left join employees m
on e.manager_id = m.emp_id;

select e.emp_name
from employees e
inner join employees m
on e.manager_id = m.emp_id
where m.emp_name = 'john';

select e.emp_name
from employees e
inner join employees m
on e.manager_id = m.emp_id
where m.emp_name = 'david';

select emp_name
from employees
where manager_id is null;

select c.customer_name,o.order_id,p.product_name
from customers c
inner join orders o
on c.customer_id=o.customer_id
inner join order_items oi
on o.order_id=oi.order_id
inner join products p
on oi.product_id=p.product_id;

select c.customer_name,o.order_date,p.product_name,oi.quantity
from customers c
inner join orders o
on c.customer_id=o.customer_id
inner join order_items oi
on o.order_id=oi.order_id
inner join products p
on oi.product_id=p.product_id;