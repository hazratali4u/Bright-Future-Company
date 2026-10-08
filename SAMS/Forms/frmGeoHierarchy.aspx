<%@ Page Language="C#" MasterPageFile="~/Forms/AppMaster.master" AutoEventWireup="true"
    CodeFile="frmGeoHierarchy.aspx.cs" Inherits="frmGeoHierarchy" Title="SAMS :: Geo Hierarchy" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="mainCopy" runat="Server">
    <div class="container" style="background-color: white">
        <h2>
            &nbsp; Geo Hierarchy</h2>
    </div>
    <script language="JavaScript" type="text/javascript">
        function ValidatRegion() {
            var str;
            str = document.getElementById('<%=txtRegion.ClientID%>').value;
            if (str == null || str.length == 0) {
                alert('Must enter Region Name');
                return false;
            }
        }
        function ValidatZone() {
            var str;
            str = document.getElementById('<%=txtZone.ClientID%>').value;
            if (str == null || str.length == 0) {
                alert('Must enter Zone Name');
                return false;
            }
        }
        function ValidateTerritory() {
            var str;
            str = document.getElementById('<%=txtterritory.ClientID%>').value;
            if (str == null || str.length == 0) {
                alert('Must enter Territory Name');
                return false;
            }
        }
        function ValidateTown() {
            var str;
            str = document.getElementById('<%=txtRoute.ClientID%>').value;
            if (str == null || str.length == 0) {
                alert('Must enter City Name');
                return false;
            }
        }
    </script>
    <div class="container">
        <table width="100%">
            <tr>
                <td style="width: 100px">
                    <div style="z-index: 101; left: 403px; width: 68px; position: absolute; top: 232px;
                        height: 86px">
                        <asp:UpdateProgress ID="UpdateProgress1" runat="server" AssociatedUpdatePanelID="UpdatePanel1">
                            <ProgressTemplate>
                                <asp:ImageButton ID="ImageButton1" runat="server" Width="31px" Height="24px" ImageUrl="~/App_Themes/Granite/Images/image003.gif">
                                </asp:ImageButton>
                            </ProgressTemplate>
                        </asp:UpdateProgress>
                    </div>
                </td>
                <td>
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate>
                            <table width="100%">
                                <tbody>
                                    <tr>
                                        <td colspan="5">
                                            <asp:Label ID="lblErrorMsg" runat="server" ForeColor="Red" Font-Bold="True" Height="13px"
                                                Width="214px"></asp:Label>
                                        </td>
                                        <td style="width: 11px">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="Label1" runat="server" Text="Region" CssClass="lblbox"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="ddRegion" runat="server" Width="200px" CssClass="DropList"
                                                AutoPostBack="True" OnSelectedIndexChanged="ddRegion_SelectedIndexChanged">
                                            </asp:DropDownList>
                                            <asp:TextBox ID="txtRegion" runat="server" Visible="False" Width="194px" CssClass="txtBox "></asp:TextBox>
                                        </td>
                                        <td>
                                        </td>
                                        <td>
                                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                        </td>
                                        <td>
                                            <asp:Button ID="btnRegion" OnClick="btnRegion_Click" runat="server" Width="125px"
                                                Font-Size="8pt" Text="New Region" AccessKey="R"></asp:Button>
                                        </td>
                                        <td style="width: 11px">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="Label2" runat="server" Text="Zone" CssClass="lblbox"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="ddZone" runat="server" Width="200px" CssClass="DropList" AutoPostBack="True"
                                                OnSelectedIndexChanged="ddZone_SelectedIndexChanged">
                                            </asp:DropDownList>
                                            <asp:TextBox ID="txtZone" runat="server" Visible="False" Width="194px" CssClass="txtBox "></asp:TextBox>
                                        </td>
                                        <td>
                                        </td>
                                        <td>
                                        </td>
                                        <td>
                                            <asp:Button ID="btnZone" OnClick="btnZone_Click" runat="server" Width="125px" Font-Size="8pt"
                                                Text="New Zone" AccessKey="Z"></asp:Button>
                                        </td>
                                        <td style="width: 11px">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="Label3" runat="server" Text="Territory" CssClass="lblbox"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="ddTerritory" runat="server" Width="200px" CssClass="DropList"
                                                AutoPostBack="True" OnSelectedIndexChanged="ddTerritory_SelectedIndexChanged">
                                            </asp:DropDownList>
                                            <asp:TextBox ID="txtterritory" runat="server" Visible="False" Width="194px" CssClass="txtBox "></asp:TextBox>
                                        </td>
                                        <td>
                                        </td>
                                        <td>
                                        </td>
                                        <td>
                                            <asp:Button ID="btnTerritory" OnClick="btnTerritory_Click" runat="server" Width="125px"
                                                Font-Size="8pt" Text="New Territory" AccessKey="T"></asp:Button>
                                        </td>
                                        <td style="width: 11px">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="Label5" runat="server" Text="City" CssClass="lblbox"></asp:Label>
                                        </td>
                                        <td style="width: 169px; height: 26px">
                                            <asp:TextBox ID="txtRoute" runat="server" Width="194px" CssClass="txtBox "></asp:TextBox>
                                        </td>
                                        <td style="height: 26px">
                                        </td>
                                        <td style="height: 26px">
                                        </td>
                                        <td style="height: 26px">
                                            <asp:CheckBox ID="IsActive" runat="server" Font-Size="9pt" Text="IsActive" CssClass="lblbox"
                                                Checked="True" Visible="False"></asp:CheckBox>
                                        </td>
                                        <td style="width: 11px; height: 26px">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                        </td>
                                        <td align="left">
                                            <asp:Button ID="btnSave" OnClick="btnSave_Click" runat="server" Width="89px" Font-Size="8pt"
                                                Text="Save City" AccessKey="S"></asp:Button>
                                            <asp:Button ID="Button1" OnClick="Button1_Click" runat="server" Width="81px" Font-Size="8pt"
                                                Text="Cancel"></asp:Button>
                                        </td>
                                        <td>
                                        </td>
                                        <td>
                                        </td>
                                        <td>
                                        </td>
                                        <td style="width: 11px">
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                    &nbsp;
                </td>
                <td>
                </td>
            </tr>
        </table>
    </div>
    <div class="container">
        <asp:UpdatePanel ID="UpdatePanel2" runat="server">
            <ContentTemplate>
                <table style="border-right: silver thin inset; border-top: silver thin inset; border-left: silver thin inset;
                    border-bottom: silver thin inset; background-color: silver">
                    <tbody>
                        <tr>
                            <td style="height: 21px" align="left">
                                <asp:Label ID="Label10" runat="server" Width="153px" Text="Select Searching Type"></asp:Label>
                            </td>
                            <td style="width: 170px; height: 21px" align="left">
                                <asp:DropDownList ID="ddSearchType" runat="server" Width="200px" CssClass="DropList">
                                    <asp:ListItem Value="SKU_code">All Records</asp:ListItem>
                                    <asp:ListItem Value="region_name">Region</asp:ListItem>
                                    <asp:ListItem Value="Zone_Name">Zone</asp:ListItem>
                                    <asp:ListItem Value="Territory_Name">Territory</asp:ListItem>
                                    <asp:ListItem Value="Town_name">City</asp:ListItem>
                                </asp:DropDownList>
                            </td>
                            <td style="width: 224px; height: 21px" align="left">
                                <asp:TextBox ID="txtSeach" runat="server" Width="200px" CssClass="txtBox "></asp:TextBox>
                            </td>
                            <td style="height: 21px" align="left" width="250">
                                <asp:Button ID="Button2" OnClick="Button2_Click" runat="server" Width="85px" Font-Size="8pt"
                                    Text="Filter"></asp:Button>
                            </td>
                        </tr>
                    </tbody>
                </table>
                <asp:GridView ID="Grid_Hierarchy" runat="server" Width="100%" ForeColor="SteelBlue"
                    CssClass="gridRow2" OnRowCommand="Grid_Hierarchy_RowCommand" OnRowDeleting="Grid_Hierarchy_RowDeleting"
                    OnRowEditing="Grid_Hierarchy_RowEditing" AllowPaging="True" AutoGenerateColumns="False"
                    BackColor="White" HorizontalAlign="Center" OnPageIndexChanging="Grid_Brand_PageIndexChanging"
                    BorderColor="White">
                    <PagerSettings FirstPageText="" LastPageText="" Mode="NextPrevious" NextPageText="Next"
                        PreviousPageText="Previous"></PagerSettings>
                    <RowStyle BorderColor="Silver" BorderWidth="1px" BorderStyle="Solid" ForeColor="Black">
                    </RowStyle>
                    <Columns>
                        <asp:BoundField DataField="region_id" HeaderText="Region Id">
                            <HeaderStyle CssClass="HidePanel"></HeaderStyle>
                            <ItemStyle CssClass="HidePanel"></ItemStyle>
                        </asp:BoundField>
                        <asp:BoundField DataField="region_name" HeaderText="Region Name">
                            <ItemStyle BorderColor="Silver" BorderWidth="1px" BorderStyle="Solid" HorizontalAlign="Left">
                            </ItemStyle>
                            <HeaderStyle HorizontalAlign="Left" />
                        </asp:BoundField>
                        <asp:BoundField DataField="zone_id" HeaderText="zone id">
                            <HeaderStyle CssClass="HidePanel"></HeaderStyle>
                            <ItemStyle CssClass="HidePanel"></ItemStyle>
                        </asp:BoundField>
                        <asp:BoundField DataField="zone_name" HeaderText="Zone Name">
                            <ItemStyle BorderColor="Silver" BorderWidth="1px" BorderStyle="Solid" HorizontalAlign="Left">
                            </ItemStyle>
                            <HeaderStyle HorizontalAlign="Left" />
                        </asp:BoundField>
                        <asp:BoundField DataField="territory_Id" HeaderText="territory Id">
                            <HeaderStyle CssClass="HidePanel"></HeaderStyle>
                            <ItemStyle CssClass="HidePanel"></ItemStyle>
                        </asp:BoundField>
                        <asp:BoundField DataField="territory_Name" HeaderText="Territory Name">
                            <ItemStyle BorderColor="Silver" BorderWidth="1px" BorderStyle="Solid" HorizontalAlign="Left">
                            </ItemStyle>
                            <HeaderStyle HorizontalAlign="Left" />
                        </asp:BoundField>
                        <asp:BoundField DataField="town_Id" HeaderText="City Id">
                            <HeaderStyle CssClass="HidePanel"></HeaderStyle>
                            <ItemStyle CssClass="HidePanel"></ItemStyle>
                        </asp:BoundField>
                        <asp:BoundField DataField="town_name" HeaderText="City Name">
                            <ItemStyle BorderColor="Silver" BorderWidth="1px" BorderStyle="Solid" HorizontalAlign="Left">
                            </ItemStyle>
                            <HeaderStyle HorizontalAlign="Left" />
                        </asp:BoundField>
                        <asp:CommandField ShowEditButton="True" HeaderText="Edit">
                            <ItemStyle BorderColor="Silver" BorderWidth="1px" BorderStyle="Solid"></ItemStyle>
                        </asp:CommandField>
                        <asp:TemplateField HeaderText="Delete">
                            <ItemTemplate>
                                <asp:LinkButton ID="btnDelete" runat="server" Text="Delete" OnClientClick="javascript:return confirm('Are you sure you want to Delete?');return false;"
                                    CommandName="Delete"></asp:LinkButton>
                            </ItemTemplate>
                            <ItemStyle BorderColor="Silver" BorderWidth="1px" BorderStyle="Solid"></ItemStyle>
                        </asp:TemplateField>
                    </Columns>
                    <FooterStyle BackColor="White"></FooterStyle>
                    <PagerStyle BackColor="Transparent"></PagerStyle>
                    <HeaderStyle BackColor="#007395" BorderColor="Silver" BorderWidth="1px" BorderStyle="Solid"
                        ForeColor="White"></HeaderStyle>
                    <AlternatingRowStyle CssClass="GridAlternateRowStyle"></AlternatingRowStyle>
                </asp:GridView>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</asp:Content>
