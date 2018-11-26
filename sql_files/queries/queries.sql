-- Query 1

SELECT customer.personalID, customer.email_address,
    CASE
	WHEN person.middle_initials IS NULL
		THEN CONCAT(person.forename, ' ', person.surname)
		ELSE CONCAT(person.forename, ' ', person.middle_initials, ' ', person.surname)
	END as Full_Name
,
COUNT(audiobook_purchases.ISBN) as Total_Number_Of_Purchases,
IFNULL(SUM(audiobook.purchase_price), 0) as Total_Spent
FROM customer
    LEFT JOIN audiobook_purchases
    ON customer.personalID = audiobook_purchases.customer_ID
    LEFT JOIN audiobook
    ON audiobook.ISBN = audiobook_purchases.ISBN
    LEFT JOIN person
    ON person.ID = customer.personalID
GROUP BY person.ID
ORDER BY Total_Spent DESC, person.forename ASC, person.surname ASC, person.middle_initials ASC;


-- Query 2

SELECT audiobook.ISBN, audiobook.title FROM audiobook
WHERE audiobook.ISBN NOT IN
    (SELECT audiobook_purchases.ISBN FROM audiobook_purchases)
ORDER BY audiobook.title ASC;


-- Query 3

SELECT audiobook_authors.contributor_ID,
    CASE
	WHEN person.middle_initials IS NULL
		THEN CONCAT(person.forename, ' ', person.surname)
		ELSE CONCAT(person.forename, ' ', person.middle_initials, ' ', person.surname)
	END as Full_Name
,
    GROUP_CONCAT(audiobook.title ORDER BY audiobook.title SEPARATOR ',') as Titles
FROM audiobook_authors
JOIN audiobook_purchases
ON audiobook_authors.contributor_ID = audiobook_purchases.customer_ID
AND audiobook_authors.ISBN = audiobook_purchases.ISBN
JOIN audiobook
JOIN person
WHERE audiobook.ISBN = audiobook_authors.ISBN
AND audiobook_authors.contributor_ID = person.ID
group by audiobook_authors.contributor_ID
order by audiobook_authors.contributor_ID;