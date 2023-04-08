-- Q1. Who is the senior most employee based on job title?

SELECT *
FROM employee
ORDER BY levels DESC
LIMIT 1;

-- Q2. Which contries have the most invoices?

SELECT billing_country, COUNT(*) AS total_invoice
FROM invoice
GROUP BY billing_country
ORDER BY total_invoice DESC;

-- Q3. What are top 3 values of total invoice?

SELECT total
FROM invoice
ORDER BY total DESC
LIMIT 3;

/* Q4. WHich city has the best customers? We would like to throw a promotional Music festival
    in the city we made the most money. Write a query that returns one city that has the highest
    sum of invoice totals. Return both the city name & sum of all invoice totals? */

SELECT billing_city, sum(total) as invoice_total
FROM invoice
GROUP BY billing_city
ORDER BY invoice_total DESC
LIMIT 1;

/* Q5. Who is the best customer? The customer who has spend the most money will be declared 
    the best customer. Write a query the returns the person who has spend the most money? */

SELECT C.customer_id, first_name, last_name, sum(total) as total_spend
FROM customer C JOIN invoice I
ON C.customer_id = I.customer_id
GROUP BY C.customer_id
ORDER BY total_spend DESC
LIMIT 1;

/* Q6. Write a query to return the email, first name, last name & genre of all 
    Rock Music listeners. Returned your list ordered alphabetically by email
    starting with A. */ 

SELECT DISTINCT email, first_name, last_name
FROM customer
JOIN invoice ON customer.customer_id = invoice.customer_id
JOIN invoice_line ON invoice.invoice_id = invoice_line.invoice_id
WHERE track_id IN (SELECT track_id FROM track
				   JOIN genre ON track.genre_id = genre.genre_id
				   WHERE genre.name LIKE 'Rock'
)
ORDER BY email;

/* Q7. Let's invite the artists who have written the most rock music in our dataset.
    Write a query that returns the Artist name and total track count of the top 10
    rock bands. */
	
SELECT artist.name, COUNT(track.track_id) as number_of_songs
FROM artist
JOIN album ON artist.artist_id = album.artist_id
JOIN track ON album.album_id = track.album_id
JOIN genre ON genre.genre_id = track.genre_id
WHERE genre.name LIKE 'Rock'
GROUP BY artist.name
ORDER BY number_of_songs DESC
LIMIT 10;

/* Q8. Return all the Track names that have a song length longer than the average song length.
    Return the Name and Milliseconds for each track. Order by the song length with
    the longest songs listed first. */
	
SELECT name, milliseconds
FROM track
WHERE milliseconds > (SELECT AVG(milliseconds) AS avg_track_length
					 FROM track) 
					 
show data_directory;
					 
ORDER BY milliseconds DESC;