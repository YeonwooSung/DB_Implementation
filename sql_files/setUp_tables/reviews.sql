-- Insert sample data to review table and purchase table

--review

INSERT INTO audiobook_reviews SET customer_ID =  10, ISBN = "860-1404211171", rating = 2, title = "Not as good as Harry Potter",
comment = "Never read the book, seen the movie or listened to the audio book but I can tell you right now - its not as good as harry potter";

INSERT INTO audiobook_reviews SET customer_ID =  1, ISBN = "860-1404211171", rating = 4, title = "Fantastic Book",
comment = "Loved listening to this book before bed.";

INSERT INTO audiobook_reviews SET customer_ID =  7, ISBN = "978-1408855652", rating = 5, title = "Best audio book EVER!",
comment = "Best audio book I ever listened to. Stephen Fry does an excellent job reading the superb prose written by a genius author.";

-- purchase

INSERT INTO audiobook_purchases SET customer_ID = 3, ISBN = "978-0099457046", purchase_date = "2018-10-23 21:34:02";

INSERT INTO audiobook_purchases SET customer_ID = 7, ISBN = "978-0393957242", purchase_date = "2018-10-23 21:30:34";

INSERT INTO audiobook_purchases SET customer_ID = 5, ISBN = "978-0393957242", purchase_date = "2018-10-23 21:35:54";

INSERT INTO audiobook_purchases SET customer_ID = 4, ISBN = "978-0393957242", purchase_date = "2018-10-23 21:30:10";

INSERT INTO audiobook_purchases SET customer_ID = 7, ISBN = "978-1408855652", purchase_date = "2018-10-23 21:31:08";

INSERT INTO audiobook_purchases SET customer_ID = 3, ISBN = "978-1408855652", purchase_date = "2018-10-23 21:29:48";

INSERT INTO audiobook_purchases SET customer_ID = 9, ISBN = "978-1611749731", purchase_date = "2018-10-23 21:30:47";