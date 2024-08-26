-- Table creation script for Apartment Prices project

--Table for sales data
CREATE TABLE ApartmentsSales (
    Id VARCHAR(255),  
    City VARCHAR(255), 
    Type VARCHAR(255),
    SquareMeters FLOAT,
    Rooms INT,
    Floor INT,
    FloorCount INT,
    BuildYear INT,
    Latitude FLOAT,
    Longitude FLOAT,
    CentreDistance DECIMAL(10, 2),
    poiCount INT,
    SchoolDistance DECIMAL(10, 2),
    ClinicDistance DECIMAL(10, 2),
    PostOfficeDistance DECIMAL(10, 2),
    KinderGartenDistance DECIMAL(10, 2),
    RestaurantDistance DECIMAL(10, 2),
    ColleageDistance DECIMAL(10, 2),
    PharmacyDistance DECIMAL(10, 2),
    Ownership VARCHAR(255),
    BuildingMaterial VARCHAR(255),
    Condition VARCHAR(255),
    HasParkingSpace BIT, 
    HasBalcony BIT,
    HasElevator BIT,
    HasSecurity BIT,
    HasStorageRoom BIT,
    Price FLOAT,
    Year INT,  -- The year associated with the date of the offer (based on the file name)
    Month INT,  -- Month associated with bid date (based on file name)
    CONSTRAINT PK_ApartmentSales PRIMARY KEY (Id, Year, Month)
);

-- Table for rental data
CREATE TABLE ApartmentsRentals (
    Id VARCHAR(255),  
    City VARCHAR(255), 
    Type VARCHAR(255),
    SquareMeters FLOAT,
    Rooms INT,
    Floor INT,
    FloorCount INT,
    BuildYear INT,
    Latitude FLOAT,
    Longitude FLOAT,
    CentreDistance DECIMAL(10, 2),
    poiCount INT,
    SchoolDistance DECIMAL(10, 2),
    ClinicDistance DECIMAL(10, 2),
    PostOfficeDistance DECIMAL(10, 2),
    KinderGartenDistance DECIMAL(10, 2),
    RestaurantDistance DECIMAL(10, 2),
    ColleageDistance DECIMAL(10, 2),
    PharmacyDistance DECIMAL(10, 2),
    Ownership VARCHAR(255),
    BuildingMaterial VARCHAR(255),
    Condition VARCHAR(255),
    HasParkingSpace BIT, 
    HasBalcony BIT,
    HasElevator BIT,
    HasSecurity BIT,
    HasStorageRoom BIT,
    Price FLOAT,
    Year INT,  -- The year associated with the date of the offer (based on the file name)
    Month INT,  -- Month associated with bid date (based on file name)
    CONSTRAINT PK_ApartmentRentals PRIMARY KEY (Id, Year, Month)
);
