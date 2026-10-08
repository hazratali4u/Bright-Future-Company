<%@ Page Language="C#" MasterPageFile="~/Forms/PageMaster.master" AutoEventWireup="true"
    CodeFile="RptChequeDetailReport.aspx.cs" Inherits="Forms_RptChequeDetailReport"
    Title="SAMS :: Cheque Detail Report" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" runat="server" ContentPlaceHolderID="cphPage">
    <script language="JavaScript" type="text/javascript">
        function ValidateForm() {

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
                                            <asp:Label ID="lblErrorMsg" runat="server" ForeColor="Red" Font-Bold="True"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="height: 25px" align="center" colspan="4">
                                            <asp:RadioButtonList ID="rblReportFor" runat="server" Width="250px" __designer:wfdid="w1"
                                                RepeatDirection="Horizontal" OnSelectedIndexChanged="rblReportFor_SelectedIndexChanged"
                                                AutoPostBack="True">
                                                <asp:ListItem Selected="True" Value="0">Cheque Detail</asp:ListItem>
                                                <asp:ListItem Value="1">Customer Credit</asp:ListItem>
                                            </asp:RadioButtonList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="left">
                                        </td>
                                        <td align="left">
                                            <strong>
                                                <asp:Label ID="lbltoLocation" runat="server" Width="73px" Text="Location" CssClass="lblbox"></asp:Label></strong>
                                        </td>
                                        <td align="left">
                                        </td>
                                        <td style="width: 258px; height: 25px" align="left">
                                            &nbsp;
                                            <asp:DropDownList ID="drpDistributor" runat="server" Width="240px" CssClass="DropList"
                                                OnSelectedIndexChanged="drpDistributor_SelectedIndexChanged" AutoPostBack="True">
                                            </asp:DropDownList>
                                        </td>
                                    </tr>                                    
                                    <tr>
                                        <td colspan="4">
                                            <div id="divDetail" runat="server">
                                                <table>
                                                    <tbody>
                                                        <tr>
                                                            <td align="left">
                                                            </td>
                                                            <td align="left">
                                                                <strong>
                                                                    <asp:Label ID="lblfromLocation" runat="server" Width="94px" Text="Customer Area"
                                                                        CssClass="lblbox"></asp:Label></strong>
                                                            </td>
                                                            <td align="left">
                                                            </td>
                                                            <td style="height: 25px" align="left">
                                                                <asp:DropDownList ID="DrpRoute" runat="server" Width="240px" CssClass="DropList">
                                                                </asp:DropDownList>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left">
                                                            </td>
                                                            <td align="left">
                                                                <strong>
                                                                    <asp:Label ID="lblNickName" runat="server" Width="79px" Text="Channel Type" CssClass="lblbox"></asp:Label></strong>
                                                            </td>
                                                            <td align="left">
                                                            </td>
                                                            <td style="height: 25px" align="left">
                                                                <asp:DropDownList ID="drpChannelType" runat="server" Width="240px" CssClass="DropList">
                                                                </asp:DropDownList>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left">
                                                            </td>
                                                            <td align="left">
                                                                <strong>
                                                                    <asp:Label ID="Label1" runat="server" Width="79px" Text="Customer" CssClass="lblbox"></asp:Label></strong>
                                                            </td>
                                                            <td align="left">
                                                            </td>
                                                            <td style="height: 25px" align="left">
                                                                <asp:DropDownList ID="DrpCustomer" runat="server" Width="240px" CssClass="DropList">
                                                                </asp:DropDownList>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left">
                                                            </td>
                                                            <td align="left">
                                                                <strong>
                                                                    <asp:Label ID="Label10" runat="server" Width="80px" Text="Status" CssClass="lblbox"></asp:Label></strong>
                                                            </td>
                                                            <td align="left">
                                                            </td>
                                                            <td style="height: 25px" align="left">
                                                                <asp:DropDownList ID="DrpStatus" runat="server" Width="240px" CssClass="DropList">
                                                                </asp:DropDownList>
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="left">
                                        </td>
                                        <td align="left">
                                            <strong>
                                                <asp:Label ID="Label3" runat="server" Width="75px" Height="13px" Text="From Date"></asp:Label></strong>
                                        </td>
                                        <td align="left">
                                        </td>
                                        <td style="width: 258px; height: 25px" align="left">
                                            &nbsp;&nbsp;<asp:TextBox ID="txtStartDate" onkeyup="BlockStartDateKeyPress()" runat="server"
                                                Width="150px" CssClass="txtBox" MaxLength="10"></asp:TextBox>
                                            <asp:ImageButton ID="ibtnStartDate" runat="server" Width="16px" ImageUrl="~/App_Themes/Granite/Images/date.gif">
                                            </asp:ImageButton>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="left">
                                        </td>
                                        <td align="left">
                                            <strong>
                                                <asp:Label ID="Label4" runat="server" Width="80px" Height="13px" Text="To Date"></asp:Label></strong>
                                        </td>
                                        <td align="left">
                                        </td>
                                        <td style="width: 258px; height: 25px" align="left">
                                            &nbsp;&nbsp;<asp:TextBox ID="txtEndDate" onkeyup="BlockEndDateKeyPress()" runat="server"
                                                Width="150px" CssClass="txtBox " MaxLength="10"></asp:TextBox>
                                            <asp:ImageButton ID="ibnEndDate" runat="server" Width="16px" ImageUrl="~/App_Themes/Granite/Images/date.gif">
                                            </asp:ImageButton>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="left">
                                        </td>
                                        <td align="left">
                                            &nbsp; <strong>
                                                <asp:Label ID="Label2" runat="server" Width="73px" Text="Search On"></asp:Label></strong>
                                        </td>
                                        <td align="left">
                                            &nbsp;&nbsp;
                                        </td>
                                        <td style="width: 258px" align="left">
                                            <asp:RadioButtonList ID="RbReportFilter" runat="server" Width="250px">
                                                <asp:ListItem Selected="True">Recevied Date</asp:ListItem>
                                                <asp:ListItem>Deposit Date</asp:ListItem>
                                                <asp:ListItem>Realized Date</asp:ListItem>
                                                <asp:ListItem>Due Date </asp:ListItem>
                                            </asp:RadioButtonList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="left">
                                        </td>
                                        <td align="left">
                                        </td>
                                        <td align="left">
                                        </td>
                                        <td style="width: 258px; height: 25px" align="left">
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
                    <asp:Button ID="btnViewPDF" runat="server" CssClass="Button" Text="View PDF" Width="90"
                        OnClick="btnViewPDF_Click" />
                    <asp:Button ID="btnViewExcel" runat="server" CssClass="Button" Text="View Excel"
                        Width="90" OnClick="btnViewExcel_Click" />
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
