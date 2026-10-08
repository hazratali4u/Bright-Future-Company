<%@ Page Language="C#" MasterPageFile="~/Forms/PageMaster.master" AutoEventWireup="true"
    CodeFile="frmPostVoucher.aspx.cs" Inherits="Forms_frmPostVoucher" Title="SAMS :: Voucher Posting" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" runat="server" ContentPlaceHolderID="cphPage">
    <div id="right_data">
        <div>
            <table width="100%">
                <tr>
                    <td>
                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                            <ContentTemplate>
                                <table>
                                    <tbody>
                                        <tr>
                                            <td style="width: 100px" align="left">
                                                <strong>
                                                    <asp:Label ID="lbltoLocation" runat="server" Width="67px" Text="Location" CssClass="lblbox"></asp:Label></strong>
                                            </td>
                                            <td style="width: 100px">
                                                <asp:DropDownList ID="drpDistributor" runat="server" Width="200px" CssClass="DropList">
                                                </asp:DropDownList>
                                            </td>
                                            <td style="height: 25px">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="width: 100px" align="left">
                                                <strong>
                                                    <asp:Label ID="Label3" runat="server" Width="104px" Text="Voucher Type" CssClass="lblbox"></asp:Label></strong>
                                            </td>
                                            <td style="width: 100px">
                                                <asp:DropDownList ID="DrpVoucherType" runat="server" Width="200px" CssClass="DropList">
                                                    <asp:ListItem Value="14">Cash Voucher</asp:ListItem>
                                                    <asp:ListItem Value="15">Bank Voucher</asp:ListItem>
                                                    <asp:ListItem Value="16">Journal Voucher</asp:ListItem>
                                                </asp:DropDownList>
                                            </td>
                                            <td style="height: 25px">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="width: 100px" valign="middle" align="left">
                                                <strong>
                                                    <asp:Label ID="Label1" runat="server" Width="104px" Text="Principal" CssClass="lblbox"></asp:Label></strong>
                                            </td>
                                            <td style="width: 100px" align="left">
                                                <asp:DropDownList ID="DrpPrincipal" runat="server" Width="200px" CssClass="DropList">
                                                </asp:DropDownList>
                                            </td>
                                            <td style="height: 25px" align="left">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="width: 100px" valign="middle" align="left">
                                                <strong>
                                                    <asp:Label ID="Label4" runat="server" Width="70px" Height="13px" Text="From Date"></asp:Label></strong>
                                            </td>
                                            <td style="width: 100px" align="left">
                                                <asp:TextBox ID="txtStartDate" onkeyup="BlockStartDateKeyPress()" runat="server"
                                                    Width="190px" CssClass="txtBox" MaxLength="10"></asp:TextBox>
                                            </td>
                                            <td style="height: 25px" align="left">
                                                <asp:ImageButton ID="ibtnStartDate" runat="server" Width="16px" ImageUrl="~/App_Themes/Granite/Images/date.gif">
                                                </asp:ImageButton>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="width: 100px" valign="middle" align="left">
                                                <strong>
                                                    <asp:Label ID="Label5" runat="server" Width="80px" Height="13px" Text="To Date"></asp:Label></strong>
                                            </td>
                                            <td style="width: 100px" align="left">
                                                <asp:TextBox ID="txtEndDate" onkeyup="BlockEndDateKeyPress()" runat="server" Width="191px"
                                                    CssClass="txtBox " MaxLength="10"></asp:TextBox>
                                            </td>
                                            <td style="height: 25px" align="left">
                                                <asp:ImageButton ID="ibnEndDate" runat="server" Width="16px" ImageUrl="~/App_Themes/Granite/Images/date.gif">
                                                </asp:ImageButton>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td valign="top" align="left">
                                                &nbsp;
                                            </td>
                                            <td align="left">
                                                <cc1:CalendarExtender ID="CEStartDate" runat="server" TargetControlID="txtStartDate"
                                                    PopupButtonID="ibtnStartDate" Format="dd-MMM-yyyy">
                                                </cc1:CalendarExtender>
                                                <cc1:CalendarExtender ID="CEEndDate" runat="server" TargetControlID="txtEndDate"
                                                    PopupButtonID="ibnEndDate" Format="dd-MMM-yyyy">
                                                </cc1:CalendarExtender>
                                            </td>
                                            <td align="left">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="width: 100px; height: 12px" valign="top" align="left">
                                                <asp:CheckBox ID="ChbSelect" runat="server" Width="115px" Text="All Select" OnCheckedChanged="ChbSelect_CheckedChanged"
                                                    AutoPostBack="True"></asp:CheckBox>
                                            </td>
                                            <td style="width: 100px; height: 12px" align="left">
                                                <asp:Button ID="btnView" OnClick="btnView_Click" runat="server" Width="80px" Font-Size="8pt"
                                                    Text="View" CssClass="Button" />
                                                <asp:Button ID="btnPost" runat="server" Width="80px" Font-Size="8pt" Text="Post"
                                                    OnClick="btnPost_Click" CssClass="Button" />
                                                <div style="z-index: 101; left: 368px; width: 100px; position: absolute; top: 242px;
                                                    height: 100px">
                                                    <asp:UpdateProgress ID="UpdateProgress1" runat="server" AssociatedUpdatePanelID="UpdatePanel3">
                                                        <ProgressTemplate>
                                                            <asp:ImageButton ID="ImageButton1" runat="server" Height="23px" ImageUrl="~/App_Themes/Granite/Images/image003.gif"
                                                                Width="22px" />
                                                            Record Update
                                                        </ProgressTemplate>
                                                    </asp:UpdateProgress>
                                                </div>
                                            </td>
                                            <td style="height: 25px" align="left">
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                        <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                            <ContentTemplate>
                                <asp:Panel ID="Panel2" runat="server" BorderColor="Silver" BorderStyle="Groove" BorderWidth="2px"
                                    Height="150px" ScrollBars="Vertical" Width="650px">
                                    <asp:GridView ID="GrdLedger" runat="server" AutoGenerateColumns="False" BackColor="White"
                                        BorderColor="White" CssClass="gridRow2" ForeColor="SteelBlue" HorizontalAlign="Center"
                                        OnRowEditing="GrdLedger_RowEditing" Width="628px">
                                        <PagerSettings FirstPageText="" LastPageText="" Mode="NextPrevious" NextPageText="Next"
                                            PreviousPageText="Previous" />
                                        <Columns>
                                            <asp:TemplateField HeaderText="Voucher">
                                                <ItemTemplate>
                                                    <asp:CheckBox ID="ChbSelect" runat="server" />
                                                </ItemTemplate>
                                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" />
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="VOUCHER_NO" HeaderText="Voucher No">
                                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="Ledger_date" HeaderText="Voucher Date">
                                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="Remarks" HeaderText="Remarks">
                                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left"
                                                    Width="250px" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="VOUCHER_TYPE_ID" HeaderText="VOUCHER_TYPE_ID">
                                                <HeaderStyle CssClass="HidePanel" />
                                                <ItemStyle CssClass="HidePanel" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="VOUCHER_DATE" HeaderText="VOUCHER_DATE">
                                                <HeaderStyle CssClass="HidePanel" />
                                                <ItemStyle CssClass="HidePanel" />
                                            </asp:BoundField>
                                            <asp:CommandField EditText="View" HeaderText="Detail" ShowEditButton="True">
                                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                            </asp:CommandField>
                                        </Columns>
                                        <HeaderStyle CssClass="tblhead" HorizontalAlign="Center" VerticalAlign="Middle" />
                                    </asp:GridView>
                                </asp:Panel>
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
                        <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                            <ContentTemplate>
                                <asp:Panel ID="Panel1" runat="server" BorderColor="Silver" BorderStyle="Groove" BorderWidth="2px"
                                    Height="150px" ScrollBars="Vertical" Width="650px">
                                    <asp:GridView ID="GrdOrder" runat="server" AutoGenerateColumns="False" BackColor="White"
                                        BorderColor="White" CaptionAlign="Left" CssClass="gridRow2" ForeColor="SteelBlue"
                                        HorizontalAlign="Center" Width="628px" OnRowDataBound="GrdOrder_RowDataBound"
                                        ShowFooter="True">
                                        <PagerSettings FirstPageText="" LastPageText="" Mode="NextPrevious" NextPageText="Next"
                                            PreviousPageText="Previous" />
                                        <Columns>
                                            <asp:BoundField DataField="Account_Code" HeaderText="Account Code">
                                                <FooterStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                                <HeaderStyle HorizontalAlign="Left" />
                                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left"
                                                    Width="90px" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="Account_Name" HeaderText="Account Name">
                                                <FooterStyle CssClass="HidePanel" />
                                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left"
                                                    Width="170px" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="REMARKS" HeaderText="Account Description">
                                                <FooterStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Right" />
                                                <HeaderStyle HorizontalAlign="Left" />
                                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left"
                                                    Width="180px" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="debit" DataFormatString="{0:F2}" HeaderText="Debit">
                                                <FooterStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Right" />
                                                <HeaderStyle HorizontalAlign="Right" />
                                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Right"
                                                    Width="100px" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="credit" DataFormatString="{0:F2}" HeaderText="Credit">
                                                <FooterStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Right" />
                                                <HeaderStyle HorizontalAlign="Right" />
                                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Right"
                                                    Width="100px" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="ACCOUNT_HEAD_ID" HeaderText="ACCOUNT_HEAD_ID">
                                                <FooterStyle HorizontalAlign="Right" />
                                                <HeaderStyle CssClass="HidePanel" />
                                                <ItemStyle CssClass="HidePanel" />
                                            </asp:BoundField>
                                        </Columns>
                                        <HeaderStyle CssClass="tblhead" HorizontalAlign="Center" VerticalAlign="Middle" />
                                    </asp:GridView>
                                </asp:Panel>
                                <asp:HiddenField ID="HF1" runat="server" />
                                <asp:HiddenField ID="HF2" runat="server" />
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </td>
                </tr>
            </table>
        </div>
    </div>
</asp:Content>
