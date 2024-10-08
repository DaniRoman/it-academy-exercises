-- Nivell 1 - Exercici 1

CREATE TABLE credit_card (
    id VARCHAR(15), 
    iban VARCHAR(26), 
    pan VARCHAR(19) , 
    pin CHAR(4), 
    cvv CHAR(3), 
    expiring_date VARCHAR(10), 
    CONSTRAINT pk_id PRIMARY KEY (id)
);
--Asi queda despues 

-- CREATE TABLE credit_card (
--     id VARCHAR(20), 
--     iban VARCHAR(50), 
--     pin VARCHAR(4), 
--     cvv INT, 
--     expiring_date VARCHAR(10), 
--     CONSTRAINT pk_id PRIMARY KEY (id)
-- );

ALTER TABLE transaction
ADD CONSTRAINT fk_credit_card FOREIGN KEY(credit_card_id)
    REFERENCES credit_card(id);

-- ALTER TABLE company 
-- ADD credit_card_id VARCHAR(15),
-- ADD CONSTRAINT fk_credit_card FOREIGN KEY(credit_card_id)
--     REFERENCES credit_card(id);
-------------------------

-- Nivell 1 - Exercici 2

SELECT * FROM credit_card 
WHERE id = 'CcU-2938';

UPDATE credit_card SET iban='R323456312213576817699999'
WHERE id = 'CcU-2938';

-- Nivell 1 - Exercici 3

INSERT INTO company (id, company_name, phone, email, country, website) 
VALUES ('b-9999', 'Umbrella CORP', '06 85 57 52 33', 'nemesis@ps5.com', 'Germany', 'https://instagram.com/site');

INSERT INTO credit_card (id, iban, pan, pin, cvv, expiring_date) 
VALUES ('CcU-9999', 'BG72LKTQ15627628377365', '446566 886747 7265', '4800', '160', '10/29/24');

INSERT INTO transaction (  Id,  credit_card_id,   company_id,  user_id,  lat,   longitude,   amount,  declined)  
VALUES ('108B1D1D-5B23-A76C-55EF-C568E49A99DD',  'CcU-9999',  'b-9999',  '9999',  '829.999',  '-117.999',  '111.11',  '0');

SELECT * FROM transaction 
WHERE id = '108B1D1D-5B23-A76C-55EF-C568E49A99DD'

-- Nivell 1 - Exercici 4

ALTER TABLE credit_card DROP pan;

---------------------------------

-- Nivell 2 - Exercici 1

DELETE FROM transaction WHERE id = '02C6201E-D90A-1859-B4EE-88D2986D3B02';
-- Nivell 2 - Exercici 2

CREATE VIEW VistaMarketing 
AS
SELECT c.company_name, c.phone, c.country, AVG(t.amount) AS shopping_average
FROM company c
JOIN transaction t
ON c.id = t.company_id
WHERE declined != 1
GROUP BY c.company_name, c.phone, c.country
ORDER BY shopping_average DESC;

-- Nivell 2 - Exercici 3

SELECT * FROM VistaMarketing
WHERE country = 'Germany';

----------------------------------

-- Nivell 3 - Exercici 1

ALTER TABLE company DROP website;

ALTER TABLE credit_card MODIFY id VARCHAR(20);
ALTER TABLE credit_card MODIFY iban VARCHAR(50);
ALTER TABLE credit_card MODIFY pin VARCHAR(4);
ALTER TABLE credit_card MODIFY cvv INT;

ALTER TABLE credit_card ADD fecha_actual DATE;

CREATE TABLE IF NOT EXISTS user (
        id INT PRIMARY KEY,
        name VARCHAR(100),
        surname VARCHAR(100),
        phone VARCHAR(150),
        email VARCHAR(150),
        birth_date VARCHAR(100),
        country VARCHAR(150),
        city VARCHAR(150),
        postal_code VARCHAR(100),
        address VARCHAR(255)
);

ALTER TABLE transaction 
ADD CONSTRAINT fk_user FOREIGN KEY(user_id) 
	REFERENCES user(id);

ALTER TABLE user RENAME TO user_data;

-- Nivell 3 - Exercici 2

CREATE VIEW InformeTecnico
AS
SELECT t.id AS id_transaccion, u.name AS nombre_usuario, u.surname as apellido_usuario, cc.iban, c.company_name AS nombre_compañia
FROM transaction t 
JOIN user_data u
ON t.user_id = u.id
JOIN credit_card cc
ON t.credit_card_id = cc.id
JOIN company c
ON t.company_id = c.id
ORDER BY id_transaccion DESC;