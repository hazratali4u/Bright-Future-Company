<%@ Page Language="C#" MasterPageFile="~/Forms/PageMaster.master" AutoEventWireup="true"
    CodeFile="RptRouteEfficiency.aspx.cs" Inherits="Forms_RptRouteEfficiency" Title="SAMS :: Area Efficiency Report" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphPage" runat="Server">
    <script language="JavaScript" type="text/javascript">
        function ValidateForm() {

            return true;
        }

        function TopPercent(event) {
            // Allow: backspace, delete
            if (event.keyCode == 46 || event.keyCode == 8 ||
            // Allow: home, end, left, right
            (event.keyCode >= 35 && event.keyCode <= 39) ||
            //Allow 0-9
            ((event.keyCode >= 48 && event.keyCode <= 57) && event.shiftKey === false) || //Standard Numbers
            //Keypad numbers
            (event.keyCode >= 96 && event.keyCode <= 105)) {
                return;
            }
            else {
                // Ensure that it is a number and stop the keypress
                event.preventDefault();
            }
        }
        function CheckValue() {
            if ($('#<%=txtTop.ClientID %>').val() > 100) {
                $('#<%=txtTop.ClientID %>').val(100);
            }
        }
        function pageLoad() {
            $('#<%=txtTop.ClientID %>').keydown(TopPercent);
            $('#<%=txtTop.ClientID %>').keyup(CheckValue);
            addBubbleMouseovers("TopPercent");
        }

        //--indicates the mouse is currently over a div
        var onDiv = false;
        //--indicates the mouse is currently over a link
        var onLink = false;
        //--indicates that the bubble currently exists
        var bubbleExists = false;
        //--this is the ID of the timeout that will close the window if the user mouseouts the link
        var timeoutID;
        //Text To be shown
        var DivText;

        function addBubbleMouseovers(mouseoverClass) {
            $("." + mouseoverClass).mouseover(function (event) {
                if (onDiv || onLink) {
                    return false;
                }
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
            DivText = '<u><b>Top Percent</b></u><br/>'
        + 'Max length:3<br>'
        + 'Allowed: Numbers(0-100)';

            var tPosX = event.pageX + 2;
            var tPosY = event.pageY + 2;
            $('<div ID="bubbleID"'
        + 'style="top:' + tPosY + 'px;'
        + 'left:' + tPosX + 'px;'
        + 'position: absolute;'
        + 'display: inline;'
        + 'border: 2px;'
        + 'width: 200px;'
        + 'height: 50px;'
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
                                            <asp:Label ID="lblErrorMsg" runat="server" ForeColor="Red" Font-Bold="True"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="left">
                                        </td>
                                        <td style="width: 81px" align="left">
                                            <strong>
                                                <asp:Label ID="lbltoLocation" runat="server" Width="73px" Text="Location" CssClass="lblbox"></asp:Label></strong>
                                        </td>
                                        <td align="left">
                                        </td>
                                        <td style="height: 25px" align="left">
                                            <asp:DropDownList ID="drpDistributor" runat="server" Width="200px" CssClass="DropList"
                                                OnSelectedIndexChanged="drpDistributor_SelectedIndexChanged" AutoPostBack="True">
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="left">
                                        </td>
                                        <td style="width: 81px" align="left">
                                            <strong>
                                                <asp:Label ID="Label6" runat="server" Width="78px" Text="Principal" CssClass="lblbox"></asp:Label></strong>
                                        </td>
                                        <td align="left">
                                        </td>
                                        <td style="height: 25px" align="left">
                                            <asp:DropDownList ID="DrpPrincipal" runat="server" Width="200px" CssClass="DropList"
                                                OnSelectedIndexChanged="DrpPrincipal_SelectedIndexChanged" AutoPostBack="True">
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="left">
                                        </td>
                                        <td style="width: 81px" align="left">
                                            <strong>
                                                <asp:Label ID="lblOrderBooker" runat="server" Width="79px" Text="Order Booker" CssClass="lblbox"
                                                    __designer:wfdid="w3"></asp:Label></strong>
                                        </td>
                                        <td align="left">
                                        </td>
                                        <td style="height: 25px" align="left">
                                            <asp:DropDownList ID="drpSaleForce" runat="server" Width="199px" CssClass="DropList"
                                                __designer:wfdid="w4">
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="left">
                                        </td>
                                        <td style="width: 81px" align="left">
                                            <strong>
                                                <asp:Label ID="lblTop" runat="server" Width="78px" Text="Top %" CssClass="lblbox"
                                                    __designer:wfdid="w1"></asp:Label></strong>
                                        </td>
                                        <td align="left">
                                        </td>
                                        <td style="height: 25px" align="left">
                                            &nbsp;<asp:TextBox ID="txtTop" runat="server" CssClass="txtBox" __designer:wfdid="w3"
                                                MaxLength="3"></asp:TextBox>
                                            <a class="TopPercent" href="javascript:void(0)">
                                                <img height="15" alt="" src="../App_Themes/Granite/Images/help.jpg" />
                                            </a>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="left">
                                        </td>
                                        <td style="width: 81px" align="left">
                                            <strong>
                                                <asp:Label ID="Label3" runat="server" Width="70px" Height="13px" Text="From Date"></asp:Label></strong>
                                        </td>
                                        <td align="left">
                                        </td>
                                        <td style="height: 25px" align="left">
                                            &nbsp;<asp:TextBox ID="txtStartDate" onkeyup="BlockStartDateKeyPress()" runat="server"
                                                Width="150px" CssClass="txtBox" MaxLength="10"></asp:TextBox>
                                            <asp:ImageButton ID="ibtnStartDate" runat="server" Width="16px" ImageUrl="~/App_Themes/Granite/Images/date.gif">
                                            </asp:ImageButton>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="left">
                                        </td>
                                        <td style="width: 81px" align="left">
                                            <strong>
                                                <asp:Label ID="Label4" runat="server" Width="80px" Height="13px" Text="To Date"></asp:Label></strong>
                                        </td>
                                        <td align="left">
                                        </td>
                                        <td style="height: 25px" align="left">
                                            &nbsp;<asp:TextBox ID="txtEndDate" onkeyup="BlockEndDateKeyPress()" runat="server"
                                                Width="150px" CssClass="txtBox " MaxLength="10"></asp:TextBox>
                                            <asp:ImageButton ID="ibnEndDate" runat="server" Width="16px" ImageUrl="~/App_Themes/Granite/Images/date.gif">
                                            </asp:ImageButton>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="left">
                                        </td>
                                        <td style="width: 81px" align="left">
                                        </td>
                                        <td align="left">
                                        </td>
                                        <td style="height: 25px" align="left">
                                            <%@ register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="cc1" %>
                                            <cc1:CalendarExtender ID="CEStartDate" runat="server" TargetControlID="txtStartDate"
                                                PopupButtonID="ibtnStartDate" Format="dd-MMM-yyyy">
                                            </cc1:CalendarExtender>
                                            <cc1:CalendarExtender ID="CEEndDate" runat="server" TargetControlID="txtEndDate"
                                                PopupButtonID="ibnEndDate" Format="dd-MMM-yyyy">
                                            </cc1:CalendarExtender>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                    <asp:Button ID="btnViwPDF" runat="server" CssClass="Button" Text="View PDF" Width="90"
                        OnClick="btnViwPDF_Click" />
                    <asp:Button ID="btnViewExcel" runat="server" CssClass="Button" Text="View Excel"
                        Width="90" OnClick="btnViewExcel_Click" />
                </td>
            </tr>
        </table>
        &nbsp;
    </div>
</asp:Content>
