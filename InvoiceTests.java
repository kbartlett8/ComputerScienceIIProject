package com.vgb;

import static org.junit.Assert.assertTrue;
import static org.junit.jupiter.api.Assertions.assertEquals;
import java.util.UUID;
import org.junit.jupiter.api.Test;

/**
 * JUnit test suite for VGB invoice system.
 */
public class InvoiceTests {

	public static final double TOLERANCE = 0.001;


	/**
	 * Tests the sub total, tax total and grand total values of an invoice in
	 * the VGB system.
	 */
	@Test
	public void testInvoice01() {
		Equipment equipment = new Equipment(UUID.randomUUID(), "Concrete Mixer", "CMX123", 1500.00);
		Material material = new Material(UUID.randomUUID(), "Scaffolding", "kg", 200.00);
		material.setQuantity(6);
		Contract contract = new Contract(UUID.randomUUID(), "Construction Contract", new Company(UUID.randomUUID(), null, "XYZ Ltd.", null));
		contract.setContractAmount(5000.00);
		Invoice  invoice = new Invoice (new Company(UUID.randomUUID(), null, "ABC Corp", null));  
		invoice.addItem(equipment);
		invoice.addItem(material);
		invoice.addItem(contract);
		
		double expectedSubtotal = 1500.00 + (200.00 * 6) + 5000.00;
		double expectedTaxTotal = (equipment.computeTax() + material.computeTax() + contract.computeTax());
		double expectedTotalCost = expectedSubtotal + expectedTaxTotal;
		double actualSubtotal = invoice.computeSubtotal();
		double actualTaxTotal = invoice.computeTax();
		double actualTotalCost = invoice.computeTotalCost();
	        
		assertEquals(expectedSubtotal, actualSubtotal, TOLERANCE);  
		assertEquals(expectedTaxTotal, actualTaxTotal, TOLERANCE);
		assertEquals(expectedTotalCost, actualTotalCost, TOLERANCE);  
		
        String s = invoice.toString();
        assertTrue(s.contains("Concrete Mixer"));
        assertTrue(s.contains("Scaffolding"));
        assertTrue(s.contains("Construction Contract"));
	}

	/**
	 * Tests the sub total, tax total and grand total values of an invoice in
	 * the VGB system.
	 */
	@Test
	public void testInvoice02() {
		Material material = new Material(UUID.randomUUID(), "Scaffolding", "kg", 200.00);
		material.setQuantity(6); 

	    Contract contract = new Contract(UUID.randomUUID(), "Construction Contract", new Company(UUID.randomUUID(), null, "XYZ Ltd.", null));
	    contract.setContractAmount(5000.00); 

	    Invoice invoice = new Invoice(new Company(UUID.randomUUID(), null, "ABC Corp", null));
	    invoice.addItem(material);
	    invoice.addItem(contract);

	    double expectedSubtotal = (200.00 * 6) + 5000.00;
	    double expectedTaxTotal = (material.computeTax() + contract.computeTax());
	    double expectedTotalCost = expectedSubtotal + expectedTaxTotal;

	    double actualSubtotal = invoice.computeSubtotal();
	    double actualTaxTotal = invoice.computeTax();
	    double actualTotalCost = invoice.computeTotalCost();  

	    assertEquals(expectedSubtotal, actualSubtotal, TOLERANCE);
	    assertEquals(expectedTaxTotal, actualTaxTotal, TOLERANCE);
	    assertEquals(expectedTotalCost, actualTotalCost, TOLERANCE);

	    String s = invoice.toString();
	    assertTrue(s.contains("Scaffolding"));
	    assertTrue(s.contains("Construction Contract"));
	}

}
package com.vgb;
 
import static org.junit.Assert.assertTrue;
import static org.junit.jupiter.api.Assertions.assertEquals;
import java.util.UUID;
import org.junit.jupiter.api.Test;
 
/**
 * JUnit test suite for VGB invoice system.
 */
public class InvoiceTests {
 
	public static final double TOLERANCE = 0.001;
 
 
	/**
	 * Tests the sub total, tax total and grand total values of an invoice in
	 * the VGB system.
	 */
	@Test
	public void testInvoice01() {
		Equipment equipment = new Equipment(UUID.randomUUID(), "Concrete Mixer", "CMX123", 1500.00);
		Material material = new Material(UUID.randomUUID(), "Scaffolding", "kg", 200.00);
		material.setQuantity(6);
		Contract contract = new Contract(UUID.randomUUID(), "Construction Contract", new Company(UUID.randomUUID(), null, "XYZ Ltd.", null));
		contract.setContractAmount(5000.00);
		Invoice  invoice = new Invoice (new Company(UUID.randomUUID(), null, "ABC Corp", null));  
		invoice.addItem(equipment);
		invoice.addItem(material);
		invoice.addItem(contract);
		
		double expectedSubtotal = 1500.00 + (200.00 * 6) + 5000.00;
		double expectedTaxTotal = (equipment.computeTax() + material.computeTax() + contract.computeTax());
		double expectedTotalCost = expectedSubtotal + expectedTaxTotal;
		double actualSubtotal = invoice.computeSubtotal();
		double actualTaxTotal = invoice.computeTax();
		double actualTotalCost = invoice.computeTotalCost();
	        
		assertEquals(expectedSubtotal, actualSubtotal, TOLERANCE);  
		assertEquals(expectedTaxTotal, actualTaxTotal, TOLERANCE);
		assertEquals(expectedTotalCost, actualTotalCost, TOLERANCE);  
		
        String s = invoice.toString();
        assertTrue(s.contains("Concrete Mixer"));
        assertTrue(s.contains("Scaffolding"));
        assertTrue(s.contains("Construction Contract"));
	}
 
	/**
	 * Tests the sub total, tax total and grand total values of an invoice in
	 * the VGB system.
	 */
	@Test
	public void testInvoice02() {
		Material material = new Material(UUID.randomUUID(), "Scaffolding", "kg", 200.00);
		material.setQuantity(6); 
 
	    Contract contract = new Contract(UUID.randomUUID(), "Construction Contract", new Company(UUID.randomUUID(), null, "XYZ Ltd.", null));
	    contract.setContractAmount(5000.00); 
 
	    Invoice invoice = new Invoice(new Company(UUID.randomUUID(), null, "ABC Corp", null));
	    invoice.addItem(material);
	    invoice.addItem(contract);
 
	    double expectedSubtotal = (200.00 * 6) + 5000.00;
	    double expectedTaxTotal = (material.computeTax() + contract.computeTax());
	    double expectedTotalCost = expectedSubtotal + expectedTaxTotal;
 
	    double actualSubtotal = invoice.computeSubtotal();
	    double actualTaxTotal = invoice.computeTax();
	    double actualTotalCost = invoice.computeTotalCost();  
 
	    assertEquals(expectedSubtotal, actualSubtotal, TOLERANCE);
	    assertEquals(expectedTaxTotal, actualTaxTotal, TOLERANCE);
	    assertEquals(expectedTotalCost, actualTotalCost, TOLERANCE);
 
	    String s = invoice.toString();
	    assertTrue(s.contains("Scaffolding"));
	    assertTrue(s.contains("Construction Contract"));
	}
 
}
