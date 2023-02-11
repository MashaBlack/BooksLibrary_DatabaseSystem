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
				
		String genres_req = "SELECT id, genre_name "
				          + "FROM genre";
		ResultSet res_genres_req = statement.executeQuery(genres_req);
		JSONObject result = new JSONObject();
		JSONArray genres = new JSONArray();			
		while(res_genres_req.next())
		{
			JSONObject obj = new JSONObject();
			obj.put("genre_id", res_genres_req.getString("id"));
			obj.put("genre_name", res_genres_req.getString("genre_name"));
			genres.put(obj);
		}
		result.put("genre", genres);
		
		String publ_house_req = "SELECT id, publishing_name "
						      + "FROM publishing_house";
		ResultSet res_publ_house_req = statement.executeQuery(publ_house_req);		
		JSONArray publ_houses = new JSONArray();
		while(res_publ_house_req.next())
		{
			JSONObject obj = new JSONObject();
			obj.put("publ_house_id", res_publ_house_req.getString("id"));
			obj.put("publ_house_name", res_publ_house_req.getString("publishing_name"));
			publ_houses.put(obj);
		}
		result.put("publishing_house", publ_houses);
		
		String cover_type_req = "SELECT id, cover_type "
						      + "FROM book_cover_type";
		ResultSet res_cover_type_req = statement.executeQuery(cover_type_req);		
		JSONArray cover = new JSONArray();
		while(res_cover_type_req.next())
		{
			JSONObject obj = new JSONObject();
			obj.put("cover_id", res_cover_type_req.getString("id"));
			obj.put("cover_type", res_cover_type_req.getString("cover_type"));
			cover.put(obj);
		}
		result.put("cover", cover);
		
		String authors_req = "SELECT id, CONCAT(first_name, ' ', patronymic, ' ', second_name) author FROM author";
		ResultSet res_authors_req = statement.executeQuery(authors_req);		
		JSONArray author = new JSONArray();
		while(res_authors_req.next())
		{
		JSONObject obj = new JSONObject();
		obj.put("author_id", res_authors_req.getString("id"));
		obj.put("author_name", res_authors_req.getString("author"));
		author.put(obj);
		}
		result.put("author", author);

		out.print(result);
	} finally {}
%>