SELECT*
FROM nike_sales_uncleaned;

CREATE TABLE nike1 LIKE nike_sales_uncleaned;
INSERT nike1
SELECT*
FROM nike_sales_uncleaned;

SELECT COUNT(Units_Sold)
FROM nike1
WHERE Units_Sold IS NULL
;-- NULL values hasilnya 0

SELECT COUNT(Units_Sold)
FROM nike1
WHERE Units_Sold = '';-- yang blank values ada 1235

SELECT DISTINCT Region, COUNT(Order_ID)
FROM nike1
GROUP BY Region;

SELECT COUNT(Units_Sold)
FROM nike1
WHERE Units_Sold < 0;-- hasilnya ada berjumlah 205

UPDATE nike1
SET Region = 'Hyderabad'
WHERE Region IN  ('Hyd','hyderbad');

UPDATE nike1
SET Region = 'Bangalore'
WHERE Region = 'bengaluru';

DELETE FROM nike1
WHERE Units_Sold < 0;

SELECT Units_Sold FROM nike1;

UPDATE nike1
SET Units_Sold = NULL
WHERE Units_Sold = '';

SELECT Region, COUNT(Order_ID)
FROM nike1
GROUP BY Region;

SELECT COUNT(*), Order_ID
FROM nike1
GROUP BY Order_ID
HAVING COUNT(*) > 1
ORDER BY Order_ID ASC
;

SELECT*
FROM nike1
ORDER BY Order_ID;

SELECT Order_Date
FROM nike1
LIMIT 20;

UPDATE nike1
SET Order_Date = NULL
WHERE Order_Date = '';

UPDATE nike1
SET Order_Date = DATE_FORMAT (STR_TO_DATE(Order_Date, '%Y/%m/%d'), '%Y-%m-%d')
WHERE  Order_Date LIKE '%/%/%';

UPDATE nike1
SET Order_Date = DATE_FORMAT (STR_TO_DATE(Order_Date, '%d-%m-%Y'), '%Y-%m-%d')
WHERE  Order_Date LIKE '__-__-____';

SELECT Order_Date
FROM nike1
WHERE Order_Date IS NOT NULL
LIMIT 20;

CREATE TABLE nike_clean AS
SELECT DISTINCT *
FROM nike1;

SELECT COUNT(*) AS total_data_kotor FROM nike1;

SELECT COUNT(*) AS total_data_bersih FROM nike_clean;


-- Exploratpry Data Analyst
SELECT
	SUM(Units_Sold) AS TOTAL_BARANG_TERJUAL,
    AVG(MRP) AS RATA_RATA_HARGA,
    SUM(Profit) AS TOTAL_PROFIT,
    MAX(MRP) AS HARGA_TERMAHAL,
    MIN(MRP) AS HARGA_TERMURAH
FROM nike_clean;

SELECT*
FROM nike_clean;

SELECT
	Gender_Category,
    SUM(Units_Sold) AS TOTAL_TERJUAL,
    COUNT(Order_ID) AS JUMLAH_TRANSAKSI
FROM nike_clean
GROUP BY Gender_Category
ORDER BY TOTAL_TERJUAL DESC;

SELECT
	Region,
    SUM(Units_Sold) AS TOTAL_TERJUAL
FROM nike_clean
WHERE Units_Sold IS NOT NULL
GROUP BY Region
ORDER BY TOTAL_TERJUAL DESC;

SELECT
	Product_Line, Product_Name,
    SUM(Units_Sold) AS TOTAL_TERJUAL
FROM nike_clean
GROUP BY Product_Line, Product_Name
ORDER BY TOTAL_TERJUAL DESC
LIMIT 10;

SELECT
	DATE_FORMAT(Order_Date, '%Y-%m') AS BULAN_TAHUN,
    COUNT(Order_ID) AS JUMLAH_TRANSAKSI
FROM nike_clean
GROUP BY BULAN_TAHUN
ORDER BY JUMLAH_TRANSAKSI DESC;

SELECT
	COUNT(Order_ID) AS JUMLAH_TRANSAKSI_AJAIB,
    SUM(Profit) AS TOTAL_PROFIT_PALSU
FROM nike_clean
WHERE Revenue=0 AND Profit > 0;

SELECT
	Region,
    SUM(Profit) AS TOTAL_PROFIT,
    ROUND(AVG(PROFIT),2) AS RATA_RATA_PROFIT_PER_ORDER
FROM nike_clean
GROUP BY Region
ORDER BY TOTAL_PROFIT DESC;

SELECT
	CASE
		WHEN Discount_Applied IS NOT NULL AND Discount_Applied > 0 THEN 'PAKAI DISKON'
        ELSE 'HARGA NORMAL'
	END AS STATUS_DISKON,
    COUNT(Order_ID) AS JUMLAH_TRANSAKSI,
    AVG(Profit) AS RATA_RATA_PROFIT
FROM nike_clean
GROUP BY STATUS_DISKON;

SELECT
	Product_Line, Gender_Category,
    COUNT(Order_ID) AS JUMLAH_TRANSAKSI,
    SUM(Units_Sold) AS TOTAL_BARANG_KELUAR
FROM nike_clean
WHERE Region = 'Bangalore'
GROUP BY Product_Line, Gender_Category
ORDER BY JUMLAH_TRANSAKSI DESC;

SELECT*
FROM nike_clean;






