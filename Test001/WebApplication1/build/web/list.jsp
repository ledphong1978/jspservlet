<%-- 
    Document   : list
    Created on : Jun 20, 2019, 2:52:15 PM
    Author     : ledphong
--%>

<%@page import="java.io.File"%>
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
            String keyword = "";
            if(request.getParameter("txtKeyword") != null) {
                keyword = request.getParameter("txtKeyword");
            }
        %>
        
    <center>
	<form name="frmSearch" method="get" action="list.jsp">
	  <table width="860" border="1">
	    <tr>
	      <th>ชื่อ
	      <input name="txtKeyword" type="text" id="txtKeyword" value="<%=keyword%>">
	      <input type="submit" value="ค้นหา"></th>
	    </tr>
	  </table>
	</form>
    </center>
    
    <center>
	<form name="frmExcel" method="get" action="list.jsp">
	  <table width="860" border="1">
	    <tr>
              <th>
	      <input type="submit" value="Excel"></th>
	    </tr>
	  </table>
	</form>
    </center>
              
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

                String sql = "SELECT * FROM  tblstom WHERE fullname like '%" +  keyword + "%' " + 
                        "ORDER BY codeid ASC";

                ResultSet rec = s.executeQuery(sql);
                              
	%>
        
        
        <center>
		<table width="860" border="1">
		  <tr>
		    <th width="91"> <div align="center">ลำดับที่ </div></th>
		    <th width="260"> <div align="center">ชื่อ-สกุล </div></th>
		    <th width="120"> <div align="center">เลขบัตร ปช. </div></th>
		    <th width="97"> <div align="center">วันเกิด </div></th>
		    <th width="100"> <div align="center">บ้านเลขที่ </div></th>
		    <th width="71"> <div align="center">หมู่ที่ </div></th>
                    <th width="120"> <div align="center">แก้ไข / ลบ </div></th>
		  </tr>	
                    <%while((rec!=null) && (rec.next())) { %>
                        <tr>
                            <td><div align="center"><%=rec.getInt("codepk")%></div></td>
                            <td><%=rec.getString("fullname")%></td>
                            <td><%=rec.getString("idcard")%></td>
                            <td><div align="center"><%=rec.getString("birthday")%></div></td>
                            <td align="right"><%=rec.getString("banid")%></td>
                            <td align="right"><%=rec.getString("moo")%></td>
                            <td align="center"> <a href="update.jsp?CusID=<%=rec.getString("codepk")%>">Edit</a>
                                <a href="del.jsp?CusID=<%=rec.getString("codepk")%>">Del</a>
                            </td>
                        </tr>
                    <%}%>
	  	</table>  
        </center>
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
