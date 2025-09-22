package com.vgb;
 
import static org.junit.Assert.assertTrue;
import static org.junit.jupiter.api.Assertions.assertEquals;
import org.junit.jupiter.api.Test;
import java.time.LocalDate;
import java.util.Arrays;
import java.util.UUID;
 
/**
 * JUnit test suite for VGB invoice system.
 */
public class EntityTests {
 
	public static final double TOLERANCE = 0.001;
 
	/**
	 * Creates an instance of a piece of equipment and tests if
	 * its cost and tax calculations are correct.
	 *
	 * 
	 */
	@Test
	public void testEquipment() {
		UUID uuid = UUID.randomUUID();;
		String name = "Backhoe 3000";
		String model = "BH30X2";
		double cost = 95125.00;
 
        Equipment equipment = new Equipment(uuid, name, model, cost);
 
		double expectedCost = 95125.00;
		double expectedTax = 4994.06;
 
        double actualCost = equipment.computeSubtotal();
        double actualTax = equipment.computeTax();
        String s = equipment.toString();
 
        assertEquals(expectedCost, actualCost, TOLERANCE);
		assertEquals(expectedTax, actualTax, TOLERANCE);
		assertTrue(s.contains("Backhoe 3000"));
		assertTrue(s.contains("BH30X2"));
		assertTrue(s.contains("95125.0"));	
	}
 
	@Test
	public void testLease() {
		UUID uuid = UUID.randomUUID();;
	    String name = "Excavator X100";
	    double cost = 95125.00;
		String model = "BH30X2";
	    LocalDate startDate = LocalDate.of(2024, 1, 1);
	    LocalDate endDate = LocalDate.of(2026, 6, 1);
	    double markupPercentage = 0.5;
 
        LeasedItem leasedItem = new LeasedItem(uuid, name, model, cost, startDate, endDate, markupPercentage);
 
        double expectedCost = 70537.29;
        double expectedTax = 1500.00;
 
        double actualCost = leasedItem.computeTotalCost();
        double actualTax = leasedItem.computeTax();
        String s = leasedItem.toString();
 
		assertEquals(expectedCost, actualCost, TOLERANCE);
		assertEquals(expectedTax, actualTax, TOLERANCE);
	    assertTrue(s.contains("Excavator X100"));
	    assertTrue(s.contains("95125.00"));
	    assertTrue(s.contains("BH30X2"));   
	}
 
	@Test
	public void testRental() {
		UUID uuid = UUID.randomUUID();;
	    String name = "Bulldozer D450";
	    double cost = 95125.00;
		String model = "BH30X2";
	    int hours = 25;
 
        RentedItem rentedItem = new RentedItem(uuid, name, model, cost, hours);
 
        double expectedCost = 2378.13; 
        double expectedTax = 104.16;  
        
        double actualCost = rentedItem.computeTotalCost();
        double actualTax = rentedItem.computeTax();
        String s = rentedItem.toString();
 
		assertEquals(expectedCost, actualCost, TOLERANCE);
		assertEquals(expectedTax, actualTax, TOLERANCE);
	    assertTrue(s.contains("Bulldozer D450"));
	    assertTrue(s.contains("BH30X2"));
		assertTrue(s.contains("95125.0"));
	}
	
	@Test
	public void testMaterial() {
		UUID uuid = UUID.randomUUID();;
		String name = "Nails";
		String unit = "Box";
		double cost  = 9.99;
		int quantity = 31;
 
		Material material = new Material(uuid, name, unit, cost);
	    material.setQuantity(quantity); 
	    
		double expectedCost = 309.69;
		double expectedTax = 22.14;
		double actualCost = material.computeSubtotal();
		double actualTax = material.computeTax();
		
		String s = material.toString();
 
		assertEquals(expectedCost, actualCost, TOLERANCE);
		assertEquals(expectedTax, actualTax, TOLERANCE);
		assertTrue(s.contains("Nails"));
	    assertTrue(s.contains("Box"));
		assertTrue(s.contains("9.9"));
	}
 
	@Test
	public void testContract() {
        UUID companyUUID = UUID.randomUUID();
        String name = "Foundation Pour";
        UUID contactUUID = UUID.randomUUID();
        Address address = new Address("123 Main St", "Cityville", "ST", "12345");
        Person contact = new Person(contactUUID, "Doe", "John", "555-1234", Arrays.asList("john.doe@example.com"));
        Company company = new Company(companyUUID, contact, "Mitchell LLC", address);
        double contractAmount = 10500.00;
        Contract contract = new Contract(UUID.randomUUID(), name, company);
	    contract.setContractAmount(contractAmount); 
 
        double expectedCost = 10500.00;
        double expectedTax = 0.00;
        String s = contract.toString();
 
        double actualCost = contract.computeTotalCost();
        double actualTax = contract.computeTax();
 
        assertEquals(expectedCost, actualCost, TOLERANCE);
        assertEquals(expectedTax, actualTax, TOLERANCE);
        assertTrue(s.contains("Foundation Pour"));
        assertTrue(s.contains("Mitchell LLC"));
        assertTrue(s.contains("123 Main St"));
        assertTrue(s.contains("John Doe"));
	}
}
