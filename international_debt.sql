-- PostgreSQL Script for Importing CSV Data
-- Files:
-- 1. world population from 1960 to 2023.csv
-- 2. World GDP 1960-2022.csv
-- 3. central_government_debt.csv

BEGIN;

-- --------------------------------------------------------------------------------
-- Processing: world population from 1960 to 2023.csv
-- --------------------------------------------------------------------------------

-- Create Staging Table for World Population
DROP TABLE IF EXISTS WorldPopulation_Staging;
CREATE TABLE WorldPopulation_Staging (
    country_code TEXT,
    country_name TEXT,
    region TEXT,
    income_group TEXT,
    "1960" TEXT, "1961" TEXT, "1962" TEXT, "1963" TEXT, "1964" TEXT, "1965" TEXT, "1966" TEXT, "1967" TEXT, "1968" TEXT, "1969" TEXT,
    "1970" TEXT, "1971" TEXT, "1972" TEXT, "1973" TEXT, "1974" TEXT, "1975" TEXT, "1976" TEXT, "1977" TEXT, "1978" TEXT, "1979" TEXT,
    "1980" TEXT, "1981" TEXT, "1982" TEXT, "1983" TEXT, "1984" TEXT, "1985" TEXT, "1986" TEXT, "1987" TEXT, "1988" TEXT, "1989" TEXT,
    "1990" TEXT, "1991" TEXT, "1992" TEXT, "1993" TEXT, "1994" TEXT, "1995" TEXT, "1996" TEXT, "1997" TEXT, "1998" TEXT, "1999" TEXT,
    "2000" TEXT, "2001" TEXT, "2002" TEXT, "2003" TEXT, "2004" TEXT, "2005" TEXT, "2006" TEXT, "2007" TEXT, "2008" TEXT, "2009" TEXT,
    "2010" TEXT, "2011" TEXT, "2012" TEXT, "2013" TEXT, "2014" TEXT, "2015" TEXT, "2016" TEXT, "2017" TEXT, "2018" TEXT, "2019" TEXT,
    "2020" TEXT, "2021" TEXT, "2022" TEXT, "2023" TEXT
);

-- COPY Data into Staging Table
COPY WorldPopulation_Staging FROM 'C:/Users/viver/OneDrive/Documents/International-Debt-Analysis/world population from 1960 to 2023.csv' WITH (FORMAT CSV, HEADER TRUE, NULL '');

-- Create Final Long-Format Table for World Population
DROP TABLE IF EXISTS WorldPopulation_long;
CREATE TABLE WorldPopulation_long (
    CountryCode TEXT,
    CountryName TEXT,
    Region TEXT,
    IncomeGroup TEXT,
    Year INTEGER,
    PopulationValue BIGINT,
    PRIMARY KEY (CountryCode, Year)
);

-- Transform and Insert Data into Final Table
INSERT INTO WorldPopulation_long (CountryCode, CountryName, Region, IncomeGroup, Year, PopulationValue)
SELECT
    s.country_code,
    s.country_name,
    s.region,
    s.income_group,
    kv.key::INTEGER AS Year,
    NULLIF(TRIM(kv.value), '')::BIGINT AS PopulationValue
FROM
    WorldPopulation_Staging s,
    LATERAL jsonb_each_text(
        to_jsonb(s) - 'country_code' - 'country_name' - 'region' - 'income_group'
    ) kv
WHERE kv.value IS NOT NULL AND TRIM(kv.value) <> '' AND kv.key ~ '^[0-9]{4}$'; -- Ensure key is a 4-digit year and value is not empty

-- Drop Staging Table
DROP TABLE IF EXISTS WorldPopulation_Staging;

-- --------------------------------------------------------------------------------
-- Processing: World GDP 1960-2022.csv
-- --------------------------------------------------------------------------------

-- Create Staging Table for World GDP
DROP TABLE IF EXISTS WorldGDP_Staging;
CREATE TABLE WorldGDP_Staging (
    country_name TEXT,
    country_code TEXT,
    "1960" TEXT, "1961" TEXT, "1962" TEXT, "1963" TEXT, "1964" TEXT, "1965" TEXT, "1966" TEXT, "1967" TEXT, "1968" TEXT, "1969" TEXT,
    "1970" TEXT, "1971" TEXT, "1972" TEXT, "1973" TEXT, "1974" TEXT, "1975" TEXT, "1976" TEXT, "1977" TEXT, "1978" TEXT, "1979" TEXT,
    "1980" TEXT, "1981" TEXT, "1982" TEXT, "1983" TEXT, "1984" TEXT, "1985" TEXT, "1986" TEXT, "1987" TEXT, "1988" TEXT, "1989" TEXT,
    "1990" TEXT, "1991" TEXT, "1992" TEXT, "1993" TEXT, "1994" TEXT, "1995" TEXT, "1996" TEXT, "1997" TEXT, "1998" TEXT, "1999" TEXT,
    "2000" TEXT, "2001" TEXT, "2002" TEXT, "2003" TEXT, "2004" TEXT, "2005" TEXT, "2006" TEXT, "2007" TEXT, "2008" TEXT, "2009" TEXT,
    "2010" TEXT, "2011" TEXT, "2012" TEXT, "2013" TEXT, "2014" TEXT, "2015" TEXT, "2016" TEXT, "2017" TEXT, "2018" TEXT, "2019" TEXT,
    "2020" TEXT, "2021" TEXT, "2022" TEXT
);

-- COPY Data into Staging Table
COPY WorldGDP_Staging FROM 'C:/Users/viver/OneDrive/Documents/International-Debt-Analysis/World GDP 1960-2022.csv' WITH (FORMAT CSV, HEADER TRUE, NULL '');

-- Create Final Long-Format Table for World GDP
DROP TABLE IF EXISTS WorldGDP_long;
CREATE TABLE WorldGDP_long (
    CountryName TEXT,
    CountryCode TEXT,
    Year INTEGER,
    GDPValue NUMERIC(25, 2),
    PRIMARY KEY (CountryCode, Year)
);

-- Transform and Insert Data into Final Table
INSERT INTO WorldGDP_long (CountryName, CountryCode, Year, GDPValue)
SELECT
    s.country_name,
    s.country_code,
    kv.key::INTEGER AS Year,
    NULLIF(TRIM(kv.value), '')::NUMERIC(25, 2) AS GDPValue
FROM
    WorldGDP_Staging s,
    LATERAL jsonb_each_text(
        to_jsonb(s) - 'country_name' - 'country_code'
    ) kv
WHERE kv.value IS NOT NULL AND TRIM(kv.value) <> '' AND kv.key ~ '^[0-9]{4}$';

-- Drop Staging Table
DROP TABLE IF EXISTS WorldGDP_Staging;

-- --------------------------------------------------------------------------------
-- Processing: central_government_debt.csv
-- --------------------------------------------------------------------------------

-- Create Staging Table for Central Government Debt
DROP TABLE IF EXISTS CentralGovernmentDebt_Staging;
CREATE TABLE CentralGovernmentDebt_Staging (
    country_name TEXT,
    indicator_name TEXT,
    "1950" TEXT, "1951" TEXT, "1952" TEXT, "1953" TEXT, "1954" TEXT, "1955" TEXT, "1956" TEXT, "1957" TEXT, "1958" TEXT, "1959" TEXT,
    "1960" TEXT, "1961" TEXT, "1962" TEXT, "1963" TEXT, "1964" TEXT, "1965" TEXT, "1966" TEXT, "1967" TEXT, "1968" TEXT, "1969" TEXT,
    "1970" TEXT, "1971" TEXT, "1972" TEXT, "1973" TEXT, "1974" TEXT, "1975" TEXT, "1976" TEXT, "1977" TEXT, "1978" TEXT, "1979" TEXT,
    "1980" TEXT, "1981" TEXT, "1982" TEXT, "1983" TEXT, "1984" TEXT, "1985" TEXT, "1986" TEXT, "1987" TEXT, "1988" TEXT, "1989" TEXT,
    "1990" TEXT, "1991" TEXT, "1992" TEXT, "1993" TEXT, "1994" TEXT, "1995" TEXT, "1996" TEXT, "1997" TEXT, "1998" TEXT, "1999" TEXT,
    "2000" TEXT, "2001" TEXT, "2002" TEXT, "2003" TEXT, "2004" TEXT, "2005" TEXT, "2006" TEXT, "2007" TEXT, "2008" TEXT, "2009" TEXT,
    "2010" TEXT, "2011" TEXT, "2012" TEXT, "2013" TEXT, "2014" TEXT, "2015" TEXT, "2016" TEXT, "2017" TEXT, "2018" TEXT, "2019" TEXT,
    "2020" TEXT, "2021" TEXT, "2022" TEXT
);

-- COPY Data into Staging Table
COPY CentralGovernmentDebt_Staging FROM 'C:/Users/viver/OneDrive/Documents/International-Debt-Analysis/central_government_debt.csv' WITH (FORMAT CSV, HEADER TRUE, NULL '');

-- Create Final Long-Format Table for Central Government Debt
DROP TABLE IF EXISTS CentralGovernmentDebt_long;
CREATE TABLE CentralGovernmentDebt_long (
    CountryName TEXT,
    IndicatorName TEXT,
    Year INTEGER,
    DebtPercentage NUMERIC(10, 5),
    PRIMARY KEY (CountryName, IndicatorName, Year)
);

-- Transform and Insert Data into Final Table
INSERT INTO CentralGovernmentDebt_long (CountryName, IndicatorName, Year, DebtPercentage)
SELECT
    s.country_name,
    s.indicator_name,
    kv.key::INTEGER AS Year,
    NULLIF(TRIM(kv.value), '')::NUMERIC(10, 5) AS DebtPercentage
FROM
    CentralGovernmentDebt_Staging s,
    LATERAL jsonb_each_text(
        to_jsonb(s) - 'country_name' - 'indicator_name'
    ) kv
WHERE kv.value IS NOT NULL AND TRIM(kv.value) <> '' AND kv.key ~ '^[0-9]{4}$';

-- Drop Staging Table
DROP TABLE IF EXISTS CentralGovernmentDebt_Staging;

COMMIT;

