/*Instructions
In this lab we will find the customers who were active in consecutive months of May and June. 
Follow the steps to complete the analysis.
	- Create a table rentals_may to store the data from rental table with information for the month of May.*/
    
SHOW CREATE TABLE rental;
SELECT * FROM rental;

DROP TABLE IF EXISTS rentals_may;
CREATE TABLE `rentals_may` (
   `rental_id` int NOT NULL AUTO_INCREMENT,
   `rental_date` datetime NOT NULL,
   `inventory_id` mediumint unsigned NOT NULL,
   `customer_id` smallint unsigned NOT NULL,
   `return_date` datetime DEFAULT NULL,
   `staff_id` tinyint unsigned NOT NULL,
   `last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
   PRIMARY KEY (`rental_id`),
   UNIQUE KEY `rental_date` (`rental_date`,`inventory_id`,`customer_id`),
   KEY `fk_inventory_id` (`inventory_id`),
   KEY `fk_customer_id` (`customer_id`),
   KEY `fk_staff_id` (`staff_id`),
   CONSTRAINT `fk_rental_may_customer` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
   CONSTRAINT `fk_rental__may_inventory` FOREIGN KEY (`inventory_id`) REFERENCES `inventory` (`inventory_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
   CONSTRAINT `fk_rental_may_staff` FOREIGN KEY (`staff_id`) REFERENCES `staff` (`staff_id`) ON DELETE RESTRICT ON UPDATE CASCADE
 ) ENGINE=InnoDB AUTO_INCREMENT=16053 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
  
 /* Insert values in the table rentals_may using the table rental, filtering values only for the month 
	of May.*/

INSERT INTO rentals_may (rental_id, rental_date, inventory_id, customer_id, return_date, 
staff_id, last_update)
SELECT * FROM rental
WHERE MONTH(rental_date) = 5;

SELECT * FROM rentals_may;
 
 /* Create a table rentals_june to store the data from rental table with information for the month 
    of June*/
 
 DROP TABLE IF EXISTS rentals_june;
CREATE TABLE `rentals_june` (
   `rental_id` int NOT NULL AUTO_INCREMENT,
   `rental_date` datetime NOT NULL,
   `inventory_id` mediumint unsigned NOT NULL,
   `customer_id` smallint unsigned NOT NULL,
   `return_date` datetime DEFAULT NULL,
   `staff_id` tinyint unsigned NOT NULL,
   `last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
   PRIMARY KEY (`rental_id`),
   UNIQUE KEY `rental_date` (`rental_date`,`inventory_id`,`customer_id`),
   KEY `fk_inventory_id` (`inventory_id`),
   KEY `fk_customer_id` (`customer_id`),
   KEY `fk_staff_id` (`staff_id`),
   CONSTRAINT `fk_rental_june_customer` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
   CONSTRAINT `fk_rental__june_inventory` FOREIGN KEY (`inventory_id`) REFERENCES `inventory` (`inventory_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
   CONSTRAINT `fk_rental_june_staff` FOREIGN KEY (`staff_id`) REFERENCES `staff` (`staff_id`) ON DELETE RESTRICT ON UPDATE CASCADE
 ) ENGINE=InnoDB AUTO_INCREMENT=16053 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
 
 /* Insert values in the table rentals_june using the table rental, filtering values only for the month 
 of June.*/
 
INSERT INTO rentals_june (rental_id, rental_date, inventory_id, customer_id, return_date, 
staff_id, last_update)
SELECT * FROM rental
WHERE MONTH(rental_date) = 6;

SELECT * FROM rentals_june;

# Check the number of rentals for each customer for May.
SELECT CONCAT(c.first_name, ' ', c.last_name) AS `customer`, COUNT(r.rental_id) AS number_of_rentals
FROM customer AS c
LEFT JOIN rentals_may AS r
ON c.customer_id = r.customer_id
GROUP BY `customer`
ORDER BY 2 DESC;

# Check the number of rentals for each customer for June.
SELECT CONCAT(c.first_name, ' ', c.last_name) AS `customer`, COUNT(r.rental_id) AS number_of_rentals
FROM customer AS c
LEFT JOIN rentals_june AS r
ON c.customer_id = r.customer_id
GROUP BY `customer`
ORDER BY 2 DESC;






