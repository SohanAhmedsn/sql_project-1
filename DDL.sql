--CREATE DATABASE
IF DB_ID('CarRental') IS NULL
	CREATE DATABASE CarRental
GO 
USE CarRental
GO
--________________________________/Table# 1\_____________________________________
CREATE TABLE manufacturers
(
	manufacturer_id INT IDENTITY PRIMARY KEY,
	manufacturer_name NVARCHAR(50) NOT NULL,
	manufacturer_details NVARCHAR(150) NULL
)
GO
-- ____________________/Insert in manufacturers with procedure\____________________
CREATE PROC spInsertManufacturer	
							@manufacturer_name nvarchar(50) ,
							@manufacturer_details nvarchar(150),
							@manufacturer_id INT  OUTPUT
AS
	DECLARE @id INT
	BEGIN TRY
		insert into manufacturers (manufacturer_name, manufacturer_details) values (@manufacturer_name, @manufacturer_details)
		SELECT @manufacturer_id = SCOPE_IDENTITY()
	END TRY
	BEGIN CATCH
		DECLARE @errmessage nvarchar(500)
		set @errmessage = ERROR_MESSAGE()
		RAISERROR( @errmessage, 11, 1)
		return 
	END CATCH
GO
--_____________________/Update in manufacturers with procedure\__________________
CREATE PROC spUpdateManufacturer
								@manufacturer_id INT,
								@manufacturer_name NVARCHAR(50)=null,
								@manufacturer_details NVARCHAR(150)=NULL
AS
BEGIN TRY
	UPDATE manufacturers 
	SET manufacturer_name=ISNULL(@manufacturer_name,manufacturer_name),manufacturer_details=ISNULL(@manufacturer_details,manufacturer_details)
	WHERE manufacturer_id=@manufacturer_id
END TRY
BEGIN CATCH
	DECLARE @errmessage nvarchar(500)
	set @errmessage = ERROR_MESSAGE()
	RAISERROR( @errmessage, 11, 1)
	return 
END CATCH
return 
GO
--___________________/Delete from manufacturers with procedure\___________________
CREATE PROC spDeleteManufacturer @manufacturer_id INT							
AS
BEGIN TRY
	DELETE manufacturers
	WHERE manufacturer_id=@manufacturer_id
END TRY
BEGIN CATCH
	;
	THROW 5002,'Can''t Delete',1
END CATCH
GO
-- __________________________/Table# 2\__________________________
CREATE TABLE models
(
	model_id INT IDENTITY PRIMARY KEY,
	model_name NVARCHAR(30) NOT NULL,
	manufacturer_id INT NOT NULL REFERENCES manufacturers (manufacturer_id)
)
GO
--_____________________/Insert in models with procedure\______________________________
CREATE PROC spInsertModels	@model_name nvarchar(30) ,
	
	@manufacturer_id INT,
							@model_id INT  OUTPUT
AS
	DECLARE @id INT
	BEGIN TRY
		insert into models(model_name,manufacturer_id) values (@model_name,@manufacturer_id)
		SELECT @model_id = SCOPE_IDENTITY()
		
	END TRY
	BEGIN CATCH
		DECLARE @errmessage nvarchar(500)
		set @errmessage = ERROR_MESSAGE()
		RAISERROR( @errmessage, 11, 1)
		return 
	END CATCH
GO
--_______________________/Update in models with procedure\____________________________
CREATE PROC spUpdateModels 
							@model_name NVARCHAR(50),
							@manufacturer_id INT,
							@model_id INT
							
AS
BEGIN TRY
	UPDATE models
	SET model_name=@model_name, manufacturer_id=@manufacturer_id
	WHERE model_id=@model_id

END TRY
BEGIN CATCH
	;
	THROW 5002,'Update failed',1
END CATCH
GO
--_____________________/Delete from models with procedure\__________________________________
CREATE PROC spDeleteModels @model_id INT							
AS
BEGIN TRY
	DELETE models
	WHERE model_id=@model_id
END TRY
BEGIN CATCH
	;
	THROW 5002,'Can''t Delete',1
END CATCH
GO
--____________________________/Table# 3\______________________
CREATE TABLE customers
(
	customer_id INT IDENTITY PRIMARY KEY,
	customer_name NVARCHAR(50) NOT NULL,
	customer_email NVARCHAR(50) NOT NULL,
	customer_phone NVARCHAR(20) NOT NULL,
	customer_address NVARCHAR(150) NOT NULL
)
GO
--__________________________/Insert in customers with procedure\____________________
CREATE PROC spInsertCustomers	
								@customer_name nvarchar(30) ,
								@customer_email NVARCHAR(50),
								@customer_phone NVARCHAR(20),
								@customer_address NVARCHAR(150)

AS
	
	BEGIN TRY
		insert into customers(customer_name,customer_email,customer_phone,customer_address) values (@customer_name,@customer_email,@customer_phone,@customer_address)
		
		
	END TRY
	BEGIN CATCH
		DECLARE @errmessage nvarchar(500)
		set @errmessage = ERROR_MESSAGE()
		RAISERROR( @errmessage, 11, 1)
		return 
	END CATCH
GO
--_______________________/Update in customers with procedure\____________________________
CREATE PROC spUpdateCustomers @customer_id INT,
							@customer_name nvarchar(30) ,
								@customer_email NVARCHAR(50),
								@customer_phone NVARCHAR(20)
							
AS
BEGIN TRY
	UPDATE customers
	SET customer_name =@customer_name,customer_email=@customer_email,customer_phone=@customer_phone
	WHERE customer_id=@customer_id

END TRY
BEGIN CATCH
	;
	THROW 5002,'Update failed',1
END CATCH
GO
--______________________/Delete from customers with procedure\______________________________
CREATE PROC spDeleteCustomers @customer_id INT							
AS
BEGIN TRY
	DELETE customers
	WHERE customer_id=@customer_id
END TRY
BEGIN CATCH
	;
	THROW 5002,'Can''t Delete',1
END CATCH
GO
--_________________________/ Table# 4\______________________________________________________
CREATE TABLE bookingstatus
(
	status_id INT IDENTITY PRIMARY KEY,
	status_desc NVARCHAR(20) NOT NULL
)
GO
--_________________________/Insert in bookingstatus with procedure\_____________________________
CREATE PROC spInsertBookingstatus @status_desc nvarchar(20),
												@status_id INT OUTPUT
AS
	DECLARE @id INT
	BEGIN TRY
		INSERT INTO bookingstatus(status_desc) VALUES (@status_desc)
		SELECT @status_id=SCOPE_IDENTITY()
	END TRY
	BEGIN CATCH
		DECLARE @errmessage nvarchar(500)
		set @errmessage = ERROR_MESSAGE()
		RAISERROR( @errmessage, 11, 1)
		return 
	END CATCH
GO
--________________________/Update in bookingstatus with procedure\____________________________________
CREATE PROC spUpdateBookingStatus 
								@status_id INT,
								@status_desc NVARCHAR(20)
								
							
AS
BEGIN TRY
	UPDATE BookingStatus
	SET status_desc =@status_desc
	WHERE status_id=@status_id

END TRY
BEGIN CATCH
	;
	THROW 5002,'Update failed',1
END CATCH
GO
--______________________/Delete from bookingstatus with procedure\______________________________________________
CREATE PROC spDeleteBookingStatus @status_id INT							
AS
BEGIN TRY
	DELETE bookingstatus
	WHERE status_id=@status_id
END TRY
BEGIN CATCH
	;
	THROW 5002,'Can''t Delete',1
END CATCH
GO
-- _________________________________/Table# 5\___________________________________________________________
CREATE TABLE vehicle_categories
(
	category_id INT IDENTITY PRIMARY KEY,
	category_name  NVARCHAR(40) NOT NULL
)
GO
--________________________/Insert in vehicle_catagory with procedure\______________________________________________
CREATE TABLE vehicle_categories
(
	category_id INT IDENTITY PRIMARY KEY,
	category_name  NVARCHAR(40) NOT NULL
)
CREATE PROC spInsertVrhicleCategories	
										@category_name  NVARCHAR(40)
										

AS
	
	BEGIN TRY
		insert into vehicle_categories(category_name) values (@category_name)
		
		
	END TRY
	BEGIN CATCH
		DECLARE @errmessage nvarchar(500)
		set @errmessage = ERROR_MESSAGE()
		RAISERROR( @errmessage, 11, 1)
		return 
	END CATCH
GO
--____________________/Update in vehicle_catagory with procedure\_________________________________________________
CREATE TABLE vehicle_categories
(
	category_id INT IDENTITY PRIMARY KEY,
	category_name  NVARCHAR(40) NOT NULL
)
CREATE PROC spUpdateVrhicleCategories @category_id INT,
							@category_name  NVARCHAR(40)
							
AS
BEGIN TRY
	UPDATE vehicle_categories
	SET category_name=@category_name
	WHERE category_id=@category_id

END TRY
BEGIN CATCH
	;
	THROW 5002,'Update failed',1
END CATCH
GO
--______________________/Delete from vehicle_catagory with procedure\_______________________________________
CREATE TABLE vehicle_categories
(
	category_id INT IDENTITY PRIMARY KEY,
	category_name  NVARCHAR(40) NOT NULL
)
CREATE PROC spDeleteVrhicleCategories @category_id INT							
AS
BEGIN TRY
	DELETE vehicle_categories
	WHERE category_id=@category_id

END TRY
BEGIN CATCH
	;
	THROW 5002,'Can''t Delete',1
END CATCH
GO
--___________________________/Table# 6\___________________________________________________________
CREATE TABLE vehicle_categories
(
	category_id INT IDENTITY PRIMARY KEY,
	category_name  NVARCHAR(40) NOT NULL
)
CREATE TABLE vehicles
(
	vehicle_id INT IDENTITY PRIMARY KEY,
	current_milage INT NOT NULL,
	hire_rate MONEY NOT NULL,
	engine_size INT NOT NULL,
	category_id INT NOT NULL REFERENCES vehicle_categories(category_id),
	model_id INT NOT NULL REFERENCES models(model_id)
)
GO
--_____________________/Insert in vahicles with procedure\____________________________________________________
CREATE TABLE vehicle_categories
(
	category_id INT IDENTITY PRIMARY KEY,
	category_name  NVARCHAR(40) NOT NULL
)
CREATE PROC spInsertVehicles @current_milage INT,
								@hire_rate MONEY ,
								@engine_size INT,
								@category_id INT,
								@model_id INT,
								@vehicle_id INT OUTPUT
AS
	DECLARE @id INT
	BEGIN TRY
		INSERT INTO vehicles(current_milage,hire_rate,engine_size,category_id,model_id) VALUES (@current_milage,@hire_rate,@engine_size,@category_id,@model_id)
		SELECT @vehicle_id=SCOPE_IDENTITY()
	END TRY
	BEGIN CATCH
		DECLARE @errmessage nvarchar(500)
		set @errmessage = ERROR_MESSAGE()
		RAISERROR( @errmessage, 11, 1)
		return 
	END CATCH
GO
--__________________________/-Update in vahicles with procedure\______________________________________________
CREATE TABLE vehicle_categories
(
	category_id INT IDENTITY PRIMARY KEY,
	category_name  NVARCHAR(40) NOT NULL
)
CREATE PROC spUpdateVehicles 
								@vehicle_id INT,
								@current_milage INT,
								@hire_rate MONEY ,
								@engine_size INT
							
AS
BEGIN TRY
	UPDATE vehicles
	SET current_milage=@current_milage,hire_rate=@hire_rate,engine_size=@engine_size
	WHERE vehicle_id=@vehicle_id

END TRY
BEGIN CATCH
	;
	THROW 5002,'Update failed',1
END CATCH
GO
--__________________/Delete from vahicles with procedure\___________________________________________
CREATE TABLE vehicle_categories
(
	category_id INT IDENTITY PRIMARY KEY,
	category_name  NVARCHAR(40) NOT NULL
)
CREATE PROC spDeleteVehicles @vehicle_id INT							
AS
BEGIN TRY
	DELETE vehicles
	WHERE vehicle_id=@vehicle_id
END TRY
BEGIN CATCH
	;
	THROW 5002,'Can''t Delete',1
END CATCH
GO
--___________________________/Table# 7\___________________________________________________________
CREATE TABLE vehicle_categories
(
	category_id INT IDENTITY PRIMARY KEY,
	category_name  NVARCHAR(40) NOT NULL
)
CREATE TABLE bookings
(
	booking_id INT IDENTITY PRIMARY KEY,
	date_from DATE NOT NULL,
	date_to DATE NOT NULL,
	payment_recieved_on DATE  NULL,
	customer_id INT NOT NULL REFERENCES customers (customer_id),
	vehicle_id INT NOT NULL REFERENCES vehicles (vehicle_id)
	
)
GO
--___________________/Insert in bookings with procedure\___________________________________________________________
CREATE TABLE vehicle_categories
(
	category_id INT IDENTITY PRIMARY KEY,
	category_name  NVARCHAR(40) NOT NULL
)
CREATE PROC spInsertBookings	
								@date_from DATE ,
								@date_to DATE,
								@payment_recieved_on DATE,
								@customer_id INT,
								@vehicle_id INT

AS
	
	BEGIN TRY
		insert into bookings(date_from,date_to,payment_recieved_on,customer_id,vehicle_id) values 
		(@date_from,@date_to,@payment_recieved_on,@customer_id,@vehicle_id)
		
		
	END TRY
	BEGIN CATCH
		DECLARE @errmessage nvarchar(500)
		set @errmessage = ERROR_MESSAGE()
		RAISERROR( @errmessage, 11, 1)
		return 
	END CATCH
GO

--______________/Update in bookings with procedure\___________________________________________________________
CREATE TABLE vehicle_categories
(
	category_id INT IDENTITY PRIMARY KEY,
	category_name  NVARCHAR(40) NOT NULL
)
CREATE PROC spUpdateBookings @booking_id INT,
							@date_from DATE,
							@date_to DATE
							
AS
BEGIN TRY
	UPDATE bookings
	SET date_from=@date_from,date_to=@date_to
	WHERE booking_id=@booking_id

END TRY
BEGIN CATCH
	;
	THROW 5002,'Update failed',1
END CATCH
GO
--___________________________/-Delete from bookings with procedure\___________________________________________________________
CREATE TABLE vehicle_categories
(
	category_id INT IDENTITY PRIMARY KEY,
	category_name  NVARCHAR(40) NOT NULL
)
CREATE PROC spDeleteBookings @booking_id INT							
AS
BEGIN TRY
	DELETE bookings
	WHERE booking_id=@booking_id
END TRY
BEGIN CATCH
	;
	THROW 5002,'Can''t Delete',1
END CATCH
GO
--___________________________/VIEW \___________________________________________________________
CREATE TABLE vehicle_categories
(
	category_id INT IDENTITY PRIMARY KEY,
	category_name  NVARCHAR(40) NOT NULL
)
CREATE VIEW vBookingCurrentMonth
AS
SELECT c.customer_name, c.customer_phone, c.customer_email, c.customer_address,
	m.model_name, v.engine_size, v.hire_rate, b.date_from, b.date_to,
	b.payment_recieved_on
	FROM bookings b
	INNER JOIN customers c
	ON b.customer_id = c.customer_id
	INNER JOIN vehicles v
	ON b.vehicle_id = v.vehicle_id
	INNER JOIN models m
	ON v.model_id = m.model_id
	WHERE MONTH(date_from) = MONTH(GETDATE())
		AND YEAR(date_from) = YEAR(GETDATE())
GO
--___________________________/View\___________________________________________________________
CREATE TABLE vehicle_categories
(
	category_id INT IDENTITY PRIMARY KEY,
	category_name  NVARCHAR(40) NOT NULL
) 
create view vehiclelist
as
SELECT vehicle_categories.category_name, models.model_name, manufacturers.manufacturer_name, vehicles.current_milage, vehicles.hire_rate, vehicles.engine_size
FROM vehicle_categories 
INNER JOIN vehicles ON vehicle_categories.category_id = vehicles.category_id 
INNER JOIN models ON vehicles.model_id = models.model_id 
INNER JOIN manufacturers ON models.manufacturer_id = manufacturers.manufacturer_id
go

--___________________________/-Triggers\___________________________________________________________
CREATE TABLE vehicle_categories
(
	category_id INT IDENTITY PRIMARY KEY,
	category_name  NVARCHAR(40) NOT NULL
)
create trigger checkbooking
on bookings
after insert 
as
begin
	declare @bid int, @vid int, @f date, @t date
	select @bid =booking_id, @vid=vehicle_id, @f=date_from, @t=date_to from inserted
	IF EXISTS (SELECT 1 FROM bookings WHERE booking_id <> @bid and vehicle_id = @vid AND @f <= cast(date_to as date))
	BEGIN
		ROLLBACK TRANSACTION
		RAISERROR ('Car is not available.', 10, 1)
		RETURN
	END
end
go
--___________________________/UDF \___________________________________________________________
CREATE TABLE vehicle_categories
(
	category_id INT IDENTITY PRIMARY KEY,
	category_name  NVARCHAR(40) NOT NULL
)
create function bookingofvehcle_date_range(@vid int, @from date, @to date) returns table
as
return (SELECT vehicles.vehicle_id, models.model_name, vehicle_categories.category_name, bookings.date_from, bookings.date_to, bookings.payment_recieved_on, customers.customer_name, customers.customer_email, 
                         customers.customer_phone
FROM vehicles 
INNER JOIN models ON vehicles.model_id = models.model_id 
INNER JOIN vehicle_categories ON vehicles.category_id = vehicle_categories.category_id 
INNER JOIN bookings ON vehicles.vehicle_id = bookings.vehicle_id 
INNER JOIN customers ON bookings.customer_id = customers.customer_id
where vehicles.vehicle_id=@vid and (cast(bookings.date_from as date) between @from and @to)
)
go