package com.vgb;
 
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;
 
/**
 * Represents an Invoice item with an invoice uuid, company, and then the list of the invoice items that correspond to the 
 * company and uuid.
 */
public class Invoice {
	private UUID invoiceId;
	private Company company;
	private Person salesPerson;
	private LocalDate date;
	private List<Item> items;
	
	public Invoice(UUID invoiceId, LocalDate date, Company customer, Person salesperson) {
		this.invoiceId = invoiceId;
		this.date = date;
		this.company = customer;
        this.salesPerson = salesperson;
        this.items = new ArrayList<>();
	}
	
	public Invoice(Company company) {
        this.company = company;
        this.items = new ArrayList<>();
    }
	
	public Person getSalesPerson() {
		return salesPerson;
	}
 
	public LocalDate getDate() {
		return date;
	}
 
	public void addItem(Item item) {
        items.add(item);
    }
 
    public UUID getInvoiceId() {
        return invoiceId;
    }
 
    public Company getCompany() {
        return company;
    }
    
    public List<Item> getItems() {
        return items;
    }
	 
    /**
     * Computes the total tax of the invoice.
     */
    public double computeTax() {
        double totalTax = 0.0;
        for (Item item : items) {
	            totalTax += item.computeTax(); 
        }
        return totalTax;
    }
 
    /**
     * Computes the subtotal of the invoice.
     */
    public double computeSubtotal() {
        double subtotal = 0;
        for (Item item : items) {
            subtotal += item.computeSubtotal();
        }
        return subtotal;
    }
    
    /**
     * Computes the total cost of the invoice.
     */
    public double computeTotalCost() {
    	return computeSubtotal() + computeTax();
    }
    
 
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append(String.format("Invoice#  %s%n", invoiceId));
        sb.append(String.format("Date      %s%n", date));
        sb.append(String.format("Customer: %s (%s)%n", company.getName(), company.getUuid()));
        sb.append(String.format(" %s%n", company.getPerson()));
        sb.append(String.format("Address: %s%n", company.getAddress()));  
 
        sb.append(String.format("Sales Person: %s %s (%s)%n",
                salesPerson.getFirstName(),
                salesPerson.getLastName(),
                salesPerson.getUuid()));
 
        sb.append("Items:\n");
        for (Item item : items) {
            sb.append(String.format("- %s (%s)%n", item.getName(), item.getUUID()));
 
            if (item instanceof Material material) {
                sb.append(String.format("Quantity: %d Cost: $%.1f%n", material.getQuantity(), material.getCost()));
            } else if (item instanceof LeasedItem leased) {
                sb.append(String.format("%d Days (%s - %s)\n", leased.getDays(),
                        leased.getStartDate(), leased.getEndDate()));
            } else if (item instanceof RentedItem rented) {
                sb.append(String.format("%.1f Hours, Price: $%.1f\n",
                        rented.getHours(), ((Equipment) rented).getRetailPrice()));
            }
 
            double tax = item.computeTax();
            double total = item.computeTotalCost();
            sb.append(String.format(" Tax: $%-7.2f, Total: $%7.2f%n", tax, total));
        }
 
        sb.append(String.format("Subtotals $%-10.2f%n", computeSubtotal()));
        sb.append(String.format("Tax       $%-10.2f%n", computeTax()));
        sb.append(String.format("Grand Total $%-10.2f%n", computeTotalCost()));
        sb.append("------------------------------------------------\n");
 
        return sb.toString();
    }
 
 
}
