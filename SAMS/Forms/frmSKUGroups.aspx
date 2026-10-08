<%@ Page Language="C#" AutoEventWireup="true" CodeFile="frmSKUGroups.aspx.cs" Inherits="frmSKUGroups"
    MasterPageFile="~/Forms/PageMaster.master" Title="SAMS :: SKU Group" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphPage" runat="Server">
    <div id="right_data">
        <table width="100%">
            <tr>
                <td>
                    <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                        <ContentTemplate>
                            <table width="90%">
                                <tr>
                                    <td style="width:10%"></td>
                                    <td style="width:90%">
                                        <asp:Label ID="lblErrormsg" runat="server" ForeColor="Red"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width:10%">
                                        <strong>
                                            <asp:Label ID="Label1" runat="server" Text="Group Name"></asp:Label>
                                        </strong>
                                    </td>
                                    <td style="width:90%">
                                        <asp:TextBox ID="txtGroupName" runat="server" Width="194px" ></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" Width="136px"
                                            ControlToValidate="txtGroupName" Display="Dynamic" ErrorMessage="Enter Group Name"
                                            ValidationGroup="vg"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width:10%">
                                        <strong>
                                            <asp:Label ID="Label5" runat="server" Text="Principal"></asp:Label>
                                        </strong>
                                    </td>
                                    <td style="width:90%">
                                        <asp:DropDownList ID="ddPrincipal" runat="server" Width="200px" CssClass="DropList"
                                            AutoPostBack="True" OnSelectedIndexChanged="ddPrincipal_SelectedIndexChanged">
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width:10%">
                                        <strong>
                                            <asp:Label ID="Label8" runat="server" Text="Division"></asp:Label>
                                        </strong>
                                    </td>
                                    <td style="width:90%">
                                        <asp:DropDownList ID="ddDivision" runat="server" Width="200px" CssClass="DropList"
                                            AutoPostBack="True" OnSelectedIndexChanged="ddDivision_SelectedIndexChanged">
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width:10%">
                                        <strong>
                                            <asp:Label ID="Label11" runat="server" Text="Catagory"></asp:Label>
                                        </strong>
                                    </td>
                                    <td style="width:90%">
                                        <asp:DropDownList ID="ddCatagory" runat="server" Width="200px" CssClass="DropList"
                                            AutoPostBack="True" OnSelectedIndexChanged="ddCatagory_SelectedIndexChanged">
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width:10%">
                                        <strong>
                                            <asp:Label ID="Label2" runat="server" Text="Brand"></asp:Label>
                                        </strong>
                                    </td>
                                    <td style="width:90%">
                                        <asp:DropDownList ID="ddBrand" runat="server" Width="200px" CssClass="DropList" AutoPostBack="True"
                                            OnSelectedIndexChanged="ddBrand_SelectedIndexChanged">
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                            </table>

                                <fieldset style="border-width: 1px; border-color: Snow;width:90%;">
                                <legend style="text-align: center;">SKU Collection</legend>
                                <table width="100%">
                                    <tr>
                                        <td style="width: 45%" valign="top">
                                            <asp:ListBox ID="lstUnAssignSKU" runat="server" Width="100%" Height="200px">
                                            </asp:ListBox>
                                        </td>
                                        <td style="width: 10%" valign="middle" align="center">
                                            <asp:Button ID="btnAddAll" runat="server" Width="30px" Font-Size="8pt" Text=">>"
                                                OnClick="btnAddAll_Click" CssClass="Button" />
                                                <br />
                                                <br />
                                                <asp:Button ID="btnAdd" runat="server" Width="30px" Font-Size="8pt" Text=">" OnClick="btnAdd_Click"
                                                CssClass="Button" />
                                                <br />
                                                <br />
                                                <asp:Button ID="btnRemove" runat="server" Width="30px" Font-Size="8pt" Text="<" OnClick="btnRemove_Click"
                                                CssClass="Button" />
                                                <br />
                                                <br />
                                                <asp:Button ID="btnRemoveAll" runat="server" Width="30px" Font-Size="8pt" Text="<<"
                                                OnClick="btnRemoveAll_Click" CssClass="Button" />
                                        </td>
                                        <td style="width: 45%" valign="top">
                                            <asp:ListBox ID="lstAssignSKU" runat="server" Width="100%" Height="200px">
                                            </asp:ListBox>
                                        </td>
                                    </tr>
                                </table>
                                <table width="100%">                                                                        
                                    <tr>
                                        <td rowspan="1">
                                            <asp:CheckBox ID="chIsActive" runat="server" Visible="False" Text="Is Active" CssClass="lblbox">
                                            </asp:CheckBox>
                                        </td>
                                        <td align="center">
                                            <asp:Button ID="btnSave" OnClick="btnSave_Click" runat="server" Width="62px" Font-Size="8pt"
                                                Text="Save" ValidationGroup="vg" CssClass="Button" />
                                        </td>
                                        <td rowspan="1">
                                        </td>
                                    </tr>
                                </table>
                            </fieldset>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </td>
            </tr>
            <tr>
                <td style="width: 100%">
                    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                        <ContentTemplate>
                            <asp:Panel ID="Panel1" runat="server" Width="95%" Height="200px" ScrollBars="Vertical"
                                BackColor="#E0E0E0">
                                <asp:GridView ID="SKUGroup_Grid" runat="server" Width="99%" Height="1px" ForeColor="SteelBlue"
                                    CssClass="gridRow2" BackColor="White" OnPageIndexChanging="SKUGroup_Grid_PageIndexChanging"
                                    AutoGenerateColumns="False" BorderColor="White" HorizontalAlign="Center" OnRowEditing="SKUGroup_Grid_RowEditing">
                                    <PagerSettings FirstPageText="" LastPageText="" Mode="NextPrevious" NextPageText="Next"
                                        PreviousPageText="Previous"></PagerSettings>
                                    <Columns>
                                        <asp:BoundField DataField="SKU_GROUP_ID" HeaderText="Group Id">
                                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="GROUP_NAME" HeaderText="Group Name">
                                            <ItemStyle BorderColor="Silver" BorderWidth="1px" BorderStyle="Solid"></ItemStyle>
                                        </asp:BoundField>
                                        <asp:TemplateField HeaderText="SKU Name">
                                            <ItemTemplate>
                                                <asp:ListBox ID="listbox1" runat="server" Width="100%" AutoPostBack="True">
                                                </asp:ListBox>
                                            </ItemTemplate>
                                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                        </asp:TemplateField>
                                       
                                        <asp:CommandField ShowEditButton="True" >
                                            <ItemStyle BorderColor="Silver" BorderWidth="1px" BorderStyle="Solid"></ItemStyle>
                                        </asp:CommandField>
                                    </Columns>
                                    <HeaderStyle CssClass="tblhead"></HeaderStyle>
                                </asp:GridView>
                            </asp:Panel>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
