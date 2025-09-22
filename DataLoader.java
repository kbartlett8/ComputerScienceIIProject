ackage com.vgb;
 
import java.io.File;
import java.io.FileNotFoundException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Scanner;
import java.util.UUID;
 
/**
 * Reads a csv data file or companies, people, and items and sorts its contents
 * into objects, ready to be used.
 */
public class DataLoader {
 
	public static Map<String, Company> loadCompanyData(String filePath, Map<String, Company> companyMap,
			Map<String, Person> personMap) {
		try {
			Scanner s = new Scanner(new File(filePath));
			s.nextLine();
			while (s.hasNextLine()) {
				String line = s.nextLine();
				if (!line.isEmpty()) {
					String tokens[] = line.split(",");
					UUID companyUUID = UUID.fromString(tokens[0]);
					String contactUUIDStr = tokens[1];
					String name = tokens[2];
					String street = tokens[3];
					String city = tokens[4];
					String state = tokens[5];
					String zip = tokens[6];
					Address address = new Address(street, city, state, zip);
					Person contactPerson = personMap.get(contactUUIDStr);
					Company c = new Company(companyUUID, contactPerson, name, address);
					companyMap.put(companyUUID.toString(), c);
				}
			}
			s.close();
		} catch (FileNotFoundException e) {
			System.err.println("Error: File not found :" + filePath);
		}
 
		return companyMap;
	}
 
	public static Map<String, Person> loadPersonData(String filePath, Map<String, Person> personMap) {
		try {
			Scanner s = new Scanner(new File(filePath));
			s.nextLine();
			while (s.hasNextLine()) {
				String line = s.nextLine().trim();
				if (!line.trim().isEmpty()) {
					String tokens[] = line.split(",", -1);
 
					UUID uuid = UUID.fromString(tokens[0]);
					String lastName = tokens[1];
					String firstName = tokens[2];
					String phoneNumber = tokens[3];
 
					List<String> emails = new ArrayList<>();
					int i = 4;
					while (i < tokens.length) {
						emails.add(tokens[i]);
						i++;
					}
					Person p = new Person(uuid, lastName, firstName, phoneNumber, emails);
					personMap.put(uuid.toString(), p);
				}
			}
			s.close();
		} catch (FileNotFoundException e) {
			System.err.println("Error: File not found");
		}
 
		return personMap;
	}
 
	public static Map<String, Item> loadItemData(String filePath, Map<String, Item> itemMap,
			Map<String, Company> companyMap) {
		try (Scanner s = new Scanner(new File(filePath))) {
			s.nextLine();
			while (s.hasNextLine()) {
				String[] tokens = s.nextLine().split(",");
				if (tokens.length < 3)
					continue;
 
				UUID uuid = UUID.fromString(tokens[0]);
				String name = tokens[2];
				Item item = null;
 
				if (tokens[1].equals("M") && tokens.length >= 5) {
					item = new Material(uuid, name, tokens[3], Double.parseDouble(tokens[4]));
				} else if (tokens[1].equals("E") && tokens.length >= 5) {
					item = new Equipment(uuid, name, tokens[3], Double.parseDouble(tokens[4]));
				} else if (tokens[1].equals("C") && tokens.length >= 4) {
					Company company = companyMap.get((String) tokens[3]);
					item = new Contract(uuid, name, company);
				}
 
				itemMap.put(uuid.toString(), item);
			}
		} catch (FileNotFoundException e) {
			System.err.println("Error: File not found: " + filePath);
		}
		return itemMap;
	}
 
	public static Map<String, Invoice> loadInvoiceData(String filePath, Map<String, Invoice> invoiceMap,
			Map<String, Company> companyMap, Map<String, Person> personMap) {
		try (Scanner s = new Scanner(new File(filePath))) {
			s.nextLine();
			while (s.hasNextLine()) {
				String[] tokens = s.nextLine().split(",");
				if (tokens.length < 4)
					continue;
 
				UUID invoiceUUID = UUID.fromString(tokens[0]);
				Company customer = companyMap.get(tokens[1]);
				Person salesPerson = personMap.get(tokens[2]);
				LocalDate date = LocalDate.parse(tokens[3]);
 
				Invoice invoice = new Invoice(invoiceUUID, date, customer, salesPerson);
				invoiceMap.put(invoiceUUID.toString(), invoice);
			}
		} catch (FileNotFoundException e) {
			System.err.println("Error: File not found: " + filePath);
		}
		return invoiceMap;
	}
 
	public static Map<String, Invoice> loadInvoiceItems(String filePath, Map<String, Invoice> invoiceMap,
			Map<String, Item> itemMap) {
		try (Scanner s = new Scanner(new File(filePath))) {
			s.nextLine();
			while (s.hasNextLine()) {
				String[] tokens = s.nextLine().split(",");
				if (tokens.length < 2)
					continue;
 
				UUID invoiceUUID = UUID.fromString(tokens[0]);
				UUID itemUUID = UUID.fromString(tokens[1]);
 
				Invoice invoice = invoiceMap.get(invoiceUUID.toString());
				Item item = itemMap.get(itemUUID.toString());
 
				if (invoice != null && item != null) {
					String action = tokens[2];
					switch (action) {
					case "R":
						double hours = Double.parseDouble(tokens[3]);
						invoice.addItem(new RentedItem(itemUUID, item.getName(), ((Equipment) item).getModelNumber(),
								((Equipment) item).getRetailPrice(), hours));
						break;
					case "L":
						LocalDate startDate = LocalDate.parse(tokens[3]);
						LocalDate endDate = LocalDate.parse(tokens[4]);
						invoice.addItem(new LeasedItem(itemUUID, item.getName(), ((Equipment) item).getModelNumber(),
								((Equipment) item).getRetailPrice(), startDate, endDate, 0.5));
						break;
					default:
						if (item instanceof Contract) {
							double cost = Double.parseDouble(tokens[2]);
							Contract newContract = new Contract(item.getUUID(), item.getName(),
									((Contract) item).getCompany());
							newContract.setContractAmount(cost);
							item = newContract;
						}
						if (item instanceof Material) {
							int quantity = Integer.parseInt(tokens[2]);
							item = new Material((Material) item, quantity);
						}
						invoice.addItem(item);
					}
				} else {
					System.err.println("ERROR - Missing invoice or item! Invoice UUID: " + invoiceUUID + ", Item UUID: "
							+ itemUUID);
				}
			}
		} catch (FileNotFoundException e) {
			System.err.println("Error: File not found: " + filePath);
		}
		return invoiceMap;
	}
	
}
