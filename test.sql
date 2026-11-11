
----step1 CREATE--------------
CREATE TABLE artists (
    artist_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE song (
    song_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    length INT NOT NULL,
    album_id INT REFERENCES album(album_id) ON DELETE CASCADE --Raderar låten om albumet tas bortc
);

CREATE TABLE album (
    album_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE artist_song (
    artist_id INT REFERENCES artists(artist_id) ON DELETE CASCADE, --Raderar kopplingen om artisten tas bort
    song_id INT REFERENCES song(song_id) ON DELETE CASCADE, --Raderar kopplingen om låten tas bort
    PRIMARY KEY (artist_id, song_id)
);

---step2 INSERT------------------------

--Lägg in artister i artists tabellen
INSERT INTO artists (name) VALUES ('Lady Gaga');
INSERT INTO artists (name) VALUES ('The Weeknd');
INSERT INTO artists (name) VALUES ('Adele');


---Lägg in album i album tabellen
INSERT INTO album (name) VALUES ('Chromatica');
INSERT INTO album (name) VALUES ('After Hours');
INSERT INTO album (name) VALUES ('30');

---Lägg in låtar i song tabellen
INSERT INTO song (name, length, album_id) VALUES ('Rain on Me', 180, 1);
INSERT INTO song (name, length, album_id) VALUES ('Blinding Lights', 200, 2);
INSERT INTO song (name, length, album_id) VALUES ('Easy on Me', 210, 3);

--Lägg in kopplingar mellan artister och låtar i artist_song tabellen
INSERT INTO artist_song (artist_id, song_id) VALUES (1, 1); --Lady Gaga - Rain on Me
INSERT INTO artist_song (artist_id, song_id) VALUES (2, 2); --The Weeknd - Blinding Lights
INSERT INTO artist_song (artist_id, song_id) VALUES (3, 3); --  Adele - Easy on Me

---step3 SELECT------------------------
--Hämta alla artister och deras låtar
SELECT * FROM artists;
SELECT * FROM song WHERE song_id = 1;
SELECT * FROM album;    

--step4 UPDATE------------------------
update artists set name = 'Ariana Grande' where artist_id = 1;
SELECT * FROM artists where artist_id = 1;
update song set name = 'Positions' where song_id = 1;

--step5 DELETE------------------------
DELETE FROM artists WHERE artist_id = 2; --Tar bort The Weeknd och kopplingen i artist_song tabellen    
SELECT * FROM artists;
SELECT * FROM artist_song; --Kopplingen mellan The Weeknd och Blinding Lights är borta
SELECT * FROM song; --Blinding Lights finns fortfarande kvar i song tabellen        

DELETE FROM song WHERE song_id = 4; --Tar bort Easy on Me och kopplingen i artist_song tabellen
SELECT * FROM artist_song;

------- uppgift 2.1 till 2.7 -------------------------
SELECT last_name, first_name from employees;
SELECT home_phone FROM employees WHERE title = 'Vice President, Sales';
SELECT company_name, contact_name, contact_title FROM suppliers WHERE company_name = 'Svensk Sjöföda AB'; 
SELECT last_name, first_name, birth_date FROM employees Order by birth_date DESC;
SELECT customer_id, country, city FROM customers ORDER BY country, city;
SELECT last_name FROM employees WHERE last_name LIKE '%an';
SELECT title, first_name, last_name FROM employees WHERE title LIKE '%Vice%' OR title LIKE '%President%' OR title LIKE '%Manager%';

--- Uppgift 2.8 till 2.11 -------------------------
SELECT product_name, unit_price , unit_price * 1.07 AS price_increase FROM products;
SELECT product_name, unit_price * units_in_stock AS inventory_value FROM products;  
SELECT product_name FROM products WHERE products.units_in_stock < reorder_level;
SELECT product_name, units_in_stock + units_on_order as total_units from products where units_in_stock + units_on_order  < reorder_level;

---- Uppgift 2.12 & 2.13 -------------------------
SELECT category_id from products where product_name = 'Lakkalikööri';
Select category_name from categories where category_id = 1;
-- Går också att skriva på en rad
Select category_name from categories where category_id = (SELECT category_id from products where product_name = 'Lakkalikööri');


select product_name, supplier_id from products where product_name = 'Gravad lax';
select company_name from suppliers where supplier_id = 17;
select company_name, (select product_name from products where product_name = 'Gravad lax') as product_name from suppliers where supplier_id = (select supplier_id from products where product_name = 'Gravad lax');

--- Uppgift 2.15 & 2.16 -------------------------

select count(*) as antal from employees where title = 'Sales Representative';

select sum((unit_price * quantity) * (1 - discount)) as total_sales from order_details where order_id in (select order_id from orders where order_date = '1996-12-12');
-- med join
SELECT SUM((order_details.unit_price * order_details.quantity) * (1 - order_details.discount)) AS total_sales 
FROM order_details
JOIN orders ON order_details.order_id = orders.order_id
WHERE orders.order_date = '1996-12-12';

-- Uppgift 2.19 & 2.20 ---------
select product_name, unit_price from products where category_id = 4;
update products set unit_price = unit_price * 1.2 where category_id = 4;

select supplier_id, company_name from suppliers where company_name = 'Tokyo Traders';
select product_name, unit_price from products where supplier_id = 4;
update products set unit_price = unit_price * 1.1 where supplier_id = (select supplier_id from suppliers where company_name = 'Tokyo Traders');
--med join
SELECT products.product_name, products.unit_price, suppliers.company_name FROM products JOIN suppliers ON products.supplier_id = suppliers.supplier_id WHERE suppliers.company_name = 'Tokyo Traders';

--uppgift 3.1---
CREATE PROCEDURE increase_prices()
LANGUAGE plpgsql
AS $$
BEGIN

    update products set unit_price = unit_price * 1.05;

END;
$$;

select unit_price from products;
call increase_prices();
select unit_price from products;
--- Uppgift 3.3----

create view vinfo
as
select products.product_name, products.unit_price, categories.category_name
from products
join categories on products.category_id = categories.category_id;

select * from vinfo;

--- uppgift 3.5 ----
select product_name, unit_price from products where product_id in(1,2);

BEGIN;
UPDATE products SET unit_price = unit_price * 1.1 WHERE product_id IN (1, 2);
select product_name, unit_price from products where product_id in(1,2);
ROLLBACK;


BEGIN;
UPDATE products SET unit_price = unit_price * 1.1 WHERE product_id IN (1, 2);
UPDATE products SET unit_price = unit_price * 1.1 WHERE hejbaberiba IN (1, 2);
select product_name, unit_price from products where product_id in(1,2);
ROLLBACK;