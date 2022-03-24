use `tiny-theaters`;

select p.performance_title from performance p
	where p.performance_date between '2021-10-01' and '2021-12-31';


select * from customer;


select * from customer
	where customer_email not like '%.com';


select * from performance
	order by current_ticket_price
    limit 3;



select p.performance_title, p.performance_date, c.* from reservations r
	left outer join reserved_seats s on s.reservation_id = r.reservation_id
    left outer join performance p on p.performance_id = s.performance_id
    left outer join customer c on c.customer_id = r.customer_id
    group by r.reservation_id, s.performance_id
    order by c.customer_email;




select c.*, p.performance_title, p.performance_date, t.theater_name, n.seat_name from reserved_seats s
	left outer join reservations r on s.reservation_id = r.reservation_id
    left outer join performance p on p.performance_id = s.performance_id
    left outer join customer c on c.customer_id = r.customer_id
    left outer join theater t on t.theater_id = p.theater_id
    left outer join seats n on n.seat_id = s.seat_id
    group by s.seat_id, s.reservation_id, s.performance_id
    order by p.performance_date, p.performance_title, c.customer_email, n.seat_name;



select * from customer
where customer_address = '' or customer_address = null;




select c.first_name as customer_first, c.last_name as customer_last, c.customer_email, c.customer_phone, c.customer_address, n.seat_name as	seat, p.performance_title as `show`, p.current_ticket_price as ticket_price, p.performance_date as `date`, t.theater_name as theater, t.theater_address, t.theater_phone, t.theater_email
	from reserved_seats s
	left outer join reservations r on s.reservation_id = r.reservation_id
    left outer join performance p on p.performance_id = s.performance_id
    left outer join customer c on c.customer_id = r.customer_id
    left outer join theater t on t.theater_id = p.theater_id
    left outer join seats n on n.seat_id = s.seat_id
    group by s.seat_id, s.reservation_id, s.performance_id
    order by p.performance_date, p.performance_title, c.customer_email, n.seat_name;




select c.*, count(s.reserved_seat_id) as total_seats
	from customer c
	left outer join reservations r on c.customer_id = r.customer_id
    left outer join reserved_seats s on s.reservation_id = r.reservation_id
    group by c.customer_id
    having total_seats > 0
    order by c.customer_email;




select p.performance_title, sum(r.reservation_total)
	from reservations r
    right outer join performance p on p.performance_id = (
			select performance_id
				from reserved_seats
                where reservation_id = r.reservation_id limit 1)
    group by p.performance_title
    order by p.performance_title;






select t.theater_name, sum(r.reservation_total)
	from reservations r
    right outer join theater t on t.theater_id = (
			select theater_id
				from performance
				where performance_id = (
						select performance_id
							from reserved_seats
							where reservation_id = r.reservation_id limit 1)
				limit 1)
    group by t.theater_name
    order by t.theater_name;



select *
from (select c.*, sum(r.reservation_total) as total_spent
	from customer c
    left outer join reservations r on r.customer_id = c.customer_id
    group by c.customer_id) temp
	where temp.total_spent = (select max(total_spent) from (
			select c.*, sum(r.reservation_total) as total_spent
				from customer c
				left outer join reservations r on r.customer_id = c.customer_id
				group by c.customer_id) temp);







