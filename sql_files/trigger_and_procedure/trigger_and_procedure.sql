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

-- TODO