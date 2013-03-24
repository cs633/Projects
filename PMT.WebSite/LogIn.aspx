<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LogIn.aspx.cs" Inherits="PMT.Login" %>

<!DOCTYPE html>

<html>
<head id="Head1" runat="server">
    <title>Login</title>
    <link rel="stylesheet" href="Site.css"/> 
</head>
<body>
    <form id="form1" runat="server" defaultfocus="txtUserName">
    <asp:ScriptManager runat="server" ID="ScriptManager1" />
    <div class="centered">
        <table border="0">
            <tr>
                <td style="width:100px;text-align:right"><asp:Label runat="server" Text="User Name:" ID="lblUserName"></asp:Label></td>
                <td><asp:TextBox runat="server" ID="txtUserName" Width="150px"></asp:TextBox></td>
            </tr>
            <tr>
                <td style="text-align:right"><asp:Label runat="server" Text="Password:" ID="lblPassword"></asp:Label></td>
                <td><asp:TextBox runat="server" ID="txtPassword" TextMode="Password" Width="150px"></asp:TextBox></td>
            </tr>
            <tr>
                <td colspan="2">
                    <asp:RequiredFieldValidator ID="userNameRequiredValidator" runat="server" CssClass="requiredFieldValidator" ErrorMessage="User name cannot be blank." ControlToValidate="txtUserName" display="Dynamic" />
                    <asp:CustomValidator ID="loginValidator" runat="server" 
                        ControlToValidate="txtUserName" Display="Dynamic" 
                        OnServerValidate="LoginValidation"></asp:CustomValidator>&nbsp;
                </td>
            </tr>
            <tr>
                <td colspan="2" style="text-align:right"><asp:Button runat="server" Text="Login" 
                        ID="btnLogin"  UseSubmitBehavior="true" OnClick="btnLogin_Click"/></td>
            </tr>
        </table>
    </div>
    </form>
</body>
</html>
