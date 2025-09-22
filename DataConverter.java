package com.vgb;
 
import java.io.File;
import java.io.FileNotFoundException;
import java.util.HashMap;
import java.util.Map;
import java.util.Scanner;
import com.google.gson.Gson; 
import com.google.gson.GsonBuilder;
import java.io.FileWriter;
import java.io.IOException;
 
/**
 * 
 * Converts and prints out data to JSON format.
 */
public class DataConverter {
	/**
	 * Reads a file and outputs the data as a JSON file.
	 * 
	 */
	public static void outputJson(String fileName, Object data) {
		Gson gson = new GsonBuilder().setPrettyPrinting().create();
	    File dataFolder = new File("data");
 
		File outputFile = new File(dataFolder, fileName);
		
		try(FileWriter output = new FileWriter(outputFile)){
			gson.toJson(data, output);
		} catch (IOException e) {
			System.err.println("Error outputing Json.");
		}
		
	}
	
	/**
	 * Reads the file and prints its contents.
	 */
	public static void printFile(String filePath) {
		try(Scanner s = new Scanner(new File(filePath))) {
			while(s.hasNextLine()) {
				System.out.println(s.nextLine());
			}
		} catch (FileNotFoundException e) {
	        System.err.println("Error: File not found: " + filePath);
		}
	}
	
	public static void main (String [] args) {
		
		String dataFile1 = "data/Persons.csv";
		String dataFile2 = "data/Companies.csv";
		String dataFile3 = "data/Items.csv";
		
	    System.out.println("Contents of Persons.csv:");
	    printFile(dataFile1);
	    System.out.println("\nContents of Companies.csv:");
	    printFile(dataFile2);
	    System.out.println("\nContents of Items.csv:");
	    printFile(dataFile3);
	    
	    Map<String, Person> people = DataLoader.loadPersonData(dataFile1, new HashMap<>());
	    Map<String, Company> companies = DataLoader.loadCompanyData(dataFile2, new HashMap<>(), people);
	    Map<String, Item> items = DataLoader.loadItemData(dataFile3, new HashMap<>(), companies);
 
		outputJson("Persons.json", people);
		outputJson("Companies.json", companies);
		outputJson("Items.json", items);

	}
	
}
