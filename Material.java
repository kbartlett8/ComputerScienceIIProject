package com.vgb;
 
import java.util.UUID;
 
/**
 * Represents a piece of material separates the material into uuid, type, name, unit, and cost.
 */
public class Material extends Item {
	private String unit;
	private double cost;
	private int quantity;
	final static double taxRate = 0.0715;
 
	public Material(UUID uuid, String name, String unit, double cost) {
		super(uuid, name);
		this.unit = unit;
		this.cost = cost;
	}
	
	public Material(Material material, int quantity) {
		this(material.getUUID(), material.getName(), material.getUnit(), material.getCost(), quantity);
	}
 
	public Material(UUID uuid, String name, String unit, double cost, int quantity) {
		super(uuid, name);
		this.unit = unit;
		this.cost = cost;
		this.quantity = quantity;
	}
	
 
	public String getUnit() {
		return unit;
	}
 
	public double getCost() {
		return cost;
	}
	
    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
	
    /**
     * Computes the subtotal of the a material.
     */
    public double computeSubtotal() {
        return roundToCent(cost * quantity);
    }
    
    /**
     * Computes the total tax of the a material.
     */
    public double computeTax() {
        return roundToCent(computeSubtotal() * taxRate);
    }
    
    /**
     * Computes the total cost of the a material.
     */
    public double computeTotalCost() {
        double subtotal = computeSubtotal();
        double tax = computeTax();
        return roundToCent(subtotal + tax);
    }
    
	/**
	 * Rounds a given value to 2 decimal places.
	 */
    private double roundToCent(double value) {
        return Math.round(value * 100.00) / 100.00;
    }
    
	public String toString() {
		return "Material [unit=" + unit + ", cost=" + cost + ", quantity=" + quantity + ", taxRate=" + taxRate
				+ ", getUnit()=" + getUnit() + ", getCost()=" + getCost() + ", getName()=" + getName() + "]";
	}
 
	public int getQuantity() {
		return quantity;
	}
 
	
	
}
