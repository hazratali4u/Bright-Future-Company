<%@ Page Language="C#" MasterPageFile="~/Forms/PageMaster.master" AutoEventWireup="true"
    CodeFile="rptPriceList.aspx.cs" Inherits="Forms_rptPriceList" Title="SAMS :: SKU Price List" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="content1" runat="server" ContentPlaceHolderID="cphPage">
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
                            <table>
                                <tbody>
                                    <tr>
                                        <td align="left" colspan="4">
                                            <asp:Label ID="lblErrorMsg" runat="server" ForeColor="Red" Font-Bold="True"></asp:Label>
                                        </td>
                                        
                                    </tr>
                                    <tr>
                                        <td align="left">
                                        </td>
                                        <td align="left" style="width:90px;">
                                            <strong>Report Type </strong>
                                        </td>
                                        <td align="left">
                                        </td>
                                        <td align="left">
                                            <asp:DropDownList ID="DrpReportType" runat="server" Width="200px">
                                                <asp:ListItem Text="Sales" Value="0"> </asp:ListItem>
                                                <asp:ListItem Text="Purchase" Value="1"></asp:ListItem>
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                      <tr>
                                    <td align="left">
                                    </td>
                                    <td align="left">
                                        <strong>
                                            Rate Type
                                        </strong>
                                    </td>
                                    <td align="left">
                                    </td>
                                    <td align="left" >                                        
                                        <asp:RadioButtonList ID="rdbRateType" runat="server" RepeatDirection="Horizontal" Width="200px">
                                            <asp:ListItem Selected="True" Value="0" Text="Unit"></asp:ListItem>
                                            <asp:ListItem  Value="1" Text="Ctn"></asp:ListItem>
                                            <asp:ListItem Value="2" Text="Both"></asp:ListItem>
                                        </asp:RadioButtonList>
                                        
                                    </td>
                                </tr>
                                    <tr>
                                        <td align="left">
                                        </td>
                                        <td align="left">
                                            <strong>Location Type </strong>
                                        </td>
                                        <td align="left">
                                        </td>
                                        <td align="left" style="height: 25px">
                                            <asp:DropDownList ID="ddDistributorType" runat="server" Width="200px" OnSelectedIndexChanged="ddDistributorType_SelectedIndexChanged"
                                                AutoPostBack="True">
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                   
                                    <tr>
                                        <td  align="left">
                                        </td>
                                        <td  align="left">
                                            <strong>Location</strong>
                                        </td>
                                        <td align="left">
                                        </td>
                                        <td align="left">
                                            <asp:DropDownList ID="DrpDistributor" runat="server" AutoPostBack="True" CssClass="DropList"
                                                Width="200px">
                                            </asp:DropDownList>
                                        </td>
                                       
                                    </tr>
                            </table>
                            <table width="100%">
                                <tr>
                                    <td style="width: 23%">
                                        <asp:CheckBox ID="cbAllPrincipal" runat="server" Text="Principal" BorderColor="Silver"
                                            BorderWidth="1" Checked="true" AutoPostBack="True" OnCheckedChanged="cbAllPrincipal_CheckedChanged" />
                                        <asp:Panel ID="Panel3" runat="server" Width="90%" Height="250px" ScrollBars="Vertical"
                                            BorderStyle="Groove" BorderWidth="1px">
                                            <asp:CheckBoxList ID="cblPrincipal" runat="server" Width="90%" AutoPostBack="True"
                                                OnSelectedIndexChanged="cblPrincipal_SelectedIndexChanged">
                                            </asp:CheckBoxList>
                                        </asp:Panel>
                                    </td>
                                    <td style="width: 23%">
                                        <asp:CheckBox ID="cbAllCategory" runat="server" Text="Category" BorderColor="Silver"
                                            BorderWidth="1" Checked="true" AutoPostBack="True" OnCheckedChanged="cbAllCategory_CheckedChanged" />
                                        <asp:Panel ID="Panel2" runat="server" Width="90%" Height="250px" ScrollBars="Vertical"
                                            BorderStyle="Groove" BorderWidth="1px">
                                            <asp:CheckBoxList ID="cblCategory" runat="server" Width="100%" AutoPostBack="True"
                                                OnSelectedIndexChanged="cblCategory_SelectedIndexChanged">
                                            </asp:CheckBoxList>
                                        </asp:Panel>
                                    </td>
                                    <td style="width: 23%">
                                        <asp:CheckBox ID="cbAllBrand" runat="server" Text="Brand" BorderColor="Silver" BorderWidth="1"
                                            Checked="true" AutoPostBack="True" OnCheckedChanged="cbAllBrand_CheckedChanged" />
                                        <asp:Panel ID="Panel1" runat="server" Width="90%" Height="250px" ScrollBars="Vertical"
                                            BorderStyle="Groove" BorderWidth="1px">
                                            <asp:CheckBoxList ID="cblBrand" runat="server" Width="100%" AutoPostBack="true" OnSelectedIndexChanged="cblBrand_SelectedIndexChanged">
                                            </asp:CheckBoxList>
                                        </asp:Panel>
                                    </td>
                                    <td style="width: 31%">
                                        <asp:CheckBox ID="cbAllSKU" runat="server" Text="SKU" BorderColor="Silver" BorderWidth="1"
                                            Checked="true" AutoPostBack="True" OnCheckedChanged="cbAllSKU_CheckedChanged" />
                                        <asp:Panel ID="Panel4" runat="server" Width="90%" Height="250px" ScrollBars="Vertical"
                                            BorderStyle="Groove" BorderWidth="1px">
                                            <asp:CheckBoxList ID="cblSKU" runat="server" Width="100%">
                                            </asp:CheckBoxList>
                                        </asp:Panel>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                    &nbsp;
                                    </td>
                                </tr>
                            </table>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                    &nbsp; &nbsp;
                    <asp:Button ID="btnViewPDF" runat="server" CssClass="Button" Text="View PDF" OnClick="btnViewPDF_Click" />
                    <asp:Button ID="btnViewExcel" runat="server" Text="View Excel" CssClass="Button"
                        OnClick="btnViewExcel_Click" />
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
