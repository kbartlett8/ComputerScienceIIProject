-- Queries
-- Authors: Emma Rhode and Kayla Bartlett 
 
-- 1. Retrieve the main attributes of each person (UUID, last name, and first name)
SELECT uuid, lastname, firstname
FROM Person;
 
-- 2. Retrieve the major fields for every person including their email address(es)
SELECT p.uuid, p.lastname, p.firstname, e.email
FROM Person p
JOIN Email e ON p.personId = e.personId;
 
-- 3. Get the email addresses of a specific person
SELECT DISTINCT e.email
FROM Email e
JOIN Person p ON e.personId = p.personId
WHERE p.uuid = 'a052c537-cba7-4b42-9dea-3810b0c0258a';
 
UPDATE Email 
-- 4. Change the email address of a specific email record
SET Email = 'charlotte.nguyen@gmail.com'  
WHERE Email = 'charlotte.nguyen@unomaha.edu' 
AND personId = (SELECT personId FROM Person WHERE uuid = 'a052c537-cba7-4b42-9dea-3810b0c0258a');
 
-- 5. Remove a specific person record (along with their email addresses)
DELETE FROM Email 
WHERE personId = (SELECT personId FROM Person WHERE uuid = '72b5ffeb-7cbf-404c-a207-9abfa09fa6f8');
 
UPDATE Company 
SET contactId = NULL 
WHERE contactId = (SELECT personId FROM Person WHERE uuid = '72b5ffeb-7cbf-404c-a207-9abfa09fa6f8');
 
UPDATE Invoice 
SET salesPersonId = NULL 
WHERE salesPersonId = (SELECT personId FROM Person WHERE uuid = '72b5ffeb-7cbf-404c-a207-9abfa09fa6f8');
 
DELETE FROM Person 
WHERE uuid = '72b5ffeb-7cbf-404c-a207-9abfa09fa6f8';
 
-- 6. Get all the items on a specific invoice record
SELECT i.itemId, i.uuid, i.name, i.price FROM InvoiceItem ii
JOIN Item i ON ii.itemId = i.itemId
WHERE ii.invoiceId = (SELECT invoiceId FROM Invoice WHERE invoiceId = (SELECT invoiceId FROM Invoice WHERE uuid = '24840fb9-a48c-4aad-9b57-3f3c32a412e4'));
 
-- 7. Get all the items purchased by a specific customer
SELECT i.itemId, i.uuid, i.name, i.type, i.price FROM InvoiceItem ii
JOIN Invoice iv ON ii.invoiceId = iv.invoiceId
JOIN Item i ON ii.itemId = i.itemId
WHERE iv.customerId = (SELECT companyId FROM Company WHERE uuid = '1feb6f79-e282-4994-88a0-c9cdafe3da51');
 
-- 8. Find the total number of invoices for each customer (even those with no invoices)
SELECT c.companyId, c.name AS customerName, COUNT(i.invoiceId) AS totalInvoices
FROM Company c 
LEFT JOIN Invoice i ON c.companyId = i.customerId
GROUP BY c.companyId , c.name 
ORDER BY totalInvoices DESC;
 
-- 9. Find the total number of sales made by each salesperson (excluding those with zero sales)
SELECT p.personId, CONCAT(p.firstName, ' ', p.lastName) AS salespersonName, COUNT(i.invoiceId) AS totalSales
FROM Person p
JOIN Invoice i ON p.personId = i.salesPersonId
GROUP BY p.personId, p.firstName, p.lastName 
HAVING COUNT(i.invoiceId) > 0
ORDER BY totalSales DESC;
 
-- 10. Find the subtotal charge of all materials purchased in each invoice (excluding taxes) not getting all information
SELECT iv.invoiceId, ii.itemId, ii.materialQuantity, i.price, (ii.materialQuantity * i.price) AS lineTotal, SUM(ii.materialQuantity * i.price) OVER (PARTITION BY iv.invoiceId) AS subtotalCharge
FROM Invoice iv
LEFT JOIN InvoiceItem ii ON iv.invoiceId = ii.invoiceId
LEFT JOIN Item i ON ii.itemId = i.itemId
WHERE ii.type = 'M';
 
-- 11. Find any invoice that includes multiple records of the same material (if your design allows this)
SELECT iv.invoiceId, ii.itemId, i.name, COUNT(*) AS itemCount
FROM Invoice iv
JOIN InvoiceItem ii ON iv.invoiceId = ii.invoiceId
JOIN Item i ON ii.itemId = i.itemId
WHERE ii.type = 'M'  
GROUP BY iv.invoiceId, ii.itemId
HAVING COUNT(*) > 1;
 
-- 12. Detect a potential instance of fraud where an employee makes a sale to their own company
SELECT iv.invoiceId, iv.date, iv.salesPersonId, iv.customerId, p.firstName AS salespersonFirstName, p.lastName AS salespersonLastName, c.name AS companyName, pc.firstName AS contactFirstName, pc.lastName AS contactLastName
FROM Invoice iv
JOIN Person p ON iv.salesPersonId = p.personId
JOIN Company c ON iv.customerId = c.companyId
JOIN Person pc ON c.contactId = pc.personId
WHERE iv.salesPersonId = c.contactId;