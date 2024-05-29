ALTER TABLE housing2 ALTER COLUMN SaleDate DATe

select * 
from housing2
where PropertyAddress is null

select a.[UniqueID ], a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress
from housing2 a
join housing2 b
	on a.ParcelID = b.ParcelID
	and a.[UniqueID ] <> b.[UniqueID ]
where a.PropertyAddress is null

update a
set propertyaddress = ISNULL(a.propertyaddress, b.propertyaddress)
from housing2 a
join housing2 b
	on a.ParcelID = b.ParcelID
	and a.[UniqueID ] <> b.[UniqueID ]
where a.PropertyAddress is null

select SUBSTRING(propertyaddress, 1, charindex(',', propertyaddress)) as address,
	   charindex(',', propertyaddress) as Comma_Location
from housing2

select SUBSTRING(propertyaddress, 1, charindex(',', propertyaddress) -1 ) as address
from housing2

select SUBSTRING(propertyaddress, 1, charindex(',', propertyaddress) -1) as address,
	substring(propertyaddress, charindex(',', propertyaddress) + 1, len(propertyaddress)) as City
from housing2

alter table housing2
add StreetAddress2 varchar(255);

update housing2
set StreetAddress2 = SUBSTRING(propertyaddress, 1, charindex(',',propertyaddress) -1)

select *
from housing3

alter table housing2
add City varchar(255);

update housing2
set City = SUBSTRING(propertyaddress, charindex(',', propertyaddress) + 1, len(propertyaddress))

select PARSENAME(replace(owneraddress, ',', '.'), 3),
	  PARSENAME(replace(owneraddress, ',', '.'), 2),
	  PARSENAME(replace(owneraddress, ',', '.'), 1)
from housing2

select *
from housing2

alter table housing2
add Owner_Street_Address varchar(255);

update housing2
set Owner_Street_Address = PARSENAME(replace(owneraddress, ',', '.'), 3)

alter table housing2
add Owner_City varchar(255);

update housing2
set Owner_City = PARSENAME(replace(owneraddress, ',', '.'), 2)

alter table housing2
add Owner_State varchar(255);

update housing2
set Owner_State = PARSENAME(replace(owneraddress, ',', '.'), 1)

select distinct(soldasvacant), count(soldasvacant)
from housing2
group by SoldAsVacant
order by 2


select soldasvacant,
	CASe	when SoldAsVacant = 'Y' Then 'Yes'
			when SoldAsVacant = 'N' then 'No'
			else SoldAsVacant
			end as Yes_No_Vacancy

from housing2

update housing2
set SoldAsVacant = CASe	when SoldAsVacant = 'Y' Then 'Yes'
			when SoldAsVacant = 'N' then 'No'
			else SoldAsVacant
			end

select distinct(soldasvacant), count(soldasvacant)
from housing2
group by SoldAsVacant;

with rowNum as (
select *,
	ROW_NUMBER() over (
	Partition by ParcelID,
				PropertyAddress,
				SalePrice,
				SaleDate,
				LegalReference
				order by uniqueID) as row_num
from housing2)


select
from rowNum 
where row_num > 1
order by row_num desc


--DELETE
--from rowNum
--Where row_num > 1

alter table housing2
drop column propertyaddress, owneraddress, taxdistrict



































































































