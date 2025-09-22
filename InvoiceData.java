package com.vgb;
 
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.UUID;
 
 
public class InvoiceData {
 
 
	public static ConnectionPool pool;  
	
	static {
		pool = new ConnectionPool();
	}
 
	/**
	 * Removes all records from all tables in the database.
	 */
	public static void clearDatabase() {
		Connection conn = ConnectionPool.getConnection();
	    try  {
	        String[] tables = { "InvoiceItem", "Invoice", "Item", "Company", "Email", "Person", "Address", "Zip", "State" };
	        for (String table : tables) {
	            String sql = "DELETE FROM " + table;  
	            try (PreparedStatement ps = conn.prepareStatement(sql)) {
	                ps.executeUpdate();
	            }
	        }
	    } catch (Exception e) {
	        throw new RuntimeException("Failed clearing tables", e);
	    } finally {
    	ConnectionPool.putConnection(conn);
	    }
	    }
 
 
	/**
	 * Method to add a person record to the database with the provided data.
	 *
	 * @param personUuid
	 * @param firstName
	 * @param lastName
	 * @param phone
	 */
    public static void addPerson(UUID personUuid, String firstName, String lastName, String phone) {
        String sql = "INSERT INTO Person (uuid, firstName, lastName, phone) VALUES (?, ?, ?, ?)";
        Connection conn = ConnectionPool.getConnection();
        try (
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, personUuid.toString());
            ps.setString(2, firstName);
            ps.setString(3, lastName);
            ps.setString(4, phone);
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException("Error adding person", e);
        } finally {
        	ConnectionPool.putConnection(conn);
        }
    }
 
	/**
	 * Adds an email record corresponding person record corresponding to the
	 * provided <code>personUuid</code>
	 *
	 * @param personUuid
	 * @param email
	 */
    public static void addEmail(UUID personUuid, String emailAddress) {
        Connection conn = ConnectionPool.getConnection();
        String sql = "INSERT INTO Email (personId, email) SELECT personId, ? from Person where uuid = ?";
        try (
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, personUuid.toString());
            ps.setString(2, emailAddress);
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException("Error adding email", e);
        }
         finally {
        	ConnectionPool.putConnection(conn);
        }
    }
 
	/**
	 * Adds a company record to the database with the primary contact person identified by the
	 * given code.
	 *
	 * @param companyUuid
	 * @param name
	 * @param contactUuid
	 * @param street
	 * @param city
	 * @param state
	 * @param zip
	 */
    public static void addCompany(UUID companyUuid, UUID contactUuid, String name, String street, String city, String stateName, String zipCode) {
    	 String sql = "INSERT INTO Company (uuid, name, contactId, addressId) VALUES (?, ?, ?, ?)";
    	  Connection conn = ConnectionPool.getConnection();
 
    	    try (
    	        PreparedStatement ps = conn.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {  	        
    	        int stateId = getStateId(conn, stateName);
    	        if (stateId < 0) {
    	            stateId = insertState(conn, stateName);
    	        }
    	        int zipId = getZipId(conn, zipCode, city, stateId);  
    	        int addressId = insertAddress(conn, street, zipId);   	        
    	        int contactId = getPersonId(conn, contactUuid);
 
    	        ps.setString(1, companyUuid.toString());
    	        ps.setString(2, name);
    	        ps.setInt(3, contactId);
    	        ps.setInt(4, addressId);
    	        
    	        ps.executeUpdate();
    	    } catch (SQLException e) {
    	        throw new RuntimeException("Error adding company", e);
    	    } finally {
    	        ConnectionPool.putConnection(conn);
    	    }
    }
 
	/**
	 * Adds an equipment record to the database of the given values.
	 *
	 * @param equipmentUuid
	 * @param name
	 * @param modelNumber
	 * @param retailPrice
	 */
    public static void addEquipment(UUID itemUuid, String name, String modelNumber, double price) {
        Connection conn = ConnectionPool.getConnection();
 
        String sql = "INSERT INTO Item (uuid, name, type, equipmentModelNumber, price) VALUES (?, ?, ?, ?, ?)";
        try (
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, itemUuid.toString());
            ps.setString(2, name);
            ps.setString(3, "E");
            ps.setString(4, modelNumber);
            ps.setDouble(5, price);
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException("Error adding equipment", e);
        }
        finally {
       	ConnectionPool.putConnection(conn);
       }
    }
 
	/**
	 * Adds an material record to the database of the given values.
	 *
	 * @param materialUuid
	 * @param name
	 * @param unit
	 * @param pricePerUnit
	 */
    public static void addMaterial(UUID itemUuid, String name, String unit, double price) {
        Connection conn = ConnectionPool.getConnection();
 
        String sql = "INSERT INTO Item (uuid, name, type, materialUnit, price) VALUES (?, ?, ?, ?, ?)";
        try (
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, itemUuid.toString());
            ps.setString(2, name);
            ps.setString(3, "M");
            ps.setString(4, unit);
            ps.setDouble(5, price);
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException("Error adding material", e);
        }
        finally {
       	ConnectionPool.putConnection(conn);
       }
    }
 
	/**
	 * Adds an contract record to the database of the given values.
	 *
	 * @param contractUuid
	 * @param name
	 * @param unit
	 * @param pricePerUnit
	 */
    public static void addContract(UUID contractUuid, String name, UUID companyUuid) {
        Connection conn = ConnectionPool.getConnection();
        String sql = "INSERT INTO Item (uuid, name, type, contractCompanyId) VALUES (?, ?, ?, ?)";
        try {
            int contractCompanyId = getCompanyContractId(conn, companyUuid);
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setString(1, contractUuid.toString());
                ps.setString(2, name);
                ps.setString(3, "C");
                ps.setInt(4, contractCompanyId);
                ps.executeUpdate();
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error adding contract", e);
        } finally {
            ConnectionPool.putConnection(conn);
        }
    }
 
	/**
	 * Adds an Invoice record to the database with the given data.
	 *
	 * @param invoiceUuid
	 * @param customerUuid
	 * @param salesPersonUuid
	 * @param date
	 */
    public static void addInvoice(UUID invoiceUuid, UUID customerCompanyUuid, UUID salesPersonUuid, LocalDate invoiceDate) {
        Connection conn = ConnectionPool.getConnection();
 
        String sql = "INSERT INTO Invoice (uuid, customerId, salesPersonId, date) VALUES (?, (SELECT companyId FROM Company WHERE uuid = ?), (SELECT personId FROM Person WHERE uuid = ?), ?)";
        try (
            PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, invoiceUuid.toString());
            ps.setString(2, customerCompanyUuid.toString());
            ps.setString(3, salesPersonUuid.toString());           
            ps.setString(4, invoiceDate.toString());            
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException("Error adding invoice", e);
        }
        finally {
       	ConnectionPool.putConnection(conn);
       }
    }
 
 
 
	/**
	 * Adds an Equipment purchase record to the given invoice.
	 *
	 * @param invoiceUuid
	 * @param itemUuid
	 */
    public static void addEquipmentPurchaseToInvoice(UUID invoiceUuid, UUID itemUuid) {
        Connection conn = ConnectionPool.getConnection();
 
        String sql = "INSERT INTO InvoiceItem (invoiceId, itemId, type) VALUES ((SELECT invoiceId FROM Invoice WHERE uuid = ?), (SELECT itemId FROM Item WHERE uuid = ?), ?)";
        try (
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, invoiceUuid.toString());
            ps.setString(2, itemUuid.toString());
            ps.setString(3, "P");
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException("Error adding equipment purchase to invoice", e);
        }
        finally {
       	ConnectionPool.putConnection(conn);
       }
    }
 
	/**
	 * Adds an Equipment lease record to the given invoice.
	 *
	 * @param invoiceUuid
	 * @param itemUuid
	 * @param start
	 * @param end
	 */
    public static void addEquipmentLeaseToInvoice(UUID invoiceUuid, UUID itemUuid, LocalDate startDate, LocalDate endDate) {
        Connection conn = ConnectionPool.getConnection();
 
        String sql = "INSERT INTO InvoiceItem (invoiceId, itemId, type, leaseStartDate, leaseEndDate) VALUES ((SELECT invoiceId FROM Invoice WHERE uuid = ?), (SELECT itemId FROM Item WHERE uuid = ?), ?, ?, ?)";
        try (
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, invoiceUuid.toString());
            ps.setString(2, itemUuid.toString());
            ps.setString(3, "L");
            ps.setString(4, startDate.toString());
            ps.setString(5, endDate.toString());               
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException("Error adding equipment lease to invoice", e);
        }
        finally {
       	ConnectionPool.putConnection(conn);
       }
    }
 
 
	/**
	 * Adds an Equipment rental record to the given invoice.
	 *
	 * @param invoiceUuid
	 * @param itemUuid
	 * @param numberOfHours
	 */
    public static void addEquipmentRentalToInvoice(UUID invoiceUuid, UUID itemUuid, double rentalHours) {
        Connection conn = ConnectionPool.getConnection();
 
        String sql = "INSERT INTO InvoiceItem (invoiceId, itemId, type, rentalHours) VALUES ((SELECT invoiceId FROM Invoice WHERE uuid = ?), (SELECT itemId FROM Item WHERE uuid = ?), ?, ?)";
        try (
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, invoiceUuid.toString());
            ps.setString(2, itemUuid.toString());
            ps.setString(3, "R");
            ps.setDouble(4, rentalHours);
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException("Error adding equipment rental to invoice", e);
        }
        finally {
       	ConnectionPool.putConnection(conn);
       }
    }
 
	/**
	 * Adds a material record to the given invoice.
	 *
	 * @param invoiceUuid
	 * @param itemUuid
	 * @param numberOfUnits
	 */
 
    public static void addMaterialToInvoice(UUID invoiceUuid, UUID itemUuid, int quantity) {
        Connection conn = ConnectionPool.getConnection();
 
        String sql = "INSERT INTO InvoiceItem (invoiceId, itemId, type, materialQuantity) VALUES ((SELECT i.invoiceId FROM Invoice i WHERE i.uuid = ?), (SELECT it.itemId FROM Item it WHERE it.uuid = ?), ?, ?)";
 
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, invoiceUuid.toString());
            ps.setString(2, itemUuid.toString());
            ps.setString(3, "M");
            ps.setInt(4, quantity);
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException("Error adding material to invoice", e);
        } finally {
            ConnectionPool.putConnection(conn);
        }
    }
 
 
	/**
	 * Adds a contract record to the given invoice.
	 *
	 * @param invoiceUuid
	 * @param itemUuid
	 * @param amount
	 */
    public static void addContractToInvoice(UUID invoiceUuid, UUID itemUuid, double price) {
        Connection conn = ConnectionPool.getConnection();
 
        String sql = "INSERT INTO InvoiceItem (invoiceId, itemId, type) SELECT i.invoiceId, it.itemId, ? from Invoice i, Item it where i.uuid = ? and it.uuid = ?";
        String sql2 = "UPDATE Item set price = ? where uuid = ?";
        try {
	        try (
	             PreparedStatement ps = conn.prepareStatement(sql)) {
	        	ps.setString(1, "C");
	            ps.setString(2, invoiceUuid.toString());
	            ps.setString(3, itemUuid.toString());
	            ps.executeUpdate();
	        } catch (SQLException e) {
	            throw new RuntimeException("Error adding contract to invoice", e);
	        }
	        try(PreparedStatement ps = conn.prepareStatement(sql2)){
	            ps.setDouble(1, price );
	            ps.setString(2, itemUuid.toString());
	            ps.executeUpdate();
	        } catch(SQLException e) {
	        	throw new RuntimeException("Error adding contract to invoice", e);
	        }
        }finally {
       	ConnectionPool.putConnection(conn);
       }
    }
 
    /**
     * Retrieves the Person ID.
     * @param conn
     * @param personUuid
     * @return
     * @throws SQLException
     */
    private static int getPersonId(Connection conn, UUID personUuid) throws SQLException {
        String sql = "SELECT personId FROM Person WHERE uuid = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, personUuid.toString());
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt("personId");
            else {
            	return -1;
            }
        }
    }
    
    /**
     * Retrieves the Item Id
     * 
     * @param conn
     * @param itemUuid
     * @return
     */
    public static int getItemId(Connection conn, UUID itemUuid) {
        String sql = "SELECT itemId FROM Item WHERE uuid = ?";
 
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, itemUuid.toString());
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("itemId");
                } else {
                    throw new RuntimeException("Item not found for UUID: " + itemUuid);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error retrieving itemId for UUID: " + itemUuid, e);
        }
    }
 
 
    /**
     * Retrieves the State ID.
     * @param conn
     * @param stateName
     * @return
     * @throws SQLException
     */
    private static int getStateId(Connection conn, String stateName) throws SQLException {
 
        String sql = "SELECT stateId FROM State WHERE stateName = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, stateName);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {return rs.getInt("stateId");
            }
            else {
            	return -1;
            }
        }
 
    }
 
    /**
     * Retrieves the Zip Id.
     * @param conn
     * @param zipCode
     * @param city
     * @param stateId
     * @return
     * @throws SQLException
     */
    private static int getZipId(Connection conn, String zipCode, String city, int stateId) throws SQLException {
        String sql = "SELECT zipId FROM Zip WHERE zipCode = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, zipCode);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt("zipId");
 
            sql = "INSERT INTO Zip (zipCode, city, stateId) VALUES (?, ?, ?)";
            try (PreparedStatement insertPs = conn.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {
                insertPs.setString(1, zipCode);
                insertPs.setString(2, city);
                insertPs.setInt(3, stateId);
                insertPs.executeUpdate();
                ResultSet generatedKeys = insertPs.getGeneratedKeys();
                if (generatedKeys.next()) return generatedKeys.getInt(1);
                else throw new RuntimeException("Failed to insert new Zip");
            }
        }
 
    }
    
    /**
     * Retrieves the Company Contract Id
     * @param conn
     * @param companyUuid
     * @return
     */
    public static int getCompanyContractId(Connection conn, UUID companyUuid) {
        String sql = "SELECT companyId FROM Company WHERE uuid = ?";
        
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, companyUuid.toString());
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("companyId");
                } else {
                    throw new RuntimeException("Company Contract ID not found for UUID: " + companyUuid);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error retrieving company ID", e);
        }
    }
    
    /**
     * Inserts an Address object.
     * @param conn
     * @param street
     * @param zipId
     * @return
     * @throws SQLException
     */
    private static int insertAddress(Connection conn, String street, int zipId) throws SQLException {
        String sql = "INSERT INTO Address (street, zipId) VALUES (?, ?)";
        try (PreparedStatement ps = conn.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, street);
            ps.setInt(2, zipId);
            ps.executeUpdate();
            ResultSet generatedKeys = ps.getGeneratedKeys();
            if (generatedKeys.next()) return generatedKeys.getInt(1);
            else throw new RuntimeException("Failed to insert Address");
        }
    } 
    
    /**
     * Inserts a State object.
     * @param conn
     * @param stateName
     * @return
     * @throws SQLException
     */
    private static int insertState(Connection conn, String stateName) throws SQLException {
        String insertSql = "INSERT INTO State (stateName) VALUES (?)";
        try (PreparedStatement ps = conn.prepareStatement(insertSql, PreparedStatement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, stateName);
            ps.executeUpdate();
 
            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) {
                    return rs.getInt(1);
                } else {
                    throw new SQLException("Failed to insert state.");
                }
            }
        }
    }
 
}
