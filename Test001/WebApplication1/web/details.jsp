<%-- 
    Document   : details
    Created on : Jun 17, 2019, 3:34:14 PM
    Author     : ledphong
--%>

<%@ page import= "java.util.List" %>
<%@ page import= "javax.smartcardio.Card" %>
<%@ page import= "javax.smartcardio.CardChannel" %>
<%@ page import= "javax.smartcardio.CardException" %>
<%@ page import= "javax.smartcardio.CardTerminal" %>
<%@ page import= "javax.smartcardio.CommandAPDU" %>
<%@ page import= "javax.smartcardio.ResponseAPDU" %>
<%@ page import= "javax.smartcardio.TerminalFactory" %>
<%@ page import="com.java.myapp.Main" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("utf-8");%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Details JSP Page</title>
    </head>
    <body>
        <%
                        
            try {
                // Show the list of available terminals
                // On Windows see HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Cryptography\Calais\Readers
                TerminalFactory factory = TerminalFactory.getDefault();
                List terminals = factory.terminals().list();
                System.out.println("Terminals count: " + terminals.size());
                System.out.println("Terminals: " + terminals);

                // Get the first terminal in the list
                CardTerminal terminal = (CardTerminal) terminals.get(0);

                // Establish a connection with the card using
                // "T=0", "T=1", "T=CL" or "*"
                Card card = terminal.connect("*");
                System.out.println("Card: " + card);

                // Get ATR
                byte[] baATR = card.getATR().getBytes();
                //out.println("ATR: " + Main.toString(baATR) );

                // Select Card Manager
                // - Establish channel to exchange APDU
                // - Send SELECT Command APDU
                // - Show Response APDU
                CardChannel channel = card.getBasicChannel();

                //SELECT Command
                // See GlobalPlatform Card Specification (e.g. 2.2, section 11.9)
                // CLA: 00
                // INS: A4
                // P1: 04 i.e. b3 is set to 1, means select by name
                // P2: 00 i.e. first or only occurence
                // Lc: 08 i.e. length of AID see below
                // Data: A0 00 00 00 03 00 00 00
                // AID of the card manager,
                // in the future should change to A0 00 00 01 51 00 00
                // อ่านค่า Select
                byte[] baCommandAPDU = {
                    (byte) 0x00, (byte) 0xA4, (byte) 0x04, 
                    (byte) 0x00, (byte) 0x08, (byte) 0xA0, 
                    (byte) 0x00, (byte) 0x00, (byte) 0x00, 
                    (byte) 0x54, (byte) 0x48, (byte) 0x00, 
                    (byte) 0x01
                };
                System.out.println("APDU <<<: " + Main.toString(baCommandAPDU));

                ResponseAPDU r = channel.transmit(new CommandAPDU(baCommandAPDU));
                //out.println("APDU >>>: " + Main.toString(r.getBytes()));
                // อ่านเลขบัตรประชาชน
                byte[] command_idcard = {
                    (byte) 0x80, (byte) 0xb0, (byte) 0x00,
                    (byte) 0x04, (byte) 0x02, (byte) 0x00,
                    (byte) 0x0d
                };
                System.out.println("APDU <<<:: " + Main.toString(command_idcard));
                ResponseAPDU response_command_idcard = channel.transmit(new CommandAPDU(command_idcard));
                System.out.println("APDU >>>: " + Main.toString(response_command_idcard.getBytes()));
                                
                //=======new==========
                Main strToHex = new Main();              
                String hex1 = Main.toString(response_command_idcard.getBytes());
                out.println("ASCII : " + strToHex.convertHexToString(hex1));
                
                //=========Th Fullname==============================
                byte[] command_thfullname = {
                    (byte) 0x80, (byte) 0xb0, (byte) 0x00,
                    (byte) 0x11, (byte) 0x02, (byte) 0x00,
                    (byte) 0x64
                };
        
                ResponseAPDU response_command_thfullname = channel.transmit(new CommandAPDU(command_thfullname));
                String[] parts;
                
                parts = new String(response_command_thfullname.getBytes(), "TIS620").substring(0, 35).split("#");
                String part1 = parts[0]; // คำนำหน้า
                String part2 = parts[1]; // ชื่อ
                //String part3 = parts[2]; // ว่าง
                String part3 = parts[3].replaceFirst(" ", ""); // สกุล
                               //parts[3].substring(0,20).replaceFirst(" ", "")   
                out.println(part1); // คำนำหน้า
                out.println(part2); // ชื่อ                    
                out.println(part3); // สกุล
                
                //=========Address======================
                byte[] command_address = {
                    (byte) 0x80, (byte) 0xb0, (byte) 0x15,
                    (byte) 0x79, (byte) 0x02, (byte) 0x00,
                    (byte) 0x64
                };

                ResponseAPDU answer6 = channel.transmit(new CommandAPDU(command_address));
                //System.out.println(new String(answer6.getBytes(), "TIS620").substring(0,60));
        
                String[] enpart11;
                enpart11 = new String(answer6.getBytes(), "TIS620").substring(0, 60).split("#");
                String enpart12 = enpart11[0]; // บ้านเลขที่
                String enpart13 = enpart11[1]; // หมู่ที่
                //String enpart14 = enpart11[2];
                //String enpart15 = enpart11[3];
                //String enpart16 = enpart11[4];
                String enpart17 = enpart11[5]; // ตำบล
                String enpart18 = enpart11[6]; // อำเภอ
                String enpart19 = enpart11[7]; // จังหวัด
            
                out.println(enpart12);
                out.println(enpart13);
                out.println(enpart17);
                out.println(enpart18);
                out.println(enpart19);
                //===========================
                String str2 = String.format("%3s", enpart12).replace(' ', '0'); // บ้านเลขที่ 
                out.println(str2);
                String moo = enpart11[1].substring(7,9).replaceFirst(" ", "");// ลบค่าว่างทิ้ง
                //enpart11[1].substring(7,9); // หมู่ที่ 
                String moo2 = String.format("%2s", moo).replace(' ', '0');//เติม 0 หน้า
                out.println(moo2);
                
                //=========Date of birth=======================
                byte[] command_dateofbirth = {
                    (byte) 0x80, (byte) 0xb0, (byte) 0x00,
                    (byte) 0xd9, (byte) 0x02, (byte) 0x00,
                    (byte) 0x08
                };             
        
                ResponseAPDU answer1 = channel.transmit(new CommandAPDU(command_dateofbirth));
                //System.out.println(new String(answer1.getBytes(), "TIS620").substring(0,8));
        
                String year;
                String month;
                String day;
                int foo,foo2;
                               
                year = new String(answer1.getBytes(), "TIS620").substring(0,4);
                month = new String(answer1.getBytes(), "TIS620").substring(4,6);
                day = new String(answer1.getBytes(), "TIS620").substring(6,8);
                foo = Integer.parseInt(year);
                foo2 = foo-543;
                //txtBirthday.setText(day+"/"+month+"/"+year);
                out.println(day+"/"+month+"/"+year);
                //out.println(foo2+"-"+month+"-"+day);
                               
                //==========answer================================
                String strx = (part1+part2+' '+part3+
                        "#"+(part1+part2+' '+part3)+
                        "#"+(strToHex.convertHexToString(hex1))+
                        "#"+(day+"/"+month+"/"+year)+
                        "#"+enpart12.replace(" ", "")+
                        "#"+(enpart13.replace(" ", "")).replace("หมู่ที่", "")+
                        "#"+enpart17.replace("ตำบล", "")+
                        "#"+enpart18.replace("อำเภอ", "")+
                        "#"+enpart19.replace("จังหวัด", "")+   
                        "#"+enpart19.replace("จังหวัด", ""));
                out.println(strx);
                //================================================
                // Disconnect
                // true: reset the card after disconnecting card.
                card.disconnect(true);

            } 
            catch(CardException ex)  {
            }        
        
        %>
    </body>
</html>
