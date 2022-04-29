

(1) /*Customer 'Angel' has rented 'SBA1111A' from today for 10 days. (Hint: You need to insert a rental record. 
Use a SELECT subquery to get the customer_id to do this you will need to use parenthesis for your subquery as one of your values. 
Use CURDATE() (or NOW()) for today, and DATE_ADD(CURDATE(), INTERVAL x unit) to compute a future date.)

INSERT INTO rental_records VALUES(
NULL,
'SBA1111A',
(
SELECT customer_id
FROM customers
WHERE name = 'Angel'),
CURDATE(),
DATE_ADD(CURDATE(), INTERVAL 10 DAY),
NULL
)

(2) /*Customer 'Kumar' has rented 'GA5555E' from tomorrow for 3 months.
INSERT INTO rental_records VALUES(
NULL, 'GA5555E',
(
SELECT customer_id
FROM customers
WHERE name = 'Kumar'),
DATE_ADD(NOW(), INTERVAL 1 DAY),
DATE_ADD(DATE_ADD(NOW(), INTERVAL 1 DAY), INTERVAL 3 month),
NULL
);

(3) /*List all rental records (start date, end date) with vehicle's registration number, brand, and 
--customer name, sorted by vehicle's categories followed by start date. */

select start_date, end_date, v.veh_reg_no, brand, name, category from 
rental_records as R,
vehicles as V,
customers As C
where 
r.veh_reg_no = v.veh_reg_no 
and
r.customer_id = c.customer_id
order by category, start_date
 ;

(4) /*List all the expired rental records (end_date before CURDATE()).*/

select * from 
rental_records 
where end_date < CURDATE();

(5) /*List the vehicles rented out on '2012-01-10' (not available for rental), in columns of vehicle registration no, customer name, start date and end date. 
(Hint: the given date is in between the start_date and end_date.)*/

select R.veh_reg_no, C.name, R.start_date, R.end_date from
rental_records as R,
customers as C
where R.customer_id = C.customer_id 
and 
start_date <'2012-01-10'
and
end_date > '2012-01-10'

(6) /*List all vehicles rented out today, in columns registration number, customer name, start date, end date.*/

select R.veh_reg_no, C.name, R.start_date, R.end_date from
rental_records as R,
customers as C
where R.customer_id = C.customer_id 
and 
start_date <= curdate()
and
end_date > curdate()

(7) /*Similarly, list the vehicles rented out (not available for rental) for the period from '2012-01-03' to '2012-01-18'. (Hint: start_date is inside the range; or end_date is inside the range; or start_date is before the range and end_date is beyond the range.)*/

select R.veh_reg_no, V.category, V.brand, V.desc from
rental_records as R,
vehicles as V
where R.veh_reg_no = V.veh_reg_no
and 
start_date <= '2012-01-03'
and
end_date > '2012-01-18


(8) /*List the vehicles (registration number, brand and description) available for rental (not rented out) on '2012-01-10' (Hint: You could use a subquery based on a earlier query).*/

select V.veh_reg_no, V.brand, V.desc from
vehicles as V
where veh_reg_no in 
(select distinct(veh_reg_no) from rental_records where start_date > '2012-01-10' or end_date <= '2012-01-10');

(9) /*Similarly, list the vehicles available for rental for the period from '2012-01-03' to '2012-01-18'.*/

select V.veh_reg_no, V.brand, V.desc from
vehicles as V
where veh_reg_no in 
( select distinct(veh_reg_no) from rental_records where start_date > '2012-01-18' or end_date < '2012-01-03');

(10)/*Similarly, list the vehicles available for rental from today for 10 days.*/

SELECT
v.veh_reg_no,
v.brand,
v.desc
FROM vehicles as V
LEFT JOIN rental_records as R
ON V.veh_reg_no = R.veh_reg_no
WHERE V.veh_reg_no NOT IN (
SELECT
veh_reg_no
FROM rental_records
WHERE (
(start_date BETWEEN CURDATE() 
AND 
DATE_ADD(CURDATE(), INTERVAL 10 DAY))
)
);




























