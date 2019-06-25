
package com.java.myapp;

import java.io.IOException; 
import java.io.PrintStream;
import java.io.PrintWriter; 
import java.sql.Connection; 
import java.sql.PreparedStatement; 
  
import javax.servlet.ServletException; 
import javax.servlet.annotation.WebServlet; 
import javax.servlet.http.HttpServlet; 
import javax.servlet.http.HttpServletRequest; 
import javax.servlet.http.HttpServletResponse; 
  
// Import Database Connection Class file 
//import code.DatabaseConnection; 
//import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;
  
// Servlet Name 
@WebServlet("/InsertData") 
public class InsertData extends HttpServlet { 
    private static final long serialVersionUID = 1L; 
    Connection connect = null;
    Statement s = null;
    PreparedStatement pstmt=null;
    
    @Override
    @SuppressWarnings("null")
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
    { 
        try { 
                                  
            connect = DatabaseConnection.initializeDatabase();
            request.setCharacterEncoding("UTF-8");
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
            // Close all the connections 
            pstmt.close(); 
            connect.close(); 
  
            // Get a writer pointer  
            // to display the succesful result 
            response.setContentType("text/html; charset=UTF-8");
            response.setCharacterEncoding("UTF-8");
            PrintWriter out = response.getWriter(); 
            //PrintStream out = new PrintStream(out, true, "UTF-8");
            out.println("<html><body><b>Successfully Inserted" +                     
                        "<br>" +
                        "<a href=\"list.jsp\"><h1>กลับไปที่ list.jsp </h1></a>\n" +                
                        "</b></body></html>"); 
            
        } 
        catch (IOException | NumberFormatException | SQLException e) { 
            e.printStackTrace(); 
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(InsertData.class.getName()).log(Level.SEVERE, null, ex);
        } 
    } 
} 
