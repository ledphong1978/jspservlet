<%-- 
    Document   : save
    Created on : Jun 20, 2019, 4:26:44 PM
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
                String strFullName = request.getParameter("txtfullname");
                String strIDCard = request.getParameter("txtidcard");
                String strBirthday = request.getParameter("txtbirthday");
                String strBanID = request.getParameter("txtbanid");
                String strMoo = request.getParameter("txtmoo");
                String strTambon = request.getParameter("txttambon");
                String strAmphuer = request.getParameter("txtamphuer");
                String strProvince = request.getParameter("txtprovince");


                String sql = "UPDATE tblstom " +
                                "SET fullname = '"+ strFullName + "' " +
                                ", idcard = '"+ strIDCard + "' " +
                                ", birthday = '"+ strBirthday + "' " +
                                ", banid = '"+ strBanID + "' " +
                                ", moo = '"+ strMoo + "' " +
                                ", tambon = '"+ strTambon + "' " +
                                ", amphuer = '"+ strAmphuer + "' " +
                                ", province = '"+ strProvince + "' " +
                                " WHERE codepk = '" + strCustomerID + "' ";
                s.execute(sql);

                out.println("Record Update Successfully");
              
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
