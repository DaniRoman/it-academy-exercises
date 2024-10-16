-- creación de la base de datos 

CREATE DATABASE sprint4 CHARACTER SET utf8;
USE sprint4;


---
-- CREACIÓN DE TABLAS PARA LA BASE DE DATOS 
CREATE TABLE company (
    company_id VARCHAR(50),
    company_name VARCHAR(100),
    phone INT,
    email VARCHAR(50),
    country VARCHAR(50),
    website VARCHAR(100),

    CONSTRAINT pk_company_id PRIMARY KEY(company_id)
);

CREATE TABLE credit_card (
    id VARCHAR(50),
    user_id INT,
    iban VARCHAR(100),
    pan VARCHAR(100),
    pin CHAR(4),
    cvv CHAR(3),
    track1 VARCHAR(100),
    track2V VARCHAR(100),
    expiring_date VARCHAR(10)

    CONSTRAINT pk_credit_card_id PRIMARY KEY(id)
);

CREATE TABLE product(
    id INT,
    product_name VARCHAR(100),
    price DECIMAL(5,2),
    colour VARCHAR(50),
    weight DECIMAL(2,1),
    warehouse_id VARCHAR(10),

    CONSTRAINT pk_product_id PRIMARY KEY(id)
);

CREATE TABLE transaction(
    id VARCHAR(100),
    card_id VARCHAR(20),
    business_id VARCHAR(50),
    timestamp TIMESTAMP,
    amount DECIMAL(5,2),
    declined SMALLINT,
    product_ids INT,
    user_id INT,
    lat VARCHAR(50),
    longitude VARCHAR(50),

    CONSTRAINT pk_transaction_id PRIMARY KEY(id)
);

CREATED TABLE user(
id INT,
name VARCHAR(50),
surname VARCHAR(50),
phone VARCHAR(50),
email VARCHAR(50),
birth_date VARCHAR(100),
country VARCHAR(50),
city VARCHAR(50),
postal_code VARCHAR(20),
address VARCHAR(100)

CONSTRAINT pk_user_id PRIMARY KEY(id)
);

--- CARGAMOS LOS DATOS EN LA BASES DE DATOS A TRAVES DE UNA COMANDA Y UN ARCHIVO CSV

LOAD DATA 
INFILE '/Users/macbook/Documents/it-academy/scripts/sprint4/companies.csv' 
INTO TABLE company 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED 
BY '\n' 
IGNORE 1 LINES;

-------------------------------------------

----UNA VEZ TENEMOS LOS DATOS CARGADOS PROCEDEMOS A CREAR LAS CLAVES FORANEAS

-- 'user_id' en 'credit_card', que referencia a la tabla 'user'
ALTER TABLE credit_card
ADD CONSTRAINT fk_credit_card_user_id
FOREIGN KEY (user_id) REFERENCES user(id);

-- 'card_id' en 'transaction', que referencia a la tabla 'credit_card'
ALTER TABLE transaction
ADD CONSTRAINT fk_transaction_card_id
FOREIGN KEY (card_id) REFERENCES credit_card(id);

-- 'business_id' en 'transaction', que referencia a la tabla 'company'
ALTER TABLE transaction
ADD CONSTRAINT fk_transaction_business_id
FOREIGN KEY (business_id) REFERENCES company(company_id);

-- 'user_id' en 'transaction', que referencia a la tabla 'user'
ALTER TABLE transaction
ADD CONSTRAINT fk_transaction_user_id
FOREIGN KEY (user_id) REFERENCES user(id);

---
-- NIVEL 1 - EJ 1
SELECT name 
FROM user
WHERE id IN (
	SELECT user_id 
	FROM transaction
	GROUP BY user_id
	HAVING COUNT(id) > 30
);

-- NIVEL 1 - EJ 2
SELECT c.company_name, cc.iban, AVG(t.amount) 
FROM company c
JOIN transaction t
ON company_id = business_id
JOIN credit_card cc
ON t.card_id = cc.id
WHERE company_name = 'Donec Ltd'
GROUP BY cc.iban;

-- NIVEL 2 - EJ 1

CREATE TABLE credit_card_status(
	id INT,
	active TINYINT(),
	credit_card_id INT UNIQUE,

	CONSTRAINT pk_id PRIMARY KEY(id)
	CONSTRAINT fk_credit_card FOREIGN KEY(credit_card_id)
		REFERENCES credit_card(id);
)

-- Ver las targetas si tienen mas de 1 decline
SELECT cc.id, COUNT(cc.id),t.timestamp
FROM credit_card cc
JOIN transaction t
ON cc.id = t.card_id
WHERE t.declined != 0
GROUP BY cc.id, t.timestamp;

-- Ver las targetas activas
SELECT COUNT(ccs.id) AS targetas_activas
FROM credit_card cc
JOIN credit_card_status ccs
ON cc.id = ccs.credit_card_id
WHERE ccs.active !=0;


--NIVEL 3 - EJ 1

CREATE TABLE product(
	id VARCHAR(255),
    product_name VARCHAR(255),
    price VARCHAR(255),
    colour VARCHAR(50),
    weight INT,
    warehouse_id VARCHAR(10),
    
    CONSTRAINT pk_product PRIMARY KEY(id)
    
);
--Consulta
SELECT SUM(CASE WHEN '1' IN (product_ids) THEN 1 ELSE 0 END) AS product_1_sales,
	SUM(CASE WHEN '2' IN (product_ids) THEN 1 ELSE 0 END) AS product_2_sales,
    SUM(CASE WHEN '3' IN (product_ids) THEN 1 ELSE 0 END) AS product_3_sales,
    SUM(CASE WHEN '4' IN (product_ids) THEN 1 ELSE 0 END) AS product_4_sales,
    SUM(CASE WHEN '5' IN (product_ids) THEN 1 ELSE1212 0 END) AS product_5_sales,
    SUM(CASE WHEN '6' IN (product_ids) THEN 1 ELSE 0 END) AS product_6_sales,
    SUM(CASE WHEN '7' IN (product_ids) THEN 1 ELSE 0 END) AS product_7_sales,
    SUM(CASE WHEN '8' IN (product_ids) THEN 1 ELSE 0 END) AS product_8_sales,
    SUM(CASE WHEN '9' IN (product_ids) THEN 1 ELSE 0 END) AS product_9_sales
FROM transaction;

--En caso de tener otra tabla 
CREATE TABLE transaction_product (
    transaction_id VARCHAR(255),
    product_id VARCHAR(255),
    PRIMARY KEY (transaction_id, product_id),
    FOREIGN KEY (transaction_id) REFERENCES `transaction`(id),
    FOREIGN KEY (product_id) REFERENCES product(id)
);

SELECT tp.product_id, COUNT(p.id) AS sales_count
FROM transaction_product
GROUP BY tp.product_id;
