<%@ Page Language="C#" MasterPageFile="~/Forms/PageMaster.master" AutoEventWireup="true"
    CodeFile="frmPysicalStockteken.aspx.cs" Inherits="Forms_frmPysicalStockteken"
    Title="SAMS :: Physical Stock Taking" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<asp:Content ID="Content1" runat="server" ContentPlaceHolderID="cphPage">
    <script type="text/javascript" src="../AjaxLibrary/jquery.searchabledropdown-1.0.8.min.js"></script>
    <script language="JavaScript" type="text/javascript">

        function ValidateForm() {
            var str;

           
            str = document.getElementById('<%=txtQuantity.ClientID%>').value;
            if (str == null || str.length == 0) {
                alert('Must Enter Quantity');
                return false;
            }


            return true;
        }



        function ClearSelection(lb) {
            lb.selectedIndex = -1;
        }

        function ddlFocus(obj) {
            obj.className = "ddlFocus";
        }

        function ddlBlur(obj) {
            obj.className = "";

        }
        function pageLoad() {

            $("select").searchable();
        }

    </script>
    <div id="right_data">
        <div>
            <table width="100%">
                <tr>
                    <td>
                        <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                            <ContentTemplate>
                                <table>
                                    <tbody>
                                        <tr>
                                            <td style="height: 25px" align="left">
                                                <strong>
                                                    <asp:Label Width="74px" CssClass="lblbox" ID="lblDocumentNo" runat="server" Text="Location"></asp:Label></strong>
                                            </td>
                                            <td style="height: 25px">
                                                <asp:DropDownList CssClass="DropList" ID="drpDistributor" runat="server" Width="200px">
                                                </asp:DropDownList>
                                            </td>
                                            <td align="center" style="width: 316px" colspan="1" rowspan="2" valign="middle">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="height: 25px" align="left">
                                                <strong>
                                                    <asp:Label CssClass="lblbox" ID="lbltoLocation" runat="server" Text="Principal" Width="73px"></asp:Label></strong>
                                            </td>
                                            <td style="height: 25px">
                                                <asp:DropDownList AutoPostBack="True" CssClass="DropList" ID="drpPrincipal" OnSelectedIndexChanged="drpPrincipal_SelectedIndexChanged"
                                                    runat="server" Width="200px">
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="left" colspan="2" style="height: 25px">
                                               
                                            </td>
                                            <td style="width: 316px" align="center" colspan="1" rowspan="1" valign="middle">
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </td>
                </tr>
            </table>
            &nbsp;</div>
        <div>
            <table width="100%">
                <tr>
                    <td>
                        <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                            <ContentTemplate>
                                <table>
                                    <tr>
                                        <td style="height: 16px">
                                            <strong>
                                                <asp:Label ID="lblskuCode" runat="server" CssClass="lblDetail"
                                                    Text="  SKU Decription" Width="100%"></asp:Label></strong>
                                        </td>
                                       
                                        <td style="height: 16px">
                                            <strong>
                                                <asp:Label ID="Label2" runat="server" CssClass="lblDetail"
                                                     Text="Sale Ctn" Width="80px"></asp:Label></strong>
                                        </td>
                                        <td style="height: 16px">
                                            <strong>
                                                <asp:Label ID="lblquantity" runat="server" CssClass="lblDetail"
                                                    Text="Sale Qty" Width="80px"></asp:Label></strong>
                                        </td>
                                        <td style="height: 16px;">
                                            <strong>
                                                <asp:Label ID="Label3" runat="server" CssClass="lblDetail"
                                                     Text="Un Sale Ctn" Width="87px"></asp:Label></strong>
                                        </td>
                                        <td style="height: 16px;">
                                            <strong>
                                                <asp:Label ID="lblFreeSKU" runat="server" CssClass="lblDetail"
                                                    Text="Un Sale Qty" Width="87px"></asp:Label></strong>
                                        </td>
                                        <td style="height: 16px">
                                            <strong>
                                                <asp:Label ID="Label1" runat="server" CssClass="lblDetail"
                                                     Text="Unit Rate" Width="80px"></asp:Label></strong>
                                        </td>
                                        <td style="height: 16px">
                                          
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                              <asp:DropDownList ID="ddlSKuCde" runat="server" Width="299px"  onfocus="ddlFocus(this);" 
                                                    onblur="ddlBlur(this);" 
                                                  >
                                                </asp:DropDownList>
                                            </td>
                                        <td style="height: 9px">
                                            <asp:TextBox ID="txtCtn" runat="server" CssClass="txtBox " onfocus="SearchSKUCode()"
                                                Width="80px"></asp:TextBox>
                                        </td>
                                        <td style="height: 9px">
                                            <asp:TextBox ID="txtQuantity" runat="server" Width="80px"></asp:TextBox>
                                        </td>
                                        <td style="height: 9px;">
                                            <asp:TextBox ID="txtusaleableCtn" runat="server" CssClass="txtBox " onfocus="SearchSKUCode()"
                                                Width="87px"></asp:TextBox>
                                        </td>
                                        <td style="height: 9px;">
                                            <asp:TextBox ID="txtusaleableqty" runat="server" Width="87px"></asp:TextBox>
                                        </td>
                                        <td style="height: 9px">
                                            <asp:TextBox ID="txtUnitRate" runat="server" Width="80px">0</asp:TextBox>
                                        </td>
                                        <td style="height: 9px">
                                            <asp:Button ID="btnSave" runat="server" AccessKey="A" Font-Size="8pt" OnClick="btnSave_Click"
                                                Text="Save" ValidationGroup="vg" Width="87px" CssClass="Button" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="left" colspan="8">
                                            <asp:Panel ID="Panel2" runat="server" BorderColor="Silver" BorderStyle="Groove" BorderWidth="1px"
                                                Height="180px" ScrollBars="Vertical" Width="100%">
                                                <asp:GridView ID="GrdPurchase" runat="server" AutoGenerateColumns="False" BackColor="White"
                                                    BorderColor="White" ForeColor="SteelBlue" HorizontalAlign="Center" OnRowDeleting="GrdPurchase_RowDeleting"
                                                    OnRowEditing="GrdPurchase_RowEditing" ShowHeader="False" Width="100%">
                                                    <PagerSettings FirstPageText="" LastPageText="" Mode="NextPrevious" NextPageText="Next"
                                                        PreviousPageText="Previous" />
                                                    <RowStyle ForeColor="Black" />
                                                    <Columns>
                                                        <asp:BoundField DataField="SKU_ID" HeaderText="SKU_ID">
                                                            <HeaderStyle CssClass="HidePanel" />
                                                            <ItemStyle CssClass="HidePanel" />
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="SKU_CODE" HeaderText="SKU Code">
                                                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="2px" HorizontalAlign="Left"
                                                                Width="85px" />
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="SKU_NAME" HeaderText="SKU Name">
                                                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="2px" HorizontalAlign="Left"
                                                                Width="140px" />
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="PACKSIZE">
                                                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="2px" HorizontalAlign="Left"
                                                                Width="65px" />
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="SALEABLE_CTN" HeaderText="Salable Ctn">
                                                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="2px" HorizontalAlign="Right"
                                                                Width="82px" />
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="SALEABLE_QUANTITY" HeaderText="Quantity">
                                                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="2px" HorizontalAlign="Right"
                                                                Width="82px" />
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="UNSALEABLE_CTN" HeaderText="Unsalable Ctn">
                                                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="2px" HorizontalAlign="Right"
                                                                Width="82px" />
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="UNSALEABLE_QUANTITY" HeaderText="Unsalable Quantity">
                                                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="2px" HorizontalAlign="Right"
                                                                Width="82px" />
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="UNIT_RATE" HeaderText="UNIT_RATE" DataFormatString="{0:F2}">
                                                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="70px"
                                                                HorizontalAlign="Right" />
                                                        </asp:BoundField>
                                                        <asp:CommandField HeaderText="Edit" ShowEditButton="True">
                                                            <ItemStyle BorderColor="Silver" BorderWidth="2px" Width="40px" />
                                                        </asp:CommandField>
                                                        <asp:TemplateField HeaderText="Delete">
                                                            <ItemTemplate>
                                                                <asp:LinkButton ID="btnDelete" runat="server" CommandName="Delete" OnClientClick="javascript:return confirm('Are you sure you want to Delete?');return false;"
                                                                    Text="Delete"></asp:LinkButton>
                                                            </ItemTemplate>
                                                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="2px" Width="40px" />
                                                        </asp:TemplateField>
                                                    </Columns>
                                                    <FooterStyle BackColor="White" />
                                                    <PagerStyle BackColor="Transparent" />
                                                    <HeaderStyle BackColor="#007395" Font-Bold="True" ForeColor="White" HorizontalAlign="Center"
                                                        VerticalAlign="Middle" />
                                                    <AlternatingRowStyle BackColor="#F2F2F2" CssClass="GridAlternateRowStyle" ForeColor="#333333" />
                                                </asp:GridView>
                                            </asp:Panel>
                                        </td>
                                    </tr>
                                </table>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </td>
                </tr>
            </table>
        </div>
    </div>
</asp:Content>
