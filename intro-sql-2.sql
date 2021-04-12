

--- auto increment 
-- id deðeri unique olmasýný istiyorsunuz çoðu zaman
-- id deðerleri 3 tip ile yapýlýyor 
-- 1.tip integer deðer atanýp, deðeri 1'er 1'er artan veya 3'er 3'er, buna baþlangýç deðeri atýyorsunuz, ilk kullanýcý þu kadar olsun sonrasýnda 1'er 1'er artsýn gibi
-- 3.tip ise sizin TC kimlik numaranýz veya belli bir formüle göre hesaplanan ýd deðeriniz
-- Employees isminde bir tablo oluþtur, 1905 deðeri ile baþlasýn ve 2'þer 2'þer artsýn diyebilirsiniz
-- Employees'da Edit Top 200 Rows diyip girerseniz empid kýsmýna veri giriþi yapamazsýnýz ve diðer deðerleri girdikten sonra kendisi otomatik atayacaktýr.

CREATE TABLE dbo.Employees
(
  empid     INT         NOT NULL identity(1907,2) primary key clustered,
  firstname VARCHAR(30) NOT NULL,
  lastname  VARCHAR(30) NOT NULL,
  hiredate  DATE        NOT NULL,
  mgrid     INT         NULL,
  ssn       VARCHAR(20) NOT NULL,
  salary    MONEY       NOT NULL
);

-- bu da primary key'dir ve siz her çalýþtýrdýðýnýzda bambaþka kodlar oluþtururur
-- eðer oyunlara crack yaptýysanýz orada da kullanmýþ olabilirsiniz
-- integer ile newid arasýnda ki fark þu sizin bir internet siteniz var mesela hepsiburada siz birer birer artan numeric deðer verirseniz ve url'den onu sorgulatabilirseniz
-- hepsiburada.com'un tüm verilerini indirebilirsiniz ve request limiti yoksa 
-- integer olmasýnýn güzel yani ise indexlediðiniz zaman performansý daha yüksek olur unique identifier'a göre 

SELECT NEWID()

--Primary key ekleme. Create table esnasýnda da yapýlabilir primary key clustered ile
-- Alter table ile güncelleme yapabiliyorsunuz, add constraint ise koþul ekle demek
ALTER TABLE dbo.Employees
  ADD CONSTRAINT PK_Employees
  PRIMARY KEY(empid);
  


-- Unique özelliði
-- koþulun ismini verdik
-- ssn numarasýnýn unique olmasýný saðlayabilirsiniz
-- e-mail gibi düþünebilirsiniz, bir yere kayýt olurken sizden e-mail adresinizi istiyorlar
ALTER TABLE dbo.Employees
  ADD CONSTRAINT UNQ_Employees_ssn
  UNIQUE(ssn);

  -- veri giriþi
  -- insert into fonksiyonunu kullanmalsýnýz
  -- hangi columns'lara veri giriþi yapacaksanýz onlarý yazabilirsiniiz
  -- values'den sonra deðerleri yazabilirsiniz 
  -- siz bu kodu çalýþtýrýrsanýz çalýþmayacaktýr, çünkü id kýsmýný otomatik artan yapmýþtýnýz
INSERT INTO [Employees]
([empid],[firstname],[lastname],[hiredate],[mgrid],[ssn],[salary])
VALUES 
(1907,'ismet','can','2012-03-04',132,'49715774718',100)

-- bu kýsýmý çalýþtýrýrsanýz çalýþtýðýný göreceksiniz 
-- ama yukarý kýsýmda ssn numarasýný unique yaptýðýnýz için iki defa çalýþtýrdýðýnýz da çalýþmayacaktýr ve onu deðiþtirmelisiniz

INSERT INTO [Employees]
([firstname],[lastname],[hiredate],[mgrid],[ssn],[salary])
VALUES 
('ismet','can','2012-03-04',132,'49715774718',100)


--  foreign key için tablo kontrolu ve oluþturma
--  kullanýcý tablonuz var bir de order tablosu oluþturmak istiyorsanýz, kontrolunu yapýp silebilirsiniz
IF OBJECT_ID('dbo.Orders', 'U') IS NOT NULL
  DROP TABLE dbo.Orders;

-- order tablosu oluþturma 
-- constraint'i tablo oluþtururken oluþturabilirsiniz, orderid'leri primary key yapmýþ oldunuz
-- ve artýk iki tane tablonuz var employees ve order diye 
-- employees tablosunda ki empid'den order tablosunda ki empid referans almalý 
-- employees tablosunda ki order tablosunda ki empid baðýmlý olmasý gerekiyor ki veriniz güvenli olsun 
CREATE TABLE dbo.Orders
(
  orderid   INT         NOT NULL,
  empid     INT         NOT NULL,
  eventid int not null,
  custid    VARCHAR(10) NOT NULL,
  orderts   DATETIME2   NOT NULL,
  qty       INT         NOT NULL,
  CONSTRAINT PK_Orders PRIMARY KEY(orderid)
);

-- Foreign key ekleme
-- order tablosunu güncelle, ve koþul ekle
-- koþul ise empid deðerin foreign key olsun, referans alýnan yer olmasýný istiyorsunuz
-- referens almasý gereken yer ise employees tablosunda ki empid olacak 

ALTER TABLE dbo.Orders
  ADD CONSTRAINT FK_Orders_Employees
  FOREIGN KEY(empid)
  REFERENCES dbo.Employees(empid);

--Constraint ekleme
ALTER TABLE dbo.Employees
  ADD CONSTRAINT CHK_Employees_salary
  CHECK(salary > 100.00);


--Tablonun silinmesi
DROP TABLE dbo.Orders, dbo.Employees;