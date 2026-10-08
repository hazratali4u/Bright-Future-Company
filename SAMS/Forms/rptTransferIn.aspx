<%@ Page Language="C#" AutoEventWireup="true" CodeFile="rptTransferIn.aspx.cs" Inherits="Forms_rptTransferIn"
    MasterPageFile="~/Forms/PageMaster.master" Title="SAMS :: Transfer In/Out Report" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="content1" runat="server" ContentPlaceHolderID="cphPage">
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
                                        <td style="width: 1px" align="left" colspan="1">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 1px; height: 1px" align="left">
                                        </td>
                                        <td style="width: 29px; height: 1px" align="left">
                                        </td>
                                        <td style="width: 1px; height: 1px" align="left">
                                        </td>
                                        <td  align="left">
                                            <asp:RadioButtonList ID="RbTransferType" runat="server" Width="200px" Height="20px"
                                                RepeatDirection="Horizontal">
                                                <asp:ListItem Selected="True" Value="Transfer In">Transfer In</asp:ListItem>
                                                <asp:ListItem>Transfer Out</asp:ListItem>
                                            </asp:RadioButtonList>
                                        </td>
                                        <td style="width: 1px; height: 1px" align="left">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="left" style="height: 25px" >
                                        </td>
                                        <td align="left" style="width: 80px;">
                                            <strong>
                                                Report In</strong>
                                        </td>
                                        <td align="left" style="width: 1px; height: 1px">
                                        </td>
                                        <td align="left" >
                                            <asp:DropDownList ID="DrpReportType" runat="server" Width="200px" CssClass="DropList"
                                                AutoPostBack="True" OnSelectedIndexChanged="DrpReportType_SelectedIndexChanged">
                                                <asp:ListItem>Quantity</asp:ListItem>
                                                <asp:ListItem>Carton</asp:ListItem>
                                                <asp:ListItem>Value</asp:ListItem>
                                            </asp:DropDownList>
                                        </td>
                                        <td align="left" style="width: 1px; height: 1px">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="height: 25px"  align="left">
                                        </td>
                                        <td >
                                            <strong>
                                                Location</strong>
                                        </td>
                                        <td style="width: 1px" align="left">
                                        </td>
                                        <td  align="left">
                                            <asp:DropDownList ID="DrpLocation" runat="server" Width="200px" CssClass="DropList"
                                                AutoPostBack="True">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="width: 1px; height: 25px" align="left">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 1px; height: 25px" align="left">
                                        </td>
                                        <td >
                                            <strong>
                                                Principal</strong>
                                        </td>
                                        <td style="width: 1px; height: 25px" align="left">
                                        </td>
                                        <td style="width: 203px; height: 25px" align="left">
                                            <asp:DropDownList ID="drpPrincipal" runat="server" Width="200px" CssClass="DropList"
                                                AutoPostBack="True">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="width: 1px; height: 25px" align="left">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 1px; height: 25px" align="left">
                                        </td>
                                        <td >
                                            <strong>
                                               From Date</strong>
                                        </td>
                                        <td style="width: 1px; height: 25px" align="left">
                                        </td>
                                        <td >
                                            <asp:TextBox ID="txtFromDate" runat="server" Width="175px" CssClass="txtBox" MaxLength="10"></asp:TextBox>
                                            <asp:ImageButton ID="ImgBntFromCalc" runat="server" ImageUrl="~/App_Themes/Granite/Images/date.gif">
                                            </asp:ImageButton>
                                        </td>
                                        <td style="width: 1px; height: 25px" align="left">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="height: 25px" align="left">
                                        </td>
                                        <td >
                                            <strong>
                                                To Date</strong>
                                        </td>
                                        <td style="height: 25px" align="left">
                                        </td>
                                        <td >
                                            <asp:TextBox ID="txtToDate" runat="server" Width="175px" CssClass="txtBox" MaxLength="10"></asp:TextBox>
                                            <asp:ImageButton ID="ImgToDate" runat="server" ImageUrl="~/App_Themes/Granite/Images/date.gif">
                                            </asp:ImageButton>
                                        </td>
                                        <td style="width: 1px; height: 25px" align="left">
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                            <cc1:CalendarExtender ID="CalendarExtender1" runat="server" Format="dd-MMM-yyyy"
                                EnableViewState="False" PopupButtonID="ImgBntFromCalc" TargetControlID="txtFromDate">
                            </cc1:CalendarExtender>
                            <cc1:CalendarExtender ID="CalendarExtender2" runat="server" Format="dd-MMM-yyyy"
                                EnableViewState="False" PopupButtonID="ImgToDate" TargetControlID="txtToDate">
                            </cc1:CalendarExtender>
                           
                        </ContentTemplate>
                    </asp:UpdatePanel>
                     <br />&nbsp;&nbsp;
                    <asp:Button ID="btnViewPDF" runat="server" Width="90" Text="View PDF" OnClick="btnViewPDF_Click"
                        CssClass="button" />
                    <asp:Button ID="btnViewExcel" runat="server" Text="View Excel" Width="90" OnClick="btnViewExcel_Click"
                        CssClass="button" />
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
