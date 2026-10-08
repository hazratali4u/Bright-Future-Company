<%@ Page Language="C#" MasterPageFile="~/Forms/PageMaster.master" AutoEventWireup="true"
    CodeFile="frmChangePassword.aspx.cs" Inherits="Forms_fmChangePassword" Title="SAMS :: Change Password" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="content1" runat="server" ContentPlaceHolderID="cphPage">
    <script language="JavaScript" type="text/javascript">
        function pageLoad() {
            addBubbleMouseovers("CurrentPassword");
            addBubbleMouseovers("NewPassword");
            addBubbleMouseovers("ConfirmPassword");
        }

        //--indicates the mouse is currently over a div
        var onDiv = false;
        //--indicates the mouse is currently over a link
        var onLink = false;
        //--indicates that the bubble currently exists
        var bubbleExists = false;
        //--this is the ID of the timeout that will close the window if the user mouseouts the link
        var timeoutID;
        var ClassName;
        var DivText;

        function addBubbleMouseovers(mouseoverClass) {
            $("." + mouseoverClass).mouseover(function (event) {
                if (onDiv || onLink) {
                    return false;
                }
                ClassName = mouseoverClass;
                onLink = true;
                showBubble.call(this, event);
            });

            $("." + mouseoverClass).mouseout(function () {
                onLink = false;
                timeoutID = setTimeout(hideBubble, 150);
            });
        }

        function hideBubble() {
            clearTimeout(timeoutID);
            //--if the mouse isn't on the div then hide the bubble
            if (bubbleExists && !onDiv) {
                $("#bubbleID").remove();
                bubbleExists = false;
            }
        }

        function showBubble(event) {
            if (bubbleExists) {
                hideBubble();
            }
            if (ClassName == 'CurrentPassword') {
                DivText = '<u><b>Current Password</b></u><br/>'
            + 'The password you use for login to SAMS';
            }
            else if (ClassName == 'NewPassword') {
                DivText = '<u><b>New Password</b></u><br/>'
            + 'Max length:15<br>';
            }
            else if (ClassName == 'ConfirmPassword') {
                DivText = '<u><b>Confirm Password</b></u><br/>'
           + 'Same as new password';
            }

            var tPosX = event.pageX - 175;
            var tPosY = event.pageY + 2;
            $('<div ID="bubbleID"'
        + 'style="top:' + tPosY + 'px;'
        + 'left:' + tPosX + 'px;'
        + 'position: absolute;'
        + 'display: inline;'
        + 'border: 2px;'
        + 'width: 175px;'
        + 'height: 55px;'
        + 'padding:5px;'
        + 'color:White;'
        + 'background-color: #007395;">'
        + DivText
        + '</div>').mouseover(keepBubbleOpen).mouseout(letBubbleClose).appendTo('body');

            bubbleExists = true;
        }

        function keepBubbleOpen() {
            onDiv = true;
        }

        function letBubbleClose() {
            onDiv = false;

            hideBubble();
        }

        function ValidatePassword() {

            var strCurrentPassword;
            var strNewPassword;
            var strChangePassword;

            strCurrentPassword = document.getElementById('<%=txtCurrentPassword.ClientID%>').value;
            if (strCurrentPassword == null || strCurrentPassword.length == 0) {
                alert('Must Enter Current Password ');
                return false;
            }
            strNewPassword = document.getElementById('<%=txtNewPassword.ClientID%>').value;
            if (strNewPassword == null || strNewPassword.length == 0) {
                alert('Must Enter New Password ');
                return false;
            }
            strChangePassword = document.getElementById('<%=txtConfirmNewPassword.ClientID%>').value;
            if (strChangePassword == null || strChangePassword.length == 0) {
                alert('Must Enter Confirm New Password ');
                return false;
            }
            if (strNewPassword == strChangePassword) {
                return true;
            }
            else {
                alert('New Password does not match');
                return false;
            }

            return true;
        }
   
    </script>
    <div id="right_data">
        <table width="100%">
            <tr>
                <td>
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate>
                            <table>
                                <tbody>
                                    <tr>
                                        <td align="left" colspan="4">
                                            <asp:Label ID="lblErrorMsg" runat="server" Width="312px" ForeColor="Red" Font-Bold="True"></asp:Label>
                                        </td>
                                        <td align="left" colspan="1">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="left" colspan="5">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="height: 30px" align="left">
                                        </td>
                                        <td style="height: 30px" align="left">
                                            <strong>
                                                <asp:Label ID="Label2" runat="server" Width="122px" Text="Current Password" CssClass="lblbox"></asp:Label></strong>
                                        </td>
                                        <td style="height: 30px" align="left">
                                        </td>
                                        <td style="height: 30px" align="left">
                                            <asp:TextBox ID="txtCurrentPassword" runat="server" Width="153px" CssClass="txtBox"
                                                TextMode="Password" MaxLength="20"></asp:TextBox>
                                            <a class="CurrentPassword" href="javascript:void(0)">
                                                <img height="15" alt="" src="../App_Themes/Granite/Images/help.jpg" />
                                            </a>
                                        </td>
                                        <td style="height: 30px" align="left">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="height: 30px" align="left">
                                        </td>
                                        <td style="height: 30px" align="left">
                                            <strong>
                                                <asp:Label ID="lbltoLocation" runat="server" Width="121px" Text="New Password" CssClass="lblbox"></asp:Label></strong>
                                        </td>
                                        <td style="height: 30px" align="left">
                                        </td>
                                        <td style="height: 30px" align="left">
                                            <asp:TextBox ID="txtNewPassword" runat="server" Width="153px" CssClass="txtBox" TextMode="Password"
                                                MaxLength="20"></asp:TextBox>
                                            <a class="NewPassword" href="javascript:void(0)">
                                                <img height="15" alt="" src="../App_Themes/Granite/Images/help.jpg" />
                                            </a>
                                        </td>
                                        <td style="height: 30px" align="left">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="height: 30px" align="left">
                                        </td>
                                        <td style="height: 30px" align="left">
                                            <strong>
                                                <asp:Label ID="Label1" runat="server" Width="143px" Text="Confirm New Password" CssClass="lblbox"></asp:Label></strong>
                                        </td>
                                        <td style="height: 30px" align="left">
                                        </td>
                                        <td style="height: 30px" align="left">
                                            <asp:TextBox ID="txtConfirmNewPassword" runat="server" Width="153px" CssClass="txtBox"
                                                TextMode="Password" MaxLength="20"></asp:TextBox>
                                            <a class="ConfirmPassword" href="javascript:void(0)">
                                                <img height="15" alt="" src="../App_Themes/Granite/Images/help.jpg" />
                                            </a>
                                        </td>
                                        <td style="height: 30px" align="left">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="height: 20px" align="left" colspan="5">
                                       
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                            <asp:Button ID="btnSave" runat="server" Width="90" CssClass="Button" Text="Save"
                                OnClick="btnSave_Click"></asp:Button>
                            <asp:Button ID="btnCancel" OnClick="btnCancel_Click" runat="server" Width="90" CssClass="Button"
                                Text="Cancel"></asp:Button>
                            &nbsp;
                        </ContentTemplate>
                    </asp:UpdatePanel>
                    <asp:TextBox ID="hiddenPassword" runat="server" Visible="False" Width="97px"></asp:TextBox>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
