<%@ Page Language="C#" AutoEventWireup="true"  CodeFile="Calendar.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Calendar using javascript</title>
    <script language="javascript" src=Calendar.js type="text/javascript"></script>
    <link href=Calendar.css rel="stylesheet" type="text/css"> 
</head>
<body>
    <form id="form1" runat="server">    
   <asp:Label ID="lblDateSent" runat="server" Text="Posted on:" CssClass="graytextbold"></asp:Label>
        <input ID="PostedOn" runat="server" class="NormalTextBox" readonly="readOnly" type="text" />&nbsp;
        <a onclick="showCalendarControl(PostedOn)" href="#"><img alt="calendar" src=calendar.gif style="width: 34px; height: 21px" border="0" /></a>
   </form>
</body>
</html>
