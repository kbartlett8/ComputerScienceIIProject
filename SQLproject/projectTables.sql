
use kbartlett8;

##Tables and to add inforamtion into the tables to test
DROP TABLE IF EXISTS InvoiceItems;
DROP TABLE IF EXISTS Invoice;
DROP TABLE IF EXISTS RentalItem;
DROP TABLE IF EXISTS LeaseItem;
DROP TABLE IF EXISTS Contract;
DROP TABLE IF EXISTS Materials;
DROP TABLE IF EXISTS Equipment;
DROP TABLE IF EXISTS Items;
DROP TABLE IF EXISTS Company;
DROP TABLE IF EXISTS Person;
DROP TABLE IF EXISTS Address;
DROP TABLE IF EXISTS Emails;


#tables 

CREATE TABLE Address (
    addressId INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    companyId INT,
    street VARCHAR(100),
    city VARCHAR(100),
    state CHAR(10),
    zip CHAR(10)
);

CREATE TABLE Person (
    personId INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    uuid CHAR(36) UNIQUE NOT NULL,
    firstName VARCHAR(50),
    lastName VARCHAR(50),
    email VARCHAR(100),
    phone VARCHAR(15)
);

CREATE TABLE Company (
    companyId INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    uuid CHAR(36) UNIQUE NOT NULL,
    name VARCHAR(100) NOT NULL,
    addressId INT,
    companyContact int,
    FOREIGN KEY (addressId) REFERENCES Address(addressId),
    FOREIGN KEY (companyContact) REFERENCES Person(personId)
);

CREATE TABLE Items (
    itemsId INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    uuid CHAR(36) UNIQUE NOT NULL,
    name VARCHAR(100),
    type CHAR(1),
    fields VARCHAR(255)
);

CREATE TABLE Equipment (
    equipmentId INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    itemsId INT not null,
    modelNumber VARCHAR(100),
    retailPrice DOUBLE,
     FOREIGN KEY (itemsId) REFERENCES Items(itemsId)
);

CREATE TABLE Materials (
    materialsId INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    uuid CHAR(36) UNIQUE NOT NULL,
    unit VARCHAR(100),
      itemsId INT not null,
    cost DOUBLE,
    FOREIGN KEY (itemsId) REFERENCES Items(itemsId)
);
CREATE TABLE Contract (
    contractId INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
      itemsId INT NOT NULL,
    companyId INT NOT NULL,
    uuid CHAR(36) UNIQUE NOT NULL,
    FOREIGN KEY (itemsId) REFERENCES Items(itemsId),
    FOREIGN KEY (companyId) REFERENCES Company(companyId)
);

CREATE TABLE Invoice (
    invoiceId INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    uuid CHAR(36) UNIQUE NOT NULL,
    customerUUID CHAR(36),
    salesPersonUUID CHAR(36),
    date DATE
);

CREATE TABLE InvoiceItems (
    invoiceItemId INT AUTO_INCREMENT PRIMARY KEY,
    invoiceId INT NOT NULL,
    itemsId int NOT NULL,
    FOREIGN KEY (invoiceId) REFERENCES Invoice(invoiceId),
    FOREIGN KEY (itemsId) REFERENCES Items(itemsId)
);

CREATE TABLE LeaseItem (
    leaseItemId INT AUTO_INCREMENT PRIMARY KEY,
    uuid CHAR(36) UNIQUE NOT NULL,
    name VARCHAR(255),
    modelNumber VARCHAR(100),
    equipmentId INT NOT NULL,
    itemsId INT NOT NULL,
    retailPrice DOUBLE,
    startDate DATE,
    endDate DATE,
    markupPercentage DOUBLE,
    FOREIGN KEY (equipmentId) REFERENCES Equipment(equipmentId),
    FOREIGN KEY (itemsId) REFERENCES Items(itemsId)
);

CREATE TABLE RentalItem (
    rentalItemId INT AUTO_INCREMENT PRIMARY KEY,
    uuid CHAR(36) UNIQUE NOT NULL,
    equipmentId INT NOT NULL,
     itemsId INT NOT NULL,
    hours DOUBLE NOT NULL,
    taxRate DOUBLE NOT NULL,
    FOREIGN KEY (equipmentId) REFERENCES Equipment(equipmentId),
    FOREIGN KEY (itemsId) REFERENCES Items(itemsId)
);

CREATE TABLE Emails (
emailId INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
personId int,
email VARCHAR(50) not null,
FOREIGN KEY (personId) REFERENCES Person(personId)
);


#Adding information
-- Insert into Company table
INSERT INTO Company (uuid, name) VALUES
('d7bb9ad9-36e2-46df-851c-494883e2051b', 'Maliwin');

INSERT INTO Company (uuid, name) VALUES
('55e49964-5b1c-45f4-b009-bb75ef0b24a6', 'Altas');

INSERT INTO Company (uuid, name) VALUES
('1feb6f79-e282-4994-88a0-c9cdafe3da51', 'Tediore');

INSERT INTO Company (uuid, name) VALUES
('8881ea2b-4952-4377-9ad1-abd6e473c9d6', 'Jakobs');

INSERT INTO Company (uuid, name) VALUES
('b110cc6e-5fe7-4213-aa2c-cb0687da0a7e', 'Hyperion');

INSERT INTO Company (uuid, name) VALUES
('97da4a8a-020c-4f2a-b531-919ab8ecd965', 'Torgue');

INSERT INTO Company (uuid, name) VALUES
('7eba71a4-e515-41dc-9f45-95e5aad41c42', 'Pangolin');

INSERT INTO Company (uuid, name) VALUES
('c1042a59-ffbd-4a93-943e-29a47b0168cf', 'Vladof');

INSERT INTO Company (uuid, name) VALUES
('975e36bf-2a74-47ff-9563-d0c4e733227f', 'Anshin');

INSERT INTO Company (uuid, name) VALUES
('31bbd133-202f-402a-8b5f-da4cc5004a1b', 'DAHL');

-- Insert into Contract table
INSERT INTO Contract (contractId, uuid) VALUES (1, '5d646b71-6b01-47f6-ba4d-afd274d697da');
INSERT INTO Contract (contractId, uuid) VALUES (2, 'be0681c1-8cc5-4e1a-9458-89e6d67acf6d');
INSERT INTO Contract (contractId, uuid) VALUES (3, '50bf9112-9007-40cb-a7fa-9b5f4a6308b0');
INSERT INTO Contract (contractId, uuid) VALUES (4, 'e428994c-e7b4-4476-81ff-31bd2fd413a0');
INSERT INTO Contract (contractId, uuid) VALUES (5, '594750b0-b311-4f54-b499-ef31662a8d62');
INSERT INTO Contract (contractId, uuid) VALUES (6, '195893a4-4df7-45b2-8515-932c129613fd');
INSERT INTO Contract (contractId, uuid) VALUES (7, '668097b3-6cc5-4035-bf0e-1351c0c5eecb');
INSERT INTO Contract (contractId, uuid) VALUES (8, 'db9d8a9d-6487-43c7-b8a2-60d4ea0a860f');
INSERT INTO Contract (contractId, uuid) VALUES (9, '4400033e-5f2e-478c-9f03-706c60296708');


-- Insert into Address table
INSERT INTO Address (companyId, street, city, state, zip) VALUES
(1, 'Deerfield Drive', 'Los Angeles', 'CA', '60616');

INSERT INTO Address (companyId, street, city, state, zip) VALUES
(2, 'Deerfield Drive', 'Omaha', 'NE', '79176');

INSERT INTO Address (companyId, street, city, state, zip) VALUES
(3, 'Elmwood Avenue', 'Boston', 'MA', '68508');

INSERT INTO Address (companyId, street, city, state, zip) VALUES
(4, 'Church Street', 'Omaha', 'NE', '91131');

INSERT INTO Address (companyId, street, city, state, zip) VALUES
(5, 'Country Club Drive', 'Scottsbluff', 'NE', '98148');

INSERT INTO Address (companyId, street, city, state, zip) VALUES
(6, 'Columbia Street', 'Hastings', 'NE', '79176');

INSERT INTO Address (companyId, street, city, state, zip) VALUES
(7, 'College Street', 'New York', 'NY', '91131');

INSERT INTO Address (companyId, street, city, state, zip) VALUES
(8, 'Essex Court', 'Washington', 'DC', '19136');

INSERT INTO Address (companyId, street, city, state, zip) VALUES
(9, 'Cobblestone Court', 'San Francisco', 'CA', '20566');

INSERT INTO Address (companyId, street, city, state, zip) VALUES
(10, 'Deerfield Drive', 'Grand Island', 'NE', '60616');

-- Insert into Invoice table
INSERT INTO Invoice (uuid, customerUUID, salesPersonUUID, date) VALUES
('24840fb9-a48c-4aad-9b57-3f3c32a412e4', '1feb6f79-e282-4994-88a0-c9cdafe3da51', 'c022a6fb-d1da-47bd-9cdb-4273492363ca', '2025-07-15');

INSERT INTO Invoice (uuid, customerUUID, salesPersonUUID, date) VALUES
('327764ec-0bbd-4920-87f1-aaeb90ae7616', '31bbd133-202f-402a-8b5f-da4cc5004a1b', '72b5ffeb-7cbf-404c-a207-9abfa09fa6f8', '2024-08-05');

INSERT INTO Invoice (uuid, customerUUID, salesPersonUUID, date) VALUES
('4af69a44-02d2-4caa-9665-6b3b5cfc66f5', 'b110cc6e-5fe7-4213-aa2c-cb0687da0a7e', 'aa5905c1-a965-41ef-8f40-46101dd9b193', '2023-05-14');

INSERT INTO Invoice (uuid, customerUUID, salesPersonUUID, date) VALUES
('f5cbe33d-202f-4dce-96a9-f22c33913127', '8881ea2b-4952-4377-9ad1-abd6e473c9d6', '4c7b754f-b568-44cf-a631-a108faa98f28', '2023-12-12');

INSERT INTO Invoice (uuid, customerUUID, salesPersonUUID, date) VALUES
('5e0e536e-fae3-415a-8db2-cb8b6a2afdd5', 'b110cc6e-5fe7-4213-aa2c-cb0687da0a7e', '4400033e-5f2e-478c-9f03-706c60296708', '2023-09-27');

INSERT INTO Invoice (uuid, customerUUID, salesPersonUUID, date) VALUES
('852f7c92-bccd-4cd4-8c9b-cf6830fdc737', '975e36bf-2a74-47ff-9563-d0c4e733227f', '72b5ffeb-7cbf-404c-a207-9abfa09fa6f8', '2025-01-25');

INSERT INTO Invoice (uuid, customerUUID, salesPersonUUID, date) VALUES
('109da0ba-3db7-4cd4-9ec0-bfe1d7ca43b6', '97da4a8a-020c-4f2a-b531-919ab8ecd965', 'aa5905c1-a965-41ef-8f40-46101dd9b193', '2024-08-21');

INSERT INTO Invoice (uuid, customerUUID, salesPersonUUID, date) VALUES
('dfb90d8d-63f0-4b2f-8d41-0a9bfa1114ee', '97da4a8a-020c-4f2a-b531-919ab8ecd965', '417660aa-9b58-4536-88fd-7f6aab63d118', '2023-03-11');

INSERT INTO Invoice (uuid, customerUUID, salesPersonUUID, date) VALUES
('65078f3c-577e-4a07-8017-3b396a809987', 'd7bb9ad9-36e2-46df-851c-494883e2051b', '668097b3-6cc5-4035-bf0e-1351c0c5eecb', '2025-08-09');

INSERT INTO Invoice (uuid, customerUUID, salesPersonUUID, date) VALUES
('1a13a55b-3ef7-4aeb-8ce5-4c1e8f6e7c7a', '1feb6f79-e282-4994-88a0-c9cdafe3da51', 'b27bd32c-92ea-43fd-995f-179b35b37602', '2023-08-26');

INSERT INTO Invoice (uuid, customerUUID, salesPersonUUID, date) VALUES
('fa0afc26-cd34-48ac-bd6d-24361be731a5', '8881ea2b-4952-4377-9ad1-abd6e473c9d6', 'a052c537-cba7-4b42-9dea-3810b0c0258a', '2023-12-28');

INSERT INTO Invoice (uuid, customerUUID, salesPersonUUID, date) VALUES
('2665b6af-6525-4084-a789-0015085f1cdc', 'c1042a59-ffbd-4a93-943e-29a47b0168cf', '7d0e0a85-4e12-462b-8303-6746c067714b', '2023-03-08');

INSERT INTO Invoice (uuid, customerUUID, salesPersonUUID, date) VALUES
('0dfea7f0-babb-426b-8c89-c5b0ee180db3', '55e49964-5b1c-45f4-b009-bb75ef0b24a6', '7d0e0a85-4e12-462b-8303-6746c067714b', '2025-06-15');

INSERT INTO Invoice (uuid, customerUUID, salesPersonUUID, date) VALUES
('f1d7a3d4-d22d-46f1-bf63-c31bd6a41acc', 'b110cc6e-5fe7-4213-aa2c-cb0687da0a7e', 'c022a6fb-d1da-47bd-9cdb-4273492363ca', '2025-12-21');

-- Insert into InvoiceItems table
INSERT INTO InvoiceItems (invoiceId, itemUUID, fieldValue) VALUES
(1, 'f2f9dae8-bf7c-4dd8-8271-1b1dcabd060f', 'R');

INSERT INTO InvoiceItems (invoiceId, itemUUID, fieldValue) VALUES
(1, '6f00288f-8128-448e-b57d-ce7fbc055064', '75');

INSERT INTO InvoiceItems (invoiceId, itemUUID, fieldValue) VALUES
(2, '923d81d0-3a6c-40cc-a9ab-d61844b4be5b', '19');

INSERT INTO InvoiceItems (invoiceId, itemUUID, fieldValue) VALUES
(3, 'ec877930-b85f-405b-8ce6-3e41078f70b2', 'R');

INSERT INTO InvoiceItems (invoiceId, itemUUID, fieldValue) VALUES
(3, '343f5a93-3f88-47d5-8012-028ac3ab7092', '1');

INSERT INTO InvoiceItems (invoiceId, itemUUID, fieldValue) VALUES
(4, '7f159742-8ee4-4f79-a01f-7ae484e15163', '7213');

INSERT INTO InvoiceItems (invoiceId, itemUUID, fieldValue) VALUES
(5, '990fbb23-6b1b-4714-9243-8c8d9302fc03', 'P');

INSERT INTO InvoiceItems (invoiceId, itemUUID, fieldValue) VALUES
(6, 'f384cd73-2c39-41cb-98d4-c9b205a53390', '66');

INSERT INTO InvoiceItems (invoiceId, itemUUID, fieldValue) VALUES
(7, 'a0e82acf-61d1-4e26-9cea-96f14a8555f2', '80');

INSERT INTO InvoiceItems (invoiceId, itemUUID, fieldValue) VALUES
(8, '6f00288f-8128-448e-b57d-ce7fbc055064', '7519');

INSERT INTO InvoiceItems (invoiceId, itemUUID, fieldValue) VALUES
(9, '7f159742-8ee4-4f79-a01f-7ae484e15163', '7213');




-- Insert into Item table
INSERT INTO Items (uuid, type, name, fields) VALUES
('ec877930-b85f-405b-8ce6-3e41078f70b2', 'E', 'Compactor', 'S4325,5662');

INSERT INTO Items (uuid, type, name, fields) VALUES
('78fd5872-9eee-4f40-8583-8efed9d76758', 'E', 'Dump Truck', 'S4325,1611');

INSERT INTO Items (uuid, type, name, fields) VALUES
('f384cd73-2c39-41cb-98d4-c9b205a53390', 'M', 'rubber', 'box,38');

INSERT INTO Items (uuid, type, name, fields) VALUES
('343f5a93-3f88-47d5-8012-028ac3ab7092', 'M', 'plastic', 'barrel,25');

INSERT INTO Items (uuid, type, name, fields) VALUES
('923d81d0-3a6c-40cc-a9ab-d61844b4be5b', 'M', 'plastic', 'crate,32');

INSERT INTO Items (uuid, type, name, fields) VALUES
('6f00288f-8128-448e-b57d-ce7fbc055064', 'C', 'renovation', '8881ea2b-4952-4377-9ad1-abd6e473c9d6');

INSERT INTO Items (uuid, type, name, fields) VALUES
('990fbb23-6b1b-4714-9243-8c8d9302fc03', 'E', 'Bulldozer', 'FLT100,8208');

INSERT INTO Items (uuid, type, name, fields) VALUES
('7f159742-8ee4-4f79-a01f-7ae484e15163', 'C', 'transportation', '975e36bf-2a74-47ff-9563-d0c4e733227f');

INSERT INTO Items (uuid, type, name, fields) VALUES
('a5b584dd-cd31-4227-b4a4-541b0e081bb0', 'E', 'Compactor', 'CMTX-100,1974');

INSERT INTO Items (uuid, type, name, fields) VALUES
('2d8d417c-f713-48df-876c-fcf711158dd5', 'M', 'aluminum', 'barrel,10');

INSERT INTO Items (uuid, type, name, fields) VALUES
('a0e82acf-61d1-4e26-9cea-96f14a8555f2', 'M', 'aluminum', 'crate,53');

INSERT INTO Items (uuid, type, name, fields) VALUES
('80834859-03e1-4787-867d-5f69074bd267', 'M', 'aluminum', 'barrel,40');

INSERT INTO Items (uuid, type, name, fields) VALUES
('5ddbf29d-8bca-43b5-a0cf-cdaa9b30ecab', 'M', 'concrete', 'pallet,9');

INSERT INTO Items (uuid, type, name, fields) VALUES
('0e0c7de1-fe94-445e-a8fe-acf75f3419b8', 'C', 'hauling', '975e36bf-2a74-47ff-9563-d0c4e733227f');

INSERT INTO Items (uuid, type, name, fields) VALUES
('4c0e39bc-9851-4b66-aeb6-34e0215f72f9', 'M', 'steel', 'pallet,74');

INSERT INTO Items (uuid, type, name, fields) VALUES
('f2f9dae8-bf7c-4dd8-8271-1b1dcabd060f', 'E', 'Bulldozer', 'CMTX-100,7945');

INSERT INTO Items (uuid, type, name, fields) VALUES
('64624d7b-a13d-4ca8-85ca-0f02dccd2316', 'E', 'Skid-Steer', 'FLT100,7843');

INSERT INTO Items (uuid, type, name, fields) VALUES
('569500b5-2f6a-4c45-b6ce-40138b7b7d03', 'M', 'glass', 'box,70');

-- Insert into Person table
INSERT INTO Person (uuid, firstName, lastName, phone) VALUES
('aa5905c1-a965-41ef-8f40-46101dd9b193', 'Marceline', 'Mathis', '195-465-1696');

INSERT INTO Person (uuid, firstName, lastName, phone) VALUES
('a052c537-cba7-4b42-9dea-3810b0c0258a', 'Charlotte', 'Nguyen', '469-910-9636');

INSERT INTO Person (uuid, firstName, lastName, phone) VALUES
('4400033e-5f2e-478c-9f03-706c60296708', 'Tree', 'Garcia', '216-164-4670');

INSERT INTO Person (uuid, firstName, lastName, phone) VALUES
('83a4a67b-1567-43d7-a265-8af60e46a0e1', 'Princess', 'Lazuli', '529-658-4016');

INSERT INTO Person (uuid, firstName, lastName, phone) VALUES
('7d0e0a85-4e12-462b-8303-6746c067714b', 'Sofia', 'Pines', '375-688-3988');

INSERT INTO Person (uuid, firstName, lastName, phone) VALUES
('668097b3-6cc5-4035-bf0e-1351c0c5eecb', 'Lauren', 'Acosta', '443-539-1503');

INSERT INTO Person (uuid, firstName, lastName, phone) VALUES
('db9d8a9d-6487-43c7-b8a2-60d4ea0a860f', 'Mia', 'Wilhelm', '284-264-3641');

INSERT INTO Person (uuid, firstName, lastName, phone) VALUES
('195893a4-4df7-45b2-8515-932c129613fd', 'Ice', 'Wright', '962-300-3965');

INSERT INTO Person (uuid, firstName, lastName, phone) VALUES
('be0681c1-8cc5-4e1a-9458-89e6d67acf6d', 'Tingwong', 'Gipeeti', '117-643-1721');

INSERT INTO Person (uuid, firstName, lastName, phone) VALUES
('4c7b754f-b568-44cf-a631-a108faa98f28', 'Bety', 'Ramirez', '177-423-8980');

INSERT INTO Person (uuid, firstName, lastName, phone) VALUES
('5d646b71-6b01-47f6-ba4d-afd274d697da', 'Alex', 'Fahrlander', '942-700-4035');

INSERT INTO Person (uuid, firstName, lastName, phone) VALUES
('e6fce9e6-ee4e-4503-b721-d4fc037d0552', 'Isabella', 'White', '939-708-8789');

INSERT INTO Person (uuid, firstName, lastName, phone) VALUES
('594750b0-b311-4f54-b499-ef31662a8d62', 'Christopher', 'Mertens', '827-811-4368');

INSERT INTO Person (uuid, firstName, lastName, phone) VALUES
('72b5ffeb-7cbf-404c-a207-9abfa09fa6f8', 'Tree', 'Musk', '448-731-9428');

INSERT INTO Person (uuid, firstName, lastName, phone) VALUES
('c022a6fb-d1da-47bd-9cdb-4273492363ca', 'Manuel', 'DeAmbrose', '129-107-1621');

INSERT INTO Person (uuid, firstName, lastName, phone) VALUES
('50bf9112-9007-40cb-a7fa-9b5f4a6308b0', 'Diego', 'Stevens', '751-832-6219');

INSERT INTO Person (uuid, firstName, lastName, phone) VALUES
('417660aa-9b58-4536-88fd-7f6aab63d118', 'Princess', 'Fahrlander', '999-203-8809');

INSERT INTO Person (uuid, firstName, lastName, phone) VALUES
('43c9697c-b494-4420-87ab-6b07b70ea1fe', 'Bety', 'Rodriguez', '963-416-1413');

INSERT INTO Person (uuid, firstName, lastName, phone) VALUES
('e428994c-e7b4-4476-81ff-31bd2fd413a0', 'Simon', 'Smith', '675-812-7886');

INSERT INTO Person (uuid, firstName, lastName, phone) VALUES
('b27bd32c-92ea-43fd-995f-179b35b37602', 'Manuel', 'Gipeeti', '297-830-8796');



INSERT IGNORE INTO Emails (personId, email) 
SELECT personId, 'mmathis@unmc.edu' FROM Person WHERE uuid = 'aa5905c1-a965-41ef-8f40-46101dd9b193';

INSERT IGNORE INTO Emails (personId, email) 
SELECT personId, 'charlotte.nguyen@unomaha.edu' FROM Person WHERE uuid = 'a052c537-cba7-4b42-9dea-3810b0c0258a';
INSERT IGNORE INTO Emails (personId, email) 
SELECT personId, 'cnguyen@unomaha.edu' FROM Person WHERE uuid = 'a052c537-cba7-4b42-9dea-3810b0c0258a';
INSERT IGNORE INTO Emails (personId, email) 
SELECT personId, 'charlotte.nguyen@ne.gov' FROM Person WHERE uuid = 'a052c537-cba7-4b42-9dea-3810b0c0258a';

INSERT IGNORE INTO Emails (personId, email) 
SELECT personId, 'tree.garcia@unl.edu' FROM Person WHERE uuid = '4400033e-5f2e-478c-9f03-706c60296708';

INSERT IGNORE INTO Emails (personId, email) 
SELECT personId, 'plazuli@unomaha.edu' FROM Person WHERE uuid = '83a4a67b-1567-43d7-a265-8af60e46a0e1';
INSERT IGNORE INTO Emails (personId, email) 
SELECT personId, 'plazuli@nebraska.edu' FROM Person WHERE uuid = '83a4a67b-1567-43d7-a265-8af60e46a0e1';

INSERT IGNORE INTO Emails (personId, email) 
SELECT personId, 'sofia.pines@gmail.com' FROM Person WHERE uuid = '7d0e0a85-4e12-462b-8303-6746c067714b';
INSERT IGNORE INTO Emails (personId, email) 
SELECT personId, 'spines@yahoo.com' FROM Person WHERE uuid = '7d0e0a85-4e12-462b-8303-6746c067714b';

INSERT IGNORE INTO Emails (personId, email) 
SELECT personId, 'lacosta@ne.gov' FROM Person WHERE uuid = '668097b3-6cc5-4035-bf0e-1351c0c5eecb';

INSERT IGNORE INTO Emails (personId, email) 
SELECT personId, 'mia.wilhelm@unl.edu' FROM Person WHERE uuid = 'db9d8a9d-6487-43c7-b8a2-60d4ea0a860f';

INSERT IGNORE INTO Emails (personId, email) 
SELECT personId, 'iwright@protonmail.com' FROM Person WHERE uuid = '195893a4-4df7-45b2-8515-932c129613fd';
INSERT IGNORE INTO Emails (personId, email) 
SELECT personId, 'iwright@cia.gov' FROM Person WHERE uuid = '195893a4-4df7-45b2-8515-932c129613fd';

INSERT IGNORE INTO Emails (personId, email) 
SELECT personId, 'tingwong.gipeeti@outlook.com' FROM Person WHERE uuid = 'be0681c1-8cc5-4e1a-9458-89e6d67acf6d';

INSERT IGNORE INTO Emails (personId, email) 
SELECT personId, 'bramirez@unl.edu' FROM Person WHERE uuid = '4c7b754f-b568-44cf-a631-a108faa98f28';
INSERT IGNORE INTO Emails (personId, email) 
SELECT personId, 'bety.ramirez@unomaha.edu' FROM Person WHERE uuid = '4c7b754f-b568-44cf-a631-a108faa98f28';

INSERT IGNORE INTO Emails (personId, email) 
SELECT personId, 'afahrlander@protonmail.com' FROM Person WHERE uuid = '5d646b71-6b01-47f6-ba4d-afd274d697da';
INSERT IGNORE INTO Emails (personId, email) 
SELECT personId, 'afahrlander@cia.gov' FROM Person WHERE uuid = '5d646b71-6b01-47f6-ba4d-afd274d697da';

INSERT IGNORE INTO Emails (personId, email) 
SELECT personId, 'iwhite@yahoo.com' FROM Person WHERE uuid = 'e6fce9e6-ee4e-4503-b721-d4fc037d0552';
INSERT IGNORE INTO Emails (personId, email) 
SELECT personId, 'isabella.white@outlook.com' FROM Person WHERE uuid = 'e6fce9e6-ee4e-4503-b721-d4fc037d0552';

INSERT IGNORE INTO Emails (personId, email) 
SELECT personId, 'christopher.mertens@unmc.edu' FROM Person WHERE uuid = '594750b0-b311-4f54-b499-ef31662a8d62';

INSERT IGNORE INTO Emails (personId, email) 
SELECT personId, 'tmusk@unl.edu' FROM Person WHERE uuid = '72b5ffeb-7cbf-404c-a207-9abfa09fa6f8';
INSERT IGNORE INTO Emails (personId, email) 
SELECT personId, 'tmusk@protonmail.com' FROM Person WHERE uuid = '72b5ffeb-7cbf-404c-a207-9abfa09fa6f8';
INSERT IGNORE INTO Emails (personId, email) 
SELECT personId, 'tree.musk@unomaha.edu' FROM Person WHERE uuid = '72b5ffeb-7cbf-404c-a207-9abfa09fa6f8';

INSERT IGNORE INTO Emails (personId, email) 
SELECT personId, 'mdeambrose@unomaha.edu' FROM Person WHERE uuid = 'c022a6fb-d1da-47bd-9cdb-4273492363ca';
INSERT IGNORE INTO Emails (personId, email) 
SELECT personId, 'manuel.deambrose@outlook.com' FROM Person WHERE uuid = 'c022a6fb-d1da-47bd-9cdb-4273492363ca';

INSERT IGNORE INTO Emails (personId, email) 
SELECT personId, 'dstevens@protonmail.com' FROM Person WHERE uuid = '50bf9112-9007-40cb-a7fa-9b5f4a6308b0';

INSERT IGNORE INTO Emails (personId, email) 
SELECT personId, 'princess.fahrlander@unomaha.edu' FROM Person WHERE uuid = '417660aa-9b58-4536-88fd-7f6aab63d118';
INSERT IGNORE INTO Emails (personId, email) 
SELECT personId, 'pfahrlander@yahoo.com' FROM Person WHERE uuid = '417660aa-9b58-4536-88fd-7f6aab63d118';

INSERT IGNORE INTO Emails (personId, email) 
SELECT personId, 'brodriguez@nebraska.edu' FROM Person WHERE uuid = '43c9697c-b494-4420-87ab-6b07b70ea1fe';
INSERT IGNORE INTO Emails (personId, email) 
SELECT personId, 'bety.rodriguez@yahoo.com' FROM Person WHERE uuid = '43c9697c-b494-4420-87ab-6b07b70ea1fe';

INSERT IGNORE INTO Emails (personId, email) 
SELECT personId, 'ssmith@cia.gov' FROM Person WHERE uuid = 'e428994c-e7b4-4476-81ff-31bd2fd413a0';

INSERT IGNORE INTO Emails (personId, email) 
SELECT personId, 'manuel.gipeeti@nebraska.edu' FROM Person WHERE uuid = 'b27bd32c-92ea-43fd-995f-179b35b37602';
INSERT IGNORE INTO Emails (personId, email) 
SELECT personId, 'mgipeeti@yahoo.com' FROM Person WHERE uuid = 'b27bd32c-92ea-43fd-995f-179b35b37602';

