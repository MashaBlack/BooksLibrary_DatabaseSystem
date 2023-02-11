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
			String sql = "SELECT book.id 'id', book.title 'title', book.publishing_year 'year', genre.genre_name 'genre', GROUP_CONCAT(concat_ws(' ', author.first_name, author.patronymic, author.second_name) SEPARATOR ', ') 'authors', book_cover_type.cover_type 'cover_type', publishing_house.publishing_name 'publishing_house', book.ISBN 'ISBN' "
			+ "FROM book JOIN genre "
			+ "ON book.genre_id=genre.id "
			+ "JOIN book_author ON book.id=book_author.book_id "
			+ "JOIN author ON book_author.author_id=author.id "
			+ "JOIN book_cover_type ON book.cover_type_id=book_cover_type.id "
			+ "JOIN publishing_house ON book.publishing_house_id=publishing_house.id "
			+ "GROUP BY book.id "
			+ "ORDER BY(book.title)";
			ResultSet resTeams = statement.executeQuery(sql);
			JSONArray books = new JSONArray();
			while(resTeams.next()) {
				JSONObject obj = new JSONObject();
				obj.put("ID", resTeams.getString("id"));
				obj.put("Title", resTeams.getString("title"));
				obj.put("Year", resTeams.getString("year"));
				obj.put("Genre", resTeams.getString("genre"));
				obj.put("Authors", resTeams.getString("authors"));
				obj.put("CoverType", resTeams.getString("cover_type"));
				obj.put("PublishingHouse", resTeams.getString("publishing_house"));
				obj.put("Isbn", resTeams.getString("ISBN"));
				books.put(obj);
				}
			out.println(books);
		}
		catch(SQLException e) {
			e.printStackTrace();
			} 	
		%>