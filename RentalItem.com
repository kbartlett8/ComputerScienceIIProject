package com.vgb;
 
import java.util.UUID;
 
/**
 * Represents a piece of rented equipment and add the amount of hours and tax rate for rented equipment.
 */
public class RentedItem extends Equipment {
    private double hours;
    final private double taxRate = 0.0438;
 
    public RentedItem(UUID uuid, String name, String modelNumber, double retailPrice, double hours) {
        super(uuid, name, modelNumber, retailPrice);
        this.hours = hours;
    }
    
    /**
     *Computes the total cost of renting the equipment, rounded to the nearest cent.
     */
    public double computeTotalCost() {
        return roundToCent(computeSubtotal());
    }
    
    /**
     *Computes the total tax of renting the equipment, rounded to the nearest cent.
     */
	public double computeTax() {
		return roundToCent(computeSubtotal() * taxRate);
	}
	
    /**
     *Computes the subtotal of renting the equipment.
     */
	public double computeSubtotal() {
		return computePerHourRate() * hours;
	}
 
    /**
     *Computes the per hour rate of renting the equipment.
     */
	public double computePerHourRate() {
		return getRetailPrice() * 0.001;
	}
	
	/**
	 * Rounds a given value to 2 decimal places.
	 */
    private double roundToCent(double value) {
        return Math.round(value * 100.0) / 100.0;
    }
    
	
	public double getHours() {
		return hours;
	}
 
 
	public String toString() {
	    String formattedCost = String.format("%.2f", getRetailPrice());  
 
		return "RentedItem [hours=" + hours + ", taxRate=" + taxRate + ", getModelNumber()=" + getModelNumber()
				+ ", getRetailPrice()=" + formattedCost + ", getName()=" + getName() + "]";
	}
}
