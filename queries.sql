-- скрипт считает общее число записей в таблице customers

select count(*) as customers_count
from customers;

-- Подготовьте отчет с продавцами у которых наибольшая выручка

select
	employees.first_name || ' ' || employees.last_name as seller,
	COUNT(sales.sales_id) as operations,
	FLOOR(SUM(products.price * sales.quantity)) as income
from sales
inner join employees on
	sales.sales_person_id = employee_id
inner join products on
	sales.product_id = products.product_id
group by employees.first_name, employees.last_name
order by income desc
limit 10;

-- Отчет содержит информацию о продавцах, чья средняя выручка за сделку меньше средней выручки за сделку по всем продавцам. Таблица отсортирована по выручке по возрастанию.

select
    employees.first_name || ' ' || employees.last_name AS seller,
    FLOOR(SUM(sales.quantity * products.price) / COUNT(sales.sales_id)) AS average_income
from employees
inner join sales on employees.employee_id = sales.sales_person_id
inner join products on sales.product_id = products.product_id
group by employees.first_name, employees.last_name
HAVING (SUM(sales.quantity * products.price) / COUNT(sales.sales_id)) <
       (
         SELECT SUM(sales.quantity * products.price) / COUNT(sales.sales_id)
         FROM sales
         INNER JOIN products ON sales.product_id = products.product_id
       )
order by average_income ASC;

-- Отчет содержит информацию о выручке по дням недели. Каждая запись содержит имя и фамилию продавца, день недели и суммарную выручку. Отсортируйте данные по порядковому номеру дня недели и seller

select
	employees.first_name || ' ' || employees.last_name AS seller,
	TO_CHAR(sales.sale_date, 'Day') AS day_of_week,
	FLOOR(SUM(products.price * sales.quantity)) as income
from sales
inner join employees on employees.employee_id = sales.sales_person_id
inner join products on sales.product_id = products.product_id
group by employees.first_name, employees.last_name, TO_CHAR(sales.sale_date, 'Day'), EXTRACT(DOW FROM sales.sale_date)
order by EXTRACT(DOW FROM sales.sale_date), seller asc;
