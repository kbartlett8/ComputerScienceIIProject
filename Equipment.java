package com.vgb;

import java.util.UUID;

/**
 * Represents a piece of equipment and separates the equipment into uuid, type, name, model number,
 * and retail price.
 */
public class Equipment extends Item {
	private String modelNumber;
	private double retailPrice;
    final private double taxRate = 0.0525;
    
    public Equipment(UUID uuid, String name, String modelNumber, double retailPrice) {
		super(uuid, name);
		this.modelNumber = modelNumber;
		this.retailPrice = retailPrice;
	}
    
    public Equipment(Item i, double retailPrice) {
		super(i.getUUID(),i.getName());
		this.retailPrice = retailPrice;
	}

	public String getModelNumber() {
		return modelNumber;
	}

	public double getRetailPrice() {
		return retailPrice;
	}
	
    /**
     * Computes the total cost of the equipment.
     */
    public double computeTotalCost() {
    	return roundToCent(retailPrice + computeTax());
    }
    
    /**
     * Computes the total tax of the equipment.
     */
    public double computeTax() {
        return roundToCent(retailPrice * taxRate);
    }

    /**
     * Computes the subtotal of the equipment.
     */
    public double computeSubtotal() {
        return retailPrice;
    }
    
	/**
	 * Rounds a given value to 2 decimal places.
	 */
    private double roundToCent(double value) {
        return Math.round(value * 100.0) / 100.0;
    }

	public String toString() {
		return "Equipment [modelNumber=" + modelNumber + ", retailPrice=" + retailPrice + ", taxRate=" + taxRate
				+ ", getName()=" + getName() + "]";
	}

}
package com.vgb;
 
import java.util.UUID;
 
/**
 * Represents a piece of equipment and separates the equipment into uuid, type, name, model number,
 * and retail price.
 */
public class Equipment extends Item {
	private String modelNumber;
	private double retailPrice;
    final private double taxRate = 0.0525;
    
    public Equipment(UUID uuid, String name, String modelNumber, double retailPrice) {
		super(uuid, name);
		this.modelNumber = modelNumber;
		this.retailPrice = retailPrice;
	}
    
    public Equipment(Item i, double retailPrice) {
		super(i.getUUID(),i.getName());
		this.retailPrice = retailPrice;
	}
 
	public String getModelNumber() {
		return modelNumber;
	}
 
	public double getRetailPrice() {
		return retailPrice;
	}
	
    /**
     * Computes the total cost of the equipment.
     */
    public double computeTotalCost() {
    	return roundToCent(retailPrice + computeTax());
    }
    
    /**
     * Computes the total tax of the equipment.
     */
    public double computeTax() {
        return roundToCent(retailPrice * taxRate);
    }
 
    /**
     * Computes the subtotal of the equipment.
     */
    public double computeSubtotal() {
        return retailPrice;
    }
    
	/**
	 * Rounds a given value to 2 decimal places.
	 */
    private double roundToCent(double value) {
        return Math.round(value * 100.0) / 100.0;
    }
 
	public String toString() {
		return "Equipment [modelNumber=" + modelNumber + ", retailPrice=" + retailPrice + ", taxRate=" + taxRate
				+ ", getName()=" + getName() + "]";
	}
 
}
