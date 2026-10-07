-- Creating Database
create database RapidoDB; 

-- using Database 

use RapidoDB;

-- Creating table

create table RapidoData_tb(
Booking_ID varchar(20) primary key ,
Booking_Status varchar(15),
Customer_ID varchar(15),
Driver_ID varchar(15),
Pickup_Location varchar(15),
Ride_DistanceKM decimal(10,2),
Ride_TimeMIN int,
ride_Date DATE,
Vehicle_Type varchar(10),
Payment_Method varchar(10),
Customer_Rating decimal(10,2),
Driver_Rating decimal(10,2),
Canceled_Rides_by_Customer int,
Canceled_Rides_by_Driver int,
Total_Bookings int,
Canceled_Bookings int
);


-- Display the table
 
select * from rapidodata_tb;

-- Triming the Data and updateing them back

set sql_safe_updates = 0;

update rapidodata_tb
 set Booking_id = trim(Booking_id),
 Booking_status = trim(Booking_status),
 Customer_id = trim(Customer_ID),
 Driver_ID = trim(Driver_ID),
 Pickup_Location = trim(Pickup_Location),
 Ride_DistanceKM = trim(Ride_DistanceKM),
 Ride_TimeMIN = trim(Ride_TimeMIN),
 ride_Date = trim(ride_Date),
 Vehicle_Type = trim(Vehicle_Type),
 Payment_Method = trim(Payment_Method),
 Customer_Rating = trim(Customer_Rating),
 Driver_Rating = trim(Driver_Rating),
 Canceled_Rides_by_Customer = trim(Canceled_Rides_by_Customer),
 Canceled_Rides_by_Driver = trim(Canceled_Rides_by_Driver),
 Total_Bookings = trim(Total_Bookings),
 Canceled_Bookings = trim(Canceled_Bookings);
 

-- Captializing the booking id column

update rapidodata_tb
set Booking_id =  upper(Booking_id);


-- Removing the Duplicates from the Booking_id

select Booking_id, count(*) from rapidodata_tb 
group by booking_id
having count(*) >1;  -- no duplicates found

-- Droping the rows with blank in the Booking_id column

delete from rapidodata_tb
where Booking_id = '-' ;

delete from rapidodata_tb
where Booking_id = "";

select * from rapidodata_tb;

-- captilizing the Booking Status coulmn and cleaning 

update rapidodata_tb
set Booking_status = concat( upper(left(booking_status,1)), lower(substring(booking_status,2)))
where booking_status is not null;

update rapidodata_tb
set booking_status = 
case
when booking_status = "Canceled" then "Cancelled"
when booking_status = "Cancelld" then "Cancelled"
when booking_status = "Completd" then "Completed"
when booking_status = "Complete" then "Completed"
when booking_status = "In-Complete" then "Incomplete"
when booking_status = "Incompleted" then "Incomplete"
else booking_status
end 
where booking_status is not null;

update rapidodata_tb
set booking_status = 
case 
when Canceled_rides_by_customer = 0 or Canceled_rides_by_driver = 0 then "Completed"
when Canceled_rides_by_customer = 1 or Canceled_rides_by_driver = 1 then "Cancelled"
else "Incomplete"
 end
where booking_status ="-" or booking_status="";

select distinct booking_status from rapidodata_tb;


select count(*) from rapidodata_tb 
where booking_status = "-";

-- Cleaning customer_Id column

update rapidodata_tb
set customer_id = upper(Customer_id);

update rapidodata_tb
set customer_id = replace(customer_id ,"-","_");

select * from rapidodata_tb where customer_id like '%-%';

update rapidodata_tb
set customer_id = 
case customer_id
when '4176' then "CUST_4176"
when '6700' then "CUST_6700"
when '9955' then "CUST_9955"
else customer_id
end
where customer_id is not null;

select * from rapidodata_tb;

-- Cleaning driver_Id column

update rapidodata_tb
set driver_id = upper(driver_id);

update rapidodata_tb
set Driver_ID = replace(Driver_ID ,"-","_");

select * from rapidodata_tb where Driver_ID not like '%_%';

select count(*) from rapidodata_tb 
where driver_id not like'%_%';

delete from rapidodata_tb
where driver_id = "";

-- Cleaning Pickup_location column

update rapidodata_tb
set pickup_location = concat( upper(left(pickup_location,1)),lower(substring(pickup_location,2)));

select * from rapidodata_tb;

update rapidodata_tb
set pickup_location = 
case pickup_location
when "Bangalore" then "Bengaluru"
when "Bengalore" then "Bengaluru"
when "Blr" then "Bengaluru"
when "Chenai" then "Chennai"
when "Dehli" then "Delhi"
when "Hyd" then "Hyderabad"
when "Hydrabad" then "Hyderabad"
when "Madras" then "Chennai"
when "Ncr Delhi" then "Delhi"
when "New Delhi" then "Delhi"
when "Poona" then "Pune"
when "Puna" then "Pune"
when "Unknown" then "Pune"
when null then "Pune"
else pickup_location
end;

select distinct pickup_location from rapidodata_tb;

select count(*) from rapidodata_tb where pickup_location = "";

update rapidodata_tb
set pickup_location =
case pickup_location
when "New Delhi" then "Delhi"
when "" then "Pune"
else pickup_location
end;

-- cleaning Ride_distance column 

select distinct Ride_DistanceKM from rapidodata_tb;

update rapidodata_tb
set Ride_DistanceKM = replace(Ride_DistanceKM,"KM","");

select * from rapidodata_tb where Ride_DistanceKM = "";

select avg(Ride_DistanceKM) from rapidodata_tb;

update rapidodata_tb
set Ride_DistanceKM = 20.18
where Ride_DistanceKM = 0.00;

-- cleaning Ride_TimeMIN column

select distinct Ride_TimeMIN from rapidodata_tb;

update rapidodata_tb
set Ride_TimeMIN = replace(Ride_TimeMIN,"-","")
where Ride_TimeMIN like "%-%";

select * from rapidodata_tb 
where Ride_TimeMIN ="";

select avg(Ride_TimeMIN) from rapidodata_tb;

update rapidodata_tb
set Ride_TimeMIN = 33
where Ride_TimeMIN =0;

-- cleaning Vehicle_type column

select distinct Vehicle_Type from rapidodata_tb;

update rapidodata_tb
set Vehicle_Type = concat( upper(left(Vehicle_Type,1)), lower(substring(Vehicle_Type,2)));

update rapidodata_tb
set Vehicle_Type = 
case Vehicle_Type
when "Auto Rickhaw" then "Auto"
when "Auto-Rickshaw" then "Auto"
when "Motorbike" then "Bike"
when "Two Wheeler" then "Bike"
when "-" then "Bike"
else Vehicle_Type
end
where Vehicle_Type is not null;

update rapidodata_tb
set Vehicle_Type = "Auto"
where Vehicle_Type = "";

-- Cleaning Payment_Method colunm

update rapidodata_tb
set Payment_Method = concat( upper(left(Payment_Method,1)), lower(substring(Payment_Method,2)));

update rapidodata_tb
set Payment_Method =
case Payment_Method
when "Cash Payment" then "Cash"
when "Credit Card" then "Card"
when "Debit Card" then "Card"
when "E-Wallet" then "Upi"
when "Google Pay" then "Upi"
when "Gpay" then "Upi"
when "Paytm Wallet" then "Upi"
when "Phonepe" then "Upi"
when "-" then "cash"
when "" then "Cash"
else Payment_Method
end;

select distinct Payment_Method from rapidodata_tb;

-- cleaning Customer_rating colunm

select distinct Customer_Rating from rapidodata_tb;

update rapidodata_tb
set Customer_Rating = replace(Customer_Rating,"-","");

select * from rapidodata_tb;

update rapidodata_tb
set Customer_Rating = 4.8
where Customer_Rating > 5.0;

alter table rapidodata_tb 
modify Customer_Rating float check (Customer_Rating<= 5.0);

select avg(Customer_Rating) from rapidodata_tb;

update rapidodata_tb
set Customer_Rating = 3.9
where Customer_Rating = 0.0 or Customer_Rating is null;

-- cleaning Driver_rating colunm

select distinct Driver_Rating from rapidodata_tb;

update rapidodata_tb
set Driver_Rating = 
case Driver_Rating
when 45 then 4.5
when 50 then 5
when 10 then 1
else Driver_Rating
end;

update rapidodata_tb
set Driver_Rating = replace(Driver_Rating,"-","");

select avg(Driver_Rating) from rapidodata_tb;

update rapidodata_tb
set Driver_Rating = 4
where Driver_Rating = 0 or Driver_Rating is null;

update rapidodata_tb
set Driver_Rating = 4.8
where Driver_Rating >5;

alter table rapidodata_tb
modify Driver_Rating float check (Driver_Rating <=5);

-- cleaning Canceled_Rides_by_Customer colunm

select * from rapidodata_tb;

select distinct Canceled_Rides_by_Customer from rapidodata_tb;

update rapidodata_tb
set Canceled_Rides_by_Customer = replace(Canceled_Rides_by_Customer,"-","");

alter table rapidodata_tb 
modify Canceled_Rides_by_Customer int check (Canceled_Rides_by_Customer >=0);


-- cleaning Canceled_Rides_by_Driver colunm

select distinct Canceled_Rides_by_Driver from rapidodata_tb;

update rapidodata_tb
set Canceled_Rides_by_Driver = replace(Canceled_Rides_by_Driver,"-","");

alter table rapidodata_tb 
modify Canceled_Rides_by_Driver int check (Canceled_Rides_by_Driver >=0);

-- cleaning Total_Bookings colunm

select distinct Total_Bookings from rapidodata_tb;

update rapidodata_tb
set Total_Bookings = replace (Total_Bookings ,"-","");

alter table  rapidodata_tb
modify Total_Bookings int check (Total_Bookings >=0);

select avg(total_bookings) from rapidodata_tb;

update rapidodata_tb
set Total_Bookings = 969
where Total_Bookings= 0;

-- cleaning Canceled_Bookings colunm

select distinct Canceled_Bookings from rapidodata_tb;


update rapidodata_tb
set Canceled_Bookings = replace (Canceled_Bookings ,"-","");

alter table  rapidodata_tb
modify Canceled_Bookings int check (Canceled_Bookings >=0);

select avg(Canceled_Bookings) from rapidodata_tb;

update rapidodata_tb
set Canceled_Bookings = 121
where Canceled_Bookings= 0;