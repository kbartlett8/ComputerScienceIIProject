package com.vgb;
 
import java.util.UUID;
 
/**
 * Represents a company and separates the company into the UUID, contact UUID, name and address 
 * and puts them into objects
 * Includes subclass for the address.
 */
public class Company {
	private UUID companyUUID;
	private Person contact;
	private String name;
	private Address address;
	
    public Company(UUID companyUUID, Person contact, String name, Address address) {
        this.companyUUID = companyUUID;
        this.contact = contact;
        this.name = name;
        this.address = address;
    }
	public UUID getUuid() {
		return companyUUID;
	}
 
	public Person getPerson() {
		return contact;
	}
 
	public String getName() {
		return name;
	}
 
	public Address getAddress() {
		return address;
	}
	
	public String toString() {
		return "Company [companyUUID=" + companyUUID + ", contactUUID=" + contact + ", name=" + name + ", address="
				+ address + ", getUuid()=" + getUuid() + ", getContactUUID()=" + getPerson() + ", getName()="
				+ getName() + ", getAddress()=" + getAddress() + "]";
	}
 
}
