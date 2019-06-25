<%-- 
    Document   : add
    Created on : Jun 19, 2019, 3:40:53 PM
    Author     : ledphong
--%>

<%@page import="java.sql.PreparedStatement"%>
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
	String CusID = "";
	if(request.getParameter("txtcudepk") != null) {
            CusID = request.getParameter("txtcodepk");
	}
	
	Connection connect = null;
	Statement s = null;
        PreparedStatement pstmt=null;
	
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
		
		int strCodePK = Integer.parseInt(request.getParameter("txtcodepk"));
		String strCodeID = request.getParameter("txtcodeid");
		String strFullName = request.getParameter("txtfullname");
		String strIDCard = request.getParameter("txtidcard");
		String strBirthday = request.getParameter("txtbirthday");
		String strBanID = request.getParameter("txtbanid");
                String strMoo = request.getParameter("txtmoo");
                String strTambon = request.getParameter("txttambon");
                String strAmphuer = request.getParameter("txtamphuer");
                String strProvince = request.getParameter("txtprovince");
                
		pstmt = connect.prepareStatement("insert into tblstom "+
                        "(codepk,codeid,fullname,idcard,birthday,banid,moo,tambon,amphuer,province)"+
                        "values (?,?,?,?,?,?,?,?,?,?)");

                pstmt.setInt(1, strCodePK);
                pstmt.setString(2, strCodeID);
                pstmt.setString(3, strFullName);
                pstmt.setString(4, strIDCard);
                pstmt.setString(5, strBirthday);
                pstmt.setString(6, strBanID);
                pstmt.setString(7, strMoo);
                pstmt.setString(8, strTambon);
                pstmt.setString(9, strAmphuer);
                pstmt.setString(10, strProvince);
                
                pstmt.executeUpdate();
         
        
                out.println("Record Inserted Successfully");
        
	  		
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