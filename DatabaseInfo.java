package com.vgb;
 
/**
 * Database connection configuration 
 */
public class DatabaseInfo {
 
	/**
	 * User name used to connect to the SQL server
	 */
	public static final String USERNAME = "User";
 
	/**
	 * Password used to connect to the SQL server
	 */
	public static final String PASSWORD = "Password";
 
	/**
	 * Connection parameters that may be necessary for server configuration
	 * 
	 */
	public static final String PARAMETERS = "";
 
	/**
	 * SQL Server to connect to
	 */
	public static final String SERVER = "nuros.unl.edu";
 
	/**
	 * Fully formatted URL for a JDBC connection
	 */
	public static final String URL = String.format("jdbc:mysql://%s/%s?%s", SERVER, USERNAME, PARAMETERS);
 
}
 
