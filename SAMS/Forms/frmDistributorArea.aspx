<%@ Page Language="C#" MasterPageFile="~/Forms/PageMaster.master" AutoEventWireup="true"
    CodeFile="frmDistributorArea.aspx.cs" Inherits="Forms_frmDistributorArea" Title="SAMS :: City Hierarchy" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphPage" runat="Server">
    <script language="JavaScript" type="text/javascript">

        function CheckDeactivation() {
            if (document.getElementById('<%= btnSaveRoute.ClientID %>').value == 'Update') {
                if (document.getElementById('<%= ChIsActive.ClientID %>').checked) {
                }
                else {
                    return confirm('Are you sure you want Deactivate?');
                }
            }
        }

        function CheckDeactivation2() {
            if (document.getElementById('<%= btnSaveMarket.ClientID %>').value == 'Update') {
                if (document.getElementById('<%= chMarkeIsActive.ClientID %>').checked) {
                }
                else {
                    return confirm('Are you sure you want Deactivate?');
                }
            }
        }

        function ValidateArea() {
            var str;
            str = document.getElementById('<%=txtAreaName.ClientID%>').value;
            if (str == null || str.length == 0) {
                alert('Must Enter Area Name');
                return false;
            }
            return true;
        }
        function ValidateRoute() {
            var str;
            str = document.getElementById('<%=txtMarketName.ClientID%>').value;
            if (str == null || str.length == 0) {
                alert('Must Enter Sub Area Name');
                return false;
            }
            return true;
        }

        function pageLoad() {
            jQuery('#<%=grdAreaData.ClientID %>').tablesorter(
	     {
	         headers: {
	             0: {
	                 sorter: false
	             },
	             1: {
	                 sorter: false
	             },
	             2: {
	                 sorter: false
	             },
	             3: {
	                 sorter: false
	             },
	             4: {
	                 sorter: false
	             },
	             7: {
	                 sorter: false
	             },
	             8: {
	                 sorter: false
	             }
	         }
	     }
	     );
            jQuery('#<%=grdRouteData.ClientID %>').tablesorter(
	     {
	         headers: {
	             0: {
	                 sorter: false
	             },
	             1: {
	                 sorter: false
	             },
	             2: {
	                 sorter: false
	             },
	             3: {
	                 sorter: false
	             },
	             4: {
	                 sorter: false
	             },
	             5: {
	                 sorter: false
	             },
	             6: {
	                 sorter: false
	             },
	             9: {
	                 sorter: false
	             },
	             10: {
	                 sorter: false
	             }
	         }
	     }
	     );
            jQuery('#<%=txtAreaName.ClientID %>').keydown(txtName);
            jQuery('#<%=txtMarketName.ClientID %>').keydown(txtName);
        }

        function txtName(event) {
            // Allow: backspace, delete, tab , escape and space bar
            if (event.keyCode == 46 || event.keyCode == 8 || event.keyCode == 9 || event.keyCode == 27 || event.keyCode == 32 ||
            // Allow: Ctrl+A
            (event.keyCode == 65 && event.ctrlKey === true) ||
            // Allow: home, end, left, right
            (event.keyCode >= 35 && event.keyCode <= 39) ||
            // Allow: Dash, Underscoor
            (event.keyCode == 189) ||
            // Allow: Open bracket, Close bracket
            ((event.keyCode == 57 || event.keyCode == 48) && event.shiftKey === true) ||
            //Allow Comma,Period
            ((event.keyCode == 190 || event.keyCode == 188) && event.shiftKey === false) ||
            //Allow 0-9
            ((event.keyCode >= 48 && event.keyCode <= 57) && event.shiftKey === false) || //Standard Numbers
            (event.keyCode >= 96 && event.keyCode <= 105) || //Keypad numbers
            //Allow a-z
            (event.keyCode >= 65 && event.keyCode <= 90)) {
                // let it happen, don't do anything
                return;
            }
            else {
                // Ensure that it is a number and stop the keypress
                event.preventDefault();
            }
        }
    </script>
    <div id="right_data">
        <table width="100%">
            <tr>
                <td style="width: 100px">
                    <cc1:TabContainer ID="TabContainer1" runat="server" Height="375px" Width="650px"
                        ActiveTabIndex="0">
                        <cc1:TabPanel ID="TabPanel1" runat="server">
                            <HeaderTemplate>
                                Area&nbsp;
                            </HeaderTemplate>
                            <ContentTemplate>
                                <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                                    <ContentTemplate>
                                        <table width="100%">
                                            <tr>
                                                <td>
                                                </td>
                                                <td style="width: 467px">
                                                    <table width="100%">
                                                        <tbody>
                                                            <tr>
                                                                <td style="width: 100px">
                                                                </td>
                                                                <td style="width: 49px">
                                                                </td>
                                                                <td style="width: 245px">
                                                                </td>
                                                                <td style="width: 100px">
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td style="width: 100px">
                                                                </td>
                                                                <td colspan="2">
                                                                    <asp:Label ID="lblErrorMsg" runat="server" Font-Bold="True" ForeColor="Red"></asp:Label>
                                                                    <br />
                                                                </td>
                                                                <td style="width: 100px">
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td style="width: 100px; height: 28px">
                                                                </td>
                                                                <td style="width: 49px; height: 28px">
                                                                    <strong>
                                                                        <asp:Label ID="Label4" runat="server" Width="62px" Text="Location" __designer:wfdid="w46"></asp:Label></strong>
                                                                </td>
                                                                <td style="width: 245px; height: 28px">
                                                                    <asp:DropDownList ID="drpDistributor" runat="server" Width="200px" __designer:wfdid="w47"
                                                                        AutoPostBack="True" OnSelectedIndexChanged="drpDistributor_SelectedIndexChanged"
                                                                        CssClass="DropList">
                                                                    </asp:DropDownList>
                                                                </td>
                                                                <td style="width: 100px; height: 28px">
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td style="width: 100px; height: 28px">
                                                                </td>
                                                                <td style="width: 49px; height: 28px">
                                                                    <strong>
                                                                        <asp:Label ID="Label3" runat="server" Width="62px" Text="City" __designer:wfdid="w48"></asp:Label></strong>
                                                                </td>
                                                                <td style="width: 245px; height: 28px">
                                                                    <asp:DropDownList ID="drpTown" runat="server" Width="200px" __designer:wfdid="w49"
                                                                        AutoPostBack="True" OnSelectedIndexChanged="drpTown_SelectedIndexChanged" CssClass="DropList">
                                                                    </asp:DropDownList>
                                                                </td>
                                                                <td style="width: 100px; height: 28px">
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td style="width: 100px; height: 29px">
                                                                </td>
                                                                <td style="width: 49px; height: 29px">
                                                                    <strong>
                                                                        <asp:Label ID="Label2" runat="server" Width="65px" Text="Name" __designer:wfdid="w50"></asp:Label></strong>
                                                                </td>
                                                                <td style="width: 245px; height: 29px">
                                                                    <asp:TextBox ID="txtAreaName" runat="server" Width="170px" __designer:wfdid="w51"
                                                                        CssClass="txtBox " MaxLength="50"></asp:TextBox>
                                                                </td>
                                                                <td style="width: 100px; height: 29px">
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td style="width: 100px; height: 37px">
                                                                </td>
                                                                <td style="width: 49px; height: 37px" align="right">
                                                                    &nbsp;
                                                                </td>
                                                                <td style="width: 245px; height: 37px">
                                                                    <asp:CheckBox ID="ChIsActive" runat="server" Text="Is Active" __designer:wfdid="w52"
                                                                        Checked="True"></asp:CheckBox>
                                                                </td>
                                                                <td style="width: 100px; height: 37px">
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td style="width: 100px; height: 37px">
                                                                </td>
                                                                <td style="width: 49px; height: 37px" align="right">
                                                                </td>
                                                                <td style="width: 245px; height: 37px">
                                                                    <asp:Button ID="btnSaveRoute" OnClick="btnSaveRoute_Click" runat="server" Width="85px"
                                                                        Font-Size="8pt" Text="Save" CssClass="Button" OnClientClick="return CheckDeactivation();"/>
                                                                </td>
                                                                <td style="width: 100px; height: 37px">
                                                                </td>
                                                            </tr>
                                                        </tbody>
                                                    </table>
                                                </td>
                                                <td style="width: 100px">
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="center" colspan="3">
                                                    <asp:Panel ID="Panel1" runat="server" Width="100%" Height="150px" ScrollBars="Vertical" 
                                                          BorderWidth ="1px">
                                                        <asp:GridView ID="grdAreaData" runat="server" Width="100%" ForeColor="SteelBlue"
                                                            Font-Size="9pt"   HorizontalAlign="Center"
                                                            AutoGenerateColumns="False" BackColor="White" BorderColor="White" OnRowEditing="grdAreaData_RowEditing"
                                                            OnPageIndexChanging="grdAreaData_PageIndexChanging">
                                                            <PagerSettings FirstPageText="" LastPageText="" Mode="NextPrevious" NextPageText="Next"
                                                                PreviousPageText="Previous"></PagerSettings>
                                                            <Columns>
                                                                <asp:BoundField DataField="AREA_ID" HeaderText="Area Id">
                                                                    <HeaderStyle CssClass="HidePanel"></HeaderStyle>
                                                                    <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderWidth="1px" BorderStyle="Solid"
                                                                        CssClass="HidePanel"></ItemStyle>
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="DISTRIBUTOR_ID" HeaderText="Distributor">
                                                                    <HeaderStyle HorizontalAlign="Left" CssClass="HidePanel"></HeaderStyle>
                                                                    <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderWidth="1px" BorderStyle="Solid"
                                                                        CssClass="HidePanel"></ItemStyle>
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="TOWN_ID" HeaderText="City Id">
                                                                    <HeaderStyle CssClass="HidePanel"></HeaderStyle>
                                                                    <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderWidth="1px" BorderStyle="Solid"
                                                                        CssClass="HidePanel"></ItemStyle>
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="Distributor" HeaderText="Distributor">
                                                                    <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                                    <ItemStyle BorderColor="Silver" BorderWidth="1px" BorderStyle="Solid"></ItemStyle>
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="Town" HeaderText="City">
                                                                    <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                                    <ItemStyle BorderColor="Silver" BorderWidth="1px" BorderStyle="Solid"></ItemStyle>
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="AREA_CODE" HeaderText="Area Code">
                                                                    <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                                    <ItemStyle BorderColor="Silver" BorderWidth="1px" BorderStyle="Solid"></ItemStyle>
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="AREA_NAME" HeaderText="Area Name">
                                                                    <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                                    <ItemStyle BorderColor="Silver" BorderWidth="1px" BorderStyle="Solid"></ItemStyle>
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="IS_ACTIVE" HeaderText="Status">
                                                                    <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                                                    <ItemStyle BorderColor="Silver" BorderWidth="1px" BorderStyle="Solid"></ItemStyle>
                                                                </asp:BoundField>
                                                                <asp:CommandField ShowEditButton="True" HeaderText="Edit">
                                                                    <ItemStyle BorderColor="Silver" BorderWidth="1px" BorderStyle="Solid"></ItemStyle>
                                                                </asp:CommandField>
                                                            </Columns>
                                                            <HeaderStyle CssClass="tblhead"></HeaderStyle>
                                                            <AlternatingRowStyle CssClass="GridAlternateRowStyle"></AlternatingRowStyle>
                                                        </asp:GridView>
                                                    </asp:Panel>
                                                    
                                                </td>
                                            </tr>
                                        </table>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </ContentTemplate>
                        </cc1:TabPanel>
                        <cc1:TabPanel ID="TabPanel2" runat="server">
                            <HeaderTemplate>
                                Sub Area&nbsp;
                            </HeaderTemplate>
                            <ContentTemplate>
                                <table width="100%">
                                    <tr>
                                        <td style="width: 100px">
                                        </td>
                                        <td align="center">
                                            <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                                <ContentTemplate>
                                                    <table width="100%">
                                                        <tbody>
                                                            <tr>
                                                                <td style="width: 100px; height: 8px">
                                                                </td>
                                                                <td style="height: 8px" align="left" colspan="2">
                                                                    <strong>
                                                                        <asp:Label ID="lblErrorMsgDivsion" runat="server" ForeColor="Red" Font-Bold="True"
                                                                            __designer:wfdid="w17"></asp:Label></strong><br />
                                                                </td>
                                                                <td style="width: 100px; height: 8px">
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td style="width: 100px; height: 16px">
                                                                </td>
                                                                <td style="width: 49px; height: 28px" align="left">
                                                                    <strong>
                                                                        <asp:Label ID="Label1" runat="server" Width="64px" Text="Location" __designer:wfdid="w18"></asp:Label></strong>
                                                                </td>
                                                                <td style="height: 16px" align="left">
                                                                    <asp:DropDownList ID="drpMDistributor" runat="server" Width="200px" __designer:wfdid="w19"
                                                                        AutoPostBack="True" OnSelectedIndexChanged="drpMDistributor_SelectedIndexChanged"
                                                                        CssClass="DropList">
                                                                    </asp:DropDownList>
                                                                </td>
                                                                <td style="width: 100px; height: 16px">
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td style="width: 100px; height: 28px">
                                                                </td>
                                                                <td style="width: 49px; height: 28px" align="left">
                                                                    <strong>
                                                                        <asp:Label ID="Label5" runat="server" Width="42px" Text="City" __designer:wfdid="w20"></asp:Label></strong>
                                                                </td>
                                                                <td style="height: 28px" align="left">
                                                                    <asp:DropDownList ID="DrpMTown" runat="server" Width="200px" __designer:wfdid="w21"
                                                                        AutoPostBack="True" OnSelectedIndexChanged="DrpMTown_SelectedIndexChanged" CssClass="DropList">
                                                                    </asp:DropDownList>
                                                                </td>
                                                                <td style="width: 100px; height: 28px">
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td style="width: 100px; height: 8px">
                                                                </td>
                                                                <td style="width: 49px; height: 28px" align="left">
                                                                    <strong>
                                                                        <asp:Label ID="Label6" runat="server" Width="42px" Text="Area" __designer:wfdid="w22"></asp:Label></strong>
                                                                </td>
                                                                <td align="left">
                                                                    <asp:DropDownList ID="DrpRoute" runat="server" Width="200px" __designer:wfdid="w23"
                                                                        AutoPostBack="True" OnSelectedIndexChanged="DrpRoute_SelectedIndexChanged" CssClass="DropList">
                                                                    </asp:DropDownList>
                                                                </td>
                                                                <td style="width: 100px; height: 8px">
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td style="width: 100px; height: 8px">
                                                                </td>
                                                                <td style="width: 49px; height: 28px" align="left">
                                                                    <strong>
                                                                        <asp:Label ID="Label21" runat="server" Width="43px" Text="Name" __designer:wfdid="w24"></asp:Label></strong>
                                                                </td>
                                                                <td align="left">
                                                                    <asp:TextBox ID="txtMarketName" runat="server" Width="170px" __designer:wfdid="w25"
                                                                        CssClass="txtBox " MaxLength="50"></asp:TextBox>
                                                                </td>
                                                                <td style="width: 100px; height: 8px">
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td style="width: 100px; height: 37px">
                                                                </td>
                                                                <td align="right">
                                                                </td>
                                                                <td align="left">
                                                                    <asp:CheckBox ID="chMarkeIsActive" runat="server" Text="Is Active" __designer:wfdid="w26"
                                                                        Checked="True"></asp:CheckBox>
                                                                </td>
                                                                <td style="width: 100px; height: 37px">
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td style="width: 100px; height: 37px">
                                                                </td>
                                                                <td align="right">
                                                                    &nbsp;
                                                                </td>
                                                                <td align="left">
                                                                    <asp:Button ID="btnSaveMarket" OnClick="btnSaveMarket_Click" runat="server" Width="85px"
                                                                        Font-Size="8pt" Text="Save" CssClass="Button" OnClientClick="return CheckDeactivation2();"/>
                                                                </td>
                                                                <td style="width: 100px; height: 37px">
                                                                </td>
                                                            </tr>
                                                        </tbody>
                                                    </table>
                                                </ContentTemplate>
                                            </asp:UpdatePanel>
                                        </td>
                                        <td style="width: 100px">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="left" colspan="3">
                                            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                                <ContentTemplate>
                                                    <asp:Panel ID="Panel2" runat="server" Width="100%" Height="135px" ScrollBars="Vertical"
                                                         HorizontalAlign="Left" BorderWidth ="1px">
                                                        <asp:GridView ID="grdRouteData" runat="server" Width="100%" ForeColor="SteelBlue"
                                                            Font-Size="9pt"   HorizontalAlign="Center"
                                                            OnPageIndexChanging="grdRouteData_PageIndexChanging" OnRowEditing="grdRouteData_RowEditing"
                                                            BorderColor="White" BackColor="White" AutoGenerateColumns="False">
                                                            <PagerSettings FirstPageText="" LastPageText="" Mode="NextPrevious" NextPageText="Next"
                                                                PreviousPageText="Previous"></PagerSettings>
                                                            <Columns>
                                                                <asp:BoundField DataField="ROUTE_ID" HeaderText="ROUTE_ID">
                                                                    <HeaderStyle CssClass="HidePanel"></HeaderStyle>
                                                                    <ItemStyle CssClass="HidePanel"></ItemStyle>
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="DISTRIBUTOR_ID" HeaderText="Distributor Id">
                                                                    <HeaderStyle CssClass="HidePanel"></HeaderStyle>
                                                                    <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderWidth="1px" BorderStyle="Solid"
                                                                        CssClass="HidePanel"></ItemStyle>
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="AREA_ID" HeaderText="Area Id">
                                                                    <HeaderStyle CssClass="HidePanel"></HeaderStyle>
                                                                    <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderWidth="1px" BorderStyle="Solid"
                                                                        CssClass="HidePanel"></ItemStyle>
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="TOWN_ID" HeaderText="City Id">
                                                                    <HeaderStyle CssClass="HidePanel"></HeaderStyle>
                                                                    <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderWidth="1px" BorderStyle="Solid"
                                                                        CssClass="HidePanel"></ItemStyle>
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="Distributor" HeaderText="Distributor">
                                                                    <ItemStyle BorderColor="Silver" BorderWidth="1px" BorderStyle="Solid"></ItemStyle>
                                                                    <HeaderStyle HorizontalAlign="Left" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="Town" HeaderText="City">
                                                                    <ItemStyle BorderColor="Silver" BorderWidth="1px" BorderStyle="Solid"></ItemStyle>
                                                                    <HeaderStyle HorizontalAlign="Left" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="AREA_NAME" HeaderText="Area">
                                                                    <ItemStyle BorderColor="Silver" BorderWidth="1px" BorderStyle="Solid"></ItemStyle>
                                                                    <HeaderStyle HorizontalAlign="Left" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="Route_CODE" HeaderText="Sub Area Code">
                                                                    <ItemStyle BorderColor="Silver" BorderWidth="1px" BorderStyle="Solid"></ItemStyle>
                                                                    <HeaderStyle HorizontalAlign="Left" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="Route_NAME" HeaderText="Sub Area Name">
                                                                    <ItemStyle BorderColor="Silver" BorderWidth="1px" BorderStyle="Solid"></ItemStyle>
                                                                    <HeaderStyle HorizontalAlign="Left" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="IS_ACTIVE" HeaderText="Status">
                                                                    <ItemStyle BorderColor="Silver" BorderWidth="1px" BorderStyle="Solid"></ItemStyle>
                                                                    <HeaderStyle HorizontalAlign="Left" />
                                                                </asp:BoundField>
                                                                <asp:CommandField ShowEditButton="True" HeaderText="Edit">
                                                                    <ItemStyle BorderColor="Silver" BorderWidth="1px" BorderStyle="Solid"></ItemStyle>
                                                                </asp:CommandField>
                                                            </Columns>
                                                            <HeaderStyle CssClass="tblhead"></HeaderStyle>
                                                            <AlternatingRowStyle CssClass="GridAlternateRowStyle"></AlternatingRowStyle>
                                                        </asp:GridView>
                                                    </asp:Panel>
                                                </ContentTemplate>
                                            </asp:UpdatePanel>
                                        </td>
                                    </tr>
                                </table>
                                <br />
                                &nbsp;
                            </ContentTemplate>
                        </cc1:TabPanel>
                    </cc1:TabContainer>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
