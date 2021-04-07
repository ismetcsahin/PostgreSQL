--Sunucudaki veritabanlarýnýn listelenmesi
--Eðer bir tablo okuyacaksanýz, FROM'dan sonra yazmanýz gerekiyor. 
--SELECT kýsmýnda ise hangi Columns'ý görmek istiyorsanýz o kýsýma yazmalýsýnýz.
SELECT * FROM sys.databases; 

--Veritabanlarýnýn dosyalarý ve lokasyonlarý 
-- dbid diye columns koyduk, eðer biz ldf veya mdf dosyalarýný görmek istiyorsak 
-- db_name diye bir fonksiyon koyabilirsiniz o içerisin de dbid alýr ve o db'nin ismini döner size 
-- ayrýca bunu da sys.sysaltfiles üzerinden oku diyebilirsiniz
select dbid,db_name(dbid), filename from sys.sysaltfiles 
select db_name(dbid) dbname, filename from sys.sysaltfiles

--üzerinde çalýþýlan veri tabanýna ait özellikler
-- üzerinde çalýþtýðýnýz veri tabaný özelliklerini size döner 
-- Execute'un yan tarafýnda yer alan kýsýmndan veri tabanýnýzý seçip yapabilirsiniz
SELECT * FROM sys.database_files;

--Veritabaný oluþturma
-- Eðer sorgu seviyesinde veri tabaný oluþturmak istiyorsanýz CREATE DATABASE yazmanýz gerekiyor
-- Veri tabanýnýzýn ismini yazmalýsýnýz, FILENAME'in Path'ini belirtmelisiniz
CREATE DATABASE introsql ON (FILENAME = 'D:\yedek\DataScienceEarth_Data.mdf');

--Kullanýlacak veritabaný seçimi
-- Execute'un yan tarafýnda deðiþtiðini görebilirsiniz
Use introsql

--Kullanýlacak tablonun varlýðýnýn sorgulanmasý ve varsa silinmesi
-- Diðer programlama dillerinde ki gibi IF koþulu aslýnda ayný iþi yapar 
-- Veri tabanýnda Employees diye bir tablo varsa ve boþ deðilse 
-- DROP TABLE ile sil diyor
IF OBJECT_ID('dbo.Employees', 'U') IS NOT NULL
  DROP TABLE dbo.Employees;




--Tablo oluþturma
-- Üst satýrda sildiðiniz tabloyu þimdi oluþturacaksýnýz
-- Employees tablosu oluþtur
-- NOT NULL - Boþ olmamasýný saðlýyor
-- Tables üzerine Refresh yaparsanýz tablonuzu görüntüleyebilirsiniz
CREATE TABLE dbo.Employees
(
  empid     INT         NOT NULL,
  firstname VARCHAR(30) NOT NULL,
  lastname  VARCHAR(30) NOT NULL,
  hiredate  DATE        NOT NULL,
  mgrid     INT         NULL,
  ssn       VARCHAR(20) NOT NULL,
  salary    MONEY       NOT NULL
);