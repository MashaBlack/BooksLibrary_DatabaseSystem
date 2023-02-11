<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8"
    import="java.sql.*"
    import="org.json.*"%>
<%  
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
			String AuthorId = request.getParameter("authorID");
			String sql = "DELETE FROM author WHERE id =" + AuthorId;
			statement.executeUpdate(sql);
		}
		catch(SQLException e) {
			e.printStackTrace();
			} 	
		%>