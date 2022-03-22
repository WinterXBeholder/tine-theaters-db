drop database if exists `tiny-theaters`;
create database `tiny-theaters`;
use `tiny-theaters`;

create table excel_data (
	id int primary key auto_increment,
    customer_first varchar(100) not null,
    customer_last varchar(100) not null,
    customer_email varchar(100) not null,
    customer_phone varchar(100) not null,
    customer_address varchar(100) not null,
    seat varchar(100) not null,
    `show` varchar(100) not null,
    ticket_price decimal(4,2) not null,
    `date` date not null,
    theater varchar(100) not null,
    theater_address varchar(100) not null,
    theater_phone varchar(100) not null,
    theater_email varchar(100) not null
);

-- Create tables in order of dependency because a table can't be created with a reference to a table that hasn't been created yet.
create table customer (
customer_id int primary key auto_increment,
    first_name varchar(100) not null,
    last_name varchar(100) not null,
    customer_email varchar(100) not null,
    customer_phone varchar(100),
    customer_address varchar(100)
);

create table theater (
	theater_id int primary key auto_increment,
    theater_name varchar(100) not null,
    theater_address varchar(100) not null,
    theater_phone varchar(100) not null,
    theater_email varchar(100) not null,
	constraint unique_name_email
		unique (theater_name, theater_email)
);

create table performance (
	performance_id int primary key auto_increment,
	theater_id int not null,
    performance_title varchar(100) not null,
    performance_date date not null,
    current_ticket_price decimal(4,2) not null,
	constraint foreign_key_performance_theater_id
		foreign key (theater_id)
        references theater(theater_id),
	constraint unique_theater_performance_date
		unique (theater_id, performance_title, performance_date)
);

create table reservations (
	reservation_id int primary key auto_increment,
    performance_id int not null,
	customer_id int not null,
	constraint foreign_key_reservation_performance_id
		foreign key (performance_id)
        references performance(performance_id),
	constraint foreign_key_customer_id
		foreign key (customer_id)
        references customer(customer_id)
);

create table seats (
	seat_id int primary key auto_increment,
    theater_id int not null,
    seat_name varchar(100) not null,
    constraint foreign_key_seat_theater_id
		foreign key (theater_id)
        references theater(theater_id)
);

create table reserved_seats (
	reserved_seat_id int primary key auto_increment,
    seat_id int not null,
    reservation_id int not null,
    constraint foreign_key_reservation_id
		foreign key (reservation_id)
        references reservations(reservation_id),
    constraint foreign_key_seat_id
		foreign key (seat_id)
        references seats(seat_id)
);
