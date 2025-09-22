package com.vgb;

import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.UUID;

/**
 * Represents a piece of leased equipment and adds the start date, end date, markup percentage, and flat tax to the piece
 * of equipment.
 */
public class LeasedItem extends Equipment {
	private LocalDate startDate;
	private LocalDate endDate;
	private double markupPercentage;
	final private int flatTax = 1500;
	
    public LeasedItem(UUID uuid, String name, String modelNumber, double retailPrice, LocalDate startDate, LocalDate endDate, double markupPercentage) {
        super(uuid, name, modelNumber, retailPrice);
        this.startDate = startDate;
        this.endDate = endDate;
        this.markupPercentage = markupPercentage;
    }

    
    
    public LocalDate getStartDate() {
		return startDate;
	}

	public LocalDate getEndDate() {
		return endDate;
	}


	/**
     * Computes the total cost of the a leased item.
     */
    public double computeTotalCost() {
    	double cost = computeSubtotal();
        if (cost > 12500) {
            return roundToCent(cost + flatTax);
        } else {
            return roundToCent(cost);
        }    
     }
    
    /**
     * Computes the total tax of the a leased item.
     */
	public double computeTax() {
		if (computeSubtotal() > 12500) {
			return flatTax;
		}
		return 0;
	}
	
    /**
     * Computes the subtotal of the a leased item.
     */
	public double computeSubtotal() {
        double yearsLeased = getDays() / 365.0;
        double fraction = yearsLeased / 5.0;
        double cost = fraction * getRetailPrice() * (1 + markupPercentage);
        return cost;
	}
	
	public int getDays() {
		 long daysLeased = ChronoUnit.DAYS.between(startDate, endDate) + 1;
		return (int) daysLeased;
	}
	
	/**
	 * Rounds a given value to 2 decimal places.
	 */
    private double roundToCent(double value) {
        return Math.round(value * 100.0) / 100.0;
    }
	
	public String toString() {
	    String formattedCost = String.format("%.2f", getRetailPrice());  
	    return "LeasedItem [startDate=" + startDate + ", endDate=" + endDate + ", markupPercentage=" + markupPercentage
	                + ", Retail Price " + formattedCost + ", getModelNumber()=" + getModelNumber() + ", getName()=" + getName() + "]";
	}
}
package com.vgb;
 
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.UUID;
 
/**
 * Represents a piece of leased equipment and adds the start date, end date, markup percentage, and flat tax to the piece
 * of equipment.
 */
public class LeasedItem extends Equipment {
	private LocalDate startDate;
	private LocalDate endDate;
	private double markupPercentage;
	final private int flatTax = 1500;
	
    public LeasedItem(UUID uuid, String name, String modelNumber, double retailPrice, LocalDate startDate, LocalDate endDate, double markupPercentage) {
        super(uuid, name, modelNumber, retailPrice);
        this.startDate = startDate;
        this.endDate = endDate;
        this.markupPercentage = markupPercentage;
    }
 
    
    
    public LocalDate getStartDate() {
		return startDate;
	}
 
	public LocalDate getEndDate() {
		return endDate;
	}
 
 
	/**
     * Computes the total cost of the a leased item.
     */
    public double computeTotalCost() {
    	double cost = computeSubtotal();
        if (cost > 12500) {
            return roundToCent(cost + flatTax);
        } else {
            return roundToCent(cost);
        }    
     }
    
    /**
     * Computes the total tax of the a leased item.
     */
	public double computeTax() {
		if (computeSubtotal() > 12500) {
			return flatTax;
		}
		return 0;
	}
	
    /**
     * Computes the subtotal of the a leased item.
     */
	public double computeSubtotal() {
        double yearsLeased = getDays() / 365.0;
        double fraction = yearsLeased / 5.0;
        double cost = fraction * getRetailPrice() * (1 + markupPercentage);
        return cost;
	}
	
	public int getDays() {
		 long daysLeased = ChronoUnit.DAYS.between(startDate, endDate) + 1;
		return (int) daysLeased;
	}
	
	/**
	 * Rounds a given value to 2 decimal places.
	 */
    private double roundToCent(double value) {
        return Math.round(value * 100.0) / 100.0;
    }
	
	public String toString() {
	    String formattedCost = String.format("%.2f", getRetailPrice());  
	    return "LeasedItem [startDate=" + startDate + ", endDate=" + endDate + ", markupPercentage=" + markupPercentage
	                + ", Retail Price " + formattedCost + ", getModelNumber()=" + getModelNumber() + ", getName()=" + getName() + "]";
	}
}
