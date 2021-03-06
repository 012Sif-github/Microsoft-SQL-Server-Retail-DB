-- [ Part 1 ]

set serveroutput on
declaring
cust_name varchar2(50);
b_date date;
description varchar2(100);
veh varchar2(50);
start
select cust.first_name || ', ' || cust.surname, b.bill_date, di.description, v.vehicle_type
into cust_name, b_date, description, veh
from customer cust, billing b, delivery_items di, driver_deliveries dd, vehicle v, staff s
where cust.customer_id = b.customer_id
and s.staff_id = bill.staff_id
and s.staff_id = di.staff_id
and di.delivery_item_id = dd.delivery_item_id
and v.vin_number = dd.vin_number
and b.bill_date = '10 November 2020';
dbms_output.put_line('CUSTOMER: ' || cust_name);
dbms_output.put_line('BILL DATE: ' || b_date);
dbms_output.put_line('DESCRIPTION: ' || description);
dbms_output.put_line('VEHICLE: ' || veh);
end;

-- [ Part 2 ]

CREATE USER Assignment1 IDENTIFIED BY Password1;
GRANT ALL PRIVILEGES TO Assignment1;
COMMIT;

--CREATING TABLES

CREATE TABLE CUSTOMER
(
  CUSTOMER_ID INT NOT NULL ,
  FIRST_NAME VARCHAR2(65) NOT NULL ,
  SURNAME VARCHAR2(65) NOT NULL ,
  ADDRESS VARCHAR2(65) NOT NULL ,
  CONTACT_NUMBER NUMBER NOT NULL ,
  EMAIL VARCHAR2(65) ,
  CONSTRAINT PK_CUSTOMER PRIMARY KEY (CUSTOMER_ID)
);

CREATE TABLE EMPLOYEE
(
  EMPLOYEE_ID VARCHAR2(65) NOT NULL ,
  FIRST_NAME VARCHAR2(65) NOT NULL ,
  SURNAME VARCHAR2(65) NOT NULL ,
  CONTACT_NUMBER NUMBER NOT NULL ,
  POSITION VARCHAR2(65) NOT NULL ,
  ADDRESS VARCHAR2(65) NOT NULL ,
  EMAIL VARCHAR2(65) ,
  CONSTRAINT PK_EMPLOYEE PRIMARY KEY (EMPLOYEE_ID)

);

CREATE TABLE DELIVERY
(
  DELIVERY_ID INT NOT NULL ,
  DESCRIPTION VARCHAR2(120) NOT NULL ,
  DISPATCH_DATE DATE NOT NULL ,
  DELIVERY_DATE DATE NOT NULL ,
  CONSTRAINT PK_DELIVERY PRIMARY KEY (DELIVERY_ID)

);

CREATE TABLE RETURNS
(
  RETURN_ID VARCHAR2(65) NOT NULL ,
  RETURN_DATE DATE NOT NULL ,
  REASON VARCHAR2(120) ,
  CONSTRAINT PK_RETURNS PRIMARY KEY (RETURN_ID)

);

CREATE TABLE PRODUCT
(
  PRODUCT_ID INT NOT NULL ,
  PRODUCT VARCHAR2(120) ,
  PRICE NUMBER(19,4) NOT NULL ,
  QTY INT NOT NULL ,
  CONSTRAINT PK_PRODUCT PRIMARY KEY (PRODUCT_ID)

);

CREATE TABLE BILLING
(
  BILL_ID INT NOT NULL ,
  CUSTOMER_ID INT NOT NULL ,
  BILL_DATE DATE NOT NULL ,
  EMPLOYEE_ID VARCHAR(65) ,
  CONSTRAINT PK_BILLING PRIMARY KEY (BILL_ID) ,
  CONSTRAINT FK_BILLING_EMPLOYEE_ID FOREIGN KEY (EMPLOYEE_ID) REFERENCES EMPLOYEE (EMPLOYEE_ID) ,
  CONSTRAINT FK_BILLING_CUSTOMER_ID  FOREIGN KEY (CUSTOMER_ID) REFERENCES CUSTOMER (CUSTOMER_ID)

);

CREATE TABLE PRODUCT_BILLING
(
  DELIVERY_ID INT NOT NULL ,
  RETURN_ID VARCHAR(65) ,
  PRODUCT_ID INT NOT NULL ,
  BILL_ID INT ,
  CONSTRAINT FK_PRODUCT_BILLING_DELIVERY_ID FOREIGN KEY (DELIVERY_ID) REFERENCES DELIVERY (DELIVERY_ID) ,
  CONSTRAINT FK_PRODUCT_BILLING_RETURN_ID FOREIGN KEY (RETURN_ID) REFERENCES RETURNS (RETURN_ID) ,
  CONSTRAINT FK_PRODUCT_BILLING_PRODUCT_ID FOREIGN KEY (PRODUCT_ID) REFERENCES PRODUCT (PRODUCT_ID) ,
  CONSTRAINT FK_PRODUCT_BILLING_BILL_ID FOREIGN KEY (BILL_ID) REFERENCES BILLING (BILL_ID)

);

-- [ Part 3 ]

--INSERTING VALUES TO TABLES

INSERT ALL
  INTO CUSTOMER VALUES(11011, 'Jeffery', 'Smith', '18 Water rd', 0877277521, 'jef@isat.com')
  INTO CUSTOMER VALUES(11012, 'Alex', 'Hendricks', '22 Water rd', 0863257857, 'ah@mcom.co.zam')
  INTO CUSTOMER VALUES(11013, 'Johnson', 'Clark', '101 Summer lane', 0834567891, 'jclark@mcom.co.za')
  INTO CUSTOMER VALUES(11014, 'Henry', 'Jones', '55 Mountain way', 0612547895, 'hj@isat.co.za')
  INTO CUSTOMER VALUES(11015, 'Andre', 'Williams', '5 Main rd', 0827238521, 'aw@mcal.co.za')
SELECT * FROM DUAL ;
COMMIT;


INSERT ALL
 INTO EMPLOYEE VALUES('emp101', 'Roan', 'Davis', 0877277521, 'sales', '10 main road', 'rd@isat.com')
 INTO EMPLOYEE VALUES('emp102', 'Billy', 'Marks', 0837377522, 'marketing', '18 water road', 'bmark@isat.com')
 INTO EMPLOYEE VALUES('emp103', 'Chadwin', 'Andrews', 0817117523, 'sales', '21 circle lane', 'ca@isat.com')
 INTO EMPLOYEE VALUES('emp104', 'Wayne', 'Dryer', 0797215244, 'sales', '1 sea road', 'dryer@isat.com')
 INTO EMPLOYEE VALUES('emp105', 'Jaci', 'Samson', 0827122255, 'manager', '12 main road', 'samjax@isat.com')
SELECT * FROM DUAL ;
COMMIT;


INSERT ALL
  INTO DELIVERY VALUES(511, 'Delivery contains glass items - fragile', '10 May 2021', '15 May 2021')
  INTO DELIVERY VALUES(512, 'Delivery of wooden items', '12 May 2021', '15 May 2021')
  INTO DELIVERY VALUES(513, 'No description available', '12 May 2021', '17 May 2021')
  INTO DELIVERY VALUES(514, 'Delivery contains glass items - fragile', '12 May 2021', '15 May 2021')
  INTO DELIVERY VALUES(515, 'Delivery contains glass items - fragile', '18 May 2021', '19 May 2021')
  INTO DELIVERY VALUES(516, 'No description available', '20 May 2021', '25 May 2021')
  INTO DELIVERY VALUES(517, 'Delivery of wooden items', '25 May 2021', '27 May 2021')
SELECT * FROM DUAL ;
COMMIT;


INSERT ALL
  INTO RETURNS VALUES('ret001', '25 May 2021', 'Customer not satisfied with product')
  INTO RETURNS VALUES('ret002', '25 May 2021', 'Product missing part')
SELECT * FROM DUAL;
COMMIT;



INSERT ALL
  INTO PRODUCT VALUES(7111, 'Four Piece Wall Unit', 10999.00, 10)
  INTO PRODUCT VALUES(7112, 'Plasma Stand Unit', 7999.00, 8)
  INTO PRODUCT VALUES(7113, 'Leather Recliner', 5999.00, 8)
  INTO PRODUCT VALUES(7114, 'Leather Lazy Boy', 7999, 5)
  INTO PRODUCT VALUES(7115, '6 Piece Fabric Suitet', 17999.00, 15)
  INTO PRODUCT VALUES(7116, '6 Piece Leather Suite', 27999.00, 12)
  INTO PRODUCT VALUES(7117, '6 Seater Oak Dining table', 11999.00, 3)
SELECT * FROM DUAL;
COMMIT;


INSERT ALL
  INTO BILLING VALUES(8111, 11011, '15 May 2021', 'emp103')
  INTO BILLING VALUES(8112, 11013, '15 May 2021', 'emp101')
  INTO BILLING VALUES(8113, 11012, '17 May 2021', 'emp101')
  INTO BILLING VALUES(8114, 11015, '17 May 2021', 'emp102')
  INTO BILLING VALUES(8115, 11011, '17 May 2021', 'emp102')
  INTO BILLING VALUES(8116, 11015, '18 May 2021', 'emp103')
  INTO BILLING VALUES(8117, 11012, '19 May 2021', 'emp101')
  INTO BILLING VALUES(8118, 11013, '19 May 2021', 'emp105')
SELECT * FROM DUAL;
COMMIT;


INSERT ALL
  INTO PRODUCT_BILLING VALUES(512, null, 7113, 8115)
  INTO PRODUCT_BILLING VALUES(511, null, 7111, 8111)
  INTO PRODUCT_BILLING VALUES(512, null, 7111, 8114)
  INTO PRODUCT_BILLING VALUES(514, 'ret001', 7113, 8113)
  INTO PRODUCT_BILLING VALUES(516, null, 7115, 8112)
  INTO PRODUCT_BILLING VALUES(515, 'ret002', 7114, 8113)
  INTO PRODUCT_BILLING VALUES(517, null, 7113, 8115)
  INTO PRODUCT_BILLING VALUES(511, null, 7112, 8118)
  INTO PRODUCT_BILLING VALUES(513, null, 7111, 8117)
  INTO PRODUCT_BILLING VALUES(512, null, 7115, 8116)
SELECT * FROM DUAL;
COMMIT;


-- [ Part 4 ]


SELECT CUS.FIRST_NAME || ' , ' || CUS.SURNAME AS CUSTOMER , E.EMPLOYEE_ID , D.DESCRIPTION , P.PRODUCT , B.BILL_DATE
FROM CUSTOMER CUS INNER JOIN BILLING B
ON CUS.CUSTOMER_ID = B.CUSTOMER_ID JOIN EMPLOYEE E
ON B.EMPLOYEE_ID = E.EMPLOYEE_ID JOIN PRODUCT_BILLING PB
ON B.BILL_ID = PB.BILL_ID JOIN DELIVERY D
ON PB.DELIVERY_ID = D.DELIVERY_ID JOIN PRODUCT P
ON PB.PRODUCT_ID = P.PRODUCT_ID
WHERE B.BILL_DATE = '15 May 2021';


-- [ Part 5 ]

CREATE VIEW VIEW_SV AS
SELECT PRODUCT , PRICE , QTY , ' R ' || (QTY * PRICE) AS STOCK_VALUE
FROM PRODUCT
WHERE (QTY * PRICE) > 100000;
SELECT * FROM VIEW_SV;


-- [ Part 6 ]

SET SERVEROUTPUT ON;
DECLARE
v_Name CUSTOMER.FIRST_NAME%TYPE;
v_Surname CUSTOMER.SURNAME%TYPE;
v_Product PRODUCT.PRODUCT%TYPE;

CURSOR CUSTOMER_PROD IS
SELECT CUS.FIRST_NAME, CUS.SURNAME, P.PRODUCT
FROM CUSTOMER CUS INNER JOIN BILLING B
ON CUS.CUSTOMER_ID = B.CUSTOMER_ID JOIN EMPLOYEE EM
ON B.EMPLOYEE_ID = EM.EMPLOYEE_ID JOIN PRODUCT_BILLING PB
ON B.BILL_ID = PB.BILL_ID JOIN DELIVERY D
ON PB.DELIVERY_ID = D.DELIVERY_ID JOIN PRODUCT P
ON PB.PRODUCT_ID = P.PRODUCT_ID
WHERE P.PRICE > 10000;

BEGIN
OPEN CUSTOMER_PROD;
LOOP
FETCH CUSTOMER_PROD INTO v_Name, v_Surname, v_Product;
EXIT WHEN CUSTOMER_PROD%NOTFOUND;

DBMS_OUTPUT.PUT_LINE('CUSTOMER: '||v_Name|| ' ,' ||v_Surname);
DBMS_OUTPUT.PUT_LINE('PRODUCT: ' ||v_Product);

END LOOP;
CLOSE CUS_PROD;
END;


-- [ Part 7 ]

DECLARE
v_Name CUSTOMER.FIRST_NAME%TYPE;
v_Surname CUSTOMER.SURNAME%TYPE;
v_Product PRODUCT.PRODUCT%TYPE;
v_Reason RETURNS.REASON%TYPE;

CURSOR R_REASON IS
SELECT CUS.FIRST_NAME, CUS.SURNAME, P.PRODUCT, R.REASON
FROM CUSTOMER CUS INNER JOIN BILLING B
ON CUS.CUSTOMER_ID = B.CUSTOMER_ID JOIN EMPLOYEE EM
ON B.EMPLOYEE_ID = EM.EMPLOYEE_ID JOIN PRODUCT_BILLING PB
ON B.BILL_ID = PB.BILL_ID JOIN DELIVERY D
ON PB.DELIVERY_ID = D.DELIVERY_ID JOIN PRODUCT P
ON PB.PRODUCT_ID = P.PRODUCT_ID JOIN RETURNS R
ON PB.RETURN_ID = R.RETURN_ID;

BEGIN
OPEN R_REASON;
LOOP
FETCH R_REASON INTO v_Name, v_Surname, v_Product, v_Reason;
EXIT WHEN R_REASON%NOTFOUND;

DBMS_OUTPUT.PUT_LINE('CUSTOMER: '||v_Name|| ' ,' ||v_Surname);
DBMS_OUTPUT.PUT_LINE('PRODUCT: ' ||v_Product);
DBMS_OUTPUT.PUT_LINE('RETURN REASON: ' ||v_Reason);


END LOOP;
CLOSE R_REASON;
END;


-- [ Part 8 ]

SET SERVEROUTPUT ON;
DECLARE
v_pName PRODUCT.PRODUCT%TYPE;
v_pPrice PRODUCT.PRICE%TYPE;
v_Description DELIVERY.DESCRIPTION%TYPE;
v_Ddays INT;
v_ProductCat VARCHAR(65);

CURSOR PRODRUCT_CAT IS
SELECT P.PRODUCT, P.PRICE, D.DESCRIPTION, CASE WHEN P.PRICE >= 15000 THEN 'PREMIUM'  when P.PRICE < 15000 THEN 'NON PREMIUM' end as PRODUCT_CATEGORY, (D.DELIVERY_DATE - D.DISPATCH_DATE) AS DELIVERY_DAYS
FROM PRODUCT P JOIN PRODUCT_BILLING PB
ON P.PRODUCT_ID = PB.PRODUCT_ID JOIN DELIVERY D
ON PB.DELIVERY_ID = D.DELIVERY_ID
WHERE (D.DELIVERY_DATE - D.DISPATCH_DATE) > 3;

BEGIN
OPEN PRODUCT_CAT;
LOOP
FETCH PRODUCT_CAT INTO v_pName, v_pPrice, v_Description, v_ProductCat, v_Ddays;
EXIT WHEN PRODUCT_CAT%NOTFOUND;

DBMS_OUTPUT.PUT_LINE('PRODUCT: '||v_pName);
DBMS_OUTPUT.PUT_LINE('PRICE: R'||v_pPrice);
DBMS_OUTPUT.PUT_LINE('DESCRIPTION: '||v_Description);
DBMS_OUTPUT.PUT_LINE('DAYS: '||v_Ddays);
DBMS_OUTPUT.PUT_LINE('CATEGORY: '||v_ProductCat);


END LOOP;
CLOSE PRODUCT_CAT;
END;
