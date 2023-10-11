/*
          Data Cleaning Using SQL queries

   Data:Housing data

 */
 
--Data We have

Select*
from [Sql Project]..HousingData
order by 2

--Standardize Date Format

Select SaleDates--CONVERT(date,saledate)
From [Sql Project]..HousingData

Alter Table housingdata
Add  SaleDates date

Update HousingData
set Saledates=CONVERT(date,saledate)

--------------------------------------------------------------------------------------------------------------------------

-- Breaking out PropertyAddress into Individual Columns (Address, City)

Select PropertyAddress
from [Sql Project]..HousingData

Select 
SUBSTRING(propertyaddress,1,CHARINDEX(',',propertyaddress)-1) as Address
, SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1 , LEN(PropertyAddress)) as SplitCity
  from [Sql Project]..HousingData

Alter Table housingdata
Add  Address nvarchar(255)

Update HousingData
set Address=SUBSTRING(propertyaddress,1,CHARINDEX(',',propertyaddress)-1) 

Alter Table housingdata
Add  City nvarchar(255)

Update HousingData
Set City= SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1 , LEN(PropertyAddress)) 

--------------------------------------------------------------------------------------------------------------------------

 -- Breaking out OwnerAddress into Individual Columns (Address, City, State)

Select
PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3),
 PARSENAME(REPLACE(OwnerAddress,',','.'),2)
,PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1)
From [Sql Project].dbo.HousingData


ALTER TABLE Housingdata
Add OwnerSplitAddress Nvarchar(255);

Update HousingData
SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3)



ALTER TABLE Housingdata
Add Ownercities Nvarchar(255);

Update HousingData
SET OwnerCities = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2)


ALTER TABLE Housingdata
Add OwnerStates Nvarchar(255);

Update HousingData
SET OwnerStates = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1)

--------------------------------------------------------------------------------------------------------------------------
 --Change Y and N to Yes and No in "Sold as Vacant" field
 
Select SoldAsVacant
, CASE When SoldAsVacant = 'Y' THEN 'Yes'
	   When SoldAsVacant = 'N' THEN 'No'
	   ELSE SoldAsVacant
	   END
From [Sql Project]..HousingData


Update HousingData
SET SoldAsVacant = CASE When SoldAsVacant = 'Y' THEN 'Yes'
	   When SoldAsVacant = 'N' THEN 'No'
	   ELSE SoldAsVacant
	   END

--------------------------------------------------------------------------------------------------------------------------
-- Populate Property Address data

Select a.ParcelID, a.Address, b.ParcelID, b.Address, ISNULL(a.Address,b.Address)
from [Sql Project]..HousingData A
join [Sql Project]..HousingData b
on A.ParcelID=b.ParcelID
AND a.[UniqueID ] <> b.[UniqueID ]
Where A.Address is null


Update A
SET Address = ISNULL(A.Address,b.Address)
From [Sql Project].dbo.Housingdata A
JOIN  [Sql Project].dbo.Housingdata b
	on a.ParcelID = b.ParcelID
	AND a.[UniqueID ] <> b.[UniqueID ]
Where A.Address is null









--------------------------------------------------------------------------------------------------------------------------
 -- In Case you Want to Delete Unused Data

 Select *
From [Sql Project].dbo.HousingData


ALTER TABLE [Sql Project].dbo.HousingData
DROP COLUMN OwnerCity, Ownerstate, PropertyAddress, SaleDate

