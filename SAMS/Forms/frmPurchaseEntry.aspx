<%@ Page Language="C#" MasterPageFile="~/Forms/PageMaster.master" AutoEventWireup="true"
    CodeFile="frmPurchaseEntry.aspx.cs" Inherits="Forms_frmPurchaseEntry" Title="SAMS :: Stock Register" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<asp:Content ID="Content1" runat="server" ContentPlaceHolderID="cphPage">
    <script type="text/javascript" src="../AjaxLibrary/jquery.searchabledropdown-1.0.8.min.js"></script>
    
    <script type="text/javascript">

        function pageLoad() {
            $("select").searchable();
        }

        function ValidateForm() {


            var DCNo = $('#ctl00_ctl00_mainCopy_cphPage_txtDocumentNo').val();
            if (DCNo == '') {

                $('#valid_error_msg').html("Invoice/DC No cannot be empty");
                $('#valid_error_msg').parent().show();

                return false;
            }

            var Quantity = $('#ctl00_ctl00_mainCopy_cphPage_txtQuantity').val();
            var Cotton = $('#ctl00_ctl00_mainCopy_cphPage_txtCtn').val();
              
           
            if ((Quantity == '' || Quantity == 0) && (Cotton == '' || Cotton == 0)){

                $('#valid_error_msg').html("Quantity cannot be empty");
                $('#valid_error_msg').parent().show();

                return false;
            }
            $('#valid_error_msg').html("");
            return true;

        }
        var prm = Sys.WebForms.PageRequestManager.getInstance();
        //Raised before processing of an asynchronous postback starts and the postback request is sent to the server.
        prm.add_beginRequest(BeginRequestHandler);
        // Raised after an asynchronous postback is finished and control has been returned to the browser.
        prm.add_endRequest(EndRequestHandler);
        function BeginRequestHandler(sender, args) {
            //Shows the modal popup - the update progress
            var popup = $find('<%= modalPopup.ClientID %>');
            if (popup != null) {
                popup.show();
            }
        }

        function EndRequestHandler(sender, args) {
            //Hide the modal popup - the update progress
            var popup = $find('<%= modalPopup.ClientID %>');
            if (popup != null) {
                popup.hide();
            }
        }          
        
       
    </script>
    <div>
    <asp:UpdateProgress ID="UpdateProgress" runat="server">
        <ProgressTemplate>
            <asp:ImageButton ID="ImageButton10" runat="server" Height="28px" ImageUrl="~/App_Themes/Granite/Images/image003.gif"
                Width="31px" />
        </ProgressTemplate>
    </asp:UpdateProgress>
    <ajaxToolkit:ModalPopupExtender ID="modalPopup" runat="server" TargetControlID="UpdateProgress"
        PopupControlID="UpdateProgress" BackgroundCssClass="modalBackground">
    </ajaxToolkit:ModalPopupExtender>
</div>
    <div id="right_data">
       
            <div class='error_msg'>
               
                <div class='error_field' id='valid_error_msg'>
                </div>
            </div>
    
    <div>
        <table width="100%">
            <tr>
                <td>
                    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                        <ContentTemplate>
                            <table width="100%">
                                <tr>
                                    <td style="width: 50%" valign="top">
                                        <table width="100%" cellpadding="2" cellspacing="2">
                                            <tr>
                                                <td style="width: 30%">
                                                    <strong>
                                                        <asp:Label ID="Label2" runat="server" Text="Transaction Type"></asp:Label>
                                                    </strong>
                                                </td>
                                                <td style="width: 70%">
                                                    <asp:DropDownList ID="DrpDocumentType" runat="server" AutoPostBack="True" OnSelectedIndexChanged="DrpDocumentType_SelectedIndexChanged"
                                                        Width="200px">
                                                        <asp:ListItem Value="2">Purchase</asp:ListItem>
                                                        <asp:ListItem Value="5">Transfer Out</asp:ListItem>
                                                        <asp:ListItem Value="3">Purchase Return</asp:ListItem>
                                                        <asp:ListItem Value="4">Transfer In</asp:ListItem>
                                                        <asp:ListItem Value="6">Damage</asp:ListItem>
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="width: 30%">
                                                    <strong>
                                                        <asp:Label ID="lblDocumentNo" runat="server" Text="Document No"></asp:Label>
                                                    </strong>
                                                </td>
                                                <td style="width: 70%">
                                                    <asp:DropDownList ID="drpDocumentNo" runat="server" AutoPostBack="True" OnSelectedIndexChanged="drpDocumentNo_SelectedIndexChanged"
                                                        Width="200px">
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="width: 30%">
                                                    <strong>
                                                        <asp:Label ID="lbltoLocation" runat="server" Text="Principal"></asp:Label>
                                                    </strong>
                                                </td>
                                                <td style="width: 70%">
                                                    <asp:DropDownList ID="drpPrincipal" runat="server" AutoPostBack="True" OnSelectedIndexChanged="drpPrincipal_SelectedIndexChanged"
                                                        Width="200px">
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="width: 30%">
                                                    <strong>
                                                        <asp:Label ID="lblfromLocation" runat="server" Text="Purchase For"></asp:Label>
                                                    </strong>
                                                </td>
                                                <td style="width: 70%">
                                                    <asp:DropDownList ID="drpDistributor" runat="server" AutoPostBack="True" Width="200px">
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="width: 30%">
                                                    <strong>
                                                        <asp:Label ID="lblTransferTo" runat="server" Text="Transfer To" Visible="False"></asp:Label>
                                                    </strong>
                                                </td>
                                                <td style="width: 70%">
                                                    <asp:DropDownList ID="DrpTransferFor" runat="server" Visible="False" Width="200px">
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="width: 30%">
                                                    <strong>
                                                        <asp:Label ID="Label1" runat="server" Text="INV/DC  No"></asp:Label>
                                                    </strong>
                                                </td>
                                                <td style="width: 70%">
                                                    <asp:TextBox ID="txtDocumentNo" runat="server" Width="195px"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="width: 30%">
                                                    <strong>
                                                        <asp:Label ID="Label3" runat="server" Text="Remarks"></asp:Label>
                                                    </strong>
                                                </td>
                                                <td style="width: 70%">
                                                    <asp:TextBox ID="txtBuiltyNo" runat="server" Width="195px"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="width: 30%">
                                                </td>
                                                <td style="width: 70%">
                                                    <asp:CheckBox ID="ChbFreeSKU" runat="server" Text="Apply Free SKU" AutoPostBack="True"
                                                        OnCheckedChanged="ChbFreeSKU_CheckedChanged"></asp:CheckBox>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                    <td style="width: 50%;" valign="middle" align="left">
                                        <asp:Panel ID="pnlSummary" runat="server" Width="70%" ScrollBars="None" BorderWidth="1px"
                                            BorderStyle="Groove" BorderColor="Silver" Style="padding: 10px;">
                                            <table width="100%" cellpadding="2" cellspacing="2">
                                                <tr>
                                                    <td style="width: 30%">
                                                        <strong>Gross Amount</strong>
                                                    </td>
                                                    <td style="width: 70%">
                                                        <asp:TextBox ID="txtGrossAmount" runat="server" Enabled="false" Width="100%"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 30%">
                                                        <strong>Discount</strong>
                                                    </td>
                                                    <td style="width: 70%">
                                                        <asp:TextBox ID="txtDiscount2" runat="server" Enabled="false" Width="100%"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 30%">
                                                        <strong>Net Value</strong>
                                                    </td>
                                                    <td style="width: 70%">
                                                        <asp:TextBox ID="txtNetValue" runat="server" Enabled="false" Width="100%"></asp:TextBox>
                                                    </td>
                                                </tr>
                                            </table>
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
    <div>
        <table width="100%">
            <tr>
                <td>
                    <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                        <ContentTemplate>
                            <table>
                                <tbody>
                                    <tr>
                                        <td>
                                            <asp:Label ID="lblskuCode" runat="server" Width="100%" Text="  SKU Description" CssClass="lblDetail"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="Label8" runat="server" Width="81" Text="Ctn" CssClass="lblDetail"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="lblquantity" runat="server" Width="88px" Text="Unit" CssClass="lblDetail"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="lblFreeSKU" runat="server" Width="88" Text="Free SKU" CssClass="lblDetail"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="Label9" runat="server" Width="88" Text="Purchase Rate" CssClass="lblDetail"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="Label10" runat="server" Width="88" Text="Discount(%)" CssClass="lblDetail"></asp:Label>
                                        </td>
                                        <td>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:DropDownList ID="ddlSKuCde" runat="server" Width="315px">
                                            </asp:DropDownList>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtCtn" onfocus="SearchedCode()" runat="server" Width="80px"></asp:TextBox>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtQuantity" runat="server" Width="88px"></asp:TextBox>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtFreeSKU" runat="server" Width="88px" CssClass="txtBox" Enabled="False">0</asp:TextBox>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtCurrentRate" runat="server" Width="88px" Text="0.00"></asp:TextBox>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtDiscount" runat="server" Width="88px" Text="0.00"></asp:TextBox>
                                            <ajaxToolkit:FilteredTextBoxExtender ID="FilteredTextBoxExtender1" runat="server"
                                                FilterType="Custom" ValidChars="0123456789." TargetControlID="txtDiscount">
                                            </ajaxToolkit:FilteredTextBoxExtender>
                                        </td>
                                        <td>
                                            <asp:Button AccessKey="A" ID="btnSave" OnClick="btnSave_Click" runat="server" Width="90px"
                                                Font-Size="8pt" Text="Add Sku" CssClass="Button" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="left" colspan="7">
                                            <asp:Panel ID="Panel2" runat="server" Width="100%" Height="130px" ScrollBars="Vertical"
                                                BorderWidth="1px" BorderStyle="Groove" BorderColor="Silver">
                                                <asp:GridView ID="GrdPurchase" runat="server" AutoGenerateColumns="False" BackColor="White"
                                                    BorderColor="White" CssClass="gridRow2" ForeColor="SteelBlue" HorizontalAlign="Center"
                                                    OnRowDeleting="GrdPurchase_RowDeleting" OnRowEditing="GrdPurchase_RowEditing"
                                                    ShowHeader="False" Width="100%">
                                                    <RowStyle ForeColor="Black" />
                                                    <Columns>
                                                        <asp:BoundField DataField="SKU_ID" HeaderText="SKU_ID">
                                                            <HeaderStyle CssClass="HidePanel" />
                                                            <ItemStyle CssClass="HidePanel" />
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="SKU_CODE" HeaderText="SKU Code">
                                                            <ItemStyle CssClass="grdDetail" HorizontalAlign="Left" Width="55px" />
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="SKU_NAME" HeaderText="SKU Name">
                                                            <ItemStyle CssClass="grdDetail" HorizontalAlign="Left" Width="180px" />
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="PACKSIZE" HeaderText="Pack Size">
                                                            <ItemStyle CssClass="grdDetail" HorizontalAlign="Left" Width="65px" />
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="QuantityCtn" HeaderText="Ctn">
                                                            <ItemStyle CssClass="grdDetail" HorizontalAlign="Right" Width="75px" />
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="Quantity" HeaderText="Quantity">
                                                            <ItemStyle CssClass="grdDetail" HorizontalAlign="Right" Width="75px" />
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="FREE_SKU" HeaderText="Free SKU">
                                                            <ItemStyle CssClass="grdDetail" HorizontalAlign="Right" Width="75px" />
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="PRICE" HeaderText="PRICE">
                                                            <ItemStyle CssClass="grdDetail" HorizontalAlign="Right" Width="75px" />
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="DISCOUNT" HeaderText="DISCOUNT">
                                                            <ItemStyle CssClass="grdDetail" HorizontalAlign="Right" Width="75px" />
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="TRADE_PRICE">
                                                            <ItemStyle CssClass="HidePanel" />
                                                            <HeaderStyle CssClass="HidePanel" />
                                                        </asp:BoundField>
                                                        <asp:CommandField HeaderText="Edit" ShowEditButton="True">
                                                            <ItemStyle CssClass="grdDetail" Width="40px" HorizontalAlign="Center" />
                                                        </asp:CommandField>
                                                        <asp:TemplateField HeaderText="Delete">
                                                            <ItemTemplate>
                                                                <asp:LinkButton ID="btnDelete" runat="server" CommandName="Delete" OnClientClick="javascript:return confirm('Are you sure you want to Delete?');return false;"
                                                                    Text="Delete"></asp:LinkButton>
                                                            </ItemTemplate>
                                                            <ItemStyle CssClass="grdDetail" Width="40px" HorizontalAlign="Center" />
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
                                    <tr>
                                        <td>
                                            <asp:Button AccessKey="S" ID="btnSaveDocument" runat="server" Width="110px" Font-Size="8pt"
                                                Text="Save Document" UseSubmitBehavior="False" OnClick="btnSaveDocument_Click"
                                                CssClass="Button" />
                                            <asp:Button AccessKey="C" ID="btnCancel" runat="server" Width="110px" Font-Size="8pt"
                                                Text="Cancel" UseSubmitBehavior="False" OnClick="btnCancel_Click" CssClass="Button" />
                                            <strong>
                                                <asp:Label ID="Label7" runat="server" Height="16px" Text="Total Quantity"></asp:Label></strong>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtTotalCtn" onkeyup="SearchList()" runat="server" Width="81px"
                                                ReadOnly="True"></asp:TextBox>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtTotalQuantity" onkeyup="SearchList()" runat="server" Width="88px"
                                                ReadOnly="True"></asp:TextBox>
                                        </td>
                                        <td>
                                        </td>
                                        <td>
                                        </td>
                                        <td>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </td>
            </tr>
        </table>
    </div>
    </div>
</asp:Content>
