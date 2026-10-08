<%@ Page Title="SAMS :: Customer Wise Sales Return Report" Language="C#" MasterPageFile="~/Forms/PageMaster.master"
    AutoEventWireup="true" CodeFile="rptSaleReturn.aspx.cs" Inherits="Forms_rptSaleReturn" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.2000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304"
    Namespace="CrystalDecisions.Web" TagPrefix="CR" %>
<asp:Content ID="Content1" runat="server" ContentPlaceHolderID="cphPage">
<script type="text/javascript" src="../AjaxLibrary/jquery.searchabledropdown-1.0.8.min.js"></script>
    <script language="JavaScript" type="text/javascript">
        function pageLoad() {
            $("select").searchable();

        }
    </script>
    <div id="right_data">
        <table width="100%">
            <tr>
                <td>
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate>
                            <table width="100%">
                                <tr>
                                    <td style="width: 10%">
                                        <strong>
                                            <asp:Label ID="lbltoLocation" runat="server" Width="94px" Text="Location" CssClass="lblbox"></asp:Label>
                                        </strong>
                                    </td>
                                    <td style="width: 90%">
                                        <asp:DropDownList ID="drpDistributor" runat="server" Width="200px" CssClass="DropList"
                                            OnSelectedIndexChanged="drpDistributor_SelectedIndexChanged" AutoPostBack="True">
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 10%">
                                        <strong>
                                            <asp:Label ID="Label6" runat="server" Width="78px" Text="Principal"></asp:Label>
                                        </strong>
                                    </td>
                                    <td style="width: 90%">
                                        <asp:DropDownList ID="DrpPrincipal" runat="server" Width="200px" OnSelectedIndexChanged="DrpPrincipal_SelectedIndexChanged"
                                            AutoPostBack="True">
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 10%">
                                        <strong>
                                            <asp:Label ID="Label7" runat="server" Width="78px" Text="SKU"></asp:Label>
                                        </strong>
                                    </td>
                                    <td style="width: 90%">
                                        <asp:DropDownList ID="DrpSKU" runat="server" Width="200px">
                                        </asp:DropDownList>
                                    </td>
                                </tr>                                
                                <tr>
                                    <td style="width: 10%">
                                        <strong>
                                            <asp:Label ID="lblfromLocation" runat="server" Width="94px" Text="Customer Area"></asp:Label>
                                        </strong>
                                    </td>
                                    <td style="width: 90%">
                                        <asp:DropDownList ID="DrpRoute" runat="server" Width="200px" OnSelectedIndexChanged="DrpRoute_SelectedIndexChanged"
                                            AutoPostBack="True">
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 10%">
                                        <strong>
                                            <asp:Label ID="Label5" runat="server" Width="94px" Text="Customer"></asp:Label>
                                        </strong>
                                    </td>
                                    <td style="width: 90%">
                                        <asp:DropDownList ID="DrpCustomer" runat="server" Width="200px" CssClass="DropList">
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 10%">
                                        <strong>
                                            <asp:Label ID="Label2" runat="server" Width="95px" Text="Return Type"></asp:Label>
                                        </strong>
                                    </td>
                                    <td style="width: 90%">
                                        <asp:CheckBoxList ID="cblType" runat="server" RepeatDirection="Horizontal" Width="250px">                                        
                                            <asp:ListItem Value="1" Text="Expiry" Selected="True" ></asp:ListItem>
                                            <asp:ListItem Value="2" Text="Damage" Selected="True" ></asp:ListItem>
                                            <asp:ListItem Value="3" Text="Saleable" Selected="True" ></asp:ListItem>
                                        </asp:CheckBoxList>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 10%">
                                        <strong>
                                            <asp:Label ID="Label3" runat="server" Height="13px" Text="From Date" Width="90px"></asp:Label>
                                        </strong>
                                    </td>
                                    <td style="width: 90%">
                                        <asp:TextBox ID="txtStartDate" runat="server" MaxLength="10" onkeyup="BlockStartDateKeyPress()"
                                            Width="150px"></asp:TextBox>
                                        <asp:ImageButton ID="ibtnStartDate" runat="server" ImageUrl="~/App_Themes/Granite/Images/date.gif"
                                            Width="16px" />
                                        <cc1:CalendarExtender ID="CEStartDate" runat="server" Format="dd-MMM-yyyy" PopupButtonID="ibtnStartDate"
                                            TargetControlID="txtStartDate">
                                        </cc1:CalendarExtender>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 10%">
                                        <strong>
                                            <asp:Label ID="Label4" runat="server" Height="13px" Text="To Date" Width="80px"></asp:Label>
                                        </strong>
                                    </td>
                                    <td style="width: 90%">
                                        <asp:TextBox ID="txtEndDate" runat="server" MaxLength="10" onkeyup="BlockEndDateKeyPress()"
                                            Width="150px"></asp:TextBox>
                                        <asp:ImageButton ID="ibnEndDate" runat="server" ImageUrl="~/App_Themes/Granite/Images/date.gif"
                                            Width="16px" />
                                        <cc1:CalendarExtender ID="CEEndDate" runat="server" Format="dd-MMM-yyyy" PopupButtonID="ibnEndDate"
                                            TargetControlID="txtEndDate">
                                        </cc1:CalendarExtender>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">&nbsp;</td>
                                </tr>
                                <tr>
                                    <td style="width: 10%">
                                    </td>
                                    <td style="width: 90%">
                                        <asp:Button ID="btnViewPDF" runat="server" Width="90" Text="View PDF" OnClick="btnViewPDF_Click"
                                            CssClass="Button" />
                                        <asp:Button ID="btnViewExcel" runat="server" Width="90" Text="View Excel" OnClick="btnViewExcel_Click"
                                            CssClass="Button" />
                                    </td>
                                </tr>
                            </table>
                        </ContentTemplate>            
                        <Triggers>
                            <asp:PostBackTrigger ControlID="btnViewPDF" />
                            <asp:PostBackTrigger ControlID="btnViewExcel" />
                        </Triggers>            
                    </asp:UpdatePanel>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
