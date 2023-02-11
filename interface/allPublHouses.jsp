<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8"
    import="java.sql.*"
    import="org.json.*"%>
<%  
response.setHeader("Cache-Control", "no-cache");


try {
    Class.forName("com.mysql.jdbc.Driver");
} catch (ClassNotFoundException e) {
	e.printStackTrace();
}
		try {
			Connection connection_;
			String dbms = "jdbc:mysql://localhost:3306/books";
			connection_ = DriverManager.getConnection(dbms, "root", "root");
			Statement statement = connection_.createStatement();
			String sql = "SELECT publishing_house.id 'id', publishing_house.publishing_name 'name', publishing_house.phone 'phone', publishing_house.email 'email', GROUP_CONCAT(book.title SEPARATOR ', ') 'books' "
			+ "FROM book RIGHT JOIN publishing_house "
			+ "ON book.publishing_house_id=publishing_house.id "
			+ "GROUP BY publishing_house.id "
			+ "ORDER BY(publishing_house.publishing_name)";
			ResultSet resTeams = statement.executeQuery(sql);
			JSONArray publHouses = new JSONArray();
			while(resTeams.next()) {
				JSONObject obj = new JSONObject();
				obj.put("ID", resTeams.getString("id"));
				obj.put("Name", resTeams.getString("name"));
				obj.put("Email", resTeams.getString("email"));
				obj.put("Phone", resTeams.getString("phone"));
				obj.put("Books", resTeams.getString("books"));
				publHouses.put(obj);
				}
			out.println(publHouses);
		}
		catch(SQLException e) {
			e.printStackTrace();
			} 	
		%>