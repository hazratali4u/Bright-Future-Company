<%@ Page Language="C#" MasterPageFile="~/Forms/AppMaster.master" AutoEventWireup="true"
    CodeFile="ModulePopupExtender.aspx.cs" Inherits="Forms_ModulePopupExtender" Title="SAMS :: Order/Invoice Step 1" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="mainCopy" runat="Server">
    <script language="javascript" type="text/javascript">

        Sys.WebForms.PageRequestManager.getInstance().add_beginRequest(startRequest);
        Sys.WebForms.PageRequestManager.getInstance().add_endRequest(endRequest);
        function startRequest(sender, e) {
            document.getElementById('<%=btnPost.ClientID%>').disabled = true;
        }

        function endRequest(sender, e) {
            document.getElementById('<%=btnPost.ClientID%>').disabled = false;
        }

        function pageLoad(sender, args) {
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


        function HeaderClick(CheckBox) {
            //Get target base & child control.
            var TargetBaseControl = document.getElementById('<%= this.GrdOrder.ClientID %>');
            var TargetChildControl = "ChbInvoice";

            //Get all the control of the type INPUT in the base control.
            var Inputs = TargetBaseControl.getElementsByTagName("input");

            //Checked/Unchecked all the checkBoxes in side the GridView.
            for (var n = 0; n < Inputs.length; ++n)
                if (Inputs[n].type == 'checkbox' && Inputs[n].id.indexOf(TargetChildControl, 0) >= 0)
                    Inputs[n].checked = CheckBox.checked;
        }

        function GridClick() {
            //Get target base & child control.
            var chkBox = document.getElementById('<%= chkBxHeader.ClientID %>');
            var TargetBaseControl = document.getElementById('<%= this.GrdOrder.ClientID %>');
            var TargetChildControl = "ChbInvoice";

            //Get all the control of the type INPUT in the base control.
            var Inputs = TargetBaseControl.getElementsByTagName("input");

            //Checked/Unchecked all the checkBoxes in side the GridView.
            for (var n = 0; n < Inputs.length; ++n)
                if (Inputs[n].type == 'checkbox' && Inputs[n].id.indexOf(TargetChildControl, 0) >= 0)
                    if (Inputs[n].checked) {
                        chkBox.checked = true;
                    }
                    else {
                        chkBox.checked = false;
                        break;
                    }
        }
        
    </script>
    <div class="container" style="background-color: white">
        <h2>
            &nbsp; Order/Invoice Step 1</h2>
    </div>
    <div class="container">
        <table width="100%">
            <tr>
                <td>
                    <div style="z-index: 101; left: 597px; width: 100px; position: absolute; top: 390px;
                        height: 100px">
                        <asp:Panel ID="Panel2" runat="server">
                            <asp:UpdateProgress ID="UpdateProgress1" runat="server" AssociatedUpdatePanelID="UpdatePanel1">
                                <ProgressTemplate>
                                    <asp:ImageButton ID="ImageButton1" runat="server" Height="26px" ImageUrl="~/App_Themes/Granite/Images/image003.gif"
                                        Width="27px" />
                                    Wait Update.......
                                </ProgressTemplate>
                            </asp:UpdateProgress>
                        </asp:Panel>
                    </div>
                </td>
                <td align="center">
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate>
                            <table>
                                <tbody>
                                    <tr>
                                        <td align="left">
                                            <asp:Label ID="Label2" runat="server" Width="104px" Text="Transaction Type" CssClass="lblbox"></asp:Label>
                                        </td>
                                        <td style="width: 238px; height: 25px" align="left">
                                            <asp:DropDownList ID="DrpDocumentType" runat="server" Width="200px" CssClass="DropList"
                                                AutoPostBack="True" OnSelectedIndexChanged="DrpDocumentType_SelectedIndexChanged">
                                                <asp:ListItem Value="0">Order Entry</asp:ListItem>
                                                <asp:ListItem Value="1">Spot Sale</asp:ListItem>
                                                <asp:ListItem Value="2">Sale Return</asp:ListItem>
                                            </asp:DropDownList>
                                            &nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="left">
                                            <asp:Label ID="lbltoLocation" runat="server" Width="94px" Text="Location" CssClass="lblbox"></asp:Label>
                                        </td>
                                        <td style="width: 238px; height: 25px" align="left">
                                            <asp:DropDownList ID="drpDistributor" runat="server" Width="200px" CssClass="DropList"
                                                AutoPostBack="True" OnSelectedIndexChanged="drpDistributor_SelectedIndexChanged">
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="left">
                                            <asp:Label ID="Label1" runat="server" Width="94px" Text="Principal" CssClass="lblbox"></asp:Label>
                                        </td>
                                        <td style="width: 238px; height: 25px" align="left">
                                            <asp:DropDownList ID="DrpPrincipal" runat="server" Width="200px" CssClass="DropList"
                                                AutoPostBack="True" OnSelectedIndexChanged="DrpPrincipal_SelectedIndexChanged">
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="left">
                                            <asp:Label ID="lblfromLocation" runat="server" Width="94px" Text="Customer Area"
                                                CssClass="lblbox"></asp:Label>
                                        </td>
                                        <td style="width: 238px; height: 25px" align="left">
                                            <asp:DropDownList ID="DrpRoute" runat="server" Width="200px" CssClass="DropList"
                                                AutoPostBack="True" OnSelectedIndexChanged="DrpRoute_SelectedIndexChanged">
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="left">
                                            <asp:Label ID="Label6" runat="server" Width="94px" Text="Order Booker" CssClass="lblbox"></asp:Label>
                                        </td>
                                        <td style="width: 238px; height: 25px" align="left">
                                            <asp:DropDownList ID="DrpOrderBooker" runat="server" Width="200px" CssClass="DropList">
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="left">
                                            <asp:Label ID="Label5" runat="server" Width="94px" Text="Sale Force" CssClass="lblbox"></asp:Label>
                                        </td>
                                        <td style="width: 238px; height: 25px" align="left">
                                            <asp:DropDownList ID="DrpDeliveryMan" runat="server" Width="200px" CssClass="DropList">
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="left">
                                            <asp:Label ID="Label3" runat="server" Width="100px" Text="Payment Mode" __designer:wfdid="w1"></asp:Label>
                                        </td>
                                        <td style="width: 238px; height: 25px" align="left">
                                            <asp:DropDownList ID="ddSearchType" runat="server" Width="200px" CssClass="DropList"
                                                __designer:wfdid="w2">
                                                <asp:ListItem Value="214">Cash</asp:ListItem>
                                                <asp:ListItem Value="215">Credit</asp:ListItem>
                                                <asp:ListItem Value="216">Advance</asp:ListItem>
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="left">
                                            <asp:Label ID="Label4" runat="server" Width="94px" Text="Quantity Type" CssClass="lblbox"></asp:Label>
                                        </td>
                                        <td style="width: 238px; height: 25px" align="left">
                                            <asp:RadioButtonList ID="RbUnitType" runat="server" Width="225px" RepeatDirection="Horizontal">
                                                <asp:ListItem Selected="True">Quantity In Unit</asp:ListItem>
                                                <asp:ListItem>Quantity In Ctns</asp:ListItem>
                                            </asp:RadioButtonList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right">
                                        </td>
                                        <td style="width: 238px; height: 25px" align="left">
                                            <asp:Button ID="btnGetOrder" OnClick="btnGetOrder_Click" runat="server" Width="100px"
                                                Font-Size="8pt" Text="Get Order" __designer:dtid="562949953421327" __designer:wfdid="w1">
                                            </asp:Button>
                                            <asp:Button ID="btnNext" OnClick="btnNext_Click" runat="server" Width="100px" Font-Size="8pt"
                                                Text="Next"></asp:Button>
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
        </table>
        <ajaxToolkit:ModalPopupExtender ID="ModalPopupExtender" runat="server" BackgroundCssClass="modalBackground"
            CancelControlID="CancelButton" DropShadow="true" PopupControlID="Panel1"
            PopupDragHandleControlID="Panel3" TargetControlID="dummyLink" BehaviorID="ModelPopup">
        </ajaxToolkit:ModalPopupExtender>
        <asp:Panel ID="Panel1" runat="server" Style="display: none; background-color: White;"
            Width="800px">
            <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                <ContentTemplate>
                    <table width="100%">
                        <tbody>
                            <tr>
                                <td style="width: 780px">
                                    <asp:GridView ID="GrdFreeSKU" runat="server" Visible="False" Width="100%" Height="57px"
                                        ForeColor="Red" CssClass="gridRow2" __designer:wfdid="w25" AutoGenerateColumns="False"
                                        BackColor="White" BorderColor="White" HorizontalAlign="Center">
                                        <PagerSettings FirstPageText="" LastPageText="" Mode="NextPrevious" NextPageText="Next"
                                            PreviousPageText="Previous" />
                                        <RowStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" ForeColor="Black" />
                                        <Columns>
                                            <asp:BoundField DataField="SALE_ORDER_ID" HeaderText="Order Id">
                                                <HeaderStyle HorizontalAlign="Left" />
                                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="SKU_Code" HeaderText="SKU Code">
                                                <HeaderStyle HorizontalAlign="Left" />
                                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left"
                                                    Width="80px" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="QUANTITY_UNIT" HeaderText="Order Qty">
                                                <HeaderStyle HorizontalAlign="Center" />
                                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="BALANCE" HeaderText="Stock">
                                                <HeaderStyle HorizontalAlign="Center" />
                                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center"
                                                    Width="50px" />
                                            </asp:BoundField>
                                        </Columns>
                                        <FooterStyle BackColor="White" />
                                        <PagerStyle BackColor="Transparent" />
                                        <HeaderStyle BackColor="Red" BorderColor="Black" BorderStyle="Solid" BorderWidth="1px"
                                            ForeColor="Black" />
                                    </asp:GridView>
                                    <asp:GridView ID="gvRateDifference" runat="server" Visible="False" Width="100%" Height="57px"
                                        ForeColor="Red" CssClass="gridRow2" __designer:wfdid="w26" AutoGenerateColumns="False"
                                        BackColor="White" BorderColor="White" HorizontalAlign="Center">
                                        <PagerSettings PreviousPageText="Previous" Mode="NextPrevious" LastPageText="" FirstPageText=""
                                            NextPageText="Next"></PagerSettings>
                                        <FooterStyle BackColor="White"></FooterStyle>
                                        <Columns>
                                            <asp:BoundField DataField="SALE_ORDER_ID" HeaderText="Order Id">
                                                <ItemStyle BorderStyle="Solid" BorderWidth="1px" BorderColor="Silver" HorizontalAlign="Left">
                                                </ItemStyle>
                                                <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                            </asp:BoundField>
                                            <asp:BoundField DataField="SKU_Code" HeaderText="SKU Code">
                                                <ItemStyle BorderStyle="Solid" Width="80px" BorderWidth="1px" BorderColor="Silver"
                                                    HorizontalAlign="Left"></ItemStyle>
                                                <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                            </asp:BoundField>
                                            <asp:BoundField DataField="Order_Rate" HeaderText="Order Rate">
                                                <ItemStyle BorderStyle="Solid" BorderWidth="1px" BorderColor="Silver" HorizontalAlign="Center">
                                                </ItemStyle>
                                                <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                            </asp:BoundField>
                                            <asp:BoundField DataField="SSR_Rate" HeaderText="SSR Rate">
                                                <ItemStyle BorderStyle="Solid" Width="50px" BorderWidth="1px" BorderColor="Silver"
                                                    HorizontalAlign="Center"></ItemStyle>
                                                <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
                                            </asp:BoundField>
                                        </Columns>
                                        <RowStyle BorderStyle="Solid" ForeColor="Black" BorderWidth="1px" BorderColor="Silver">
                                        </RowStyle>
                                        <PagerStyle BackColor="Transparent"></PagerStyle>
                                        <HeaderStyle BackColor="Red" BorderStyle="Solid" ForeColor="Black" BorderWidth="1px"
                                            BorderColor="Black"></HeaderStyle>
                                    </asp:GridView>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 780px">
                                    <table style="border-right: silver thin inset; border-top: silver thin inset; border-left: silver thin inset;
                                        width: 650px; border-bottom: silver thin inset">
                                        <tbody>
                                            <tr>
                                                <td style="border-right: darkgray 1px solid; border-top: darkgray 1px solid; border-left: darkgray 1px solid;
                                                    width: 4px; border-bottom: darkgray 1px solid; height: 21px; background-color: silver"
                                                    align="left">
                                                    <asp:CheckBox ID="chkBxHeader" onclick="javascript:HeaderClick(this);" runat="server"
                                                        Width="103px" Text="Select All" __designer:wfdid="w27"></asp:CheckBox>
                                                </td>
                                                <td style="border-right: darkgray 1px solid; border-top: darkgray 1px solid; border-left: darkgray 1px solid;
                                                    border-bottom: darkgray 1px solid; height: 21px; background-color: silver" align="right"
                                                    colspan="4">
                                                    &nbsp;&nbsp;<asp:Button ID="btnPost" OnClick="btnPost_Click" runat="server" Width="128px"
                                                        Font-Size="8pt" Text="Convert to Invoice" __designer:wfdid="w3"></asp:Button>&nbsp;
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="height: 21px" align="left" colspan="5">
                                                    <asp:Panel ID="Panel3" runat="server" Width="780px" Height="250px" ScrollBars="Vertical"
                                                        __designer:wfdid="w31">
                                                        <asp:GridView ID="GrdOrder" onclick="GridClick();" runat="server" Width="750px" ForeColor="SteelBlue"
                                                            CssClass="gridRow2" __designer:wfdid="w32" HorizontalAlign="Center" BorderColor="White"
                                                            BackColor="White" AutoGenerateColumns="False">
                                                            <PagerSettings FirstPageText="" LastPageText="" Mode="NextPrevious" NextPageText="Next"
                                                                PreviousPageText="Previous"></PagerSettings>
                                                            <RowStyle ForeColor="Black"></RowStyle>
                                                            <Columns>
                                                                <asp:BoundField DataField="CUSTOMER_ID" HeaderText="Customer Id">
                                                                    <HeaderStyle CssClass="HidePanel"></HeaderStyle>
                                                                    <ItemStyle CssClass="HidePanel"></ItemStyle>
                                                                </asp:BoundField>
                                                                <asp:TemplateField HeaderText="Select">
                                                                    <ItemTemplate>
                                                                        <asp:CheckBox ID="ChbInvoice" runat="server" __designer:wfdid="w33"></asp:CheckBox>
                                                                    </ItemTemplate>
                                                                    <ItemStyle BorderColor="Silver" BorderWidth="1px" BorderStyle="Solid"></ItemStyle>
                                                                </asp:TemplateField>
                                                                <asp:BoundField DataField="CUSTOMER_CODE" HeaderText="Code">
                                                                    <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderWidth="1px" BorderStyle="Solid">
                                                                    </ItemStyle>
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="CUSTOMER_NAME" HeaderText="Name">
                                                                    <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderWidth="1px" BorderStyle="Solid">
                                                                    </ItemStyle>
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="SALE_ORDER_ID" HeaderText="Sale Order Id">
                                                                    <ItemStyle HorizontalAlign="Center" BorderColor="Silver" BorderWidth="1px" BorderStyle="Solid">
                                                                    </ItemStyle>
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="DOCUMENT_DATE" HeaderText="Order Date">
                                                                    <ItemStyle HorizontalAlign="Center" BorderColor="Silver" BorderWidth="1px" BorderStyle="Solid">
                                                                    </ItemStyle>
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="TOTAL_AMOUNT" DataFormatString="{0:F2}" HeaderText="Gross Amount">
                                                                    <ItemStyle HorizontalAlign="Center" BorderColor="Silver" BorderWidth="1px" BorderStyle="Solid">
                                                                    </ItemStyle>
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="DISCOUNT_AMOUNT" DataFormatString="{0:F2}" HeaderText="Discount">
                                                                    <ItemStyle HorizontalAlign="Center" BorderColor="Silver" BorderWidth="1px" BorderStyle="Solid">
                                                                    </ItemStyle>
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="SCHEME_AMOUNT" DataFormatString="{0:F2}" HeaderText="Scheme">
                                                                    <ItemStyle HorizontalAlign="Center" BorderColor="Silver" BorderWidth="1px" BorderStyle="Solid">
                                                                    </ItemStyle>
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="GST_AMOUNT" DataFormatString="{0:F2}" HeaderText="GST Amount">
                                                                    <ItemStyle HorizontalAlign="Center" BorderColor="Silver" BorderWidth="1px" BorderStyle="Solid">
                                                                    </ItemStyle>
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="TOTAL_NET_AMOUNT" DataFormatString="{0:F2}" HeaderText="Net Amount">
                                                                    <ItemStyle HorizontalAlign="Center" BorderColor="Silver" BorderWidth="1px" BorderStyle="Solid">
                                                                    </ItemStyle>
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="DELIVERYMAN_ID" HeaderText="DELIVERYMAN_ID">
                                                                    <HeaderStyle CssClass="HidePanel"></HeaderStyle>
                                                                    <ItemStyle CssClass="HidePanel"></ItemStyle>
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="MANUAL_ORDER_ID" HeaderText="Bill Book No">
                                                                    <HeaderStyle CssClass="HidePanel"></HeaderStyle>
                                                                    <ItemStyle CssClass="HidePanel"></ItemStyle>
                                                                </asp:BoundField>
                                                            </Columns>
                                                            <FooterStyle BackColor="White"></FooterStyle>
                                                            <PagerStyle BackColor="Transparent"></PagerStyle>
                                                            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" BackColor="#007395"
                                                                Font-Bold="True" ForeColor="White"></HeaderStyle>
                                                            <AlternatingRowStyle BackColor="#F2F2F2" CssClass="GridAlternateRowStyle" ForeColor="#333333">
                                                            </AlternatingRowStyle>
                                                        </asp:GridView>
                                                    </asp:Panel>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 780px">
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </ContentTemplate>
            </asp:UpdatePanel>
            <a href="#" style="display: none; visibility: hidden;" onclick="return false" id="dummyLink"
                runat="server">dummy</a> &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp;
            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp;
            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp;
            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
            <asp:ImageButton ID="CancelButton" runat="server" ImageUrl="~/App_Themes/Granite/Images/closelabel.gif" /></asp:Panel>
    </div>
</asp:Content>
