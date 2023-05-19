----- district TABLE -------

DELETE FROM district ;
ALTER TABLE district AUTO_INCREMENT=1;
INSERT INTO district VALUES
	(1,"Barcelona"), (2,"Tarragona"), (3, "Lleida"), (4, "Girona");
        
----- city TABLE ------

DELETE FROM city;
ALTER TABLE city AUTO_INCREMENT=1;
INSERT INTO city VALUES
	(1, "Montgat", 1), (2, "Mataró", 1), (3, "La Roca del Vallès", 1), (4, "Granollers", 1) ;
	
----- category_pizza TABLE ------

DELETE FROM category_pizza;
ALTER TABLE category_pizza AUTO_INCREMENT=1;
INSERT INTO category_pizza VALUES
	(1, "Vegan"), (2, "Promo");
    
----- shop TABLE -----

DELETE FROM shop;
ALTER TABLE shop AUTO_INCREMENT=1;
INSERT INTO shop VALUES
	(1, "Avd Diagonal, 12", 08210, 1, 1), (2, "Carrer Girona, 34", 08350, 4, 1);
    
----- employee TABLE -----

DELETE FROM employee;
ALTER TABLE employee AUTO_INCREMENT=1;
INSERT INTO employee VALUES
	(1, "Juan", "Ruiz", "38849625_M", "657851256", "Cooker", 1, 1, 1);
    
----- client TABLE -----

DELETE FROM client;
ALTER TABLE client AUTO_INCREMENT=1;
INSERT INTO client VALUES
	(1, "Nuria", "Viana", "Avd Solell, 17", 08340, "651256897", 3, 1), 
    (2, "David", "Llull", "Riera de Cirera, 20", 08520, "521458789", 2, 1);
    
----- product TABLE ------

DELETE FROM product;
ALTER TABLE product AUTO_INCREMENT=1;
INSERT INTO product VALUES
	(1, "Pizza Margarita", "P", "Pizza básica", null, 12.5, 2), 
    (2, "Hamburguesa vegana", "H", "Hamburguesa", null, 12.5, 2);
    
----- order TABLE -----

DELETE FROM pedido;
ALTER TABLE pedido AUTO_INCREMENT=1;
INSERT INTO pedido VALUES
	(1, null, "TakeAway", 2, 1, 0, 37.5, 1, 3, 1, 1, 2), 
    (2, null, "DeliverHome", 1, 2, 0, 37.5, 1, 3, 1, 2, 2);
    

