<%@ Page Language="C#" MasterPageFile="~/Forms/PageMaster.master" AutoEventWireup="true" CodeFile="RptDailySaleUpdate.aspx.cs" Inherits="Forms_RptDailySaleUpdate" Title="SAMS :: Daily Sale Update" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<asp:Content ID="Content1" runat="server" ContentPlaceHolderID="cphPage">
    
<div id="right_data">
        <table width="100%">
            <tr>
                <td>
                    <asp:UpdatePanel id="UpdatePanel1" runat="server">
                        <contenttemplate>
<TABLE><TBODY><TR><TD align=left colSpan=4><asp:Label id="lblErrorMsg" runat="server" ForeColor="Red" Font-Bold="True"></asp:Label> </TD><TD style="WIDTH: 1px" align=left colSpan=1></TD></TR><TR><TD style="HEIGHT: 25px" align=left></TD><TD style="WIDTH: 92px; HEIGHT: 25px" align=left>
<strong><asp:Label id="Label3" runat="server" Width="65px" Text="Region" CssClass="lblbox"></asp:Label></strong></TD><TD style="WIDTH: 1px; HEIGHT: 25px" align=left></TD><TD style="WIDTH: 203px; HEIGHT: 25px" align=left><asp:DropDownList id="DrpRegion" runat="server" Width="200px" CssClass="DropList" OnSelectedIndexChanged="DrpRegion_SelectedIndexChanged" AutoPostBack="True">
            </asp:DropDownList></TD><TD style="WIDTH: 1px; HEIGHT: 25px" align=left></TD></TR><TR><TD align=left></TD><TD style="WIDTH: 92px" align=left>
            <strong><asp:Label id="Label4" runat="server" Width="65px" Text="Zone" CssClass="lblbox"></asp:Label></strong></TD><TD style="WIDTH: 1px" align=left></TD><TD style="WIDTH: 203px; HEIGHT: 25px" align=left><asp:DropDownList id="DrpZone" runat="server" Width="200px" CssClass="DropList" OnSelectedIndexChanged="DrpZone_SelectedIndexChanged" AutoPostBack="True">
            </asp:DropDownList></TD><TD style="WIDTH: 1px; HEIGHT: 25px" align=left></TD></TR><TR><TD align=left></TD><TD style="WIDTH: 92px" align=left>
            <strong><asp:Label id="Label5" runat="server" Width="65px" Text="Territory" CssClass="lblbox"></asp:Label></strong></TD><TD style="WIDTH: 1px" align=left></TD><TD style="WIDTH: 203px; HEIGHT: 25px" align=left><asp:DropDownList id="DrpTerritory" runat="server" Width="200px" CssClass="DropList">
            </asp:DropDownList></TD><TD style="WIDTH: 1px; HEIGHT: 25px" align=left></TD></TR><TR><TD align=left></TD><TD style="WIDTH: 92px" align=left>
            <strong><asp:Label id="lbltoLocation" runat="server" Width="61px" Text="Principal" CssClass="lblbox"></asp:Label></strong></TD><TD style="WIDTH: 1px" align=left></TD><TD style="WIDTH: 203px; HEIGHT: 25px" align=left><asp:DropDownList id="drpPrincipal" runat="server" Width="200px" CssClass="DropList" AutoPostBack="True"></asp:DropDownList></TD><TD style="WIDTH: 1px; HEIGHT: 25px" align=left></TD></TR><TR><TD style="HEIGHT: 25px" align=left></TD><TD style="WIDTH: 92px; HEIGHT: 25px" align=left>
            <strong><asp:Label id="Label6" runat="server" Width="75px" Text="Report Type" CssClass="lblbox"></asp:Label></strong></TD><TD style="WIDTH: 1px; HEIGHT: 25px" align=left></TD><TD style="WIDTH: 203px; HEIGHT: 25px" align=left><asp:RadioButtonList id="RbUnitType" runat="server" Width="159px" RepeatDirection="Horizontal">
                <asp:ListItem Selected="True">Units</asp:ListItem>
                <asp:ListItem>Carton</asp:ListItem>
                <asp:ListItem>Kg</asp:ListItem>
            </asp:RadioButtonList></TD><TD style="WIDTH: 1px; HEIGHT: 25px" align=left></TD></TR><TR><TD style="HEIGHT: 25px" align=left></TD><TD style="WIDTH: 92px; HEIGHT: 25px" align=left>
            <strong><asp:Label id="Label1" runat="server" Width="48px" Text="Date" CssClass="lblbox"></asp:Label></strong></TD><TD style="WIDTH: 1px; HEIGHT: 25px" align=left></TD><TD style="WIDTH: 203px; HEIGHT: 25px" align=left><asp:TextBox id="txtDate" runat="server" Width="150px" CssClass="txtBox" MaxLength="10"></asp:TextBox> <asp:ImageButton id="ImgBntFromCalc" runat="server" ImageUrl="~/App_Themes/Granite/Images/date.gif"></asp:ImageButton></TD><TD style="WIDTH: 1px; HEIGHT: 25px" align=left></TD></TR></TBODY></TABLE><cc1:CalendarExtender id="CalendarExtender1" runat="server" Format="dd-MMM-yyyy" EnableViewState="False" PopupButtonID="ImgBntFromCalc" TargetControlID="txtdate"></cc1:CalendarExtender>&nbsp;&nbsp; 
</contenttemplate>
                    </asp:UpdatePanel>                 &nbsp;
                    <asp:Button ID="btnViewPDF" runat="server" CssClass="Button" Width="90" Text="View PDF" OnClick="btnViewPDF_Click" />
                    <asp:Button ID="btnViewExcel" runat="server" OnClick="btnViewExcel_Click" Width="90" Text="View Excel" CssClass="Button" /></td>
            </tr>
        </table>
        
           </div>
</asp:Content>

