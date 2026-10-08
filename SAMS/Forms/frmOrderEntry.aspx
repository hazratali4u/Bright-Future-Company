<%@ Page Language="C#" MasterPageFile="~/Forms/PageMaster.master" AutoEventWireup="true"
    MaintainScrollPositionOnPostback="true" CodeFile="frmOrderEntry.aspx.cs" Inherits="Forms_frmOrderEntry"
    Title="SAMS :: Order/Invoice Step 2" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<asp:Content ID="Content1" runat="server" ContentPlaceHolderID="cphPage">
    <script type="text/javascript" src="../AjaxLibrary/jquery.searchabledropdown-1.0.8.min.js"></script>
    <script language="JavaScript" type="text/javascript">
        function pageLoad() {
            $("select").searchable();
            //find the current popup
            var popUp = $find('ModelPopup');

            //check it exists so the script won't fail
            if (popUp) {
                //Add the function below as the event
                popUp.add_hidden(HidePopupPanel);
            }
        }

        function HidePopupPanel(source, args) {
            //find the panel associated with the extender
            objPanel = document.getElementById(source._PopupControlID);

            //check the panel exists
            if (objPanel) {
                //set the display attribute, so it remains hidden on postback
                objPanel.style.display = 'none';
            }
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

        function ValidateForm() {
            var str;
            str = document.getElementById('<%=txtQuantity.ClientID%>').value;
            var str2 = document.getElementById('<%=txtCtn.ClientID%>').value;
            if ((str == null || str.length == 0) && (str2 == null || str2.length == 0)) {
                alert('Must Enter Quantity');
                return false;
            }
            return true;
        }

    </script>
    <div id="right_data">        
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
        <div>
            <span class="heading">Order/Invoice Step 2</span>
        </div>
        <div>
            <table width="100%">
                <tr>
                    <td align="left">                        
                        <asp:UpdatePanel ID="UpdatePanel4" runat="server">
                            <ContentTemplate>
                                <table width="100%">
                                    <tbody>
                                        <tr>
                                            <td valign="top" align="left" style="width:15%">
                                                <strong>
                                                   Invoice #</strong>
                                            </td>
                                            <td valign="top" align="left" colspan="2">
                                                <asp:DropDownList ID="drpDocumentNo" runat="server" Width="231px" OnSelectedIndexChanged="drpDocumentNo_SelectedIndexChanged"
                                                    AutoPostBack="True">
                                                </asp:DropDownList>
                                                <strong>
                                                    <asp:Label ID="lblBillBook" runat="server" Text="Bill Book No:" Visible="false"></asp:Label></strong>
                                                <asp:TextBox ID="txtBillBookNo" runat="server" CssClass="uppercase" MaxLength="10"
                                                    Visible="false" Width="22px"></asp:TextBox>
                                            </td>
                                            <td>
                                                <asp:CheckBox ID="ChbDiscount" runat="server" Width="90px" Text="Promotion" AutoPostBack="True"
                                                    Checked="True" Visible="false"></asp:CheckBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td valign="middle" align="left">
                                                <strong>
                                                    Invoice Type</strong>
                                            </td>
                                            <td valign="top" align="left" colspan="2">
                                                <asp:RadioButtonList ID="RblPayMode" runat="server" Width="228px" Height="1px" RepeatDirection="Horizontal">
                                                    <asp:ListItem Selected="True" Value="214">Cash</asp:ListItem>
                                                    <asp:ListItem Value="215">Credit</asp:ListItem>
                                                    <asp:ListItem Value="216">Advance</asp:ListItem>
                                                </asp:RadioButtonList>
                                            </td>
                                            <td valign="top" align="left" colspan="1">
                                                <asp:CheckBox ID="ChbBatchNo" runat="server" Width="94px" Text="Batch No" AutoPostBack="True"
                                                    Visible="false"></asp:CheckBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td valign="middle" align="left">
                                                <strong>
                                                    Area/Saleman</strong>
                                            </td>
                                            <td valign="top" align="left" colspan="2">
                                                <asp:TextBox ID="txtprincipal" runat="server" Width="295px" CssClass="txtBox " ReadOnly="True"></asp:TextBox>
                                            </td>
                                            <td valign="top" align="left" colspan="1">
                                                <asp:TextBox ID="txtDeliveryMan" runat="server" Width="180px" CssClass="txtBox "
                                                    ReadOnly="True"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="height: 23px" align="left">
                                                <strong>
                                                   Customer</strong>
                                            </td>
                                            <td style="height: 23px" align="left" colspan="2">
                                                <asp:DropDownList ID="drpCustomer" runat="server" Width="290px" AutoPostBack="true"
                                                    OnSelectedIndexChanged="ddlCustomer_SelectedIndexChange">
                                                </asp:DropDownList>                                                
                                            </td>
                                            <td style="height: 23px" align="left">
                                                <asp:TextBox ID="txtPriceGroup" runat="server" Width="90px"></asp:TextBox>
                                                <asp:TextBox ID="txtDiscountType" runat="server" Width="180px" CssClass="txtBox "
                                                    ReadOnly="True"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td valign="middle" align="left">
                                                <strong>
                                                    <label style="width: 77px;">
                                                        Remarks</label></strong>
                                            </td>
                                            <td valign="top" align="left" colspan="3">
                                                <asp:TextBox ID="txtRemarks" runat="server" Width="100%"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="4">
                                                &nbsp;
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="4">
                                                <table width="100%">
                                                    <tr>
                                                        <td style="width:15%">
                                                            <strong>SKU Category:</strong>
                                                        </td>
                                                        <td style="width:35%">                                                            
                                                            <asp:DropDownList ID="ddlCategory" runat="server" Width="100%"
                                                            AutoPostBack="true" onselectedindexchanged="ddlCategory_SelectedIndexChanged"></asp:DropDownList>
                                                        </td>
                                                        <td style="width:50%">
                                                            <strong>Available Stock:</strong>
                                                            <asp:TextBox ID="txtStock" runat="server" Text="0-0" Enabled="false" Width="100px"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </td>
                    <td>
                    </td>
                </tr>
                <tr>
                    <td align="left">
                        <asp:Panel ID="Panel5" runat="server" DefaultButton="btnSave">
                            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                <ContentTemplate>
                                    <table width="100%">
                                        <tr>
                                            <td style="width: 10%" class="lblDetail">
                                                <strong style="color: White;">SKU Description</strong>
                                            </td>
                                            <td style="width: 8%" class="lblDetail">
                                                <strong style="color: White;">Ctn</strong>
                                            </td>
                                            <td style="width: 8%" class="lblDetail">
                                                <strong style="color: White;">Unit</strong>
                                            </td>
                                            <td style="width: 8%" class="lblDetail">
                                                <strong style="color: White;">Unit Price</strong>
                                            </td>
                                            <td style="width: 8%" class="lblDetail">
                                                <strong style="color: White;">Amount</strong>
                                            </td>
                                            <td style="width: 8%" colspan="2">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:DropDownList ID="ddlSKuCde" runat="server" Width="302px" AutoPostBack="true"
                                                    OnSelectedIndexChanged="ddlSKuCde_SelectedIndexChanged">
                                                </asp:DropDownList>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtCtn" runat="server" Width="100%"></asp:TextBox>
                                                <ajaxToolkit:FilteredTextBoxExtender ID="FilteredTextBoxExtender5" runat="server"
                                                    FilterType="Custom" ValidChars="01234567890." TargetControlID="txtCtn">
                                                </ajaxToolkit:FilteredTextBoxExtender>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtQuantity" runat="server" Width="100%"></asp:TextBox>
                                                <ajaxToolkit:FilteredTextBoxExtender ID="FilteredTextBoxExtender6" runat="server"
                                                    FilterType="Custom" ValidChars="01234567890." TargetControlID="txtQuantity">
                                                </ajaxToolkit:FilteredTextBoxExtender>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtUnitRate" runat="server" Width="100%" Enabled="False"></asp:TextBox>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtAmount" runat="server" Enabled="False" Width="100%"></asp:TextBox>
                                            </td>
                                            <td>
                                                <asp:DropDownList runat="server" ID="drpReturnType" Visible="false">
                                                    <asp:ListItem Value="1" Text="Expiry"></asp:ListItem>
                                                    <asp:ListItem Value="2" Text="Damage"></asp:ListItem>
                                                    <asp:ListItem Selected="True" Value="3" Text="Saleable"></asp:ListItem>
                                                </asp:DropDownList>
                                            </td>
                                            <td colspan="2">
                                                <asp:Button ID="btnSave" runat="server" Font-Size="8pt" OnClick="btnSave_Click" Text="Add"
                                                    ValidationGroup="vg" Width="100%" AccessKey="A" CssClass="Button" />
                                            </td>
                                        </tr>
                                    </table>
                                    <asp:Panel ID="Panel2" runat="server" Height="130px" ScrollBars="Vertical" Width="100%"
                                        BorderColor="Silver" BorderStyle="Groove" BorderWidth="1px">
                                        <asp:GridView ID="GrdPurchase" runat="server" ForeColor="SteelBlue" BackColor="White"
                                            HorizontalAlign="Center" AutoGenerateColumns="False" BorderColor="White" ShowHeader="False"
                                            OnRowDeleting="GrdPurchase_RowDeleting" OnRowEditing="GrdPurchase_RowEditing"
                                            Width="100%">
                                            <Columns>
                                                <asp:BoundField DataField="SKU_ID" HeaderText="SKU_ID">
                                                    <HeaderStyle CssClass="HidePanel"></HeaderStyle>
                                                    <ItemStyle CssClass="HidePanel"></ItemStyle>
                                                </asp:BoundField>
                                                <asp:BoundField DataField="SKU_CODE" HeaderText="SKU Code">
                                                    <ItemStyle HorizontalAlign="Left" CssClass="grdDetail" Width="13%"></ItemStyle>
                                                </asp:BoundField>
                                                <asp:BoundField DataField="SKU_NAME" HeaderText="SKU Name">
                                                    <ItemStyle HorizontalAlign="Left" CssClass="grdDetail" Width="20%"></ItemStyle>
                                                </asp:BoundField>
                                                 <asp:BoundField DataField="PACKSIZE" HeaderText="Pack Size">
                                                    <ItemStyle HorizontalAlign="Left" CssClass="grdDetail" Width="8%"></ItemStyle>
                                                </asp:BoundField>
                                                <asp:BoundField DataField="QUANTITY_CTN" HeaderText="Ctn">
                                                    <ItemStyle HorizontalAlign="Right" CssClass="grdDetail" Width="12%"></ItemStyle>
                                                </asp:BoundField>
                                                <asp:BoundField DataField="QUANTITY_UNIT" HeaderText="Quantity">
                                                    <ItemStyle HorizontalAlign="Right" CssClass="grdDetail" Width="12%"></ItemStyle>
                                                </asp:BoundField>
                                                <asp:BoundField DataField="UNIT_PRICE" HeaderText="PRICE" DataFormatString="{0:F2}">
                                                    <ItemStyle HorizontalAlign="Right" CssClass="grdDetail" Width="12%"></ItemStyle>
                                                </asp:BoundField>
                                                <asp:BoundField DataField="Amount" HeaderText="Amount" DataFormatString="{0:F2}">
                                                    <ItemStyle HorizontalAlign="Right" CssClass="grdDetail" Width="12%" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="EXTRA_DISCOUNT_PER" HeaderText="Ext. Discount" DataFormatString="{0:F2}">
                                                    <HeaderStyle CssClass="HidePanel" />
                                                    <ItemStyle CssClass="HidePanel" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="EXTRA_DISCOUNT" HeaderText="Ext. Dis Value" DataFormatString="{0:F2}">
                                                    <HeaderStyle CssClass="HidePanel" />
                                                    <ItemStyle CssClass="HidePanel" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="NET_AMOUNT" HeaderText="Net Value" DataFormatString="{0:F2}">
                                                    <HeaderStyle CssClass="HidePanel" />
                                                    <ItemStyle CssClass="HidePanel" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="QUANTITY_CTN2" HeaderText="QUANTITY_CTN2">
                                                    <HeaderStyle CssClass="HidePanel" />
                                                    <ItemStyle CssClass="HidePanel" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="QUANTITY_UNIT2" HeaderText="QUANTITY_UNIT2">
                                                    <HeaderStyle CssClass="HidePanel" />
                                                    <ItemStyle CssClass="HidePanel" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="Stock" HeaderText="Stock">
                                                    <HeaderStyle CssClass="HidePanel" />
                                                    <ItemStyle CssClass="HidePanel" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="UNITS_IN_CASE" HeaderText="UNITS_IN_CASE">
                                                    <HeaderStyle CssClass="HidePanel" />
                                                    <ItemStyle CssClass="HidePanel" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="returnType" HeaderText="returnType">
                                                    <HeaderStyle CssClass="HidePanel" />
                                                    <ItemStyle CssClass="HidePanel" />
                                                </asp:BoundField>
                                                <asp:CommandField ShowEditButton="True" HeaderText="Edit">
                                                    <ItemStyle HorizontalAlign="Center" CssClass="grdDetail"></ItemStyle>
                                                </asp:CommandField>
                                                <asp:TemplateField HeaderText="Delete">
                                                    <ItemTemplate>
                                                        <asp:LinkButton ID="btnDelete" runat="server" Text="Delete" OnClientClick="javascript:return confirm('Are you sure you want to Delete?');return false;"
                                                            CommandName="Delete"></asp:LinkButton>
                                                    </ItemTemplate>
                                                    <ItemStyle HorizontalAlign="Center" CssClass="grdDetail"></ItemStyle>
                                                </asp:TemplateField>
                                            </Columns>
                                            <AlternatingRowStyle BackColor="#F2F2F2" CssClass="GridAlternateRowStyle" ForeColor="#333333" />
                                        </asp:GridView>
                                    </asp:Panel>
                                    <table width="100%">
                                        <tr>
                                            <td style="width: 10%">
                                            </td>
                                            <td style="width: 26%" align="right">
                                                <strong>Total</strong>
                                            </td>
                                            <td style="width: 8%; border: 1px solid silver;" align="right">
                                                <asp:Label ID="lblCtn" runat="server" Width="100%" Text="0"></asp:Label>
                                            </td>
                                            <td style="width: 8%; border: 1px solid silver;" align="right">
                                                <asp:Label ID="lblUnit" runat="server" Width="100%" Text="0"></asp:Label>
                                            </td>
                                            <td style="width: 8%; border: 1px solid silver;">
                                            </td>
                                            <td style="width: 8%; border: 1px solid silver;" align="right">
                                                <asp:Label ID="lblAmount" runat="server" Width="100%" Text="0"></asp:Label>
                                            </td>
                                            <td style="width: 8%">
                                            </td>
                                            <td style="width: 8%" colspan="2">
                                            </td>
                                        </tr>
                                    </table>
                                    <hr />
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </asp:Panel>
                    </td>
                    <td style="width: 100px">
                        <asp:HiddenField ID="hfBillBookNo" runat="server" />
                    </td>
                </tr>
            </table>
        </div>
        <div>
            <table width="100%">
                <tr>
                    <td align="left">
                        <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                            <ContentTemplate>
                                <table>
                                    <tbody>
                                        <tr>
                                            <td valign="top" align="left" colspan="2" rowspan="7">
                                                <strong>Free SKU</strong>
                                                <asp:Panel ID="Panel4" runat="server" Width="350px" Height="130px" BorderColor="Silver"
                                                    BorderStyle="Groove" ScrollBars="Vertical" BorderWidth="1px">
                                                    <asp:GridView ID="GrdFreeSKU" runat="server" Width="100%" ForeColor="Silver" CssClass="gridRow2"
                                                        BorderColor="White" BackColor="White" AutoGenerateColumns="False" HorizontalAlign="Center">
                                                        
                                                        <RowStyle BorderColor="Silver" BorderWidth="1px" BorderStyle="Solid" ForeColor="Black" />                                                        
                                                        <Columns>
                                                            <asp:TemplateField>
                                                                <ItemTemplate>
                                                                    <asp:CheckBox ID="cbSelect" runat="server" Checked="true" />
                                                                </ItemTemplate>
                                                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" />
                                                            </asp:TemplateField>
                                                            <asp:BoundField DataField="SKU_ID" HeaderText="SKU_ID">
                                                                <HeaderStyle CssClass="HidePanel"></HeaderStyle>
                                                                <ItemStyle CssClass="HidePanel"></ItemStyle>
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="SKU_Code" HeaderText="SKU Code">
                                                                <ItemStyle Width="80px" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px">
                                                                </ItemStyle>
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="SKU_Name" HeaderText="SKU Name">
                                                                <ItemStyle Width="200px" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px">
                                                                </ItemStyle>
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="Quantity" HeaderText="Qty">
                                                                <ItemStyle Width="50px" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px">
                                                                </ItemStyle>
                                                            </asp:BoundField>
                                                        </Columns>
                                                        <HeaderStyle CssClass="tblhead"></HeaderStyle>
                                                    </asp:GridView>
                                                </asp:Panel>
                                            </td>
                                            <td style="height: 20px" align="left">
                                            </td>
                                            <td style="height: 20px; width:20%" align="left" >
                                                   
                                                     <strong >Gross Sale</strong>
                                            </td>
                                            <td style="width: 7px; height: 20px">
                                                <asp:TextBox ID="txtGrossAmount" runat="server" Width="150px" ForeColor="Black" Font-Bold="True"
                                                    CssClass="txtBoxnNum" ReadOnly="True"></asp:TextBox>
                                            </td>
                                        </tr>                                        
                                        <tr>
                                            <td style="height: 18px" align="left">
                                            </td>
                                            <td style="height: 18px" align="left">
                                                     <strong >Discount</strong>
                                            </td>
                                            <td style="width: 7px; height: 18px">
                                                <asp:TextBox ID="numTxtTotalStndrdDiscnt" runat="server" Width="150px" ForeColor="Black"
                                                    Font-Bold="True" CssClass="txtBoxnNum" ReadOnly="True"></asp:TextBox>
                                                <ajaxToolkit:FilteredTextBoxExtender ID="FilteredTextBoxExtender" runat="server"
                                                    FilterType="Custom" ValidChars="01234567890." TargetControlID="numTxtTotalStndrdDiscnt">
                                                </ajaxToolkit:FilteredTextBoxExtender>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="left">
                                            </td>
                                            <td align="left">                                              
                                                     <strong >Extra Discount</strong>
                                            </td>
                                            <td style="width: 7px">
                                                <asp:TextBox ID="numtxtTotalExtraDiscnt" runat="server" Width="150px" ForeColor="Black"
                                                    ReadOnly="true" Font-Bold="True"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="width: 1px; height: 20px" valign="top">
                                            </td>
                                            <td style="width: 1px; height: 20px" align="left">
                                                     <strong >Claimable Discount</strong>

                                            </td>
                                            <td style="width: 7px; height: 20px" align="right">
                                                <asp:TextBox ID="numtxtUnClaimabledist" runat="server" Width="150px" ForeColor="Black"
                                                    Font-Bold="True" CssClass="txtBoxnNum" ReadOnly="True"></asp:TextBox>
                                                <ajaxToolkit:FilteredTextBoxExtender ID="FilteredTextBoxExtender1" runat="server"
                                                    FilterType="Custom" ValidChars="01234567890." TargetControlID="numtxtUnClaimabledist">
                                                </ajaxToolkit:FilteredTextBoxExtender>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="width: 1px; height: 20px" valign="top">
                                            </td>
                                            <td style="width: 1px; height: 20px" align="left">
                                                    <strong >GST Amount</strong>

                                            </td>
                                            <td style="width: 7px; height: 20px" align="right">
                                                <asp:TextBox ID="numTxtTotalGST" runat="server" Width="150px" ForeColor="Black" Font-Bold="True"
                                                    CssClass="txtBoxnNum" ReadOnly="True"></asp:TextBox>
                                                <ajaxToolkit:FilteredTextBoxExtender ID="FilteredTextBoxExtender2" runat="server"
                                                    FilterType="Custom" ValidChars="01234567890." TargetControlID="numTxtTotalGST">
                                                </ajaxToolkit:FilteredTextBoxExtender>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="width: 1px; height: 20px" valign="top">
                                            </td>
                                            <td style="width: 1px; height: 20px" align="left">
                                                     <strong >TST Amount</strong>

                                            </td>
                                            <td style="width: 7px; height: 20px" align="right">
                                                <asp:TextBox ID="numTxtTotalTST" runat="server" Width="150px" ForeColor="Black" Font-Bold="True"
                                                    CssClass="txtBoxnNum" ReadOnly="True"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="width: 1px; height: 20px" valign="top">
                                            </td>
                                            <td style="width: 1px; height: 20px" align="left">
                                                  <strong >Net Amount</strong>
                                            </td>
                                            <td style="width: 7px; height: 20px" align="right">
                                                <asp:TextBox ID="numTxtTotlAmnt" runat="server" Width="150px" ForeColor="Black" Font-Bold="True"
                                                    CssClass="txtBoxnNum" ReadOnly="True"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="left" colspan="2">
                                                <table>
                                                    <tbody>
                                                        <tr>
                                                            <td style="width: 100px">
                                                                <asp:Button AccessKey="C" ID="btnCalculate" OnClick="btnCalculate_Click" runat="server"
                                                                    Width="100px" Font-Size="8pt" Text="Calculate" Enabled="False" CssClass="Button" />
                                                            </td>
                                                            <td style="width: 100px">
                                                                <asp:Button AccessKey="S" ID="btnSaveOrder" OnClick="btnSaveOrder_Click" runat="server"
                                                                    Width="110px" Font-Size="8pt" Text="Save Order" CssClass="Button" />
                                                            </td>
                                                            <td style="width: 100px">
                                                                <asp:Button AccessKey="H" ID="btnCancel" runat="server" Width="110px" Font-Size="8pt"
                                                                    Text="Home" OnClick="btnCancel_Click" CssClass="Button" />
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </td>
                                            <td style="width: 1px" valign="top" align="left">
                                                &nbsp; &nbsp; &nbsp;&nbsp;
                                            </td>
                                            <td style="width: 1px" align="left">
                                                <strong>
                                                    <asp:Label ID="Label5" runat="server" Width="105px" Text="Cash Received" Visible="false"></asp:Label></strong>
                                            </td>
                                            <td style="width: 7px" align="right">
                                                <asp:TextBox ID="txtCashReceived" runat="server" Width="150px" ForeColor="Black"
                                                    Font-Bold="True" CssClass="txtBoxnNum" Visible="False"></asp:TextBox>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                        &nbsp;&nbsp;
                        <asp:TextBox ID="numTxtTotalSED" runat="server" CssClass="txtBox " Font-Bold="False"
                            ForeColor="Black" Width="139px" ReadOnly="True" Visible="False"></asp:TextBox>&nbsp;&nbsp;
                    </td>
                </tr>
            </table>
        </div>
    </div>
</asp:Content>
