<%@ Page Language="C#" AutoEventWireup="true" CodeFile="RptBookingSupplyMonitoring.aspx.cs"
    Inherits="Forms_RptBookingSupplyMonitoring" MasterPageFile="~/Forms/PageMaster.master"
    Title="SAMS :: Booking vs Execution" %>

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
                                        <td style="width: 89px" align="left" colspan="1">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 19px; height: 5px" align="left" rowspan="1">
                                        </td>
                                        <td style="width: 19px; height: 5px" align="left" rowspan="1">
                                            <strong>
                                                <asp:Label ID="lblType" runat="server" Width="70px" Text="Report Type" __designer:wfdid="w2"
                                                    CssClass="lblbox"></asp:Label></strong>
                                        </td>
                                        <td style="width: 19px; height: 5px" align="left" rowspan="1">
                                        </td>
                                        <td style="width: 19px; height: 5px" align="left" rowspan="1">
                                            <asp:DropDownList ID="DrpReportType" runat="server" Width="210px" __designer:wfdid="w3"
                                                CssClass="DropList" OnSelectedIndexChanged="DrpLocation_SelectedIndexChanged">
                                                <asp:ListItem Selected="True" Value="0">Date Wise</asp:ListItem>
                                                <asp:ListItem Value="1">SKU Wise (Units)</asp:ListItem>
                                                <asp:ListItem Value="2">SKU Wise (Cartons)</asp:ListItem>
                                                <asp:ListItem Value="3">SKU Wise (Values)</asp:ListItem>
                                            </asp:DropDownList>
                                        </td>
                                        <td style="width: 19px; height: 5px" align="left" rowspan="1">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 1px; height: 1px" align="left">
                                        </td>
                                        <td style="width: 19px; height: 1px" align="left">
                                        </td>
                                        <td style="height: 1px" align="left">
                                        </td>
                                        <td style="width: 203px; height: 1px" align="left">
                                        </td>
                                        <td style="width: 89px; height: 1px" align="left">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 1px; height: 1px" align="left">
                                        </td>
                                        <td style="width: 19px; height: 1px" align="left">
                                            <strong>
                                                <asp:Label ID="Label2" runat="server" Width="70px" Text="Location" CssClass="lblbox"></asp:Label></strong>
                                        </td>
                                        <td style="height: 1px" align="left">
                                        </td>
                                        <td style="width: 203px; height: 1px" align="left">
                                            <asp:DropDownList ID="DrpLocation" runat="server" Width="210px" CssClass="DropList"
                                                OnSelectedIndexChanged="DrpLocation_SelectedIndexChanged" AutoPostBack="True">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="width: 89px; height: 1px" align="left">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 1px" align="left">
                                        </td>
                                        <td style="width: 19px" align="left">
                                            <strong>
                                                <asp:Label ID="lbltoLocation" runat="server" Width="70px" Text="Principal" CssClass="lblbox" Visible="false" ></asp:Label></strong>
                                        </td>
                                        <td align="left">
                                        </td>
                                        <td >
                                            <asp:DropDownList ID="drpPrincipal" runat="server" Visible="false"  Width="210px" CssClass="DropList"
                                                OnSelectedIndexChanged="drpPrincipal_SelectedIndexChanged" AutoPostBack="True">
                                            </asp:DropDownList>
                                        </td>
                                        <td >
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 1px; height: 25px" align="left">
                                        </td>
                                        <td style="width: 19px; height: 25px" align="left">
                                            <strong>
                                                <asp:Label ID="lblSaleForce" runat="server" Width="70px" Text="Orderbooker" CssClass="lblbox"></asp:Label></strong>
                                        </td>
                                        <td style="height: 25px" align="left">
                                        </td>
                                        <td style="width: 203px; height: 25px" align="left">
                                            <asp:DropDownList ID="drpSaleForce" runat="server" Width="210px" CssClass="DropList">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="width: 89px; height: 25px" align="left">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 1px; height: 25px" align="left">
                                        </td>
                                        <td style="width: 19px; height: 25px" align="left">
                                            <strong>
                                                <asp:Label ID="lblDM" runat="server" Width="70px" Text="Sale Force" __designer:wfdid="w1"
                                                    CssClass="lblbox"></asp:Label></strong>
                                        </td>
                                        <td style="height: 25px" align="left">
                                        </td>
                                        <td style="width: 203px; height: 25px" align="left">
                                            <asp:DropDownList ID="DrpDeliveryMan" runat="server" Width="210px" __designer:wfdid="w3"
                                                CssClass="DropList">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="width: 89px; height: 25px" align="left">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 1px; height: 25px" align="left">
                                        </td>
                                        <td style="width: 19px; height: 25px" align="left">
                                            <strong>
                                                <asp:Label ID="Label1" runat="server" Width="70px" Text="From Date" CssClass="lblbox"></asp:Label></strong>
                                        </td>
                                        <td style="height: 25px" align="left">
                                        </td>
                                        <td style="width: 203px; height: 25px" align="left">
                                            <asp:TextBox ID="txtFromDate" runat="server" Width="153px" CssClass="txtBox" MaxLength="10"></asp:TextBox>
                                            <asp:ImageButton ID="ImgBntFromCalc" runat="server" ImageUrl="~/App_Themes/Granite/Images/date.gif">
                                            </asp:ImageButton>
                                        </td>
                                        <td style="width: 89px; height: 25px" align="left">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 1px; height: 25px" align="left">
                                        </td>
                                        <td style="width: 19px; height: 25px" align="left">
                                            <strong>
                                                <asp:Label ID="Label3" runat="server" Width="70px" Text="To  Date" CssClass="lblbox"></asp:Label></strong>
                                        </td>
                                        <td style="height: 25px" align="left">
                                        </td>
                                        <td style="width: 203px; height: 25px" align="left">
                                            <asp:TextBox ID="txtToDate" runat="server" Width="153px" CssClass="txtBox" MaxLength="10"></asp:TextBox>
                                            <asp:ImageButton ID="ImgToDate" runat="server" ImageUrl="~/App_Themes/Granite/Images/date.gif">
                                            </asp:ImageButton>
                                        </td>
                                        <td style="width: 89px; height: 25px" align="left">
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                            <cc1:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="txtFromDate"
                                PopupButtonID="ImgBntFromCalc" Format="dd-MMM-yyyy" EnableViewState="False">
                            </cc1:CalendarExtender>
                            <cc1:CalendarExtender ID="CalendarExtender2" runat="server" TargetControlID="txtToDate"
                                PopupButtonID="ImgToDate" Format="dd-MMM-yyyy" EnableViewState="False">
                            </cc1:CalendarExtender>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                    <asp:Button ID="btnViewPDF" runat="server" CssClass="Button" Text="View PDF" Width="90"
                        OnClick="btnViewPDF_Click" />
                    <asp:Button ID="Button1" runat="server" CssClass="Button" Text="View Excel" Width="90"
                        OnClick="btnViewExcel" />
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
