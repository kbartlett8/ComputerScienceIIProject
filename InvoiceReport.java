package com.vgb;
 
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
 
/**
 * Generates reports for the invoice management system.
 */
public class InvoiceReport {
 
	/**
	 * Generates a summary report for all invoices.
	 */
	public static void generateInvoiceSummaryReport1(Map<String, Invoice> invoiceMap, Map<String, Company> listCompany) {
		System.out.println("+----------------------------------------------------------------------------------------+");
		System.out.println("| Summary Report - By Total                                                              |");
		System.out.println("+----------------------------------------------------------------------------------------+");
		System.out.printf("%-40s %-30s %-10s %-12s %-12s\n", "Invoice #", "Customer", "Num Items", "Tax", "Total");
 
		double totalRevenue = 0.0;
		double totalTax = 0.0;
		int totalNumItems = 0;
 
		List<Invoice> sortedInvoices = new ArrayList<>(invoiceMap.values());
		System.out.println(sortedInvoices.size());
		sortedInvoices.sort(Comparator.comparingDouble(Invoice::computeTotalCost).reversed());
 
		for (Invoice invoice : sortedInvoices) {
			int numItems = invoice.getItems().size();
			double tax = invoice.computeTax();
			double total = invoice.computeTotalCost();
 
			totalRevenue += total;
			totalTax += tax;
			totalNumItems += numItems;
 
			System.out.printf("%-40s %-30s %-10d $%-11.2f $%-11.2f\n", invoice.getInvoiceId(),
					invoice.getCompany().getName(), numItems, tax, total);
		}
 
		System.out
				.println("+----------------------------------------------------------------------------------------+");
		System.out.printf("%-40s %-30d $%-11.2f $%-11.2f\n", "TOTAL:", totalNumItems, totalTax, totalRevenue);
	}
 
	/**
	 * Generates a summary report for each company.
	 */
	public static void generateCustomerSummaryReport(Map<String, Invoice> invoiceMap, Map<String, Company> companyMap) {
		System.out.println("+----------------------------------------------------------------+");
		System.out.println("| Company Invoice Summary Report                                 |");
		System.out.println("+----------------------------------------------------------------+");
		System.out.printf("%-30s %-15s %-12s\n", "Company", "# Invoices", "Grand Total");
		
		double grandTotal = 0.0;
		int totalInvoice = 0;
 
		Map<String, Double> customerTotals = new HashMap<>();
		Map<String, Integer> invoiceCounts = new HashMap<>();
 
		for (String companyId : companyMap.keySet()) {
			customerTotals.put(companyMap.get(companyId).getName(), 0.0);
			invoiceCounts.put(companyMap.get(companyId).getName(), 0);
		}
 
		for (Invoice invoice : invoiceMap.values()) {
			String customerName = invoice.getCompany().getName();
			double total = invoice.computeTotalCost();
			customerTotals.put(customerName, customerTotals.getOrDefault(customerName, 0.0) + total);
			invoiceCounts.put(customerName, invoiceCounts.getOrDefault(customerName, 0) + 1);
			totalInvoice += 1;
			grandTotal += total;
		}
 
		List<String> sortedCompanies = new ArrayList<>(customerTotals.keySet());
		Collections.sort(sortedCompanies);
 
		for (String company : sortedCompanies) {
			System.out.printf("%-30s %-15d $%-11.2f\n", company, invoiceCounts.get(company),
					customerTotals.get(company));
		}
		System.out.println("+----------------------------------------------------------------------------------------+");
		System.out.printf("%-28s %-15d $%-11.2f\n", "TOTAL:", totalInvoice, grandTotal);
	}
 
	/**
	 * Generates a detailed report for each invoice.
	 */
	public static void generateDetailedInvoiceReport(Map<String, Invoice> invoiceMap) {
	    System.out.println("\n=== Detailed Invoice Report ===");
	    for (Invoice invoice : invoiceMap.values()) {
	        System.out.print(invoice);  
	    }
	}
	
	
	public static void generateSortedReports(Map<String, Invoice> invoiceMap, Map<String, Company> companyMap) {
 
	    System.out.println("+-------------------------------------------------------------------------+");
	    System.out.println("| Invoices by Total                                                       |");
	    System.out.println("+-------------------------------------------------------------------------+");
	    System.out.printf("%-36s %-25s %s%n", "Invoice", "Customer", "Total");
 
	    SortedLinkedList<Invoice> byTotalList = new SortedLinkedList<>(
	        (inv1, inv2) -> Double.compare(inv2.computeTotalCost(), inv1.computeTotalCost())
	    );
 
	    for (Invoice invoice : invoiceMap.values()) {
	        byTotalList.add(invoice);
	    }
 
	    for (int i = 0; i < byTotalList.getSize(); i++) {
	        Invoice invoice = byTotalList.get(i);
	        System.out.printf("%-36s %-25s $%10.2f%n",
	            invoice.getInvoiceId(),
	            invoice.getCompany().getName(),
	            invoice.computeTotalCost());
	    }
 
	    System.out.println();
	    System.out.println("+-------------------------------------------------------------------------+");
	    System.out.println("| Invoices by Customer                                                    |");
	    System.out.println("+-------------------------------------------------------------------------+");
	    System.out.printf("%-36s %-25s %s%n", "Invoice", "Customer", "Total");
 
	    SortedLinkedList<Invoice> byCustomerList = new SortedLinkedList<>(
	           Comparator.comparing((Invoice inv) -> inv.getCompany().getName())
	            .thenComparing(Invoice::getInvoiceId)
	    );
 
	    for (Invoice invoice : invoiceMap.values()) {
	        byCustomerList.add(invoice);
	    }
 
	    for (int i = 0; i < byCustomerList.getSize(); i++) {
	        Invoice invoice = byCustomerList.get(i);
	        System.out.printf("%-36s %-25s $%10.2f%n",
	            invoice.getInvoiceId(),
	            invoice.getCompany().getName(),
	            invoice.computeTotalCost());
	    }
 
	    System.out.println();
	    System.out.println("+-------------------------------------------------------------------------+");
	    System.out.println("| Customer Invoice Totals                                                 |");
	    System.out.println("+-------------------------------------------------------------------------+");
	    System.out.printf("%-25s %-20s %s%n", "Customer", "Number of Invoices", "Total");
 
	    Map<String, Double> customerTotals = new HashMap<>();
	    Map<String, Integer> customerCounts = new HashMap<>();
 
	    for (Company company : companyMap.values()) {
	        customerTotals.put(company.getName(), 0.0);
	        customerCounts.put(company.getName(), 0);
	    }
 
	    for (Invoice invoice : invoiceMap.values()) {
	        String customerName = invoice.getCompany().getName();
	        double total = invoice.computeTotalCost();
	        customerTotals.put(customerName, customerTotals.get(customerName) + total);
	        customerCounts.put(customerName, customerCounts.get(customerName) + 1);
	    }
 
	    SortedLinkedList<CustomerSummary> customerSummaryList = new SortedLinkedList<>(
	        (c1, c2) -> {
	            int cmp = Double.compare(c1.getTotal(), c2.getTotal());
	            if (cmp == 0) {
	                return c1.getName().compareTo(c2.getName());
	            }
	            return cmp;
	        }
	    );
 
	    for (String customer : customerTotals.keySet()) {
	        customerSummaryList.add(new CustomerSummary(
	            customer,
	            customerCounts.get(customer),
	            customerTotals.get(customer)
	        ));
	    }
 
	    for (int i = 0; i < customerSummaryList.getSize(); i++) {
	        System.out.println(customerSummaryList.get(i));
	    }
	}
 
	public static void main(String[] args) {		
		Map<String, Person> personMapJDBC = new HashMap<>();
		Map<String, Company> companyMapJDBC = new HashMap<>();
		Map<String, Item> itemMapJDBC = new HashMap<>();
		Map<String, Invoice> invoiceMapJDBC = new HashMap<>();
 
		System.out.println("Database Report:");
		ConnectionPool pool = new ConnectionPool();
		JDBCDataLoader.loadPersonDataJDBC(pool, personMapJDBC);
		JDBCDataLoader.loadCompanyDataJDBC(pool,companyMapJDBC, personMapJDBC);
		JDBCDataLoader.loadItemDataJDBC(pool, itemMapJDBC, companyMapJDBC);
		JDBCDataLoader.loadInvoiceDataJDBC(pool,invoiceMapJDBC, personMapJDBC, companyMapJDBC);
		JDBCDataLoader.loadInvoiceItemsJDBC(pool,invoiceMapJDBC, itemMapJDBC, companyMapJDBC);
		
		generateInvoiceSummaryReport1(invoiceMapJDBC, companyMapJDBC);
		generateCustomerSummaryReport(invoiceMapJDBC, companyMapJDBC);
		generateDetailedInvoiceReport(invoiceMapJDBC);
 
        generateSortedReports(invoiceMapJDBC, companyMapJDBC);
 
        pool.shutdown();
	}
}
