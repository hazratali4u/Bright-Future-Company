<%@ Page Language="C#" MasterPageFile="~/Forms/PageMaster.master" AutoEventWireup="true" CodeFile="frmTargetEntry.aspx.cs" Inherits="Forms_frmTargetEntry" Title="SAMS :: Target Entry" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" runat="server" ContentPlaceHolderID="cphPage">
    <script language="JavaScript" type="text/javascript">
        Sys.WebForms.PageRequestManager.getInstance().add_beginRequest(startRequest);
        Sys.WebForms.PageRequestManager.getInstance().add_endRequest(endRequest);

        function startRequest(sender, e) {
            document.getElementById('<%=btnTarget.ClientID%>').disabled = true;
        }

        function endRequest(sender, e) {
            document.getElementById('<%=btnTarget.ClientID%>').disabled = false;
        }

        function ConfirmDelete() {
            if (confirm("Do you want to Cancel this record?") == true)
                return true;

            else {
                return false;
            }
        }

        function ValidateForm() {
            var str;
            str = document.getElementById('<%=txtAmount.ClientID%>').value;
            if (str == null || str.length == 0) {
                alert('Must Enter Amount');
                return false;
            }
            str = document.getElementById('<%=txtFromdate.ClientID%>').value;
            if (str == null || str.length <= 1) {
                alert('Must Select Target Month');
                return false;
            }
            str = document.getElementById('<%=drpPrincipal.ClientID%>').value;
            if (str == null || str.length == 0) {
                alert('Must Select Principal');
                return false;
            }
            str = document.getElementById('<%=drpDistributor.ClientID%>').value;
            if (str == null || str.length == 0) {
                alert('Must Select Distributor');
                return false;
            }
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
                        <asp:UpdatePanel ID="upSearchResults" runat="server">
                            <ContentTemplate>
                                <table>
                                    <tbody>
                                        <tr>
                                            <td align="left" style="height: 25px">
                                                <strong>
                                                    <asp:Label ID="Label6" runat="server" CssClass="lblbox" Height="14px" Text="Location"
                                                        Width="98px"></asp:Label></strong>
                                            </td>
                                            <td style="height: 25px" align="left">
                                                <asp:DropDownList ID="drpDistributor" runat="server" CssClass="DropList" Width="212px"
                                                    OnSelectedIndexChanged="drpDistributor_SelectedIndexChanged" AutoPostBack="True">
                                                </asp:DropDownList>
                                            </td>
                                            <td style="height: 25px">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="left" style="height: 25px">
                                                <strong>
                                                    <asp:Label ID="lbltoLocation" runat="server" Width="71px" Text="Principal" CssClass="lblbox"></asp:Label></strong>
                                            </td>
                                            <td style="height: 25px" align="left">
                                                <asp:DropDownList ID="drpPrincipal" runat="server" Width="211px" CssClass="DropList"
                                                    AutoPostBack="True" OnSelectedIndexChanged="drpPrincipal_SelectedIndexChanged">
                                                </asp:DropDownList>
                                            </td>
                                            <td style="height: 25px">
                                                <strong>
                                                    <asp:Label ID="Label5" runat="server" CssClass="lblbox" Width="50px"></asp:Label></strong>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="left" style="height: 25px">
                                                <strong>
                                                    <asp:Label ID="Label7" runat="server" Width="71px" Text="Category"></asp:Label></strong>
                                            </td>
                                            <td style="height: 25px" align="left">
                                                <asp:DropDownList ID="ddlCategory" runat="server" Width="211px">
                                                </asp:DropDownList>
                                            </td>
                                            <td style="height: 25px">
                                                
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="left" style="height: 25px">
                                                <strong>
                                                    <asp:Label ID="Label2" runat="server" Width="98px" Text="Target For Type" CssClass="lblbox"
                                                        Height="14px"></asp:Label></strong>
                                            </td>
                                            <td style="height: 25px" align="left">
                                                <asp:DropDownList ID="DrpTargetType" runat="server" Width="211px" CssClass="DropList"
                                                    OnSelectedIndexChanged="DrpTargetType_SelectedIndexChanged" AutoPostBack="True">
                                                    <asp:ListItem Value="96">Order Booker</asp:ListItem>
                                                    <asp:ListItem Value="97">Sale Person</asp:ListItem>
                                                    <asp:ListItem Value="98">City</asp:ListItem>
                                                </asp:DropDownList>
                                            </td>
                                            <td style="height: 25px">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="left" style="height: 25px">
                                                <strong>
                                                    <asp:Label ID="lblDocumentNo" runat="server" Width="76px" Text="Target For" CssClass="lblbox"></asp:Label></strong>
                                            </td>
                                            <td style="height: 25px" align="left">
                                                <asp:DropDownList ID="DrpTargetFor" runat="server" Width="210px" CssClass="DropList">
                                                </asp:DropDownList>
                                            </td>
                                            <td style="height: 25px">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="left" style="height: 25px">
                                                <strong>
                                                    <asp:Label ID="Label1" runat="server" Width="72px" Text="From Month" CssClass="lblbox"></asp:Label></strong>
                                            </td>
                                            <td style="height: 25px" align="left">
                                                <asp:TextBox ID="txtFromdate" runat="server" Width="204px" CssClass="txtBox" MaxLength="1"></asp:TextBox>
                                            </td>
                                            <td style="height: 25px">
                                                <asp:ImageButton ID="ibtnStartDate" runat="server" ImageUrl="~/App_Themes/Granite/Images/date.gif"
                                                    Width="16px" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="left" style="height: 25px">
                                                <strong>
                                                    <asp:Label ID="Label3" runat="server" Width="72px" Text="To Month"></asp:Label></strong>
                                            </td>
                                            <td style="height: 25px" align="left">
                                                <asp:TextBox ID="txtTodate" runat="server" Width="204px"></asp:TextBox>
                                            </td>
                                            <td style="height: 25px">
                                                <asp:ImageButton ID="ibtnToDate" runat="server" ImageUrl="~/App_Themes/Granite/Images/date.gif"
                                                    Width="16px" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="left" style="height: 25px">
                                                <strong>
                                                    <asp:Label ID="Label4" runat="server" CssClass="lblbox" Text="Target Value" Width="97px"></asp:Label></strong>
                                            </td>
                                            <td align="left" style="height: 25px">
                                                <asp:TextBox ID="txtAmount" runat="server" CssClass="txtBox" Width="204px">0</asp:TextBox>
                                            </td>
                                            <td style="height: 25px">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="left" style="height: 25px" valign="top">
                                            </td>
                                            <td style="width: 1px; height: 25px;" valign="top">
                                                <%@ register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="cc1" %>
                                                <cc1:CalendarExtender ID="CEStartDate" runat="server" Format="MMM-yyyy" PopupButtonID="ibtnStartDate"
                                                    TargetControlID="txtFromdate">
                                                </cc1:CalendarExtender>
                                                <cc1:CalendarExtender ID="CEToDate" runat="server" Format="MMM-yyyy" PopupButtonID="ibtnToDate"
                                                    TargetControlID="txtTodate">
                                                </cc1:CalendarExtender>
                                                <asp:Button ID="btnTarget" runat="server" Font-Size="8pt" Text="Save" ValidationGroup="vg"
                                                    Width="95px" OnClick="btnTarget_Click" CssClass="Button" />
                                            </td>
                                            <td style="width: 1px; height: 25px;" valign="top">
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                        &nbsp;
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
                                <table width="100%">
                                    <tr>
                                        <td colspan="6">
                                            <asp:Panel ID="Panel2" runat="server" BorderColor="Silver" BorderStyle="Groove" BorderWidth="1px"
                                                Height="180px" ScrollBars="Vertical" Width="640px">
                                                <asp:GridView ID="GrdPurchase" runat="server" AutoGenerateColumns="False" BackColor="White"
                                                    BorderColor="White" CssClass="gridRow2" ForeColor="SteelBlue" HorizontalAlign="Center"
                                                    OnRowDeleting="GrdPurchase_RowDeleting" OnRowEditing="GrdPurchase_RowEditing"
                                                    Width="620px">
                                                    <PagerSettings FirstPageText="" LastPageText="" Mode="NextPrevious" NextPageText="Next"
                                                        PreviousPageText="Previous" />
                                                    <Columns>
                                                        <asp:BoundField DataField="TARGET_ID" HeaderText="TARGET_ID">
                                                            <HeaderStyle CssClass="HidePanel" />
                                                            <ItemStyle CssClass="HidePanel" />
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="TARGET_FOR_ID" HeaderText="TARGET_FOR_ID">
                                                            <HeaderStyle CssClass="HidePanel" />
                                                            <ItemStyle CssClass="HidePanel" />
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="USER_CODE" HeaderText="Code">
                                                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="2px" HorizontalAlign="Left"
                                                                Width="85px" />
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="User_NAME" HeaderText="Description">
                                                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="2px" HorizontalAlign="Left"
                                                                Width="205px" />
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="TARGET_MONTH" HeaderText="From Month">
                                                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="TARGET_MONTH2" HeaderText="To Month">
                                                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="AMOUNT" HeaderText="Value" DataFormatString="{0:F2}">
                                                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Right" />
                                                        </asp:BoundField>
                                                        <asp:CommandField HeaderText="Edit" ShowEditButton="True">
                                                            <ItemStyle BorderColor="Silver" BorderWidth="1px" Width="40px" />
                                                        </asp:CommandField>
                                                        <asp:TemplateField HeaderText="Delete">
                                                            <ItemTemplate>
                                                                <asp:LinkButton ID="btnDelete" runat="server" CommandName="Delete" OnClientClick="javascript:return confirm('Are you sure you want to Delete?');return false;"
                                                                    Text="Delete"></asp:LinkButton>
                                                            </ItemTemplate>
                                                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="2px" Width="45px" />
                                                        </asp:TemplateField>
                                                    </Columns>
                                                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" CssClass="tblhead" />
                                                </asp:GridView>
                                            </asp:Panel>
                                        </td>
                                    </tr>
                                </table>
                                &nbsp;
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </td>
                </tr>
            </table>
            &nbsp;
        </div>
    </div>
</asp:Content>

