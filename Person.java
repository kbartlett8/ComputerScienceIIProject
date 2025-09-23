package com.vgb;
 
import java.util.List;
import java.util.UUID;
 
/**
 * Represents a person with a first and last name, UUID, emails and puts them into objects
 */
public class Person {
	private UUID uuid;
	private String firstName;
	private String lastName;
	private String phoneNumber;
	private List<String> emails;
	
	public Person(UUID uuid, String lastName, String firstName, String phoneNumber, List<String> emails) {
		super();
		this.uuid = uuid;
		this.firstName = firstName;
		this.lastName = lastName;
		this.phoneNumber = phoneNumber;
		this.emails = emails;
	}
 
	public List<String> getEmails() {
		return emails;
	}
 
	public String getFirstName() {
		return firstName;
	}
	public String getPhoneNumber() {
		return phoneNumber;
	}
 
	public String getLastName() {
		return lastName;
	}
 
	public UUID getUuid() {
		return uuid;
	}
 
	public String toString() {
		return "Person [uuid=" + uuid + ", firstName=" + firstName + ", lastName=" + lastName + ", phoneNumber="
				+ phoneNumber + ", emails=" + emails + "]";
	}
}
