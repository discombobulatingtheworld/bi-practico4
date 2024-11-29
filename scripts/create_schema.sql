CREATE SCHEMA IF NOT EXISTS staging;
CREATE SCHEMA IF NOT EXISTS datawarehouse;

-- Step                : Table output
-- Database Connection : practico4
-- SQL                  : 
CREATE TABLE staging.onestar (
    "name" VARCHAR(60),
    "year" BIGINT,
    latitude BIGINT,
    longitude BIGINT,
    city VARCHAR(60),
    region VARCHAR(14),
    zipCode VARCHAR(8),
    cuisine VARCHAR(60),
    price VARCHAR(5),
    url VARCHAR(256)
);

-------------------------------------------------------------------------------------------
-- Step                : Table output
-- Database Connection : practico4
-- SQL                  : 
CREATE TABLE staging.twostar (
    "name" VARCHAR(60),
    "year" BIGINT,
    latitude BIGINT,
    longitude BIGINT,
    city VARCHAR(60),
    region VARCHAR(60),
    zipCode VARCHAR(8),
    cuisine VARCHAR(60),
    price VARCHAR(5),
    url VARCHAR(256)
);

-------------------------------------------------------------------------------------------
-- Step                : Table output
-- Database Connection : practico4
-- SQL                  : 
CREATE TABLE staging.threestar (
    "name" VARCHAR(60),
    "year" BIGINT,
    latitude BIGINT,
    longitude BIGINT,
    city VARCHAR(60),
    region VARCHAR(14),
    zipCode VARCHAR(7),
    cuisine VARCHAR(60),
    price VARCHAR(5),
    url VARCHAR(256)
);

-------------------------------------------------------------------------------------------
-- Step                : Búsqueda/actualización en dimensión
-- Database Connection : practico4
-- SQL                  : 
CREATE TABLE datawarehouse.DT_City (
    City_SK BIGSERIAL,
    City_Version INTEGER,
    City_DateFrom TIMESTAMP,
    City_DateTo TIMESTAMP,
    City_Name VARCHAR(60),
    City_Region VARCHAR(14)
);

CREATE INDEX idx_DT_City_lookup ON datawarehouse.DT_City(City_Name, City_Region);

CREATE INDEX idx_DT_City_tk ON datawarehouse.DT_City(City_SK);

-------------------------------------------------------------------------------------------
-- Step                : Búsqueda/actualización en dimensión
-- Database Connection : practico4
-- SQL                  : 
CREATE TABLE datawarehouse.DT_Cuisine (
    Cuisine_SK BIGSERIAL,
    Cuisine_Version INTEGER,
    Cuisine_DateFrom TIMESTAMP,
    Cuisine_DateTo TIMESTAMP,
    Cuisine_Name VARCHAR(60)
);

CREATE INDEX idx_DT_Cuisine_lookup ON datawarehouse.DT_Cuisine(Cuisine_Name);

CREATE INDEX idx_DT_Cuisine_tk ON datawarehouse.DT_Cuisine(Cuisine_SK);

-------------------------------------------------------------------------------------------
-- Step                : Búsqueda/actualización en dimensión
-- Database Connection : practico4
-- SQL                  : 
CREATE TABLE datawarehouse.DT_Restaurant (
    Restaurant_SK BIGSERIAL,
    Restaurant_Version INTEGER,
    Restaurant_DateFrom TIMESTAMP,
    Restaurant_DateTo TIMESTAMP,
    Restaurant_Name VARCHAR(60),
    Restaurant_ZipCode VARCHAR(8),
    Restaurant_Cuisine_SK BIGINT,
    Restaurant_City_SK BIGINT
);

CREATE INDEX idx_DT_Restaurant_lookup ON datawarehouse.DT_Restaurant(
    Restaurant_Name,
    Restaurant_ZipCode,
    Restaurant_Cuisine_SK,
    Restaurant_City_SK
);

CREATE INDEX idx_DT_Restaurant_tk ON datawarehouse.DT_Restaurant(Restaurant_SK);

-------------------------------------------------------------------------------------------
-- Step                : Insertar / Actualizar
-- Database Connection : practico4
-- SQL                  : 
CREATE TABLE datawarehouse.FT_Awards (
    award_year BIGINT,
    award_price VARCHAR(5),
    award_grade TEXT,
    award_restaurant_sk BIGINT
);

CREATE INDEX idx_FT_Awards_lookup ON datawarehouse.FT_Awards(
    award_year,
    award_price,
    award_grade,
    award_restaurant_sk
);