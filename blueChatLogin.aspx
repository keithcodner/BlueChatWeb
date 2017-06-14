<%@ Page Language="C#" AutoEventWireup="true" CodeFile="blueChatLogin.aspx.cs" Inherits="blueChatLogin" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server"><link rel="shortcut icon" href="img/bcl.ico" />
    <title></title>
    <style type="text/css">
        .auto-style1
        {
            width: 64px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server" >
    <div style="width: 221px">
    
      -  <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="#">Register</asp:HyperLink><br />
      -  <asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl="#">Reset Password</asp:HyperLink><br />
       
    
    </div>

        <div  id="Div1" style="position: absolute; left: 733px; top: 295px; width: 416px;
        height: 133px; z-index: 3">

            <table>
                <tr>
                   <td>
                   <asp:Label ID="statusLabel" runat="server" ForeColor="Red"></asp:Label>
                   </td>
                </tr>
                <tr>
                    <td class="auto-style1">
                        <asp:Label ID="Label1" runat="server" Text="Username: "></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="usernameTxt" runat="server"></asp:TextBox>
                    </td>
                </tr>

                <tr>
                    <td class="auto-style1">
                        <asp:Label ID="Label2" runat="server" Text="Password: "></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="passwordTxt" runat="server" TextMode="Password"></asp:TextBox>
                    </td>
                </tr>

                <tr>
                    <td class="auto-style1">
                        </td>
                    <td class="auto-style1">
                        <asp:Button ID="loginBtn" runat="server" Text="Login" OnClick="loginBtn_Click" style="height: 26px" /></td>
                </tr>
             
            </table>

        </div>
    <p>
        &nbsp;</p>
        
    </form>
    </body>
</html>
