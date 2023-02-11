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
		int count = Integer.parseInt(request.getParameter("count"));
		int i=0;
		String result = "(";
		while (i < count){
			String str = "author" + (i+1);
			if (i != count-1){
				result += request.getParameter(str) + ", ";
			} else{
				result += request.getParameter(str);
			}
			i++;
		}
		result += ")";
		String authors_req = "SELECT id, CONCAT(first_name, ' ', patronymic, ' ', second_name) author FROM author WHERE id NOT IN" + result;
		ResultSet res_authors_req = statement.executeQuery(authors_req);
		JSONObject res = new JSONObject();
		JSONArray author = new JSONArray();
		while(res_authors_req.next())
		{
		JSONObject obj = new JSONObject();
		obj.put("author_id", res_authors_req.getString("id"));
		obj.put("author_name", res_authors_req.getString("author"));
		author.put(obj);
		}
		res.put("author", author);

		out.print(res);
	} finally {}
%>