package com.vgb;
 
import java.util.UUID;
 
/**
 * Represents an Item with a UUID, type, name and puts them into objects
 * sub class for type:
 * separates in for equipment, material, and contracts
 */
public abstract class Item {
	private UUID uuid;
	private String name;
	
	/**
	 * Method to compute the subtotal of the item
	 */
	protected abstract double computeSubtotal();
	
	/**
	 * Method to compute the tax of the item
	 */
	protected abstract double computeTax();
	
	/**
	 * Method to compute the cost plus the tax of the item
	 */
    protected abstract double computeTotalCost(); 
 
	public Item(UUID uuid, String name) {
		this.uuid = uuid;
		this.name = name;
	}
	
	public UUID getUUID() {
		return uuid;
	}
 
	public String getName() {
		return name;
	}
	
	public String toString() {
		return "Item [uuid=" + uuid + ", name=" + name + "]";
	}
}
