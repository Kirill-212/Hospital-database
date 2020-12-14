use CourseDB;
use test;
create database test;
use test;
select * from syb;
insert into syb(pass) values(1);
insert into syb(pass) values(2);
insert into syb(passID,pass) values('23',23);
insert into syb(passID,pass)values('123',3534534);
insert into syb(passID,pass)values('534',534);
drop table syb;
create table syb(
ID int primary key identity,
pass varbinary(128) null);

CREATE MASTER KEY ENCRYPTION BY   
PASSWORD = '123';  
  

CREATE CERTIFICATE Sales09
   WITH SUBJECT = 'Password';  

CREATE SYMMETRIC KEY Encoding_Password 
    WITH ALGORITHM = AES_256  
    ENCRYPTION BY CERTIFICATE Sales09;  



	OPEN SYMMETRIC KEY Encoding_Password   
   DECRYPTION BY CERTIFICATE Sales09;  


   UPDATE syb  
SET pass = EncryptByKey(Key_GUID('Encoding_Password')  
    , '12',1, HashBytes('SHA1', CONVERT( varbinary  
    , id))) where id=2; 



	OPEN SYMMETRIC KEY Encoding_Password   
   DECRYPTION BY CERTIFICATE Sales09;  

SELECT id, pass  
    AS 'Encrypted ID Number',  
    CONVERT(int, DecryptByKey(pass, 1 ,   
    HashBytes('SHA1', CONVERT(varbinary, id))))  
    AS 'Decrypted card number'   
    FROM syb; 




	select * from syb;
insert into syb(pass) values(1);
insert into syb(pass) values(2);
insert into syb(passID,pass) values('23',23);
insert into syb(passID,pass)values('123',3534534);
insert into syb(passID,pass)values('534',534);
drop table syb;
create table syb(
ID int primary key identity,
pass varbinary(128) null);


CREATE CERTIFICATE HumanResources37  
   WITH SUBJECT = 'Security Password';  

CREATE SYMMETRIC KEY SSN_Key_1  
    WITH ALGORITHM = AES_256  
    ENCRYPTION BY CERTIFICATE HumanResources37;  
GO  

OPEN SYMMETRIC KEY SSN_Key_1  
   DECRYPTION BY CERTIFICATE HumanResources37;  

UPDATE syb  
SET pass = EncryptByKey(Key_GUID('SSN_Key_1'), '1232424') ; 

SELECT id, pass
    AS 'Encrypted ID Number',  
    CONVERT(char, DecryptByKey(pass))   
    AS 'Decrypted ID Number'  
    FROM syb;


	drop table Membership ;
CREATE TABLE Membership  
  (MemberID int IDENTITY PRIMARY KEY,  
   FirstName varchar(100) MASKED WITH (FUNCTION = 'partial(2,"XXXXXXX",1)') NULL,  
   LastName varchar(100) NOT NULL,  
   Phone varchar(12) MASKED WITH (FUNCTION = 'default()') NULL,  
   Email varchar(100) MASKED WITH (FUNCTION = 'email()') NULL);  
  
INSERT Membership (FirstName, LastName, Phone, Email) VALUES   
('Roberto', 'Tamburello', '555.123.4567', 'RTamburello@contoso.com'),  
('Janice', 'Galvin', '555.123.4568', 'JGalvin@contoso.com.co'),  
('Zheng', 'Mu', '555.123.4569', 'ZMu@contoso.net');  
SELECT * FROM dbo.Membership;  

CREATE USER TestUser WITHOUT LOGIN;  
GRANT SELECT ON Membership TO TestUser;  
EXECUTE AS USER = 'dbo';   
EXECUTE AS USER = 'TestUser';  
SELECT * FROM Membership;  
CREATE USER TestUser1 WITHOUT LOGIN;  
GRANT SELECT ON Membership TO TestUser1;  

GRANT UNMASK TO TestUser1; 

ALTER TABLE Membership  
ALTER COLUMN LastName ADD MASKED WITH (FUNCTION = 'partial(2,"XXX",0)');  


GRANT UNMASK TO TestUser;  
EXECUTE AS USER = 'TestUser';
EXECUTE AS USER = 'TestUser1';  
SELECT * FROM Membership;  
REVERT;   
    
-- Removing the UNMASK permission  
REVOKE UNMASK TO TestUser;





DECLARE @json NVARCHAR(MAX);
SET @json = N'[
  {"id": 2, "info": {"name": "John", "surname": "Smith"}, "age": 25},
  {"id": 5, "info": {"name": "Jane", "surname": "Smith"}, "dob": "2005-11-04T12:00:00"}
]';

SELECT *
FROM OPENJSON(@json)
  WITH (
    id INT 'strict $.id',
    firstName NVARCHAR(50) '$.info.name',
    lastName NVARCHAR(50) '$.info.surname',
    age INT,
    dateOfBirth DATETIME2 '$.dob'
  );
-----------------------json
--C:\ycheba\3course1sem\курсач бд\Hospital.json
DECLARE @json NVARCHAR(MAX)
SELECT @json = BulkColumn
 FROM OPENROWSET (BULK 'C:\ycheba\3course1sem\курсач бд\Hospital.json', SINGLE_CLOB) as j
 SELECT value

DECLARE @json NVARCHAR(MAX)
SET @json =   
  N'[  
       {  
         "Order": {  
           "Number":"SO43659",  
           "Date":"2011-05-31T00:00:00"  
         },  
         "AccountNumber":"AW29825",  
         "Item": {  
           "Price":2024.9940,  
           "Quantity":1  
         }  
       },  
       {  
         "Order": {  
           "Number":"SO43661",  
           "Date":"2011-06-01T00:00:00"  
         },  
         "AccountNumber":"AW73565",  
         "Item": {  
           "Price":2024.9940,  
           "Quantity":3  
         }  
      }  
 ]'  
   
SELECT * FROM  
 OPENJSON ( @json )  
WITH (   
              Number   varchar(200) '$.Order.Number' ,  
              Date     datetime     '$.Order.Date',  
              Customer varchar(200) '$.AccountNumber',  
              Quantity int          '$.Item.Quantity'  
 ) 

 INSERT INTO Customers(Age,FirstName,LastName,Email,Phone)VALUES(2,'F','F','F','F'),(1,'E','E','E','E')
 INSERT INTO Orders (CustomerId,CreatedAt) VALUES(3,'10-10-2000'),(4,'10-10-2000')

 DELETE Customers
WHERE Id=3