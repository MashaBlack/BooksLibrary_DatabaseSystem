<%@page contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="org.json.*"%>
<%

	try{
		Class.forName("com.mysql.jdbc.Driver");
	}
	catch(ClassNotFoundException exc){exc.printStackTrace();}
	
	try{
		Connection connection_;
		String dbms = "jdbc:mysql://localhost:3306/books";
		connection_ = DriverManager.getConnection(dbms, "root", "root");
		Statement statement = connection_.createStatement();	
		String title_book = request.getParameter("title");
		String genre_id = request.getParameter("genre");
		String year = request.getParameter("year");
		String house_id = request.getParameter("house");
		String ISBN = request.getParameter("ISBN");
		String cover_id = request.getParameter("cover");
		int count = Integer.parseInt(request.getParameter("count"));
		String add_book_req = "INSERT INTO book(title, genre_id, publishing_year, publishing_house_id, ISBN, cover_type_id) VALUES('" + title_book + "', " + genre_id + ", " + year + ", " + house_id + ", '" + ISBN + "', " + cover_id + ")";
		statement.executeUpdate(add_book_req);		
		String get_id_req = "SELECT id FROM book WHERE ISBN = '" + ISBN + "'";		
		ResultSet res_get_id_req = statement.executeQuery(get_id_req);
		int book_id = res_get_id_req.next()?res_get_id_req.getInt("id"):1;
		int i=0;
		while (i < count){
			String str = "author" + (i+1);
			String author_id = request.getParameter(str);
			String book_author_req = "INSERT INTO book_author(book_id, author_id) VALUES(" + book_id + ", " + author_id + ")";
			statement.executeUpdate(book_author_req);
			i++;
		}
	
	} catch(SQLException e){
		e.printStackTrace();
}
%>