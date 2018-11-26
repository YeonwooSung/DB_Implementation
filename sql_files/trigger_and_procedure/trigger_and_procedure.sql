DELIMITER //

-- Trigger/Proceduer section 1: Verify book rating and book reviews

CREATE OR REPLACE TRIGGER `verifyBookRating` before insert on `audiobook_reviews`
for each row
begin
    if (NEW.rating > 6 OR NEW.rating < 0) then
    SIGNAL sqlstate '45001' set message_text = "The rating has to be between 1 and 5";
    end if;
end //


CREATE OR REPLACE TRIGGER `verifyBookReviews` before insert on `audiobook_reviews`
for each row
begin
	SET @purchased_boolean = 0;
	(SELECT COUNT(audiobook_purchases.customer_ID AND audiobook_purchases.ISBN) INTO @purchased_boolean
	FROM audiobook_purchases
	where audiobook_purchases.customer_ID = NEW.customer_ID AND audiobook_purchases.ISBN = NEW.ISBN);
	
    if (@purchased_boolean = 0) then
   	set NEW.verified = 0;
   	ELSE
   	set NEW.verified = 1;
    end if;
end //



-- Trigger/Proceduer section 2: Enforce age ratings

CREATE OR REPLACE TRIGGER `enforceAgeRating` before insert on `audiobook_purchases`
for each row
begin
	SET @rating = 0;
	(SELECT audiobook.age_rating INTO @rating
	FROM audiobook
	where audiobook.ISBN = NEW.ISBN);

	SET @customer_age = 0;
	(SELECT timestampdiff(year,person.date_of_birth,now()) INTO @customer_age
	FROM person
	where person.ID = NEW.customer_ID);
	
    if (@rating > @customer_age) then
   	SIGNAL sqlstate '45001' set message_text = "Underaged To Buy this Audiobook";
    end if;
end //



-- Trigger/Proceduer section 3: Ensure each person is either a customer or contributor (or both). Prevent direct entry into the ‘person’ relation.

-- The procedure to insert data into person table
CREATE PROCEDURE insertPerson(personalID INT,forename VARCHAR(20), middle_inititals VARCHAR(20), surname VARCHAR(20), date_ofbirth DATE)
BEGIN
	INSERT INTO 
	person(ID, forename, middle_initials, surname, date_of_birth)
	values (personalID, forename, middle_initials, surname, date_of_birth);
END //


-- The procedure to insert  data into person table
insertPerson_noMiddleInitial(personalID INT,forename VARCHAR(20), middle_inititals VARCHAR(20), surname VARCHAR(20), date_ofbirth DATE)
BEGIN
	INSERT INTO person SET ID = personalID, forename = forename, middle_initials = middle_initials, surname = surname, date_of_birth = date_of_birth;
END //


-- The procedure to insert data into contributor table.
CREATE PROCEDURE insertAsContributor(personalID INT, biography VARCHAR(1024))
BEGIN
	INSERT INTO contributor (personalID, biography) values (personalID, biography);
END //


-- The procedure to insert data into the person table and the contributor table.
CREATE PROCEDURE insertContributor(biography VARCHAR(1024), forename VARCHAR(20), middle_inititals VARCHAR(20), surname VARCHAR(20), date_of_birth DATE)
BEGIN
	DECLARE personExist INT;
	DECLARE personCount INT;
	SET personExist = 0;
	SET personCount = 0;
	(SELECT COUNT(person.ID) INTO personExist FROM person where
	person.forename = forename AND person.middle_initials = middle_initials AND person.surname = surname AND person.date_of_birth = date_of_birth);
	IF(personExist = 0) THEN
		(SELECT COUNT(person.ID) INTO personCount FROM person);
		SET personCount = personCount + 1;
		call insertPerson(personCount, forename, middle_initials, surname, date_of_birth);
	ELSE
		SET personCount = (SELECT person.ID FROM person where (person.forename = forename AND person.middle_initials = middle_initials AND person.surname = surname AND person.date_of_birth = date_of_birth));
	END IF;
	call insertAsContributor(personCount, biography);
END //


-- The procedure to insert data into the contributor table
CREATE PROCEDURE insertContributor_noMiddleInitial(biography VARCHAR(1024), forename VARCHAR(20), surname VARCHAR(20), date_of_birth DATE)
BEGIN
	DECLARE personExist INT;
	DECLARE personCount INT;
	SET personExist = 0;
	SET personCount = 0;
	(SELECT COUNT(person.ID) INTO personExist FROM person where
	person.forename = forename AND person.surname = surname AND person.date_of_birth = date_of_birth);
	IF(personExist = 0) THEN
		(SELECT COUNT(person.ID) INTO personCount FROM person);
		SET personCount = personCount + 1;
		call insertPerson_noMiddleInitial(personCount, forename, surname, date_of_birth);
	ELSE
		SET personCount = (SELECT person.ID FROM person where (person.forename = forename AND person.middle_initials = middle_initials AND person.surname = surname AND person.date_of_birth = date_of_birth));
	END IF;
	call insertAsContributor(personCount, biography);
END //


-- The procedure to insert data into customer table.
CREATE PROCEDURE insertAsCustomer(personalID INT, email_address VARCHAR(100), pwd VARCHAR(150))
BEGIN
	INSERT INTO customer (personalID, email_address, pwd) values (personalID, email_address, SHA2(pwd, 512));
END //


-- The procedure to insert into the person table and the customer table
CREATE PROCEDURE insertCustomer(email_address VARCHAR(100), pwd VARCHAR(150), forename VARCHAR(20), middle_inititals VARCHAR(20), surname VARCHAR(20), date_of_birth DATE)
BEGIN
	DECLARE personExist INT;
	DECLARE personCount INT;
	SET personExist = 0;
	SET personCount = 0;
	(SELECT COUNT(person.ID) INTO personExist FROM person where
	person.forename = forename AND person.middle_initials = middle_initials AND person.surname = surname AND person.date_of_birth = date_of_birth);
	IF(personExist = 0) AND (email_address IS NOT NULL) AND (pwd IS NOT NULL) THEN
		(SELECT COUNT(person.ID) INTO personCount FROM person);
		SET personCount = personCount + 1;
		call insertPerson(personCount, forename, middle_initials, surname, date_of_birth);
	ELSE
		SET personCount = (SELECT person.ID FROM person where (person.forename = forename AND person.middle_initials = middle_initials AND person.surname = surname AND person.date_of_birth = date_of_birth));
	END IF;
	call insertAsCustomer(personCount, email_address, pwd);
END //


-- The procedure to insert into the person table and the customer table
CREATE PROCEDURE insertCustomer(email_address VARCHAR(100), pwd VARCHAR(150), forename VARCHAR(20), surname VARCHAR(20), date_of_birth DATE)
BEGIN
	DECLARE personExist INT;
	DECLARE personCount INT;
	SET personExist = 0;
	SET personCount = 0;
	(SELECT COUNT(person.ID) INTO personExist FROM person where
	person.forename = forename AND person.surname = surname AND person.date_of_birth = date_of_birth);
	IF(personExist = 0) AND (email_address IS NOT NULL) AND (pwd IS NOT NULL) THEN
		(SELECT COUNT(person.ID) INTO personCount FROM person);
		SET personCount = personCount + 1;
		call insertPerson_noMiddleInitial(personCount, forename, surname, date_of_birth);
	ELSE
		SET personCount = (SELECT person.ID FROM person where (person.forename = forename AND person.middle_initials = middle_initials AND person.surname = surname AND person.date_of_birth = date_of_birth));
	END IF;
	call insertAsCustomer(personCount, email_address, pwd);
END //