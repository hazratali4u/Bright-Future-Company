<%@ Page Language="C#" MasterPageFile="~/Forms/PageMaster.master" AutoEventWireup="true"
    CodeFile="RptStockReconcilation.aspx.cs" Inherits="Forms_RptStockReconcilation"
    Title="SAMS :: Stock Reconciliation" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" runat="server" ContentPlaceHolderID="cphPage">
<script type="text/javascript" src="../AjaxLibrary/jquery.searchabledropdown-1.0.8.min.js"></script>
    <script type="text/javascript">
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
        <table width="100%">
            <tr>
                <td>
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate>
                        <table width="100%" cellspacing="2" cellpadding="5">
                            <tr>
                                <td style="width:12%">
                                    <strong>
                                        Rate Impelement
                                    </strong>                
                                </td>
                                <td style="width:88%">
                                    <asp:RadioButtonList ID="rblRate" runat="server" RepeatDirection="Horizontal" Width="250px">
                                        <asp:ListItem Selected="True" Text="Trade Price" Value="0"></asp:ListItem>
                                        <asp:ListItem Text="Purchase Price" Value="1"></asp:ListItem>
                                    </asp:RadioButtonList>
                                </td>
                            </tr>
                            <tr>
                                <td style="width:12%">
                                    <strong>
                                        Location
                                    </strong>                
                                </td>
                                <td style="width:88%">
                                    <asp:DropDownList ID="drpDistributor" runat="server" Width="200px">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                        </table>
                        <table width="100%">
                            <tr>
                                <td style="width:33%" valign="top">
                                    <asp:CheckBox ID="cbAll" runat="server" Text="Principal" BorderColor="Silver" 
                                        BorderWidth="1"  Checked="true" AutoPostBack="True" 
                                        oncheckedchanged="cbAll_CheckedChanged"/>
                                    <asp:Panel ID="Panel3" runat="server" Width="90%" Height="250px" ScrollBars="Vertical"
                                        BorderStyle="Groove" BorderWidth="1px">
                                    <asp:CheckBoxList ID="cblPrincipal" runat="server" Width="90%" AutoPostBack="True" 
                                            onselectedindexchanged="cblPrincipal_SelectedIndexChanged">                                        
                                    </asp:CheckBoxList>
                                    </asp:Panel>
                                </td>
                                <td style="width:33%" valign="top">
                                    <asp:CheckBox ID="cbAllCategory" runat="server" Text="Category" 
                                        BorderColor="Silver" BorderWidth="1"  Checked="true" AutoPostBack="True" 
                                        oncheckedchanged="cbAllCategory_CheckedChanged"/>
                                    <asp:Panel ID="Panel2" runat="server" Width="90%" Height="250px" ScrollBars="Vertical"
                                        BorderStyle="Groove" BorderWidth="1px">
                                    <asp:CheckBoxList ID="cblCategory" runat="server" Width="100%" AutoPostBack="True" 
                                            onselectedindexchanged="cblCategory_SelectedIndexChanged">                                        
                                    </asp:CheckBoxList>
                                    </asp:Panel>
                                </td>
                                <td style="width:33%" valign="top">
                                    <asp:CheckBox ID="cbAllBrand" runat="server" Text="Brand" 
                                        BorderColor="Silver" BorderWidth="1"  Checked="true" AutoPostBack="True" 
                                        oncheckedchanged="cbAllBrand_CheckedChanged" />
                                    <asp:Panel ID="Panel1" runat="server" Width="90%" Height="250px" ScrollBars="Vertical"
                                        BorderStyle="Groove" BorderWidth="1px">
                                    <asp:CheckBoxList ID="cblBrand" runat="server" Width="100%">                                        
                                    </asp:CheckBoxList>
                                    </asp:Panel>
                                </td>
                                <td style="width:1%"></td>
                            </tr>                                    
                        </table>
                        <table width="100%" cellspacing="2" cellpadding="5">                            
                            <tr>
                                <td style="width:12%"></td>
                                <td style="width:88%">
                                    <strong><asp:CheckBox ID="cbZero" runat="server" Text="Zero Elimination" /></strong> 
                                </td>
                            </tr>
                            <tr>
                                <td style="width:12%">
                                    <strong>
                                       From Date
                                    </strong>
                                </td>
                                <td style="width:88%">
                                    <asp:TextBox ID="txtStartDate" runat="server" CssClass="txtBox" MaxLength="10"
                                        onkeyup="BlockStartDateKeyPress()" Width="150px"></asp:TextBox>
                                    <asp:ImageButton ID="ibtnStartDate" runat="server" ImageUrl="~/App_Themes/Granite/Images/date.gif" Width="16px" />
                                    <cc1:CalendarExtender ID="CEStartDate" runat="server" Format="dd-MMM-yyyy" PopupButtonID="ibtnStartDate"
                                        TargetControlID="txtStartDate">
                                    </cc1:CalendarExtender>
                                </td>
                            </tr>
                            <tr>
                                <td style="width:12%">
                                    <strong>
                                        To Date
                                    </strong>
                                </td>
                                <td style="width:88%">
                                    <asp:TextBox ID="txtEndDate" runat="server" MaxLength="10"
                                    onkeyup="BlockEndDateKeyPress()" Width="150px"></asp:TextBox>
                                <asp:ImageButton ID="ibnEndDate" runat="server" ImageUrl="~/App_Themes/Granite/Images/date.gif" Width="16px" />
                                <cc1:CalendarExtender ID="CEEndDate" runat="server" Format="dd-MMM-yyyy" PopupButtonID="ibnEndDate"
                                    TargetControlID="txtEndDate">
                                </cc1:CalendarExtender>
                                </td>
                            </tr>
                        </table>                
                        </ContentTemplate>
                    </asp:UpdatePanel>
                    <asp:Button ID="btnViewPDF" runat="server" CssClass="Button" Width="90" Text="View PDF"
                        OnClick="btnViewPDF_Click" />
                    <asp:Button ID="btnViewExcel" runat="server" CssClass="Button" Width="90" Text="View Excel"
                        OnClick="btnViewExcel_Click" />
                </td>
            </tr>
        </table>        
    </div>
</asp:Content>
