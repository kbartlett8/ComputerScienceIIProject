-- Database
-- Authors: Emma Rhode and Kayla Bartlett
 
DROP TABLE IF EXISTS InvoiceItem;
DROP TABLE IF EXISTS Invoice;
DROP TABLE IF EXISTS Item;
DROP TABLE IF EXISTS Company;
DROP TABLE IF EXISTS Email;
DROP TABLE IF EXISTS Person;
DROP TABLE IF EXISTS Address;
DROP TABLE IF EXISTS Zip;
DROP TABLE IF EXISTS State;
 
CREATE TABLE Person (
    personId INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    uuid varchar(100) UNIQUE NOT NULL,
    firstName varchar(100) not null,
    lastName varchar(100) not null,
    phone varchar (100) not null
);
 
CREATE TABLE Email (
    emailId INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    personId int, 
    email varchar(100) not null,
    foreign key (personId) references Person(personId)
);
 
CREATE TABLE State (
    stateId INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    stateName CHAR(2) UNIQUE NOT NULL
);
 
CREATE TABLE Zip (
    zipId INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    zipCode CHAR(10) UNIQUE NOT NULL,
    stateId INT NOT NULL,
    city VARCHAR(100) NOT NULL,
    FOREIGN KEY (stateId) REFERENCES State(stateId)
);
 
CREATE TABLE Address (
    addressId INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    street VARCHAR(100) NOT NULL,
    zipId INT NOT NULL,
    FOREIGN KEY (zipId) REFERENCES Zip(zipId)
);
 
CREATE TABLE Company (
    companyId INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    uuid CHAR(36) UNIQUE NOT NULL,
    name VARCHAR(100) NOT NULL,
    contactId int, 
    addressId INT NOT NULL,
     FOREIGN KEY (contactId) REFERENCES Person(personId),
    FOREIGN KEY (addressId) REFERENCES Address(addressId)
);
 
CREATE TABLE Item (
    itemId INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    uuid CHAR(36) UNIQUE NOT NULL,
    name VARCHAR(100) NOT NULL,
    type varchar(100) not null, 
    price double not null default 0,
    materialUnit varchar (100),
    equipmentModelNumber varchar(50),
    contractCompanyId int,
    FOREIGN KEY (contractCompanyId) REFERENCES Company(CompanyId),
    constraint `onlyMaterialOrEquipmentOrContract` check (type = 'M' or type = 'E' or type = 'C')
);
 
CREATE TABLE Invoice (
    invoiceId INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    uuid CHAR(36) UNIQUE NOT NULL,
    customerId INT NOT NULL, 
    salesPersonId INT, 
    date DATE NOT NULL,
    FOREIGN KEY (customerId) REFERENCES Company(companyId),  -- Correct reference to Company(companyId)
    FOREIGN KEY (salesPersonId) REFERENCES Person(personId)  -- Correct reference to Person(personId)
);
 
CREATE TABLE InvoiceItem (
    invoiceItemId INT AUTO_INCREMENT PRIMARY KEY,
    invoiceId INT,
    itemId INT NOT NULL,
    type varchar (100) not null,
    leaseStartDate varchar(10),
    leaseEndDate varchar(10),
    rentalHours int, 
    materialQuantity int,
     constraint `onlyRPMC` check (type = 'L' or type = 'R' or type = 'P'or type = 'M' or type = 'C'),
    FOREIGN KEY (invoiceId) REFERENCES Invoice(invoiceId),
    FOREIGN KEY (itemId) REFERENCES Item(itemId)
);
 
INSERT INTO Person (uuid, firstName, lastName, phone) VALUES
('aa5905c1-a965-41ef-8f40-46101dd9b193', 'Marceline', 'Mathis', '195-465-1696'),
('a052c537-cba7-4b42-9dea-3810b0c0258a', 'Charlotte', 'Nguyen', '469-910-9636'),
('4400033e-5f2e-478c-9f03-706c60296708', 'Tree', 'Garcia', '216-164-4670'),
('83a4a67b-1567-43d7-a265-8af60e46a0e1', 'Princess', 'Lazuli', '529-658-4016'),
('7d0e0a85-4e12-462b-8303-6746c067714b', 'Sofia', 'Pines', '375-688-3988'),
('668097b3-6cc5-4035-bf0e-1351c0c5eecb', 'Lauren', 'Acosta', '443-539-1503'),
('db9d8a9d-6487-43c7-b8a2-60d4ea0a860f', 'Mia', 'Wilhelm', '284-264-3641'),
('195893a4-4df7-45b2-8515-932c129613fd', 'Ice', 'Wright', '962-300-3965'),
('be0681c1-8cc5-4e1a-9458-89e6d67acf6d', 'Tingwong', 'Gipeeti', '117-643-1721'),
('4c7b754f-b568-44cf-a631-a108faa98f28', 'Bety', 'Ramirez', '177-423-8980'),
('5d646b71-6b01-47f6-ba4d-afd274d697da', 'Alex', 'Fahrlander', '942-700-4035'),
('e6fce9e6-ee4e-4503-b721-d4fc037d0552', 'Isabella', 'White', '939-708-8789'),
('594750b0-b311-4f54-b499-ef31662a8d62', 'Christopher', 'Mertens', '827-811-4368'),
('72b5ffeb-7cbf-404c-a207-9abfa09fa6f8', 'Tree', 'Musk', '448-731-9428'),
('c022a6fb-d1da-47bd-9cdb-4273492363ca', 'Manuel', 'DeAmbrose', '129-107-1621'),
('50bf9112-9007-40cb-a7fa-9b5f4a6308b0', 'Diego', 'Stevens', '751-832-6219'),
('417660aa-9b58-4536-88fd-7f6aab63d118', 'Princess', 'Fahrlander', '999-203-8809'),
('43c9697c-b494-4420-87ab-6b07b70ea1fe', 'Bety', 'Rodriguez', '963-416-1413'),
('e428994c-e7b4-4476-81ff-31bd2fd413a0', 'Simon', 'Smith', '675-812-7886'),
('b27bd32c-92ea-43fd-995f-179b35b37602', 'Manuel', 'Gipeeti', '297-830-8796');
 
INSERT INTO Email (personId, email) VALUES
((SELECT personId FROM Person WHERE uuid = 'aa5905c1-a965-41ef-8f40-46101dd9b193'), 'mmathis@unmc.edu'),
((SELECT personId FROM Person WHERE uuid = 'a052c537-cba7-4b42-9dea-3810b0c0258a'), 'charlotte.nguyen@unomaha.edu'),
((SELECT personId FROM Person WHERE uuid = 'a052c537-cba7-4b42-9dea-3810b0c0258a'), 'cnguyen@unomaha.edu'),
((SELECT personId FROM Person WHERE uuid = 'a052c537-cba7-4b42-9dea-3810b0c0258a'), 'charlotte.nguyen@ne.gov'),
((SELECT personId FROM Person WHERE uuid = '4400033e-5f2e-478c-9f03-706c60296708'), 'tree.garcia@unl.edu'),
((SELECT personId FROM Person WHERE uuid = '83a4a67b-1567-43d7-a265-8af60e46a0e1'), 'plazuli@unomaha.edu'),
((SELECT personId FROM Person WHERE uuid = '83a4a67b-1567-43d7-a265-8af60e46a0e1'), 'plazuli@nebraska.edu'),
((SELECT personId FROM Person WHERE uuid = '7d0e0a85-4e12-462b-8303-6746c067714b'), 'sofia.pines@gmail.com'),
((SELECT personId FROM Person WHERE uuid = '7d0e0a85-4e12-462b-8303-6746c067714b'), 'spines@yahoo.com'),
((SELECT personId FROM Person WHERE uuid = '668097b3-6cc5-4035-bf0e-1351c0c5eecb'), 'lacosta@ne.gov'),
((SELECT personId FROM Person WHERE uuid = 'db9d8a9d-6487-43c7-b8a2-60d4ea0a860f'), 'mia.wilhelm@unl.edu'),
((SELECT personId FROM Person WHERE uuid = '195893a4-4df7-45b2-8515-932c129613fd'), 'iwright@protonmail.com'),
((SELECT personId FROM Person WHERE uuid = '195893a4-4df7-45b2-8515-932c129613fd'), 'iwright@cia.gov'),
((SELECT personId FROM Person WHERE uuid = 'be0681c1-8cc5-4e1a-9458-89e6d67acf6d'), 'tingwong.gipeeti@outlook.com'),
((SELECT personId FROM Person WHERE uuid = '4c7b754f-b568-44cf-a631-a108faa98f28'), 'bramirez@unl.edu'),
((SELECT personId FROM Person WHERE uuid = '4c7b754f-b568-44cf-a631-a108faa98f28'), 'bety.ramirez@unomaha.edu'),
((SELECT personId FROM Person WHERE uuid = '5d646b71-6b01-47f6-ba4d-afd274d697da'), 'afahrlander@protonmail.com'),
((SELECT personId FROM Person WHERE uuid = '5d646b71-6b01-47f6-ba4d-afd274d697da'), 'afahrlander@cia.gov'),
((SELECT personId FROM Person WHERE uuid = 'e6fce9e6-ee4e-4503-b721-d4fc037d0552'), 'iwhite@yahoo.com'),
((SELECT personId FROM Person WHERE uuid = 'e6fce9e6-ee4e-4503-b721-d4fc037d0552'), 'isabella.white@outlook.com'),
((SELECT personId FROM Person WHERE uuid = '594750b0-b311-4f54-b499-ef31662a8d62'), 'christopher.mertens@unmc.edu'),
((SELECT personId FROM Person WHERE uuid = '72b5ffeb-7cbf-404c-a207-9abfa09fa6f8'), 'tmusk@unl.edu'),
((SELECT personId FROM Person WHERE uuid = '72b5ffeb-7cbf-404c-a207-9abfa09fa6f8'), 'tmusk@protonmail.com'),
((SELECT personId FROM Person WHERE uuid = '72b5ffeb-7cbf-404c-a207-9abfa09fa6f8'), 'tree.musk@unomaha.edu'),
((SELECT personId FROM Person WHERE uuid = 'c022a6fb-d1da-47bd-9cdb-4273492363ca'), 'mdeambrose@unomaha.edu'),
((SELECT personId FROM Person WHERE uuid = 'c022a6fb-d1da-47bd-9cdb-4273492363ca'), 'manuel.deambrose@outlook.com'),
((SELECT personId FROM Person WHERE uuid = '50bf9112-9007-40cb-a7fa-9b5f4a6308b0'), 'dstevens@protonmail.com');
 
INSERT INTO State (stateName) VALUES 
('CA'), 
('NE'), 
('MA'), 
('NY'), 
('DC');
 
INSERT  INTO Zip (zipCode, city, stateId) VALUES 
('60916', 'Los Angeles', (SELECT stateId FROM State WHERE stateName = 'CA')),
('79196', 'Omaha', (SELECT stateId FROM State WHERE stateName = 'NE')),
('68508', 'Boston', (SELECT stateId FROM State WHERE stateName = 'MA')),
('91141', 'Omaha', (SELECT stateId FROM State WHERE stateName = 'NE')),
('98148', 'Scottsbluff', (SELECT stateId FROM State WHERE stateName = 'NE')),
('79176', 'Hastings', (SELECT stateId FROM State WHERE stateName = 'NE')),
('91131', 'New York', (SELECT stateId FROM State WHERE stateName = 'NY')),
('19136', 'Washington', (SELECT stateId FROM State WHERE stateName = 'DC')),
('20566', 'San Francisco', (SELECT stateId FROM State WHERE stateName = 'CA')),
('60616', 'Grand Island', (SELECT stateId FROM State WHERE stateName = 'NE'));
 
INSERT  INTO Address (street, zipId) VALUES
('Deerfield Drive', (SELECT zipId FROM Zip WHERE zipCode = '60916' AND city = 'Los Angeles')),
('Deerfield Drive', (SELECT zipId FROM Zip WHERE zipCode = '79196' AND city = 'Omaha')),
('Elmwood Avenue', (SELECT zipId FROM Zip WHERE zipCode = '68508' AND city = 'Boston')),
('Church Street', (SELECT zipId FROM Zip WHERE zipCode = '91141' AND city = 'Omaha')),
('Country Club Drive', (SELECT zipId FROM Zip WHERE zipCode = '98148' AND city = 'Scottsbluff')),
('Columbia Street', (SELECT zipId FROM Zip WHERE zipCode = '79176' AND city = 'Hastings')),
('College Street', (SELECT zipId FROM Zip WHERE zipCode = '91131' AND city = 'New York')),
('Essex Court', (SELECT zipId FROM Zip WHERE zipCode = '19136' AND city = 'Washington')),
('Cobblestone Court', (SELECT zipId FROM Zip WHERE zipCode = '20566' AND city = 'San Francisco')),
('Deerfield Drive', (SELECT zipId FROM Zip WHERE zipCode = '60616' AND city = 'Grand Island'));
 
INSERT IGNORE INTO Company (uuid, name, contactId, addressId)
SELECT 'd7bb9ad9-36e2-46df-851c-494883e2051b', 'Maliwin', 
       (SELECT personId FROM Person WHERE uuid = '5d646b71-6b01-47f6-ba4d-afd274d697da'),
       a.addressId
FROM Address a
JOIN Zip z ON a.zipId = z.zipId
WHERE a.street = 'Deerfield Drive' AND z.city = 'Los Angeles';
 
INSERT IGNORE INTO Company (uuid, name, contactId, addressId)
SELECT '55e49964-5b1c-45f4-b009-bb75ef0b24a6', 'Altas', 
       (SELECT personId FROM Person WHERE uuid = 'be0681c1-8cc5-4e1a-9458-89e6d67acf6d'),
       a.addressId
FROM Address a
JOIN Zip z ON a.zipId = z.zipId
WHERE a.street = 'Deerfield Drive' AND z.city = 'Omaha';
 
INSERT IGNORE INTO Company (uuid, name, contactId, addressId)
SELECT '1feb6f79-e282-4994-88a0-c9cdafe3da51', 'Tediore', 
       (SELECT personId FROM Person WHERE uuid = '50bf9112-9007-40cb-a7fa-9b5f4a6308b0'),
       a.addressId
FROM Address a
JOIN Zip z ON a.zipId = z.zipId
WHERE a.street = 'Elmwood Avenue' AND z.city = 'Boston';
 
INSERT IGNORE INTO Company (uuid, name, contactId, addressId)
SELECT '8881ea2b-4952-4377-9ad1-abd6e473c9d6', 'Jakobs', 
       (SELECT personId FROM Person WHERE uuid = 'e428994c-e7b4-4476-81ff-31bd2fd413a0'),
       a.addressId
FROM Address a
JOIN Zip z ON a.zipId = z.zipId
WHERE a.street = 'Church Street' AND z.city = 'Omaha';
 
INSERT IGNORE INTO Company (uuid, name, contactId, addressId)
SELECT 'b110cc6e-5fe7-4213-aa2c-cb0687da0a7e', 'Hyperion', 
       (SELECT personId FROM Person WHERE uuid = 'e428994c-e7b4-4476-81ff-31bd2fd413a0'),
       a.addressId
FROM Address a
JOIN Zip z ON a.zipId = z.zipId
WHERE a.street = 'Country Club Drive' AND z.city = 'Scottsbluff';
 
INSERT IGNORE INTO Company (uuid, name, contactId, addressId)
SELECT '97da4a8a-020c-4f2a-b531-919ab8ecd965', 'Torgue', 
       (SELECT personId FROM Person WHERE uuid = '594750b0-b311-4f54-b499-ef31662a8d62'),
       a.addressId
FROM Address a
JOIN Zip z ON a.zipId = z.zipId
WHERE a.street = 'Columbia Street' AND z.city = 'Hastings';
 
INSERT IGNORE INTO Company (uuid, name, contactId, addressId)
SELECT '7eba71a4-e515-41dc-9f45-95e5aad41c42', 'Pangolin', 
       (SELECT personId FROM Person WHERE uuid = '195893a4-4df7-45b2-8515-932c129613fd'),
       a.addressId
FROM Address a
JOIN Zip z ON a.zipId = z.zipId
WHERE a.street = 'College Street' AND z.city = 'New York';
 
INSERT IGNORE INTO Company (uuid, name, contactId, addressId)
SELECT 'c1042a59-ffbd-4a93-943e-29a47b0168cf', 'Vladof', 
       (SELECT personId FROM Person WHERE uuid = '668097b3-6cc5-4035-bf0e-1351c0c5eecb'),
       a.addressId
FROM Address a
JOIN Zip z ON a.zipId = z.zipId
WHERE a.street = 'Essex Court' AND z.city = 'Washington';
 
INSERT IGNORE INTO Company (uuid, name, contactId, addressId)
SELECT '975e36bf-2a74-47ff-9563-d0c4e733227f', 'Anshin', 
       (SELECT personId FROM Person WHERE uuid = 'db9d8a9d-6487-43c7-b8a2-60d4ea0a860f'),
       a.addressId
FROM Address a
JOIN Zip z ON a.zipId = z.zipId
WHERE a.street = 'Cobblestone Court' AND z.city = 'San Francisco';
 
INSERT IGNORE INTO Company (uuid, name, contactId, addressId)
SELECT '31bbd133-202f-402a-8b5f-da4cc5004a1b', 'DAHL', 
       (SELECT personId FROM Person WHERE uuid = '4400033e-5f2e-478c-9f03-706c60296708'),
       a.addressId
FROM Address a
JOIN Zip z ON a.zipId = z.zipId
WHERE a.street = 'Deerfield Drive' AND z.city = 'Grand Island';
 
INSERT IGNORE INTO Invoice (uuid, customerId, salesPersonId, date)
SELECT '24840fb9-a48c-4aad-9b57-3f3c32a412e4', 
    (SELECT companyId FROM Company WHERE uuid = '1feb6f79-e282-4994-88a0-c9cdafe3da51'), 
    (SELECT personId FROM Person WHERE uuid = 'c022a6fb-d1da-47bd-9cdb-4273492363ca'), 
    '2025-07-15';
 
INSERT IGNORE INTO Invoice (uuid, customerId, salesPersonId, date)
SELECT '327764ec-0bbd-4920-87f1-aaeb90ae7616', 
    (SELECT companyId FROM Company WHERE uuid = '31bbd133-202f-402a-8b5f-da4cc5004a1b'), 
    (SELECT personId FROM Person WHERE uuid = '72b5ffeb-7cbf-404c-a207-9abfa09fa6f8'), 
    '2024-08-05';
 
INSERT  INTO Invoice (uuid, customerId, salesPersonId, date)
SELECT '4af69a44-02d2-4caa-9665-6b3b5cfc66f5', 
    (SELECT companyId FROM Company WHERE uuid = 'b110cc6e-5fe7-4213-aa2c-cb0687da0a7e'), 
    (SELECT personId FROM Person WHERE uuid = 'aa5905c1-a965-41ef-8f40-46101dd9b193'), 
    '2023-05-14';
 
INSERT IGNORE INTO Invoice (uuid, customerId, salesPersonId, date)
SELECT 'f5cbe33d-202f-4dce-96a9-f22c33913127', 
    (SELECT companyId FROM Company WHERE uuid = '8881ea2b-4952-4377-9ad1-abd6e473c9d6'), 
    (SELECT personId FROM Person WHERE uuid = '4c7b754f-b568-44cf-a631-a108faa98f28'), 
    '2023-12-12';
 
INSERT IGNORE INTO Invoice (uuid, customerId, salesPersonId, date)
SELECT '5e0e536e-fae3-415a-8db2-cb8b6a2afdd5', 
    (SELECT companyId FROM Company WHERE uuid = 'b110cc6e-5fe7-4213-aa2c-cb0687da0a7e'), 
    (SELECT personId FROM Person WHERE uuid = '4400033e-5f2e-478c-9f03-706c60296708'), 
    '2023-09-27';
 
INSERT IGNORE INTO Invoice (uuid, customerId, salesPersonId, date)
SELECT '852f7c92-bccd-4cd4-8c9b-cf6830fdc737', 
    (SELECT companyId FROM Company WHERE uuid = '975e36bf-2a74-47ff-9563-d0c4e733227f'), 
    (SELECT personId FROM Person WHERE uuid = '72b5ffeb-7cbf-404c-a207-9abfa09fa6f8'), 
    '2025-01-25';
 
INSERT IGNORE INTO Invoice (uuid, customerId, salesPersonId, date)
SELECT '109da0ba-3db7-4cd4-9ec0-bfe1d7ca43b6', 
    (SELECT companyId FROM Company WHERE uuid = '97da4a8a-020c-4f2a-b531-919ab8ecd965'), 
    (SELECT personId FROM Person WHERE uuid = 'aa5905c1-a965-41ef-8f40-46101dd9b193'), 
    '2024-08-21';
 
INSERT IGNORE INTO Invoice (uuid, customerId, salesPersonId, date)
SELECT 'dfb90d8d-63f0-4b2f-8d41-0a9bfa1114ee', 
    (SELECT companyId FROM Company WHERE uuid = '97da4a8a-020c-4f2a-b531-919ab8ecd965'), 
    (SELECT personId FROM Person WHERE uuid = '417660aa-9b58-4536-88fd-7f6aab63d118'), 
    '2023-03-11';
 
INSERT IGNORE INTO Invoice (uuid, customerId, salesPersonId, date)
SELECT '65078f3c-577e-4a07-8017-3b396a809987', 
    (SELECT companyId FROM Company WHERE uuid = 'd7bb9ad9-36e2-46df-851c-494883e2051b'), 
    (SELECT personId FROM Person WHERE uuid = '668097b3-6cc5-4035-bf0e-1351c0c5eecb'), 
    '2025-08-09';
 
INSERT IGNORE INTO Invoice (uuid, customerId, salesPersonId, date)
SELECT '1a13a55b-3ef7-4aeb-8ce5-4c1e8f6e7c7a', 
    (SELECT companyId FROM Company WHERE uuid = '1feb6f79-e282-4994-88a0-c9cdafe3da51'), 
    (SELECT personId FROM Person WHERE uuid = 'b27bd32c-92ea-43fd-995f-179b35b37602'), 
    '2023-08-26';
 
INSERT IGNORE INTO Invoice (uuid, customerId, salesPersonId, date)
SELECT 'fa0afc26-cd34-48ac-bd6d-24361be731a5', 
    (SELECT companyId FROM Company WHERE uuid = '8881ea2b-4952-4377-9ad1-abd6e473c9d6'), 
    (SELECT personId FROM Person WHERE uuid = 'a052c537-cba7-4b42-9dea-3810b0c0258a'), 
    '2023-12-28';
 
INSERT IGNORE INTO Invoice (uuid, customerId, salesPersonId, date)
SELECT '2665b6af-6525-4084-a789-0015085f1cdc', 
    (SELECT companyId FROM Company WHERE uuid = 'c1042a59-ffbd-4a93-943e-29a47b0168cf'), 
    (SELECT personId FROM Person WHERE uuid = '7d0e0a85-4e12-462b-8303-6746c067714b'), 
    '2023-03-08';
 
INSERT IGNORE INTO Invoice (uuid, customerId, salesPersonId, date)
SELECT '0dfea7f0-babb-426b-8c89-c5b0ee180db3', 
    (SELECT companyId FROM Company WHERE uuid = '55e49964-5b1c-45f4-b009-bb75ef0b24a6'), 
    (SELECT personId FROM Person WHERE uuid = '7d0e0a85-4e12-462b-8303-6746c067714b'), 
    '2025-06-15';
 
INSERT IGNORE INTO Invoice (uuid, customerId, salesPersonId, date)
SELECT 'f1d7a3d4-d22d-46f1-bf63-c31bd6a41acc', 
    (SELECT companyId FROM Company WHERE uuid = 'b110cc6e-5fe7-4213-aa2c-cb0687da0a7e'), 
    (SELECT personId FROM Person WHERE uuid = 'c022a6fb-d1da-47bd-9cdb-4273492363ca'), 
    '2025-12-21';
 
INSERT IGNORE INTO Item (uuid, name, type, price, equipmentModelNumber) VALUES 
('ec877930-b85f-405b-8ce6-3e41078f70b2', 'Compactor', 'E', 8128, 'S4325'),
('78fd5872-9eee-4f40-8583-8efed9d76758', 'Dump Truck', 'E', 7420, 'S4325'),
('990fbb23-6b1b-4714-9243-8c8d9302fc03', 'Bulldozer', 'E', 9500, 'FLT100'),
('a5b584dd-cd31-4227-b4a4-541b0e081bb0', 'Compactor', 'E', 7200, 'CMTX-100'),
('f2f9dae8-bf7c-4dd8-8271-1b1dcabd060f', 'Bulldozer', 'E', 8350, 'CMTX-100'),
('64624d7b-a13d-4ca8-85ca-0f02dccd2316', 'Skid-Steer', 'E', 6890, 'FLT100');
 
INSERT IGNORE INTO Item (uuid, name, type, price, materialUnit) VALUES 
('f384cd73-2c39-41cb-98d4-c9b205a53390', 'rubber', 'M', 38, 'box'),
('343f5a93-3f88-47d5-8012-028ac3ab7092', 'plastic', 'M', 25, 'barrel'),
('923d81d0-3a6c-40cc-a9ab-d61844b4be5b', 'plastic', 'M', 32, 'crate'),
('2d8d417c-f713-48df-876c-fcf711158dd5', 'aluminum', 'M', 10, 'barrel'),
('a0e82acf-61d1-4e26-9cea-96f14a8555f2', 'aluminum', 'M', 53, 'crate'),
('80834859-03e1-4787-867d-5f69074bd267', 'aluminum', 'M', 40, 'barrel'),
('5ddbf29d-8bca-43b5-a0cf-cdaa9b30ecab', 'concrete', 'M', 9, 'pallet'),
('4c0e39bc-9851-4b66-aeb6-34e0215f72f9', 'steel', 'M', 74, 'pallet'),
('569500b5-2f6a-4c45-b6ce-40138b7b7d03', 'glass', 'M', 70, 'box');
INSERT IGNORE INTO Item (uuid, name, type, contractCompanyId) VALUES 
('6f00288f-8128-448e-b57d-ce7fbc055064', 'renovation', 'C', 
    (SELECT companyId FROM Company WHERE uuid = '8881ea2b-4952-4377-9ad1-abd6e473c9d6')),
('7f159742-8ee4-4f79-a01f-7ae484e15163', 'transportation', 'C', 
    (SELECT companyId FROM Company WHERE uuid = '975e36bf-2a74-47ff-9563-d0c4e733227f')),
('0e0c7de1-fe94-445e-a8fe-acf75f3419b8', 'hauling', 'C', 
    (SELECT companyId FROM Company WHERE uuid = '975e36bf-2a74-47ff-9563-d0c4e733227f'));
    
INSERT IGNORE INTO InvoiceItem (invoiceId, itemId, type, rentalHours) 
SELECT i.invoiceId, it.itemId, 'R', 75 
FROM Invoice i 
JOIN Item it ON it.uuid = 'f2f9dae8-bf7c-4dd8-8271-1b1dcabd060f' 
WHERE i.uuid = '109da0ba-3db7-4cd4-9ec0-bfe1d7ca43b6';
 
INSERT IGNORE INTO InvoiceItem (invoiceId, itemId, type, rentalHours) 
SELECT i.invoiceId, it.itemId, 'R', 30 
FROM Invoice i 
JOIN Item it ON it.uuid = 'ec877930-b85f-405b-8ce6-3e41078f70b2' 
WHERE i.uuid = '4af69a44-02d2-4caa-9665-6b3b5cfc66f5';
 
INSERT IGNORE INTO InvoiceItem (invoiceId, itemId, type, materialQuantity) 
SELECT i.invoiceId, it.itemId, 'M', 19 
FROM Invoice i 
JOIN Item it ON it.uuid = '923d81d0-3a6c-40cc-a9ab-d61844b4be5b' 
WHERE i.uuid = 'dfb90d8d-63f0-4b2f-8d41-0a9bfa1114ee';
 
INSERT IGNORE INTO InvoiceItem (invoiceId, itemId, type, materialQuantity) 
SELECT i.invoiceId, it.itemId, 'M', 1 
FROM Invoice i 
JOIN Item it ON it.uuid = '343f5a93-3f88-47d5-8012-028ac3ab7092' 
WHERE i.uuid = '24840fb9-a48c-4aad-9b57-3f3c32a412e4';
 
INSERT IGNORE INTO InvoiceItem (invoiceId, itemId, type, materialQuantity) 
SELECT i.invoiceId, it.itemId, 'M', 66 
FROM Invoice i 
JOIN Item it ON it.uuid = 'f384cd73-2c39-41cb-98d4-c9b205a53390' 
WHERE i.uuid = '327764ec-0bbd-4920-87f1-aaeb90ae7616';
 
INSERT IGNORE INTO InvoiceItem (invoiceId, itemId, type, materialQuantity) 
SELECT i.invoiceId, it.itemId, 'M', 80 
FROM Invoice i 
JOIN Item it ON it.uuid = 'a0e82acf-61d1-4e26-9cea-96f14a8555f2' 
WHERE i.uuid = '327764ec-0bbd-4920-87f1-aaeb90ae7616';
 
INSERT IGNORE INTO InvoiceItem (invoiceId, itemId, type) 
SELECT i.invoiceId, it.itemId, 'C' 
FROM Invoice i 
JOIN Item it ON it.uuid = '6f00288f-8128-448e-b57d-ce7fbc055064' 
WHERE i.uuid = 'fa0afc26-cd34-48ac-bd6d-24361be731a5';
 
UPDATE Item SET price = 6928 WHERE uuid = '6f00288f-8128-448e-b57d-ce7fbc055064';
 
INSERT IGNORE INTO InvoiceItem (invoiceId, itemId, type) 
SELECT i.invoiceId, it.itemId, 'C' 
FROM Invoice i 
JOIN Item it ON it.uuid = '0e0c7de1-fe94-445e-a8fe-acf75f3419b8' 
WHERE i.uuid = '24840fb9-a48c-4aad-9b57-3f3c32a412e4';
 
UPDATE Item SET price = 6928 WHERE uuid = '0e0c7de1-fe94-445e-a8fe-acf75f3419b8';
 
INSERT IGNORE INTO InvoiceItem (invoiceId, itemId, type) 
SELECT i.invoiceId, it.itemId, 'C' 
FROM Invoice i 
JOIN Item it ON it.uuid = '7f159742-8ee4-4f79-a01f-7ae484e15163' 
WHERE i.uuid = 'f5cbe33d-202f-4dce-96a9-f22c33913127';
 
UPDATE Item SET price = 6928 WHERE uuid = '7f159742-8ee4-4f79-a01f-7ae484e15163';
 
INSERT IGNORE INTO InvoiceItem (invoiceId, itemId, type) 
SELECT i.invoiceId, it.itemId, 'C' 
FROM Invoice i 
JOIN Item it ON it.uuid = '6f00288f-8128-448e-b57d-ce7fbc055064' 
WHERE i.uuid = '327764ec-0bbd-4920-87f1-aaeb90ae7616';
 
UPDATE Item SET price = 6928 WHERE uuid = '6f00288f-8128-448e-b57d-ce7fbc055064';
 
INSERT IGNORE INTO InvoiceItem (invoiceId, itemId, type) 
SELECT i.invoiceId, it.itemId, 'C' 
FROM Invoice i 
JOIN Item it ON it.uuid = '7f159742-8ee4-4f79-a01f-7ae484e15163' 
WHERE i.uuid = 'fa0afc26-cd34-48ac-bd6d-24361be731a5';
 
UPDATE Item SET price = 6928 WHERE uuid = '7f159742-8ee4-4f79-a01f-7ae484e15163';
