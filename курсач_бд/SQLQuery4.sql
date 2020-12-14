Для шифрования
------------------------------------------------------------------------------
use courseDataBase;
CREATE MASTER KEY ENCRYPTION BY   
PASSWORD = '123';  
CREATE CERTIFICATE HumanResources  
   WITH SUBJECT = 'Security Password';  

CREATE SYMMETRIC KEY SSN_Key_1  
    WITH ALGORITHM = AES_256  
    ENCRYPTION BY CERTIFICATE HumanResources;   

OPEN SYMMETRIC KEY SSN_Key_1  
   DECRYPTION BY CERTIFICATE HumanResources;  

			SET @ID_DOCTOR=(SELECT MAX(ID_DOCTOR) FROM DOCTOR);
			INSERT INTO PASSWORD_TABLE(ID_DOCTOR,ID_PATIENT,USER_PASSWORD)VALUES(@ID_DOCTOR,NULL,NULL);
			OPEN SYMMETRIC KEY SSN_Key_1  
			DECRYPTION BY CERTIFICATE HumanResources;  
			UPDATE PASSWORD_TABLE 
			SET USER_PASSWORD = EncryptByKey(Key_GUID('SSN_Key_1'), @PASSWORD_USER) where ID_DOCTOR=@ID_DOCTOR ; 
SELECT ID_DOCTOR,USER_PASSWORD 'Encrypted ID Number',  
    CONVERT(nvarchar, DecryptByKey(USER_PASSWORD)) AS 'Decrypted ID Number' FROM PASSWORD_TABLE;




	SELECT id, pass
    AS 'Encrypted ID Number',  
    CONVERT(char, DecryptByKey(pass))   
    AS 'Decrypted ID Number'  
    FROM syb;

------------------------------------------------------------------------------
Для динамического маскирования данных
CREATE USER TestUser WITHOUT LOGIN;  
GRANT SELECT ON PATIENT TO TestUser;    
EXECUTE AS USER = 'TestUser';  
SELECT * FROM PATIENT;  
