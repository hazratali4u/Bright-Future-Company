<%@ Page Language="C#" MasterPageFile="~/Forms/PageMaster.master" AutoEventWireup="true" CodeFile="RptCreditAging.aspx.cs" Inherits="Forms_RptCreditAging" Title="SAMS :: Credit Aging Report" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" runat="server" ContentPlaceHolderID="cphPage">
     <script language="JavaScript" type="text/javascript">
    function ValidateForm()
	{
			
		return true;	  		
	}

    </script>
 <div id="right_data">
        <table width="100%">
            <tr>
                <td>
                    <asp:UpdatePanel id="UpdatePanel1" runat="server">
                        <contenttemplate>
<TABLE><TBODY><TR><TD align=left></TD><TD vAlign=top align=left colSpan=3><asp:RadioButtonList id="rbtSotBy" runat="server" Width="301px" RepeatDirection="Horizontal" OnSelectedIndexChanged="rbtSotBy_SelectedIndexChanged" AutoPostBack="True">
                <asp:ListItem Selected="True" Value="0">Principal Wise</asp:ListItem>
                <asp:ListItem Value="1">Customer Wise</asp:ListItem>
                <asp:ListItem>Date Wise</asp:ListItem>
            </asp:RadioButtonList></TD></TR><TR><TD align=left></TD><TD vAlign=middle align=left>
            <strong><asp:Label id="Label1" runat="server" Width="94px" Text="Location Type" CssClass="lblbox"></asp:Label></strong></TD><TD align=left></TD><TD style="HEIGHT: 25px" vAlign=middle align=left><asp:DropDownList id="ddDistributorType" runat="server" Width="200px" OnSelectedIndexChanged="ddDistributorType_SelectedIndexChanged" AutoPostBack="True" CssClass="DropList">
        </asp:DropDownList></TD></TR><TR><TD align=left></TD><TD align=left>
        <strong><asp:Label id="lbltoLocation" runat="server" Width="94px" Text="Location" CssClass="lblbox"></asp:Label></strong></TD><TD align=left></TD><TD style="HEIGHT: 25px" align=left><asp:DropDownList id="drpDistributor" runat="server" Width="200px" CssClass="DropList">
    </asp:DropDownList></TD></TR><TR><TD align=left></TD><TD align=left>
    <strong><asp:Label id="Label6" runat="server" Width="78px" Text="Principal" CssClass="lblbox"></asp:Label></strong></TD><TD align=left></TD><TD style="HEIGHT: 25px" align=left><asp:DropDownList id="DrpPrincipal" runat="server" Width="200px" CssClass="DropList">
            </asp:DropDownList></TD></TR><TR><TD align=left></TD><TD align=left>
            <strong><asp:Label id="lblNickName" runat="server" Width="79px" Text="Channel Type" CssClass="lblbox" __designer:wfdid="w8"></asp:Label></strong></TD><TD align=left></TD><TD style="HEIGHT: 25px" align=left><asp:DropDownList id="drpChannelType" runat="server" Width="200px" CssClass="DropList" __designer:wfdid="w7"></asp:DropDownList></TD></TR><TR><TD align=left></TD><TD align=left>
            <strong><asp:Label id="Label3" runat="server" Visible="False" Width="70px" Height="13px" Text="Start Date"></asp:Label></strong></TD><TD align=left></TD><TD style="HEIGHT: 25px" align=left><asp:TextBox id="txtDocmentDate" onkeyup="BlockStartDateKeyPress()" runat="server" Visible="False" Width="150px" CssClass="txtBox" MaxLength="10"></asp:TextBox><asp:ImageButton id="ibtnStartDate" runat="server" Visible="False" Width="16px" ImageUrl="~/App_Themes/Granite/Images/date.gif"></asp:ImageButton></TD></TR><TR><TD align=left></TD><TD align=left>
            <strong><asp:Label id="Label4" runat="server" Width="80px" Height="13px" Text="End Date"></asp:Label></strong></TD><TD align=left></TD><TD style="HEIGHT: 25px" align=left><asp:TextBox id="txtEndDate" runat="server" Width="149px" CssClass="txtBox " MaxLength="10"></asp:TextBox><asp:ImageButton id="ibnEndDate" runat="server" Width="16px" ImageUrl="~/App_Themes/Granite/Images/date.gif"></asp:ImageButton></TD></TR></TBODY></TABLE><cc1:CalendarExtender id="CEStartDate" runat="server" TargetControlID="txtDocmentDate" PopupButtonID="ibtnStartDate" Format="dd-MMM-yyyy">
                            </cc1:CalendarExtender> <cc1:CalendarExtender id="CEEndDate" runat="server" TargetControlID="txtEndDate" PopupButtonID="ibnEndDate" Format="dd-MMM-yyyy">
                            </cc1:CalendarExtender> 
</contenttemplate>
                    </asp:UpdatePanel>
                
        <asp:Button ID="btnViewPDF" runat="server" CssClass="Button"
                Text="View PDF" Width="90" OnClick="btnViewPDF_Click" />
                    <asp:Button ID="btnViewExcel" runat="server" CssClass="Button"
                Text="View Excel" Width="90" OnClick="btnViewExcel_Click" /></td>
            </tr>
        </table>
         &nbsp;
        
           </div>
</asp:Content>