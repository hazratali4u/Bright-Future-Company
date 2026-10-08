<%@ Page Language="C#" MasterPageFile="~/Forms/PageMaster.master" AutoEventWireup="true"
    CodeFile="RptPhysicalStockTaking.aspx.cs" Inherits="Forms_RptPhysicalStockTaking"
    Title="SAMS :: Physical Stock Report" %>

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
                                        <td align="left" style="width: 1px; height: 40px">
                                        </td>
                                        <td align="left" style="height: 40px; width:80px;">
                                            <strong>
                                               Report Type</strong>
                                        </td>
                                        <td align="left" style="width: 1px; height: 40px">
                                        </td>
                                        <td align="left"  height: 40px">
                                            <asp:RadioButtonList ID="RblType" runat="server" AutoPostBack="True" OnSelectedIndexChanged="RblType_SelectedIndexChanged"
                                                RepeatDirection="Horizontal" Width="200px">
                                                <asp:ListItem Selected="True">SKU Wise</asp:ListItem>
                                                <asp:ListItem>Value Wise</asp:ListItem>
                                            </asp:RadioButtonList>
                                        </td>
                                        <td align="left" style="width: 1px; height: 40px">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 1px; height: 30px" align="left">
                                        </td>
                                        <td style="height: 30px" align="left">
                                            <strong>
                                                Location</strong>
                                        </td>
                                        <td style="width: 1px; height: 30px" align="left">
                                        </td>
                                        <td style="width: 203px; height: 30px" align="left">
                                            <asp:DropDownList ID="DrpLocation" runat="server" Width="200px" CssClass="DropList"
                                                AutoPostBack="True">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="width: 1px; height: 30px" align="left">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 1px; height: 33px;" align="left">
                                        </td>
                                        <td style="height: 33px;" align="left">
                                            <strong>
                                                Principal</strong>
                                        </td>
                                        <td style="width: 1px; height: 33px;" align="left">
                                        </td>
                                        <td style="width: 203px; height: 33px" align="left">
                                            <asp:DropDownList ID="drpPrincipal" runat="server" Width="200px" CssClass="DropList"
                                                AutoPostBack="True">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="width: 1px; height: 33px" align="left">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 1px; height: 25px" align="left">
                                        </td>
                                        <td style="width: 29px; height: 25px" align="left">
                                            <strong>
                                               Date</strong>
                                        </td>
                                        <td style="width: 1px; height: 25px" align="left">
                                        </td>
                                        <td style="width: 203px; height: 25px" align="left">
                                            <asp:TextBox ID="txtFromDate" runat="server" Width="175px" CssClass="txtBox" MaxLength="10"></asp:TextBox>
                                            <asp:ImageButton ID="ImgBntFromCalc" runat="server" ImageUrl="~/App_Themes/Granite/Images/date.gif">
                                            </asp:ImageButton>
                                        </td>
                                        <td style="width: 1px; height: 25px" align="left">
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                            <cc1:CalendarExtender ID="CalendarExtender1" runat="server" EnableViewState="False"
                                Format="dd-MMM-yyyy" PopupButtonID="ImgBntFromCalc" TargetControlID="txtFromDate">
                            </cc1:CalendarExtender>
                            &nbsp;
                        </ContentTemplate>
                    </asp:UpdatePanel>
                    <asp:Button ID="btnViewPDF" runat="server" CssClass="button" Text="View PDF" Width="90"
                        OnClick="btnViewPDF_Click" />
                    <asp:Button ID="btnViewExcel" runat="server" CssClass="button" Text="View Excel"
                        Width="90" OnClick="btnViewExcel_Click" />
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
