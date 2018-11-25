DELIMITER //

-- Trigger/Proceduer section 1: Verify book reviews

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

-- The procedure to insert into person table
CREATE PROCEDURE insertPerson(personID INT,forename VARCHAR(20), middle_inititals VARCHAR(20), surname VARCHAR(20), date_ofbirth DATE)
BEGIN
	INSERT INTO 
	person(ID, forename, middle_initials, surname, date_of_birth)
	values (personID, forename, middle_initials, surname, date_of_birth);
END //

-- The procedure to insert into the person table and the contributor table.
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
		call insertperson(personCount, forename, middle_initials, surname, date_of_birth);
	ELSE
		SET personCount = (SELECT person.ID FROM person where (person.forename = forename AND person.middle_initials = middle_initials AND person.surname = surname AND person.date_of_birth = date_of_birth));
	END IF;
	(INSERT INTO contributor VALUE (personCount, biography));
END //

-- The procedure to insert into the person table and the customer table
CREATE PROCEDURE insertCustomer(email_address VARCHAR(1024), forename VARCHAR(20), middle_inititals VARCHAR(20), surname VARCHAR(20), date_of_birth DATE)
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
		call insertperson(personCount, forename, middle_initials, surname, date_of_birth);
	ELSE
		SET personCount = (SELECT person.ID FROM person where (person.forename = forename AND person.middle_initials = middle_initials AND person.surname = surname AND person.date_of_birth = date_of_birth));
	END IF;
	(INSERT INTO customer VALUE (personCount, email_address));
END //