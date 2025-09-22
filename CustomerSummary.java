package com.vgb;
 
public class CustomerSummary {
    private String name;
    private int count;
    private double total;
 
    public CustomerSummary(String name, int count, double total) {
        this.name = name;
        this.count = count;
        this.total = total;
    }
 
    public String getName() {
        return name;
    }
 
    public int getCount() {
        return count;
    }
 
    public double getTotal() {
        return total;
    }
 
    public String toString() {
        return String.format("%-25s %-20d $%10.2f", name, count, total);
    }
}
