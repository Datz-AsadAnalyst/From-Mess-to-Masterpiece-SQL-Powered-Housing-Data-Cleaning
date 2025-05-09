# 🧼 From Mess to Masterpiece: Housing Data Cleaning with SQL

**Project Type:** Data Cleaning & Transformation  
**Tools Used:** SQL (MS SQL Server)  
**Dataset:** Housing Market Dataset (raw, unstructured)  
**Project Goal:** Transform messy, inconsistent housing data into a clean, structured, analysis-ready format.



## 🎯 Objective

This project tackles real-world challenges in data cleaning using raw housing market data. Through a series of SQL transformations, the project standardizes formats, parses embedded fields, and intelligently fills missing values — laying the foundation for trustworthy analytics and insights.


## 🛠️ Key Cleaning Techniques Used

### ✅ 1. **Date Format Standardization**
- Converted raw `SaleDate` strings into standardized `DATE` format using `CONVERT()`.
- Added a new `SaleDates` column for structured temporal analysis.

```sql
ALTER TABLE HousingData ADD SaleDates DATE;
UPDATE HousingData SET SaleDates = CONVERT(DATE, SaleDate);
```
### 🧾 2. Splitting Compound Fields (Address, City)
Extracted `Address` and `City` from a single `PropertyAddress` string using `SUBSTRING()` and `CHARINDEX()`
```sql
-- Extract Address
SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress)-1)

-- Extract City
SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress)+1, LEN(PropertyAddress))
```
- Created two new columns: Address, City.
- Populated them using parsed values.
### 🔄 3. Filling Missing Address Data
- Detected missing addresses by checking for `NULL`.
- Used a self-join on `ParcelID` to copy data from similar entries with different `UniqueIDs`.
```sql
UPDATE A
SET Address = ISNULL(A.Address, B.Address)
FROM HousingData A
JOIN HousingData B ON A.ParcelID = B.ParcelID
AND A.UniqueID <> B.UniqueID
WHERE A.Address IS NULL;
```
## 📈 Outcome
- ✅ Clean, consistent, and fully populated dataset.

- ✅ Improved structure for downstream analytics and visualization.

- ✅ Demonstrated strong command of SQL string manipulation, joins, and schema handling.

## 🧠 What I Learned
- Real-world data is always messier than expected.
- Cleaning is not just a technical task — it's data storytelling.
- SQL is incredibly powerful when used creatively and resourcefully.

## 📌 How to Use
Clone this repo.

Open the SQL scripts in Microsoft SQL Server.

Run them step-by-step on your copy of the Housing dataset.

Use the cleaned dataset for analysis, dashboards, or predictive modeling.

## 💡 Future Enhancements
- Automate the cleaning using a stored procedure.

- Create a Power BI dashboard on top of the cleaned data.

- Add logging for each transformation step for traceability.

## 🚀 Connect With Me
If this project inspired or helped you, feel free to:

**⭐ Star this repo**

**🤝 Connect on LinkedIn**

**📬 Reach out with feedback or collaboration ideas!**

           "Clean data isn't just cleaner — it's smarter."
          — Asad ALi, a SQL Artisan 🧙‍♂️
