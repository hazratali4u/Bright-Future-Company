<%@ Page Language="C#" MasterPageFile="~/Forms/PageMaster.master" AutoEventWireup="true" CodeFile="RptPrincipalWiseExp.aspx.cs" Inherits="Forms_RptPrincipalWiseExp" Title="SAMS :: Petty Expense Summary" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<asp:Content ID="ID" runat="server" ContentPlaceHolderID="cphPage">
    
    <script language="javascript" type="text/javascript">
    function SelectAllAccountHead()
{    
    var chkBoxList = document.getElementById('<%= LstAccountHead.ClientID %>');
    var chkBox = document.getElementById('<%= ChbAllAccountHead.ClientID %>');
    if(chkBox.checked == true)
    {
        var chkBoxCount= chkBoxList.getElementsByTagName("input");
    
        for(var i=0;i<chkBoxCount.length;i++) 
        {
            chkBoxCount[i].checked = true;
        }
    }
    else
    {
        var chkBoxCount= chkBoxList.getElementsByTagName("input");
    
        for(var i=0;i<chkBoxCount.length;i++) 
        {
            chkBoxCount[i].checked = false;
        }
    }            
}

function UnCheckSelectAll()
{
    var chkBox = document.getElementById('<%= ChbAllAccountHead.ClientID %>');
    var chkBoxList = document.getElementById('<%= LstAccountHead.ClientID %>');
    var chkBoxCount= chkBoxList.getElementsByTagName("input");
    var count = 0;
    for(var i=0;i<chkBoxCount.length;i++) 
     {
        if(chkBoxCount[i].checked == false)
        {
            count +=1;
        }
     }
     if(count > 0)
     {
        chkBox.checked = false;
     }
     else
     {
        chkBox.checked = true;
     }         
}

    </script>
    
 <div id="right_data">
        <table width="100%">
            <tr>
                <td>
                    <asp:UpdatePanel id="UpdatePanel1" runat="server">
                        <contenttemplate>
<TABLE><TBODY><TR><TD align=left colSpan=4><asp:Label id="lblErrorMsg" runat="server" ForeColor="Red" Font-Bold="True"></asp:Label> </TD><TD style="WIDTH: 1px" align=left colSpan=1></TD></TR><TR><TD align=left></TD><TD style="WIDTH: 90px" align=left>
<strong><asp:Label id="Label2" runat="server" Width="48px" Text="Location" CssClass="lblbox"></asp:Label></strong></TD><TD style="WIDTH: 1px" align=left></TD><TD style="WIDTH: 204px; HEIGHT: 25px" align=left><asp:DropDownList id="DrpLocation" runat="server" Width="200px" CssClass="DropList" AutoPostBack="True"></asp:DropDownList></TD><TD style="WIDTH: 1px; HEIGHT: 25px" align=left></TD></TR><TR><TD align=left></TD><TD style="WIDTH: 90px" align=left>
<strong><asp:Label id="Label4" runat="server" Width="48px" Text="Principal" CssClass="lblbox"></asp:Label></strong></TD><TD style="WIDTH: 1px" align=left></TD><TD style="WIDTH: 204px; HEIGHT: 25px" align=left><asp:DropDownList id="drpPrincipal" runat="server" Width="200px" CssClass="DropList" AutoPostBack="True"></asp:DropDownList></TD><TD style="WIDTH: 1px; HEIGHT: 25px" align=left></TD></TR><TR><TD align=left></TD><TD style="WIDTH: 90px" align=left>
<strong><asp:Label id="Label7" runat="server" Width="91px" Text="Account Type" CssClass="lblbox"></asp:Label></strong></TD><TD style="WIDTH: 1px" align=left></TD><TD style="WIDTH: 204px; HEIGHT: 25px" align=left><asp:DropDownList id="DrpMasterHead" runat="server" Width="200px" CssClass="DropList" AutoPostBack="True" OnSelectedIndexChanged="DrpMasterHead_SelectedIndexChanged">
            <asp:ListItem Selected="True" Value="55">Administrative Expenses</asp:ListItem>
            <asp:ListItem Value="56">Selling Expenses</asp:ListItem>
            </asp:DropDownList></TD><TD style="WIDTH: 1px; HEIGHT: 25px" align=left></TD></TR><TR><TD style="HEIGHT: 2px" align=left></TD><TD style="WIDTH: 90px; HEIGHT: 2px" align=left>
            <strong><asp:Label id="Label5" runat="server" Width="84px" Text="Account Head" CssClass="lblbox"></asp:Label></strong></TD><TD style="WIDTH: 1px; HEIGHT: 2px" align=left></TD><TD style="WIDTH: 204px; HEIGHT: 2px" align=left><asp:CheckBox id="ChbAllAccountHead" onclick="SelectAllAccountHead()" runat="server" Text="All Account Head" AutoPostBack="True"></asp:CheckBox></TD><TD style="WIDTH: 1px; HEIGHT: 2px" align=left></TD></TR><TR><TD style="HEIGHT: 2px" align=left></TD><TD style="HEIGHT: 2px" align=left colSpan=3><asp:Panel id="Panel1" runat="server" Width="295px" Height="150px" ScrollBars="Vertical" BorderWidth="1px" BorderStyle="Groove"><asp:CheckBoxList id="LstAccountHead" onclick = "UnCheckSelectAll()" runat="server"></asp:CheckBoxList></asp:Panel></TD><TD style="WIDTH: 1px; HEIGHT: 2px" align=left></TD></TR><TR><TD align=left></TD><TD style="WIDTH: 90px" align=left>
            <strong><asp:Label id="Label1" runat="server" Width="59px" Height="9px" Text="From Date" CssClass="lblbox"></asp:Label></strong></TD><TD style="WIDTH: 1px" align=left></TD><TD style="WIDTH: 204px; HEIGHT: 25px" align=left><asp:TextBox id="txtFromDate" runat="server" Width="150px" CssClass="txtBox" MaxLength="10"></asp:TextBox> <asp:ImageButton id="ImgBntFromDate" runat="server" ImageUrl="~/App_Themes/Granite/Images/date.gif"></asp:ImageButton></TD><TD style="WIDTH: 1px; HEIGHT: 25px" align=left></TD></TR><TR><TD align=left></TD><TD style="WIDTH: 90px" align=left>
            <strong><asp:Label id="Label3" runat="server" Width="55px" Text="To Date" CssClass="lblbox"></asp:Label></strong></TD><TD style="WIDTH: 1px" align=left></TD><TD style="WIDTH: 204px; HEIGHT: 25px" align=left><asp:TextBox id="txtToDate" runat="server" Width="150px" CssClass="txtBox" MaxLength="10"></asp:TextBox> <asp:ImageButton id="ImgBntToDate" runat="server" ImageUrl="~/App_Themes/Granite/Images/date.gif"></asp:ImageButton></TD><TD style="WIDTH: 1px; HEIGHT: 25px" align=left></TD></TR></TBODY></TABLE><cc1:CalendarExtender id="CalendarExtender1" runat="server" TargetControlID="txtFromDate" PopupButtonID="ImgBntFromDate" EnableViewState="False" Format="dd-MMM-yyyy"></cc1:CalendarExtender><cc1:CalendarExtender id="CalendarExtender2" runat="server" TargetControlID="txtToDate" PopupButtonID="ImgBntToDate" EnableViewState="False" Format="dd-MMM-yyyy"></cc1:CalendarExtender> &nbsp; 
</contenttemplate>
                    </asp:UpdatePanel>
                    &nbsp;
                    <asp:Button ID="btnViewPDF" runat="server" CssClass="Button"
                Text="View PDF" Width="90" OnClick="btnViewPDF_Click" />
                    <asp:Button ID="btnViewExcell" runat="server"  CssClass="Button" Text="View Excel"
                        Width="90" OnClick="btnViewExcell_Click" /></td>
            </tr>
        </table>
        
           </div>
</asp:Content>