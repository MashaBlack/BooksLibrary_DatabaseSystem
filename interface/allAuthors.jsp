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
			String sql = "SELECT author.id 'id', CONCAT(first_name, ' ', patronymic, ' ', second_name) author, author.second_name 'second_name', GROUP_CONCAT(book.title SEPARATOR ', ') 'books' "
			+ "FROM book JOIN book_author "
			+ "ON book.id=book_author.book_id "
			+ "RIGHT JOIN author ON book_author.author_id=author.id "
			+ "GROUP BY author.id "
			+ "ORDER BY(author.second_name)";
			ResultSet resTeams = statement.executeQuery(sql);
			JSONArray authors = new JSONArray();
			while(resTeams.next()) {
				JSONObject obj = new JSONObject();
				obj.put("ID", resTeams.getString("id"));
				obj.put("Author", resTeams.getString("author"));
				obj.put("Books", resTeams.getString("books"));
				authors.put(obj);
				}
			out.println(authors);
		}
		catch(SQLException e) {
			e.printStackTrace();
			} 	
		%>