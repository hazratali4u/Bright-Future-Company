<%@ Page Language="C#" MasterPageFile="~/Forms/PageMaster.master" AutoEventWireup="true"
    CodeFile="RptSalesTaxReturn.aspx.cs" Inherits="Forms_RptSalesTaxReturn" Title="SAMS :: Sale Tax Return on Sale" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="ID" runat="server" ContentPlaceHolderID="cphPage">
    <script type="text/javascript">
        jQuery(document).ready(function () {
            $('#<%=rbDetail.ClientID %>').click(function () {
                jQuery(".divCustomer").hide(800);
                jQuery(".divCustomerType").show(800);
            });
            $('#<%=rbSummary.ClientID %>').click(function () {
                jQuery(".divCustomer").hide(800);
                jQuery(".divCustomerType").show(800);
            });
        });


        function pageLoad() {
            var selectedVal = $('#<%=DrpCustomer.ClientID%> option:selected').attr('value');

            if (parseInt(selectedVal) < 0) {
                jQuery(".divCustomerType").show(800);
            }
            else {
                jQuery(".divCustomerType").hide(800);
            }

            var rbIndividual = $('#<%=rbIndividual.ClientID %>');
            if (rbIndividual.attr("checked") != "undefined" && rbIndividual.attr("checked") == "checked") {
                jQuery(".divCustomer").show();
            }
            else {
                jQuery(".divCustomer").hide();
            }

            $('#<%=DrpCustomer.ClientID%>').change(function () {
                var selectedVal = $('#<%=DrpCustomer.ClientID%> option:selected').attr('value');

                if (parseInt(selectedVal) < 0) {
                    jQuery(".divCustomerType").show(800);
                }
                else {
                    jQuery(".divCustomerType").hide(800);
                }
            });

            $('#<%=rbIndividual.ClientID %>').click(function () {
                var selectedVal = $('#<%=DrpCustomer.ClientID%> option:selected').attr('value');

                if (parseInt(selectedVal) < 0) {
                    jQuery(".divCustomerType").show(800);
                }
                else {
                    jQuery(".divCustomerType").hide(800);
                }
                jQuery(".divCustomer").show(800);
            });

        }
        
    </script>
    <div id="right_data">
        <table width="100%">
            <tr>
                <td>
                    <table>
                        <tr>
                            <td>
                                &nbsp;
                            </td>
                            <td>
                                <div id="divReportType" class="container2">
                                    <asp:RadioButton ID="rbDetail" runat="server" Text="Detail Report" GroupName="ReportType"
                                        Checked="True"></asp:RadioButton>
                                    <asp:RadioButton ID="rbSummary" runat="server" Text="Summary Report" GroupName="ReportType">
                                    </asp:RadioButton>
                                    <asp:RadioButton ID="rbIndividual" runat="server" Text="Individual Customer" GroupName="ReportType">
                                    </asp:RadioButton>
                                </div>
                            </td>
                            <td>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate>
                            <table>
                                <tbody>
                                    <tr>
                                        <td style="width: 1px" align="left">
                                        </td>
                                        <td style="width: 90px" align="left">
                                            <strong>
                                                <asp:Label ID="Label2" runat="server" Width="48px" Text="Location" CssClass="lblbox"
                                                    __designer:wfdid="w37"></asp:Label></strong>
                                        </td>
                                        <td style="width: 1px" align="left">
                                        </td>
                                        <td style="width: 204px; height: 25px" align="left">
                                            <asp:DropDownList ID="DrpLocation" runat="server" Width="200px" CssClass="DropList"
                                                OnSelectedIndexChanged="DrpLocation_SelectedIndexChanged" AutoPostBack="True"
                                                __designer:wfdid="w38">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="width: 1px; height: 25px" align="left">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 1px; height: 2px" align="left">
                                        </td>
                                        <td style="width: 90px; height: 2px" align="left">
                                            <strong>
                                                <asp:Label ID="Label4" runat="server" Width="48px" Text="Principal" CssClass="lblbox"
                                                    __designer:wfdid="w39"></asp:Label></strong>
                                        </td>
                                        <td style="width: 1px; height: 2px" align="left">
                                        </td>
                                        <td style="width: 204px; height: 2px" align="left">
                                            <asp:DropDownList ID="drpPrincipal" runat="server" Width="200px" CssClass="DropList"
                                                __designer:wfdid="w40">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="width: 1px; height: 2px" align="left">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 1px" align="left">
                                        </td>
                                        <td style="width: 90px" align="left">
                                            <strong>
                                                <asp:Label ID="Label1" runat="server" Width="59px" Height="9px" Text="From Date"
                                                    CssClass="lblbox" __designer:wfdid="w41"></asp:Label></strong>
                                        </td>
                                        <td style="width: 1px" align="left">
                                        </td>
                                        <td style="width: 204px; height: 25px" align="left">
                                            <asp:TextBox ID="txtFromDate" runat="server" Width="150px" CssClass="txtBox" MaxLength="10"
                                                __designer:wfdid="w42"></asp:TextBox>
                                            <asp:ImageButton ID="ImgBntFromDate" runat="server" ImageUrl="~/App_Themes/Granite/Images/date.gif"
                                                __designer:wfdid="w43"></asp:ImageButton>
                                        </td>
                                        <td style="width: 1px; height: 25px" align="left">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 1px; height: 25px" align="left">
                                        </td>
                                        <td style="width: 90px; height: 25px" align="left">
                                            <strong>
                                                <asp:Label ID="Label3" runat="server" Width="55px" Text="To Date" CssClass="lblbox"
                                                    __designer:wfdid="w44"></asp:Label></strong>
                                        </td>
                                        <td style="width: 1px; height: 25px" align="left">
                                        </td>
                                        <td style="width: 204px; height: 25px" align="left">
                                            <asp:TextBox ID="txtToDate" runat="server" Width="150px" CssClass="txtBox" MaxLength="10"
                                                __designer:wfdid="w45"></asp:TextBox>
                                            <asp:ImageButton ID="ImgBntToDate" runat="server" ImageUrl="~/App_Themes/Granite/Images/date.gif"
                                                __designer:wfdid="w46"></asp:ImageButton>
                                        </td>
                                        <td style="width: 1px; height: 25px" align="left">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="left" colspan="5">
                                            <div id="divCustomer" class="divCustomer">
                                                <table width="100%">
                                                    <tbody>
                                                        <tr>
                                                            <td style="padding-left: 5px; width: 8px; height: 25px">
                                                                <strong>
                                                                    <asp:Label ID="lblRoute" runat="server" Width="78px" Font-Size="8pt" Text="Area"
                                                                        CssClass="lblbox" __designer:wfdid="w47"></asp:Label></strong>
                                                            </td>
                                                            <td style="width: 1px">
                                                            </td>
                                                            <td style="padding-left: 7px; width: 204px; height: 25px" align="left">
                                                                <asp:DropDownList ID="DrpRoute" runat="server" Width="200px" Font-Size="8pt" CssClass="DropList"
                                                                    OnSelectedIndexChanged="DrpRoute_SelectedIndexChanged" AutoPostBack="True" __designer:wfdid="w48">
                                                                </asp:DropDownList>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="padding-left: 5px; width: 8px; height: 25px">
                                                                <strong>
                                                                    <asp:Label ID="lblCustomer" runat="server" Width="78px" Font-Size="8pt" Text="Customer"
                                                                        CssClass="lblbox" __designer:wfdid="w49"></asp:Label></strong>
                                                            </td>
                                                            <td style="width: 1px">
                                                            </td>
                                                            <td style="padding-left: 7px; width: 204px; height: 25px">
                                                                <asp:DropDownList ID="DrpCustomer" runat="server" Width="200px" Font-Size="8pt" CssClass="DropList"
                                                                    __designer:wfdid="w50">
                                                                </asp:DropDownList>
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="left" colspan="5">
                                            <div id="divFilter" class="divCustomerType">
                                                <table width="100%">
                                                    <tbody>
                                                        <tr>
                                                            <td align="left">
                                                                <asp:RadioButtonList ID="rblCustomerType" runat="server" Width="300px" RepeatDirection="Horizontal"
                                                                    __designer:wfdid="w51">
                                                                    <asp:ListItem Selected="True" Value="-1">All</asp:ListItem>
                                                                    <asp:ListItem Value="1">Registered</asp:ListItem>
                                                                    <asp:ListItem Value="0">Unregistered</asp:ListItem>
                                                                </asp:RadioButtonList>
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </div>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                            <cc1:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="txtFromDate"
                                PopupButtonID="ImgBntFromDate" EnableViewState="False" Format="dd-MMM-yyyy" __designer:wfdid="w52">
                            </cc1:CalendarExtender>
                            <cc1:CalendarExtender ID="CalendarExtender2" runat="server" TargetControlID="txtToDate"
                                PopupButtonID="ImgBntToDate" EnableViewState="False" Format="dd-MMM-yyyy" __designer:wfdid="w53">
                            </cc1:CalendarExtender>
                            &nbsp;
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
