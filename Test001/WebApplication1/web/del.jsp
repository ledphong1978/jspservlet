<%-- 
    Document   : del
    Created on : Jun 20, 2019, 5:28:14 PM
    Author     : ledphong
--%>

<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("utf-8");%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%	
            Connection connect = null;
            Statement s = null;

            try {
                try{
                    Class.forName("org.postgresql.Driver");
                }catch(ClassNotFoundException e){
                    System.out.println(e.getMessage());
                }

                try{
                    connect  = DriverManager.getConnection("jdbc:postgresql://127.0.0.1:5432/dbstom", "postgres","gomplayer");
                }catch(SQLException e){
                    System.out.println(e.getMessage());
                }

                s = connect.createStatement();

                String strCustomerID = request.getParameter("CusID");


                String sql = "DELETE FROM tblstom " +
                                " WHERE codepk = '" + strCustomerID + "' ";
                s.execute(sql);

                out.println("Record Delete Successfully");
                
                %>
                    <br>
                    <a href="list.jsp"><h1>กลับไปที่ list.jsp</h1></a>
                <%

            } catch (Exception e) {
                // TODO Auto-generated catch block
                out.println(e.getMessage());
                e.printStackTrace();
            }

            try {
                if(s!=null){
                    s.close();
                    connect.close();
                }
            } catch (SQLException e) {
                // TODO Auto-generated catch block
                out.println(e.getMessage());
                e.printStackTrace();
            }
	%>
    </body>
</html>
