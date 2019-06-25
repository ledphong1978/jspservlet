<%-- 
    Document   : scan
    Created on : Jun 16, 2019, 7:04:52 PM
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
        <title>Index JSP Page</title>        
        <script>
         function Smartcard(){
	    var request = new XMLHttpRequest();
	    request.onreadystatechange = function(){
	       if(this.readyState == 4 && this.status == 200){
                    var response = this.responseText;
                    document.querySelector('#txtfullname').value =response.split("#")[1]; 
                    document.querySelector('#txtidcard').value =response.split("#")[2];
                    document.querySelector('#txtbirthday').value =response.split("#")[3];
                    document.querySelector('#txtbanid').value =response.split("#")[4];
                    document.querySelector('#txtmoo').value =response.split("#")[5];
                    document.querySelector('#txttambon').value =response.split("#")[6];
                    document.querySelector('#txtamphuer').value =response.split("#")[7];
                    document.querySelector('#txtprovince').value =response.split("#")[8];
	       }
            };
            request.open("GET", "details.jsp", true);
	    request.send();
            GenID();
         }
         
         function GenID(){
            var request = new XMLHttpRequest();
	    request.onreadystatechange = function(){
                if(this.readyState == 4 && this.status == 200){
                    var response = this.responseText;
                    document.querySelector('#txtcodepk').value =response.split("#")[1];
                    document.querySelector('#txtcodeid').value =response.split("#")[2];
                }
            };
            request.open("GET", "genid.jsp", true);
	    request.send();
         }
         
        function Refresh(){
            document.querySelector('#txtcodepk').value ='';
            document.querySelector('#txtcodeid').value ='';
            document.querySelector('#txtfullname').value =''; 
            document.querySelector('#txtidcard').value ='';
            document.querySelector('#txtbirthday').value ='';
            document.querySelector('#txtbanid').value ='';
            document.querySelector('#txtmoo').value ='';
            document.querySelector('#txttambon').value ='';
            document.querySelector('#txtamphuer').value ='';
            document.querySelector('#txtprovince').value ='';
            //$('#comment').val('');
        }
         
        
                 
      </script> 
            
    </head>
    <body>
        
        <form name="frmAdd" method="post" action="./InsertData"> 
        <h1>Hello World!</h1>
        ลำดับที่............................:<input name="txtcodepk" type="text" id="txtcodepk" value=""><br><br>
        codeid.............................:<input name="txtcodeid" type="text" id="txtcodeid" value=""><br><br>
        ชื่อ-สกุล..........................:<input name="txtfullname" type="text" id="txtfullname" value=""><br><br>
        เลขบัตรประชาชน..........: <input name="txtidcard" type="text" id="txtidcard" value=""><br><br>
        วันเกิด............................: <input name="txtbirthday" type="text" id="txtbirthday" value=""><br><br>
        บ้านเลขที่......................: <input name="txtbanid" type="text" id="txtbanid" value=""><br><br>
        หมู่ที่..............................: <input name="txtmoo" type="text" id="txtmoo" value=""><br><br>
        ตำบล............................: <input name="txttambon" type="text" id="txttambon" value=""><br><br>
        อำเภอ...........................: <input name="txtamphuer" type="text" id="txtamphuer" value=""><br><br>
        จังหวัด..........................: <input name="txtprovince" type="text" id="txtprovince" value=""><br><br>
        
        <input type="submit" value="Save">
        </form>
        <br>
        <br><button onclick="Smartcard()">อ่านบัตรประชาชน</button>
        <button onclick="GenID()">GenID</button>
        <button onclick="Refresh()">รีเฟรซ</button>
                        
    </body>
</html>
