CREATE TABLE Products (Product_ID NUMBER PRIMARY KEY, Product_Name VARCHAR2(100), Product_Type VARCHAR2(50), Price NUMBER(10,2));
INSERT INTO Products VALUES (1, 'T-Shirt', 'Apparel', 750);
INSERT INTO Products VALUES (2, 'Laptop', 'Electronics', 65000);
INSERT INTO Products VALUES (3, 'Jacket', 'Apparel', 2300);
INSERT INTO Products VALUES (4, 'Jeans', 'Apparel', 1500);
INSERT INTO Products VALUES (5, 'Laptop', 'Electronics', 50000);

SET SERVEROUTPUT ON;
-- parameterized cursor to display all products in the given price range of price and type ‘Apparel’
DECLARE
  CURSOR c1(p_min NUMBER, p_max NUMBER) IS
    SELECT Product_Name, Price 
    FROM Products
    WHERE Price BETWEEN p_min AND p_max 
      AND Product_Type = 'Apparel';
BEGIN
  -- PL/SQL automatically creates a record variable (r)
  FOR r IN c1(&min_price, &max_price) LOOP
    DBMS_OUTPUT.PUT_LINE('Apparel: ' || r.Product_Name || '  Price: ' || r.Price);
  END LOOP;
END;
/
-- explicit cursor to display information of all products with Price greater than 5000.
DECLARE
  CURSOR c2 IS
    SELECT Product_Name, Product_Type, Price
    FROM Products
    WHERE Price > 5000;
BEGIN
  FOR r IN c2 LOOP
    DBMS_OUTPUT.PUT_LINE('Product: ' || r.Product_Name || ' | Type: ' || r.Product_Type || ' | Price: ' || r.Price);
  END LOOP;
END;
/
-- implicit cursor to display the number of records affected by the update operation incrementing Price of all products by 1000.
BEGIN
  UPDATE Products
  SET Price = Price + 1000;
  -- ROWCOUNT is a cursor attribute that gives the number of rows affected
  DBMS_OUTPUT.PUT_LINE('Rows Updated: ' || SQL%ROWCOUNT);
END;
/