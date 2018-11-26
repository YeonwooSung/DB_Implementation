-- Insert sample data for people (could be either customer or contributor - or both).

INSERT INTO person SET ID = 1, forename = 'Bob', middle_initials = 'B A', surname = 'Bobson', date_of_birth = '2009-12-31';

INSERT INTO customer SET personalID = 1, email_address = 'bob_jnr@bobson.com', pwd = SHA2('bobspassword1', 512);


INSERT INTO person SET ID = 2, forename = 'Bob', middle_initials = 'A B', surname = 'Bobson', date_of_birth = '1978-10-23';

INSERT INTO customer SET personalID = 2, email_address = 'bob_snr@bobson.com', pwd = SHA2('bobspassword2', 512);


INSERT INTO person SET ID = 3, forename = 'Stephen', surname = 'Fry', date_of_birth = '1957-08-24';

INSERT INTO contributor SET personalID = 3, biography = 'An English comedian, actor, writer, presenter, and activist.';

INSERT INTO customer SET personalID = 3, email_address = 'sfry@email.com', pwd = SHA2('stephan321', 512);


INSERT INTO person SET ID = 4, forename = 'Hugh', surname = 'Laurie', date_of_birth = '1959-06-10';

INSERT INTO contributor SET personalID = 4, biography = 'An English actor, musician, comedian, and writer.';

INSERT INTO customer SET personalID = 4, email_address = 'hugh@laurie.com', pwd = SHA2('hugh123huh', 512);


INSERT INTO person SET ID = 5, forename = 'Ruth', surname = 'Letham', date_of_birth = '1978-11-23';

INSERT INTO customer SET personalID = 5, email_address = 'ruth@letham.com', pwd = SHA2('ruthspassword543', 512);

INSERT INTO phone_number SET customer_ID = 5, phone_number = '02222 111 333';


INSERT INTO person SET ID = 6, forename = 'Simon', surname = 'Prebble', date_of_birth = '1942-02-13';

INSERT INTO contributor SET personalID = 6, biography = 'An English actor and narrator. Initially a stage actor, he has a wide-ranging career in television drama, was a game show announcer in Britain, and a voice-over narrator for television, and film. In recent years he has narrated a large number of audio books and received an Audie (Audio book Oscar) in 2010.';


INSERT INTO person SET ID = 7, forename = 'JK', surname = 'Rowling', date_of_birth = '1965-07-31';

INSERT INTO contributor SET personalID = 7, biography = 'After finishing the first book and whilst training as a teacher, Harry Potter was accepted for publication by Bloomsbury. Harry Potter and the Philosopher’s Stone quickly became a bestseller on publication in 1997. As the book was translated into other languages, Harry Potter started spreading round the globe – and J.K. Rowling was soon receiving thousands of letters from fans.';

INSERT INTO customer SET personalID = 7, email_address = 'jk@rowling.com', pwd = SHA2('hPotterFan1', 512);


INSERT INTO person SET ID = 8, forename = 'Newton', middle_initials = 'A F', surname = 'Scamander', date_of_birth = '1897-02-24';

INSERT INTO contributor SET personalID = 8, biography = 'Famed expert in the field of Magizoology.';


INSERT INTO person SET ID = 9, forename = 'Pippa', middle_initials = 'A', surname = 'Smith', date_of_birth = '2005-01-01';

INSERT INTO customer SET personalID = 9, email_address = 'pippa.smith@email.com', pwd = SHA2('pippaA', 512);

INSERT INTO phone_number SET customer_ID = 9, phone_number = '01111 222 333';

INSERT INTO phone_number SET customer_ID = 9, phone_number = '07777 222 333';


INSERT INTO person SET ID = 10, forename = 'Jon', middle_initials = 'Q', surname = 'Spellbad', date_of_birth = '2007-01-01';

INSERT INTO customer SET personalID = 10, email_address = 'jon@spellbad.com', pwd = SHA2('jon10qqq', 512);


INSERT INTO person SET ID = 11, forename = 'Jonathan', surname = 'Swift', date_of_birth = '1667-11-30';

INSERT INTO contributor SET personalID = 11, biography = "Irish author, clergyman and satirist Jonathan Swift received a bachelor's degree from Trinity College and then worked as a statesman's assistant. Eventually, he became dean of St. Patrick's Cathedral in Dublin.";
