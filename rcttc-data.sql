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
insert ignore into reservations(customer_id, performance_date, reservation_total)
	select distinct customer.customer_id, excel_data.`date`, sum(excel_data.ticket_price)
		from excel_data
		left outer join customer on excel_data.customer_email = customer.customer_email
		group by excel_data.customer_email, excel_data.`date`
		order by customer.customer_id;
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



-- -- UPDATES

-- --price increase to $22.25:
-- -- confirm
select *
from performance
where performance_date = '2021-03-01' and performance_title = 'The Sky Lit Up';
-- -- -- update
update performance set 
 	current_ticket_price = 22.25
where performance_id=4;
select *
from performance;



select r.reservation_id, r.customer_id, r.performance_date, r.reservation_total, c.customer_email, p.performance_id
	from reservations r
    left outer join customer c on r.customer_id = c.customer_id
    left outer join reserved_seats s on r.reservation_id = s.reservation_id
    left outer join performance p on (p.performance_id = 4 and p.performance_id = s.performance_id)
    where s.performance_id = 4
    group by r.reservation_id
    order by c.customer_email;
    -- 36, 79, 80, 20, 57, 5
 update reservations r set
 	r.reservation_total = (select count(s.seat_id)
									from reserved_seats s
									where s.reservation_id = r.reservation_id
									group by r.reservation_id)*22.25
     where r.reservation_id in (36, 79, 80, 20, 57, 5);
select r.reservation_id, r.customer_id, r.performance_date, r.reservation_total, c.customer_email, s.performance_id, count(s.seat_id) as seats, p.current_ticket_price, count(s.seat_id)*p.current_ticket_price, count(s.seat_id)*p.current_ticket_price=r.reservation_total
	from reservations r
    left outer join customer c on r.customer_id = c.customer_id
    left outer join reserved_seats s on r.reservation_id = s.reservation_id
    left outer join performance p on p.performance_id = s.performance_id
    group by r.reservation_id, s.performance_id
    order by r.reservation_id;



-- cullen b4 -> c2, chia c2 -> a4, pooh a4 -> b4, performance_id = 4
select c.first_name, s.*, n.seat_name, n.theater_id, p.performance_date, p.performance_title, p.theater_id
	from customer c
	left outer join reservations r on (c.customer_id = r.customer_id and r.performance_date = '2021-03-01')
	left outer join reserved_seats s on r.reservation_id = s.reservation_id
	left outer join performance p on s.performance_id = p.performance_id
	left outer join seats n on s.seat_id = n.seat_id
	where p.performance_id = 4 and c.customer_email in ("cguirau11@mozilla.com", "cvailhe@ft.com", "pbedburrowcc@stanford.edu");
update reserved_seats set 
 	reservation_id = 36
where reserved_seat_id = 190;
update reserved_seats set 
 	reservation_id = 79
where reserved_seat_id = 7;
update reserved_seats set 
 	reservation_id = 5
where reserved_seat_id = 81;
select c.first_name, s.*, n.seat_name, n.theater_id, p.performance_date, p.performance_title, p.theater_id
	from customer c
	left outer join reservations r on (c.customer_id = r.customer_id and r.performance_date = '2021-03-01')
	left outer join reserved_seats s on r.reservation_id = s.reservation_id
	left outer join performance p on s.performance_id = p.performance_id
	left outer join seats n on s.seat_id = n.seat_id
	where p.performance_id = 4 and c.customer_email in ("cguirau11@mozilla.com", "cvailhe@ft.com", "pbedburrowcc@stanford.edu");


select *
	from customer
	where customer_phone = "801-514-8648";
update customer set
	customer_phone = "1-801-EAT-CAKE"
	where customer_id = 66;
select *
	from customer
	where customer_id = 66;
    
    

select c.customer_email, count(s.reserved_seat_id) as seat_count, r.* from reservations r
	left outer join customer c on c.customer_id = r.customer_id
	left outer join reserved_seats s on s.reservation_id = r.reservation_id
    left outer join performance p on p.performance_id = s.performance_id
    left outer join theater t on t.theater_id = p.theater_id
    where t.theater_name = "10 Pin"
    group by r.reservation_id
    having seat_count = 1
    order by seat_count, c.customer_email;
-- 4,77,22,18,3,34,58,60,27
delete from reserved_seats where reservation_id in (4,77,22,18,3,34,58,60,27);
delete from reservations where reservation_id in (4,77,22,18,3,34,58,60,27);
select c.customer_email, count(s.reserved_seat_id) as seat_count, r.* from reservations r
	left outer join customer c on c.customer_id = r.customer_id
	left outer join reserved_seats s on s.reservation_id = r.reservation_id
    left outer join performance p on p.performance_id = s.performance_id
    left outer join theater t on t.theater_id = p.theater_id
    where t.theater_name = "10 Pin"
    group by r.reservation_id
    order by seat_count, c.customer_email;
select * from customer -- some customers without reservations
left outer join reservations on reservations.customer_id = customer.customer_id;



select s.*, r.*, c.customer_id from reserved_seats s
	left outer join reservations r on s.reservation_id = r.reservation_id
    left outer join customer c on r.customer_id = c.customer_id
    where c.last_name = "Egle of Germany"
    order by r.reservation_id;
-- reserved_seat_id = 53, 54   reservation_id = 24   customer_id = 23
delete from reserved_seats where reserved_seat_id in (53,54);
delete from reservations where reservation_id = 24;
delete from customer where customer_id = 23;
select s.*, r.*, c.customer_id from reserved_seats s
	left outer join reservations r on s.reservation_id = r.reservation_id
    left outer join customer c on r.customer_id = c.customer_id
    where c.last_name = "Egle of Germany"
    order by r.reservation_id;
