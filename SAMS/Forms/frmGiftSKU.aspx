<%@ Page Language="C#" MasterPageFile="~/Forms/PageMaster.master" AutoEventWireup="true"
    CodeFile="frmGiftSKU.aspx.cs" Inherits="Forms_frmGiftSKU" Title="SAMS :: Gift SKU Entry" %>

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
        <div style="z-index: 101; left: 437px; width: 100px; position: absolute; top: 80px;
            height: 100px">
            &nbsp;<asp:Panel ID="Panel21" runat="server">
                <asp:UpdateProgress ID="UpdateProgress1" runat="server" AssociatedUpdatePanelID="UpdatePanel1">
                    <ProgressTemplate>
                        <asp:ImageButton ID="ImageButton1" runat="server" Height="26px" ImageUrl="~/App_Themes/Granite/Images/image003.gif"
                            Width="23px" />
                        Wait Update
                    </ProgressTemplate>
                </asp:UpdateProgress>
            </asp:Panel>
        </div>
        <asp:UpdatePanel ID="UpdatePanel4" runat="server">
            <ContentTemplate>
                <table width="100%">
                    <tr>
                        <td>
                            <table>
                                <tbody>
                                    <tr>
                                        <td valign="top" align="left">
                                            <strong>
                                                <asp:Label ID="lbltoLocation" runat="server" Width="94px" Text="Location" CssClass="lblbox"></asp:Label></strong>
                                        </td>
                                        <td valign="top" align="left" colspan="2">
                                            <asp:DropDownList ID="drpDistributor" runat="server" Width="280px" CssClass="DropList"
                                                OnSelectedIndexChanged="drpDistributor_SelectedIndexChanged" AutoPostBack="True">
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="height: 17px" valign="top" align="left">
                                            <strong>Sale Force</strong>
                                        </td>
                                        <td style="height: 17px" valign="top" align="left" colspan="2">
                                            <asp:DropDownList ID="DrpSaleForce" runat="server" Width="280px" CssClass="DropList"
                                                OnSelectedIndexChanged="DrpSaleForce_SelectedIndexChanged" AutoPostBack="True">
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="height: 17px" valign="top" align="left">
                                            <strong>
                                                <asp:Label ID="lblDocumentNo" runat="server" Width="79px" Text="Order No" CssClass="lblbox"></asp:Label></strong>
                                        </td>
                                        <td style="height: 17px" valign="top" align="left" colspan="2">
                                            <asp:DropDownList ID="drpDocumentNo" runat="server" Width="280px" CssClass="DropList"
                                                OnSelectedIndexChanged="drpDocumentNo_SelectedIndexChanged" AutoPostBack="True">
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    
                                </tbody>
                            </table>
                            &nbsp;&nbsp; <strong>
                                <asp:CheckBox ID="ChbAllTax" runat="server" Checked="True" Text="Is Apply All Tax" /></strong>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <table>
                                <tbody>
                                    <tr>
                                        <td>
                                            <asp:Label ID="lblskuCode" runat="server" Width="100%" CssClass="lblDetail" Text="SKU Description"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="Label3" runat="server" Width="100%" CssClass="lblDetail" Text="Quantity"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="lblquantity" runat="server" Width="100%" CssClass="lblDetail" Text="Unit Price"></asp:Label>
                                        </td>
                                        <td align="center">
                                            <asp:Label ID="Label7" runat="server" Width="100%" CssClass="lblDetail" Text="GST Rate"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="Label2" runat="server" Width="100%" CssClass="lblDetail" Text="Amount"></asp:Label>
                                        </td>
                                        <td>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="height: 21px">
                                            <asp:DropDownList ID="ddlSKuCde" runat="server" Width="299px" onfocus="ddlFocus(this);"
                                                onblur="ddlBlur(this);">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="height: 21px">
                                            <asp:TextBox ID="txtQuantity" runat="server" Width="61px" CssClass="txtBox "></asp:TextBox>
                                        </td>
                                        <td style="height: 21px">
                                            <asp:TextBox ID="txtUnitRate" runat="server" Width="62px" CssClass="txtBox" Enabled="False"></asp:TextBox>
                                        </td>
                                        <td style="height: 21px">
                                            <asp:TextBox ID="txtBatchNo" runat="server" Width="62px" CssClass="txtBoxnNum"></asp:TextBox>
                                        </td>
                                        <td style="height: 21px">
                                            <asp:TextBox ID="TextBox1" runat="server" Width="72px" CssClass="txtBoxnNum" Enabled="False"></asp:TextBox>
                                        </td>
                                        <td style="height: 21px">
                                            <asp:Button AccessKey="A" ID="btnSave" OnClick="btnSave_Click" runat="server" Width="100px"
                                                Font-Size="8pt" Text="Add Sku" ValidationGroup="vg" CssClass="Button" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="left" colspan="7">
                                            <asp:Panel ID="Panel2" runat="server" Width="100%" Height="200px" ScrollBars="Vertical"
                                                BorderWidth="1px" BorderStyle="Groove" BorderColor="Silver">
                                                <asp:GridView ID="GrdPurchase" runat="server" ForeColor="SteelBlue" CssClass="gridRow2"
                                                    BackColor="White" BorderColor="White" ShowHeader="False" OnRowDeleting="GrdPurchase_RowDeleting"
                                                    HorizontalAlign="Center" AutoGenerateColumns="False" Width="100%">
                                                    <RowStyle ForeColor="Black" />
                                                    <Columns>
                                                        <asp:BoundField DataField="SALE_ORDER_PROMOTION_ID" HeaderText="SALE_ORDER_PROMOTION_ID">
                                                            <HeaderStyle CssClass="HidePanel" />
                                                            <ItemStyle CssClass="HidePanel" />
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="SKU_ID" HeaderText="SKU_ID">
                                                            <HeaderStyle CssClass="HidePanel" />
                                                            <ItemStyle CssClass="HidePanel" />
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="SKU_CODE" HeaderText="SKU Code">
                                                            <ItemStyle CssClass="grdDetail" HorizontalAlign="Left" Width="79px" />
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="SKU_NAME" HeaderText="SKU Name">
                                                            <ItemStyle CssClass="grdDetail" HorizontalAlign="Left" Width="160px" />
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="PACKSIZE" >
                                                            <ItemStyle CssClass="grdDetail" HorizontalAlign="Left" Width="60px" />
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="QUANTITY" HeaderText="Quantity">
                                                            <ItemStyle CssClass="grdDetail" HorizontalAlign="Right" Width="61px" />
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="UNIT_PRICE" DataFormatString="{0:F2}" HeaderText="PRICE">
                                                            <ItemStyle CssClass="grdDetail" HorizontalAlign="Right" Width="62px" />
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="GST_RATE" HeaderText="GST Rate">
                                                            <ItemStyle CssClass="grdDetail" Width="62px" />
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="Amount" DataFormatString="{0:F2}" HeaderText="Amount">
                                                            <ItemStyle CssClass="grdDetail" HorizontalAlign="Right" Width="72px" />
                                                        </asp:BoundField>
                                                        <asp:TemplateField HeaderText="Delete">
                                                            <ItemTemplate>
                                                                <asp:LinkButton ID="btnDelete" runat="server" CommandName="Delete" OnClientClick="javascript:return confirm('Are you sure you want to Delete?');return false;"
                                                                    Text="Delete"></asp:LinkButton>
                                                            </ItemTemplate>
                                                            <ItemStyle CssClass="grdDetail" HorizontalAlign="Center" Width="86px" />
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
                                </tbody>
                            </table>
                            <asp:HiddenField ID="HfOrderbooker_id" runat="server" />
                            <asp:HiddenField ID="HfDELIVERYMAN_ID" runat="server" />
                            <asp:HiddenField ID="Hflegend_id" runat="server" />
                            <asp:HiddenField ID="HfCREDIT_AMOUNT" runat="server" />
                            <asp:HiddenField ID="HfCUSTOMER_ID" runat="server" />
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</asp:Content>
