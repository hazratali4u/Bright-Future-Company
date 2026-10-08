<%@ Page Language="C#" MasterPageFile="~/Forms/PageMaster.master" AutoEventWireup="true"
    CodeFile="frmExpenseEntry.aspx.cs" Inherits="frmExpenseEntry" Title="SAMS :: Branch Expense & Salary" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" runat="server" ContentPlaceHolderID="cphPage">
    <script language="JavaScript" type="text/javascript">

        function ValidateForm() {
            var str;
            str = document.getElementById("<%= txtAmount.ClientID %>").value;
            if (str == null || str.length == 0) {
                alert('Must enter Amount');
                return false;
            }
            else if (str == "0") {
                alert('Amount should be greater than zero');
                return false;
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
    </script>
    <div id="right_data">
        <div>
    <asp:UpdateProgress ID="UpdateProgress" runat="server">
        <ProgressTemplate>
            <asp:ImageButton ID="ImageButton10" runat="server" Height="28px" ImageUrl="~/App_Themes/Granite/Images/image003.gif"
                Width="31px" />
        </ProgressTemplate>
    </asp:UpdateProgress>
    <cc1:ModalPopupExtender ID="modalPopup" runat="server" TargetControlID="UpdateProgress"
        PopupControlID="UpdateProgress" BackgroundCssClass="modalBackground">
    </cc1:ModalPopupExtender>
</div>
        <div>
            <table width="100%">
                <tr>
                    <td>
                        <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                            <ContentTemplate>
                                <cc1:FilteredTextBoxExtender ID="FilteredTextBoxExtender1" runat="server" FilterType="Custom"
                                    TargetControlID="txtAmount" ValidChars="0123456789.">
                                </cc1:FilteredTextBoxExtender>
                                <asp:Panel ID="Panel1" runat="server" DefaultButton="btnAddNew">
                                    <table>
                                        <tbody>
                                            <tr>
                                                <td style="height: 20px" valign="top" align="left">
                                                    <strong>
                                                        <asp:Label ID="Label5" runat="server" Width="116px" Text="Detail Account Type" CssClass="lblbox"
                                                            __designer:wfdid="w3"></asp:Label></strong>
                                                </td>
                                                <td style="width: 100px" valign="top" align="left">
                                                    <asp:RadioButtonList ID="rblDetailAccountType" runat="server" Width="200px" AutoPostBack="True"
                                                        OnSelectedIndexChanged="rblDetailAccountType_SelectedIndexChanged">
                                                        <asp:ListItem Selected="True" Value="55">Branch Administration Expense</asp:ListItem>
                                                        <asp:ListItem Value="617">Marketing Expense</asp:ListItem>
                                                        <asp:ListItem Value="56">Selling Expenses</asp:ListItem>
                                                    </asp:RadioButtonList>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="height: 20px" align="left">
                                                    <strong>
                                                        <asp:Label ID="Label2" runat="server" Width="65px" Text="Voucher No" CssClass="lblbox"></asp:Label></strong>
                                                </td>
                                                <td style="width: 100px">
                                                    <asp:DropDownList ID="DrpVoucherNo" runat="server" Width="250px" CssClass="DropList"
                                                        AutoPostBack="True" OnSelectedIndexChanged="DrpVoucherNo_SelectedIndexChanged">
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="height: 20px" align="left">
                                                    <strong>
                                                        <asp:Label ID="lblfromLocation" runat="server" Width="65px" Text="Location" CssClass="lblbox"></asp:Label></strong>
                                                </td>
                                                <td style="width: 100px">
                                                    <asp:DropDownList ID="drpDistributor" runat="server" Width="250px" 
                                                        AutoPostBack="True" 
                                                        onselectedindexchanged="drpDistributor_SelectedIndexChanged">
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="height: 20px" align="left">
                                                    <strong>
                                                        <asp:Label ID="Label4" runat="server" Width="65px" Text="City"></asp:Label></strong>
                                                </td>
                                                <td style="width: 100px">
                                                    <asp:DropDownList ID="ddlCity" runat="server" Width="250px">
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="height: 20px" align="left">
                                                    <strong>
                                                        <asp:Label ID="Label8" runat="server" Width="68px" Text="Principal" CssClass="lblbox"></asp:Label></strong>
                                                </td>
                                                <td style="width: 100px">
                                                    <asp:DropDownList ID="DrpPrincipal" runat="server" Width="250px" CssClass="DropList"
                                                        AutoPostBack="True" OnSelectedIndexChanged="DrpPrincipal_SelectedIndexChanged"
                                                        Enabled="False">
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="height: 20px" align="left">
                                                    <strong>
                                                        <asp:Label ID="Label1" runat="server" Width="116px" Text="Expense Head" CssClass="lblbox"></asp:Label></strong>
                                                </td>
                                                <td style="width: 100px">
                                                    <asp:DropDownList ID="DrpAccountHead" runat="server" Width="250px" CssClass="DropList">
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="height: 20px" align="left">
                                                    <strong>
                                                        <asp:Label ID="Label9" runat="server" Width="71px" Text="Remarks"></asp:Label></strong>&nbsp;
                                                </td>
                                                <td style="height: 20px" align="left">
                                                    <asp:TextBox ID="txtRemarks" runat="server" Width="243px"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="height: 20px" align="left">
                                                    <strong>
                                                        <asp:Label ID="Label3" runat="server" Width="71px" Text="Slip No" CssClass="lblbox"></asp:Label></strong>
                                                </td>
                                                <td style="height: 20px" align="left">
                                                    <asp:TextBox ID="txtslipNo" runat="server" Width="163px" CssClass="txtBox "></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="height: 20px" align="left">
                                                    <strong>
                                                        <asp:Label ID="Label7" runat="server" Width="125px" Text="Payee's Name"></asp:Label></strong>
                                                </td>
                                                <td style="height: 20px" align="left">
                                                    <asp:TextBox ID="txtPayee" runat="server" Width="163px"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="height: 20px" align="left">
                                                    <strong>
                                                        <asp:Label ID="Label6" runat="server" Width="63px" Text="Amount" CssClass="lblbox"></asp:Label></strong>
                                                </td>
                                                <td style="height: 20px" align="left">
                                                    <asp:TextBox ID="txtAmount" runat="server" Width="163px" CssClass="txtBox "></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="width: 100px" align="left">
                                                </td>
                                                <td style="height: 20px" align="left" colspan="1">
                                                    <asp:Button AccessKey="S" ID="btnAddNew" OnClick="btnAddNew_Click" runat="server"
                                                        Width="95px" Font-Size="8pt" Text="Add" CssClass="Button" />
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </asp:Panel>
                                &nbsp;&nbsp;
                            </ContentTemplate>
                        </asp:UpdatePanel>
                        <strong>
                            <asp:Label ID="lblRowId" runat="server" Text="Label" Visible="False"></asp:Label></strong>
                    </td>
                </tr>
            </table>
        </div>
        <div>
            <table width="100%">
                <tr>
                    <td>
                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                            <ContentTemplate>
                                <asp:Panel ID="Panel12" runat="server" Height="136px" ScrollBars="Vertical" Width="620px"
                                    BorderColor="Gray" BorderStyle="Groove" BorderWidth="1px">
                                    <asp:GridView ID="GrdOrder" runat="server" AutoGenerateColumns="False" BackColor="White"
                                        BorderColor="White" CaptionAlign="Left" CssClass="gridRow2" ForeColor="SteelBlue" HorizontalAlign="Center" OnRowDeleting="GrdOrder_RowDeleting" 
                                        Width="100%">
                                        <PagerSettings FirstPageText="" LastPageText="" Mode="NextPrevious" NextPageText="Next"
                                            PreviousPageText="Previous" />
                                        <Columns>
                                            <asp:BoundField DataField="Account_Head_Id" HeaderText="Account Head Id">
                                                <FooterStyle CssClass="HidePanel" />
                                                <HeaderStyle CssClass="HidePanel" />
                                                <ItemStyle CssClass="HidePanel" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="Account_Name" HeaderText="Account Head">
                                                <FooterStyle CssClass="HidePanel" />
                                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="Remarks" HeaderText="Remarks">
                                                <FooterStyle HorizontalAlign="Right" />
                                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="debit" DataFormatString="{0:F2}" FooterText="Total" HeaderText="Amount">
                                                <FooterStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Right" />
                                                <HeaderStyle HorizontalAlign="Right" />
                                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Right" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="ACCOUNT_PARENT_ID" HeaderText="ACCOUNT_PARENT_ID">
                                                <HeaderStyle CssClass="HidePanel" />
                                                <ItemStyle CssClass="HidePanel" />
                                            </asp:BoundField>                                            
                                            <asp:TemplateField HeaderText="Delete">
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="btnDelete" runat="server" CommandName="Delete" OnClientClick="javascript:return confirm('Are you sure you want to Delete?');return false;"
                                                        Text="Delete"></asp:LinkButton>
                                                </ItemTemplate>
                                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="46px" />
                                            </asp:TemplateField>
                                        </Columns>
                                        <HeaderStyle CssClass="tblhead" HorizontalAlign="Center" VerticalAlign="Middle" />
                                    </asp:GridView>
                                </asp:Panel>                               
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </td>
                </tr>
                <tr>
                    <td>
                         <asp:Button ID="btnSave" runat="server" Font-Size="8pt" OnClick="btnSave_Click" Text="Save"
                                    Width="117px" CssClass="Button" />
                            <strong>
                                <asp:Label ID="Label61" runat="server" CssClass="lblbox" Text="Amount" Width="63px"></asp:Label></strong>
                            <asp:TextBox ID="txtMainCash" runat="server" CssClass="txtBox " ReadOnly="True"></asp:TextBox>&nbsp;
                    </td>
                </tr>
            </table>
        </div>
    </div>
</asp:Content>
