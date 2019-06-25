<%-- 
    Document   : update
    Created on : Jun 20, 2019, 4:26:31 PM
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
		
		String sql = "SELECT * FROM  tblstom WHERE codepk = '" + strCustomerID + "'  ";
		
		ResultSet rec = s.executeQuery(sql);
		if(rec != null) {
			rec.next();
        %>
	<form name="frmUpdate" method="post" action="save.jsp?CusID=<%=rec.getString("codepk")%>">	
            <h1>Update Form</h1>
                <br>
                ลำดับที่............................:<input name="txtcodepk" type="text" id="txtcodepk" value="<%=rec.getString("codepk")%>"><br><br>
                codeid.............................:<input name="txtcodeid" type="text" id="txtcodeid" value="<%=rec.getString("codeid")%>"><br><br>
                ชื่อ-สกุล..........................:<input name="txtfullname" type="text" id="txtfullname" value="<%=rec.getString("fullname")%>"><br><br>
                เลขบัตรประชาชน..........: <input name="txtidcard" type="text" id="txtidcard" value="<%=rec.getString("idcard")%>"><br><br>
                วันเกิด............................: <input name="txtbirthday" type="text" id="txtbirthday" value="<%=rec.getString("birthday")%>"><br><br>
                บ้านเลขที่......................: <input name="txtbanid" type="text" id="txtbanid" value="<%=rec.getString("banid")%>"><br><br>
                หมู่ที่..............................: <input name="txtmoo" type="text" id="txtmoo" value="<%=rec.getString("moo")%>"><br><br>
                ตำบล............................: <input name="txttambon" type="text" id="txttambon" value="<%=rec.getString("tambon")%>"><br><br>
                อำเภอ...........................: <input name="txtamphuer" type="text" id="txtamphuer" value="<%=rec.getString("amphuer")%>"><br><br>
                จังหวัด..........................: <input name="txtprovince" type="text" id="txtprovince" value="<%=rec.getString("province")%>"><br><br>
            <input type="submit" value="Save">
        </form> 
		
		<% }
	  		
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
