<%-- 
    Document   : genid
    Created on : Jun 17, 2019, 6:17:00 PM
    Author     : ledphong
--%>
<%@ page import="java.sql.*"%>  

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
            PreparedStatement pstmt=null;
            ResultSet rs=null;
            
            try{
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
                
                String sql = "select max(codepk) from tblstom ";
                pstmt = connect.prepareStatement(sql);
                rs = pstmt.executeQuery();

                while(rs.next()){
                    int maxID = rs.getInt(1)+1;

                    System.out.println(String.valueOf(maxID));
                    String paded = String.format("%7s",String.valueOf(maxID)).replace(' ', '0');
                    System.out.println(paded);

                    String strx = (String.valueOf(maxID)+
                            "#"+String.valueOf(maxID)+
                            "#"+paded+
                            "#"+paded);
                    out.println(strx);
                }
            }catch(Exception e){e.printStackTrace();}  
            
        %>
    </body>
</html>
