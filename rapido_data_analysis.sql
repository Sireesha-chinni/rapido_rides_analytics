use rapidodb;

select * from rapido_table;


select * from rapido_table;

-- KPI's 

-- Total number of bookings

select count(*) as Total_number_of_bookings from rapido_table;


-- Total number of customers

select count(distinct customer_id) as Total_number_of_customers from rapido_table;

-- Total number of Drivers

select count(distinct driver_id) as Total_number_of_Drivers from rapido_table;

-- Total rides completed

select count(*) as Total_completed_rides from rapido_table 
where Booking_status = "Completed";

-- Total Cancelled Rides

select count(*) as Total_cancelled_rides from rapido_table 
where Booking_status = "Cancelled";

-- Average Rating by customer

select round(avg(customer_rating),2) as Avg_customer_Rating from rapido_table;

-- Cancellation rate of customer

select (sum(canceled_rides_by_customer)/count(booking_id)) * 100 as Customer_cancellation_rate from rapido_table;

-- Average Rating by Driver

select round(avg(Driver_rating),2) as Avg_Driver_Rating from rapido_table;

-- Cancellation rate of Driver

select (sum(Canceled_Rides_by_Driver)/count(booking_id)) * 100 as Driver_cancellation_rate from rapido_table;

 -- Analysing
 
 -- Top 10 customers who completed more rides
 
 select customer_Id, count(booking_id) as count_of_rides from rapido_table
 group by customer_Id
 order by count_of_rides desc
 limit 10;
 
 
 -- Customer Count by rating level 
 select 
 case
 when customer_rating <3.5 then "Low"
 when customer_rating <4.5 then "Medium"
 else "High"
 end as customer_rating_level ,count(*) as number_of_customers 
 from rapido_table
 group by customer_rating_level;
 
 
 -- City-wise Cancellation rate
 
 select pickup_location , (sum(canceled_rides_by_customer)/count(booking_id)) * 100 as Customer_cancellation_rate
 from rapido_table
 group by pickup_location;
 
 
 -- Cancellation Rate of customer by Rating
 
 Select (sum(canceled_rides_by_customer)/count(booking_id)) * 100 as Customer_cancellation_rate,
 customer_rating from rapido_table
 group by customer_rating;
 
 
 -- Count of customers by payment type
 
 select payment_method, count(customer_id) as number_of_customers from rapido_table
 group by payment_method;
 
 
 -- Customer Wise analysis
 
 select customer_id,
       count(booking_id) as total_rides,
       round(avg(customer_rating),2) as avg_rating,
       sum(canceled_rides_by_customer) as total_cancellations
from rapido_table
group by customer_id;
 
 -- Count of Rides Completed by Vehicle Type
 
 select vehicle_Type , count(*) as number_rides
 from rapido_table
 where Booking_status = "Completed"
 group by vehicle_Type;
 
 -- Top 10 Drivers by Rating 
 
 select Driver_ID, round(avg(Driver_Rating),1) as Driver_rating from rapido_table
 group by driver_id
 order by Driver_rating desc
 limit 10;
 
 
 -- Driver Cancellation rate by location 
 
 select pickup_location , (sum(Canceled_Rides_by_Driver)/count(booking_id)) * 100 as Driver_cancellation_rate from rapido_table
 group by pickup_location;
 
 
 -- Count of rides by Booking Status
 
 select Booking_Status , Count(*) as Total_number_of_rides from rapido_table
 group by Booking_Status;
 
 -- count of Payments method by booking status
 
  select Payment_Method , Count(*) as Total_number_of_rides from rapido_table
 group by Payment_Method;
 
 
 -- Vehicle Type-Wise Booking
 
   select Vehicle_Type , Count(*) as Total_number_of_rides from rapido_table
 group by Vehicle_Type;
 
 
 