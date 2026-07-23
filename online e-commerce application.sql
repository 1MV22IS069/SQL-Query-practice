Create database online_ecommerce_app;
use online_ecommerce_app;

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(50),
    City VARCHAR(30),
    Membership VARCHAR(20)
);

INSERT INTO Customers VALUES
(1,'Amit','Bangalore','Gold'),
(2,'Priya','Mysore','Silver'),
(3,'Rahul','Hyderabad','Gold'),
(4,'Sneha','Chennai','Silver'),
(5,'Arjun','Bangalore','Platinum'),
(6,'Meera','Pune','Gold');

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(50),
    Category VARCHAR(30),
    Price DECIMAL(10,2)
);

INSERT INTO Products VALUES
(101,'Laptop','Electronics',65000),
(102,'Phone','Electronics',35000),
(103,'Shoes','Fashion',4500),
(104,'Watch','Accessories',7000),
(105,'Tablet','Electronics',25000),
(106,'Headphones','Accessories',3000);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    ProductID INT,
    Quantity INT,
    OrderDate DATE
);

INSERT INTO Orders VALUES
(1001,1,101,1,'2025-01-10'),
(1002,2,103,2,'2025-01-12'),
(1003,3,102,1,'2025-01-15'),
(1004,1,104,3,'2025-01-18'),
(1005,5,101,2,'2025-01-20'),
(1006,6,105,1,'2025-01-25'),
(1007,4,106,4,'2025-01-28'),
(1008,5,102,1,'2025-02-02');

select productid,productname,price
from products
where price > (
select avg(price) from products
);

SELECT customerid, orderid, orderdate
FROM orders
WHERE orderdate = (
    SELECT MIN(orderdate)
    FROM orders
);

select productid,productname,category,price
from products
where price = (
select max(price) from products
);

select customerid,customername
from customers
where customerid in (
select customerid from orders
where productid in (
select productid from products
where productname='laptop'
));

select productid,productname,price
from products
where price < (
select price from products
where productname='phone'
);


select customerid,customername
from customers
where customerid in (
select customerid from orders
where productid in (
select productid from products
where category='electronics'
));

select customerid,customername
from customers
where customerid in (
select customerid from orders
group by customerid
having count(orderid)>1
);

select productid,productname
from products
where productid in(
select productid from orders
group by productid
having count(customerid)>1
);

select customerid,customername
from customers
where membership='gold'
and customerid in(
select customerid from orders
);

select category
from products
group by category
order by avg(price) desc
limit 1;