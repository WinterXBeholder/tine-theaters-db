use `tiny-theaters`;

-- this didn't work at all. Couldn't solve Error Code 1085.
-- LOAD DATA INFILE '/var/lib/mysql/tiny@002dtheaters/' ignore
-- INTO TABLE excel_data 
-- FIELDS TERMINATED BY ',' 
-- ENCLOSED BY '"'
-- LINES TERMINATED BY '\n'
-- IGNORE 1 ROWS;
-- SELECT count(*) FROM `rcttc-data`.csv;

-- Confirm 
select distinct customer_first, customer_last, customer_email, customer_phone, customer_address
from excel_data
order by customer_last;
-- Insert
insert ignore into customer(first_name, last_name, customer_email, customer_phone, customer_address)
	select distinct customer_first, customer_last, customer_email, customer_phone, customer_address
	from excel_data
    order by customer_last;
-- Verify
select count(*) from customer;


-- Confirm
select distinct theater, theater_address, theater_phone, theater_email
from excel_data;
-- Insert 
insert ignore into theater(theater_name, theater_address, theater_phone, theater_email)
	select distinct theater, theater_address, theater_phone, theater_email
	from excel_data;
-- Verify
select count(*) from theater;
    
    
-- Confirm     
select distinct excel_data.seat, theater.theater_id
	from excel_data
	left outer join theater on excel_data.theater = theater.theater_name
	order by theater.theater_id, excel_data.seat;
-- Insert 
insert ignore into seats(theater_id, seat_name)
	select distinct theater.theater_id,  excel_data.seat
		from excel_data
		left outer join theater on excel_data.theater = theater.theater_name
		order by theater.theater_id, excel_data.seat;
-- Verify
select count(*) from seats;


-- Confirm
select distinct theater.theater_id, excel_data.`show`, excel_data.`date`, excel_data.ticket_price
	from excel_data
	left outer join theater on excel_data.theater = theater.theater_name
    order by excel_data.`date`;
-- -- Insert
insert ignore into performance(theater_id, performance_title, performance_date, current_ticket_price)
	select distinct theater.theater_id, excel_data.`show`, excel_data.`date`, excel_data.ticket_price
		from excel_data
		left outer join theater on excel_data.theater = theater.theater_name
		order by excel_data.`date`;
-- Verify
select count(*) from performance;


-- Confirm
-- select distinct customer.customer_id, excel_data.`date`, sum(excel_data.ticket_price)
-- 	from excel_data
-- 	left outer join customer on excel_data.customer_email = customer.customer_email
--     group by excel_data.customer_email, excel_data.`date`
--     order by customer.customer_id;
-- Insert
-- insert ignore into reservations(customer_id, performance_date, reservation_total)
-- 	select distinct customer.customer_id, excel_data.`date`, sum(excel_data.ticket_price)
-- 		from excel_data
-- 		left outer join customer on excel_data.customer_email = customer.customer_email
-- 		group by excel_data.customer_email, excel_data.`date`
-- 		order by customer.customer_id;
-- Verify
-- select count(*) from reservations;


-- Confirm
-- select distinct performance.performance_id, seats.seat_id, reservations.reservation_id
select distinct *
	from excel_data
	left outer join performance on (excel_data.`show` = performance.performance_title AND excel_data.`date` = performance.performance_date)
    left outer join seats on (performance.theater_id = seats.theater_id AND seats.seat_name = excel_data.seat)
    left outer join customer on excel_data.customer_email = customer.customer_email
    left outer join reservations on (customer.customer_id = reservations.customer_id AND excel_data.`date` = reservations.performance_date)
    order by reservations.reservation_id;
-- Insert
insert ignore into reserved_seats(performance_id, seat_id, reservation_id)
	select distinct performance.performance_id, seats.seat_id, reservations.reservation_id
		from excel_data
		left outer join performance on (excel_data.`show` = performance.performance_title AND excel_data.`date` = performance.performance_date)
		left outer join seats on (performance.theater_id = seats.theater_id AND seats.seat_name = excel_data.seat)
		left outer join customer on excel_data.customer_email = customer.customer_email
		left outer join reservations on (customer.customer_id = reservations.customer_id AND excel_data.`date` = reservations.performance_date)
		order by reservations.reservation_id;
-- Verify
select count(*) from reserved_seats;


drop table if exists excel_data;
