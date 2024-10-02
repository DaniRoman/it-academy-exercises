-- Utilitzant JOIN realitzaràs les següents consultes:

-- Nivell 1

-- Ejercici 2

-- Llistat dels països que estan fent compres.
SELECT DISTINCT c.country 
FROM company AS c 
INNER JOIN transaction AS t ON c.id = t.company_id
WHERE t.declined != 1;

-- Des de quants països es realitzen les compres.
SELECT COUNT(DISTINCT c.country)  AS `cantidad de paises que realispaïsos es realitzen les compres`
FROM company AS c 
INNER JOIN transaction AS t ON c.id = t.company_id
WHERE t.declined != 1;

-- Identifica la companyia amb la mitjana més gran de vendes.
SELECT c.company_name, avg_transactions.avg_amount
FROM company AS c
INNER JOIN (
    SELECT company_id, AVG(amount) AS avg_amount
    FROM transaction AS t
    GROUP BY company_id
) AS avg_transactions
ON c.id = avg_transactions.company_id
ORDER BY avg_transactions.avg_amount DESC
LIMIT 1;

-- Ejercici 3

-- Utilitzant només subconsultes (sense utilitzar JOIN):

-- Mostra totes les transaccions realitzades per empreses d'Alemanya.
SELECT *,(SELECT country FROM company WHERE company.id = transaction.company_id AND company.country = 'Germany') AS 'Country'
FROM transaction
WHERE company_id IN (
    SELECT id
    FROM company
    WHERE country = 'Germany'
);

-- Llista les empreses que han realitzat transaccions per un amount superior a la mitjana de totes les transaccions.
SELECT * 
FROM company
WHERE id IN (
	SELECT company_id
    FROM transaction
    WHERE amount > (
		SELECT AVG(amount) 
        FROM transaction
    )
)

-- Eliminaran del sistema les empreses que no tenen transaccions registrades, entrega el llistat d'aquestes empreses.
SELECT *
FROM company
WHERE id NOT IN (
    SELECT company_id
    FROM transaction
);

--------------------------------------------------------------
-- Nivell 2


-- Exercici 1
-- Identifica els cinc dies que es va generar la quantitat més gran d'ingressos a l'empresa per vendes. 
-- Mostra la data de cada transacció juntament amb el total de les vendes.
SELECT timestamp, SUM(amount) AS total_vendas
FROM transaction
GROUP BY timestamp
ORDER BY total_vendas DESC
LIMIT 5;

-- Exercici 2
-- Quina és la mitjana de vendes per país? Presenta els resultats ordenats de major a menor mitjà.
SELECT c.country, AVG(t.amount) AS average_sales
FROM company c
JOIN transaction t 
ON c.id = t.company_id
GROUP BY c.country
ORDER BY average_sales DESC

-- Exercici 3
-- En la teva empresa, es planteja un nou projecte per a llançar algunes campanyes publicitàries per a fer competència a la companyia "Non Institute".
--  Per a això, et demanen la llista de totes les transaccions realitzades per empreses que estan situades en el mateix país que aquesta companyia.
-- Mostra el llistat aplicant JOIN i subconsultes.
SELECT t.* 
FROM transaction t
JOIN (
	SELECT id
    FROM company
    WHERE country IN (
		SELECT country 
		FROM company
		WHERE company_name = "Non Institute"
    ) 
) subconsulta
ON t.company_id = subconsulta.id;

-- Mostra el llistat aplicant solament subconsultes.
SELECT * 
FROM transaction
WHERE company_id IN (
	SELECT id
    FROM company
    WHERE country IN (
		SELECT country 
		FROM company
		WHERE company_name = "Non Institute"
    ) 
) 

-- Nivell 3

-- Exercici 1
-- Presenta el nom, telèfon, país, data i amount, d'aquelles empreses que van realitzar transaccions amb un valor comprès entre 100 i 200 euros 
-- i en alguna d'aquestes dates: 29 d'abril del 2021, 20 de juliol del 2021 i 13 de març del 2022. Ordena els resultats de major a menor quantitat.

SELECT c.id, c.phone, c.country, t.timestamp, t.amount 
FROM company c
JOIN transaction t ON c.id = t.company_id
WHERE t.amount BETWEEN 100 AND 200 
AND DATE(t.timestamp) IN ('2021-04-29', '2021-06-20', '2022-03-13')
ORDER BY t.amount DESC;


-- Exercici 2
-- Necessitem optimitzar l'assignació dels recursos i dependrà de la capacitat operativa que es requereixi, per la qual cosa 
-- et demanen la informació sobre la quantitat de transaccions que realitzen les empreses, però el departament de recursos humans és exigent i vol un llistat de les empreses on especifiquis si tenen més de 4 transaccions o menys.


-- quantitat de transaccions que realitzen les empreses, si tenen més de 4 transaccions o menys.
SELECT c.id, c.company_name, COUNT(t.amount) AS cantidad_transacciones,
       CASE 
           WHEN COUNT(t.amount) > 4 THEN 'Més de 4 transaccions'
           ELSE '4 transaccions o menys'
       END AS transaccio_categoria
FROM company c
LEFT JOIN transaction t
ON c.id = t.company_id
GROUP BY c.id, c.company_name;

