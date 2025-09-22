package com.vgb;

import java.util.UUID;

/**
 * Represents a Contract and separates the contract into uuid, type, name, and company uuid.
 */
public class Contract extends Item {
	private Company company;
    private double contractAmount;

	public Contract(UUID uuid, String name, Company company) {
		super(uuid, name);
		this.company = company;
	}
	
	public Contract(UUID uuid, String name, Company company, double contractAmount) {
		this(uuid, name, company);
		this.contractAmount = contractAmount;
	}
	
	public Contract(Contract item, double contractAmount) {
		this(item.getUUID(), item.getName(), item.getCompany());
		this.contractAmount = contractAmount;
	}

	public Company getCompany() {
		return company;
	}
	
    public double getContractAmount() {
		return contractAmount;
	}

	public void setContractAmount(double contractAmount) {
        this.contractAmount = contractAmount;
    }
	
    /**
     * Computes the total cost of the contract.
     */
    public double computeTotalCost() {
        return computeSubtotal();
    }
    
    /**
     * Computes the total tax of the contract.
     */
    public double computeTax() {
        return 0;
    }
    
    /**
     * Computes the subtotal cost of the contract.
     */
    public double computeSubtotal() {
        return contractAmount;
    }

	public String toString() {
	    return "Contract [companyName=" + company.getName() + 
	            ", companyAddress=" + company.getAddress().toString() + 
	            ", contactPerson=" + company.getPerson().getFirstName() + " " + company.getPerson().getLastName() + 
	            ", contractAmount=" + contractAmount + 
	            ", contractName=" + getName() + "]";
	}
}
package com.vgb;
 
import java.util.UUID;
 
/**
 * Represents a Contract and separates the contract into uuid, type, name, and company uuid.
 */
public class Contract extends Item {
	private Company company;
    private double contractAmount;
 
	public Contract(UUID uuid, String name, Company company) {
		super(uuid, name);
		this.company = company;
	}
	
	public Contract(UUID uuid, String name, Company company, double contractAmount) {
		this(uuid, name, company);
		this.contractAmount = contractAmount;
	}
	
	public Contract(Contract item, double contractAmount) {
		this(item.getUUID(), item.getName(), item.getCompany());
		this.contractAmount = contractAmount;
	}
 
	public Company getCompany() {
		return company;
	}
	
    public double getContractAmount() {
		return contractAmount;
	}
 
	public void setContractAmount(double contractAmount) {
        this.contractAmount = contractAmount;
    }
	
    /**
     * Computes the total cost of the contract.
     */
    public double computeTotalCost() {
        return computeSubtotal();
    }
    
    /**
     * Computes the total tax of the contract.
     */
    public double computeTax() {
        return 0;
    }
    
    /**
     * Computes the subtotal cost of the contract.
     */
    public double computeSubtotal() {
        return contractAmount;
    }
 
	public String toString() {
	    return "Contract [companyName=" + company.getName() + 
	            ", companyAddress=" + company.getAddress().toString() + 
	            ", contactPerson=" + company.getPerson().getFirstName() + " " + company.getPerson().getLastName() + 
	            ", contractAmount=" + contractAmount + 
	            ", contractName=" + getName() + "]";
	}
}
