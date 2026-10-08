<%@ Page Language="C#" MasterPageFile="~/Forms/PageMaster.master" AutoEventWireup="true"
    CodeFile="rptCreditDebitNote.aspx.cs" Inherits="Forms_rptCreditDebitNote"
    Title="SAMS :: Credit-Debit Note" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" runat="server" ContentPlaceHolderID="cphPage">
    
    <div id="right_data">
        <table width="100%">
            <tr>
                <td>
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate>
                            <table>
                                <tbody>         
                                    <tr>
                                        <td align="left">
                                        </td>
                                        <td align="left">
                                            <strong>
                                                <asp:Label ID="Label2" runat="server" Width="100px" Text="Report Type"></asp:Label></strong>
                                        </td>
                                        <td style="width: 1px" align="left">
                                        </td>
                                        <td style="width: 201px; height: 25px" align="left">
                                            <asp:RadioButtonList ID="rblType" runat="server" RepeatDirection="Horizontal">
                                                <asp:ListItem Value="383" Text="Credit Note" Selected="True"></asp:ListItem>
                                                <asp:ListItem Value="378" Text="Debit Note"></asp:ListItem>
                                            </asp:RadioButtonList>
                                        </td>
                                    </tr>                                                                                                                                                                           
                                    <tr>
                                        <td align="left">
                                        </td>
                                        <td align="left">
                                            <strong>
                                                <asp:Label ID="lbltoLocation" runat="server" Width="66px" Text="Location" CssClass="lblbox"></asp:Label></strong>
                                        </td>
                                        <td style="width: 1px" align="left">
                                        </td>
                                        <td style="width: 201px; height: 25px" align="left">
                                            <asp:DropDownList ID="drpDistributor" runat="server" Width="200px" AutoPostBack="true" OnSelectedIndexChanged="drpDistributor_SelectedIndexChanged">
                                            </asp:DropDownList>
                                        </td>
                                    </tr>  
                                    <tr>
                                        <td align="left">
                                        </td>
                                        <td align="left">
                                            <strong>
                                                <asp:Label ID="Label1" runat="server" Width="66px" Text="City"></asp:Label></strong>
                                        </td>
                                        <td style="width: 1px" align="left">
                                        </td>
                                        <td style="width: 201px; height: 25px" align="left">
                                            <asp:DropDownList ID="ddlCity" runat="server" Width="200px">
                                            </asp:DropDownList>
                                        </td>
                                    </tr>                                    
                                    <tr>
                                        <td style="height: 68px" align="left" colspan="4">                                                                                        
                                            <div id="divMonth" class="divMonth" runat="server">
                                                <table width="100%">
                                                    <tbody>
                                                        <tr>
                                                            <td style="padding-left: 5px; width: 8px; height: 25px">
                                                                <strong>
                                                                    <asp:Label ID="lblFromMonth" runat="server" Width="78px" Text="From Month" CssClass="lblbox"></asp:Label></strong>
                                                            </td>
                                                            <td style="width: 20px">
                                                            </td>
                                                            <td style="padding-left: 7px; width: 204px; height: 25px" align="left">
                                                                &nbsp;<asp:TextBox ID="txtFromMonth" onkeyup="BlockStartDateKeyPress()" runat="server"
                                                                    Width="100px" MaxLength="10"></asp:TextBox>
                                                                <asp:ImageButton ID="ibtnStartMonth" runat="server" Width="16px" ImageUrl="~/App_Themes/Granite/Images/date.gif">
                                                                </asp:ImageButton>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="padding-left: 5px; width: 8px; height: 25px">
                                                                <strong>
                                                                    <asp:Label ID="lblToMonth" runat="server" Width="78px" Text="To Month" CssClass="lblbox"></asp:Label></strong>
                                                            </td>
                                                            <td style="width: 1px; height: 25px">
                                                            </td>
                                                            <td style="padding-left: 7px; width: 204px; height: 25px">
                                                                &nbsp;<asp:TextBox ID="txtToMonth" onkeyup="BlockStartDateKeyPress()" runat="server"
                                                                    Width="100px" MaxLength="10"></asp:TextBox>
                                                                <asp:ImageButton ID="ibtnEndMonth" runat="server" Width="16px" ImageUrl="~/App_Themes/Granite/Images/date.gif">
                                                                </asp:ImageButton>
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="left">
                                        </td>
                                        <td align="left">
                                        </td>
                                        <td style="width: 1px" align="left">
                                        </td>
                                        <td style="width: 201px; height: 25px" align="left">
                                            <%@ register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="cc1" %>                                            
                                            <cc1:CalendarExtender ID="CEStartMonth" runat="server" Format="dd-MMM-yyyy"
                                                PopupButtonID="ibtnStartMonth" TargetControlID="txtFromMonth">
                                            </cc1:CalendarExtender>
                                            <cc1:CalendarExtender ID="CESEndMonth" runat="server" Format="dd-MMM-yyyy"
                                                PopupButtonID="ibtnEndMonth" TargetControlID="txtToMonth">
                                            </cc1:CalendarExtender>                                            
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                    &nbsp; &nbsp;
                    <asp:Button ID="btnViewPDF" runat="server" CssClass="Button" Text="View PDF" OnClick="btnViewPDF_Click" />
                    <asp:Button ID="btnViewExcel" runat="server" CssClass="Button" Text="View Excel"
                        OnClick="btnViewExcel_Click" />
                </td>
            </tr>
        </table>
        &nbsp;
    </div>
</asp:Content>
