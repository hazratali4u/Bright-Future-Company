<%@ Page Language="C#" MasterPageFile="~/Forms/PageMaster.master" AutoEventWireup="true"
    CodeFile="RptDistributorReports.aspx.cs" Inherits="Forms_RptDistributorReports"
    Title="SAMS :: Sales & Closing Stock" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" runat="server" ContentPlaceHolderID="cphPage">
    <script type="text/javascript">

        function pageLoad() {
            $('#<%=DrpReportType.ClientID %>').change(function () {
                
                var lblfrom = document.getElementById('<%= lblFromDate.ClientID %>');
                var todate = document.getElementById('<%= lblToDate.ClientID %>');
                var img = document.getElementById('<%= ibnEndDate.ClientID %>');
                var textend = document.getElementById('<%= txtEndDate.ClientID %>');
                
                todate.style.display = 'inline-block';
                textend.style.display = 'inline-block';
                img.style.visibility = 'visible';                
                lblfrom.innerHTML = 'From Date';

                var ReportType = $('#<%=DrpReportType.ClientID %> option:selected').val();
                if(ReportType == 3 || ReportType == 4)
                {
                    lblfrom.innerHTML = 'Date';
                    todate.style.display = 'none';
                    img.style.visibility = 'hidden';
                    textend.style.display = 'none';
                }
                
            });
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
        <table width="100%">
            <tr>
                <td>
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate>
                            <table>
                                <tr>
                                    <td align="left">
                                    </td>
                                    <td align="left">
                                        <strong>
                                            <asp:Label ID="Label1" runat="server" Text="Report Type"></asp:Label>
                                        </strong>
                                    </td>
                                    <td align="left">
                                    </td>
                                    <td style="height: 25px" align="left">
                                        <asp:DropDownList ID="DrpReportType" runat="server" Width="200px">
                                            <asp:ListItem Text="Sales" Value="0"> </asp:ListItem>
                                            <asp:ListItem Text="Sales Return" Value="1"></asp:ListItem>
                                            <asp:ListItem Text="Damage" Value="2"></asp:ListItem>
                                            <asp:ListItem Text="Opening Stock" Value="3"></asp:ListItem>
                                            <asp:ListItem Text="Closing Stock" Value="4"></asp:ListItem>
                                            <asp:ListItem Text="Purchase" Value="5"></asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left">
                                    </td>
                                    <td align="left">
                                        <strong>
                                            <asp:Label ID="Label5" runat="server" Text="Value Type"></asp:Label>
                                        </strong>
                                    </td>
                                    <td align="left">
                                    </td>
                                    <td align="left" style="height: 25px">                                        
                                        <asp:CheckBox ID="cbQuantity" runat="server" Text="Quantity" Checked="true" />
                                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                        <asp:CheckBox ID="cbValue" runat="server" Text="Value" />
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left">
                                    </td>
                                    <td align="left">
                                        <strong>
                                            <asp:Label ID="Label7" runat="server" Text="Location Type"></asp:Label>
                                        </strong>
                                    </td>
                                    <td align="left">
                                    </td>
                                    <td align="left" style="height: 25px">
                                        <asp:DropDownList ID="ddDistributorType" runat="server" Width="200px"
                                            OnSelectedIndexChanged="ddDistributorType_SelectedIndexChanged" AutoPostBack="True">
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left">
                                    </td>
                                    <td align="left">
                                        <strong>
                                            <asp:Label ID="lbltoLocation" runat="server" Text="Location"></asp:Label>
                                        </strong>
                                    </td>
                                    <td align="left">
                                    </td>
                                    <td align="left" style="height: 25px">
                                        <asp:DropDownList ID="drpDistributor" runat="server" Width="200px" CssClass="DropList">
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                </table>
                                <table width="100%">
                                <tr>
                                    <td style="width:25%">
                                        <asp:CheckBox ID="cbAllPrincipal" runat="server" Text="Principal" BorderColor="Silver" 
                                            BorderWidth="1"  Checked="true" AutoPostBack="True" 
                                            OnCheckedChanged="cbAllPrincipal_CheckedChanged"/>
                                        <asp:Panel ID="Panel3" runat="server" Width="90%" Height="250px" ScrollBars="Vertical"
                                            BorderStyle="Groove" BorderWidth="1px">
                                        <asp:CheckBoxList ID="cblPrincipal" runat="server" Width="90%" AutoPostBack="True"
                                            onselectedindexchanged="cblPrincipal_SelectedIndexChanged">
                                        </asp:CheckBoxList>
                                        </asp:Panel>
                                    </td>
                                    <td style="width:25%">
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
                                    <td style="width:25%">
                                        <asp:CheckBox ID="cbAllBrand" runat="server" Text="Brand" 
                                            BorderColor="Silver" BorderWidth="1"  Checked="true" AutoPostBack="True" 
                                            oncheckedchanged="cbAllBrand_CheckedChanged" />
                                        <asp:Panel ID="Panel1" runat="server" Width="90%" Height="250px" ScrollBars="Vertical"
                                            BorderStyle="Groove" BorderWidth="1px">
                                        <asp:CheckBoxList ID="cblBrand" runat="server" Width="100%" AutoPostBack="true"
                                        onselectedindexchanged="cblBrand_SelectedIndexChanged">                                        
                                        </asp:CheckBoxList>
                                        </asp:Panel>
                                    </td>
                                    <td style="width:25%">                                   
                                        <asp:CheckBox ID="cbAllSKU" runat="server" Text="SKU" 
                                            BorderColor="Silver" BorderWidth="1"  Checked="true" AutoPostBack="True" 
                                            oncheckedchanged="cbAllSKU_CheckedChanged" />
                                        <asp:Panel ID="Panel4" runat="server" Width="90%" Height="250px" ScrollBars="Vertical"
                                            BorderStyle="Groove" BorderWidth="1px">
                                        <asp:CheckBoxList ID="cblSKU" runat="server" Width="100%">                                        
                                        </asp:CheckBoxList>
                                        </asp:Panel>
                                    </td>
                                </tr>
                                </table>
                                <table>
                                <tr>
                                    <td align="left">
                                    </td>
                                    <td align="left">
                                        <strong>
                                            <asp:Label ID="lblFromDate" runat="server" Height="13px" Text="From Date" Width="70px"></asp:Label></strong>
                                    </td>
                                    <td align="left">
                                    </td>
                                    <td align="left" style="height: 25px">
                                        &nbsp;<asp:TextBox ID="txtStartDate" runat="server" CssClass="txtBox" MaxLength="10"
                                            onkeyup="BlockStartDateKeyPress()" Width="150px"></asp:TextBox>
                                        <asp:ImageButton ID="ibtnStartDate" runat="server" ImageUrl="~/App_Themes/Granite/Images/date.gif"
                                            Width="16px" />
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left">
                                    </td>
                                    <td align="left">
                                        <strong>
                                            <asp:Label ID="lblToDate" runat="server" Height="13px" Text="To Date" Width="80px"></asp:Label></strong>
                                    </td>
                                    <td align="left">
                                    </td>
                                    <td align="left" style="height: 25px">
                                        &nbsp;<asp:TextBox ID="txtEndDate" runat="server" CssClass="txtBox " MaxLength="10"
                                            onkeyup="BlockEndDateKeyPress()" Width="150px"></asp:TextBox>
                                        <asp:ImageButton ID="ibnEndDate" runat="server" ImageUrl="~/App_Themes/Granite/Images/date.gif"
                                            Width="16px" />
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left">
                                    </td>
                                    <td align="left">
                                    </td>
                                    <td align="left">
                                    </td>
                                    <td align="left" style="height: 25px">
                                        <%@ register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="cc1" %>
                                        <cc1:CalendarExtender ID="CEStartDate" runat="server" Format="dd-MMM-yyyy" PopupButtonID="ibtnStartDate"
                                            TargetControlID="txtStartDate">
                                        </cc1:CalendarExtender>
                                        <cc1:CalendarExtender ID="CEEndDate" runat="server" Format="dd-MMM-yyyy" PopupButtonID="ibnEndDate"
                                            TargetControlID="txtEndDate">
                                        </cc1:CalendarExtender>
                                    </td>
                                </tr>
                            </table>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                    &nbsp; &nbsp;
                    <asp:Button ID="btnViewPDF" runat="server" CssClass="Button" Width="90" Text="View PDF"
                        OnClick="btnViewPDF_Click" />
                    <asp:Button ID="btnViewExcel" runat="server" CssClass="Button" Width="90" Text="View Excel"
                        OnClick="btnViewExcel_Click" />
                </td>
            </tr>
        </table>
        &nbsp;
    </div>
</asp:Content>
