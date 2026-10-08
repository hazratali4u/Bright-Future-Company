<%@ page language="C#" MasterPageFile="~/Forms/PageMaster.master" AutoEventWireup="true" CodeFile="frmPromotionStep1.aspx.cs" inherits="Forms_frmPromotionStep1" title="SAMS :: Promotion Wizard" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphPage" Runat="Server">
       
     <script language="JavaScript" type="text/javascript">
    function ValidateForm()
	{
			var str;
			
			str = document.getElementById('<%=txtFromdate.ClientID%>').value;
			if(str == null || str.length == 0)
			{
				alert('Must select Promotion Start Date');
				return false;
			}
			str = document.getElementById('<%=txttoDate.ClientID%>').value;
			if(str == null || str.length == 0)
			{
				alert('Must select Promotino End Date');
				return false;
			}
					
		return true;	  		
	}
	function BlockFromDateKeyPress()
	{
	    document.getElementById('<%=txtFromdate.ClientID%>').value = '';
	    alert('Click Clender Button for Select Date');
	}
	function BlocktoDateKeyPress()
	{
	    document.getElementById('<%=txttoDate.ClientID%>').value = '';
	    alert('Click Clender Button for Select Date');
	}
    </script>
    <div id="right_data">
    <table width="100%">
        <tr>
            <td>
              
<TABLE><TBODY><TR><TD style="WIDTH: 100px"></TD><TD style="WIDTH: 201px"></TD><TD style="WIDTH: 100px" align="left"></TD></TR>


                            

<TR><TD align=left>
<strong> <asp:Label id="Label3" runat="server" Width="61px" Visible="False">Scheme</asp:Label></strong></TD><TD align="left" style="width: 201px"><asp:DropDownList id="drpScheme" runat="server" Width="200px" CssClass="DropList" Visible="False">
                            </asp:DropDownList></TD><TD align="left"></TD></TR>
<tr>
    <td align="left" style="height: 18px">
        <strong><asp:Label id="lblPrincipal" runat="server" Width="61px" CssClass="lblbox">Principal</asp:Label></strong>
    </td>
    <td align="left" style="width: 201px; height: 18px">
        <asp:DropDownList id="DrpPrincipal" runat="server" Width="200px" CssClass="DropList">
        </asp:DropDownList>
    </td>
    <td style="height: 18px" align="left"></td>
</tr>                            
                            <TR><TD align=left style="height: 20px">
                            <strong><asp:Label id="Label1" runat="server" Width="90px" Height="13px" Text="From Date"></asp:Label></strong></TD><TD align=left style="height: 20px; width: 201px;"><asp:TextBox style="TEXT-ALIGN: justify" id="txtFromdate" runat="server" Width="192px" onkeyup = "BlockFromDateKeyPress()" CssClass="txtBox"></asp:TextBox> </TD><TD style="height: 20px" align="left">
                            <asp:ImageButton id="ImgBntFromCalc" runat="server" ImageUrl="~/App_Themes/Granite/Images/date.gif" CausesValidation="False"></asp:ImageButton></TD></TR><TR><TD align=left>
                            <strong><asp:Label id="Label2" runat="server" Width="90px" Height="13px" Text="To Date"></asp:Label></strong></TD><TD align=left style="width: 201px"><asp:TextBox style="TEXT-ALIGN: justify" id="txttoDate" runat="server" Width="192px" onkeyup = "BlocktoDateKeyPress()" CssClass="txtBox"></asp:TextBox> </TD><TD align="left"><asp:ImageButton id="btnToDate" runat="server" ImageUrl="~/App_Themes/Granite/Images/date.gif" CausesValidation="False"></asp:ImageButton></TD></TR><TR><TD style="WIDTH: 100px"></TD><TD style="WIDTH: 201px"></TD><TD style="WIDTH: 100px" align="left"></TD></TR><TR><TD style="WIDTH: 100px"></TD><TD align=left style="width: 201px"><asp:CheckBox id="ChbActive" runat="server" Text="Is Active"></asp:CheckBox></TD><TD style="WIDTH: 100px" align="left"></TD></TR><TR><TD style="WIDTH: 100px; HEIGHT: 14px"></TD><TD style="WIDTH: 201px; HEIGHT: 14px"></TD><TD style="WIDTH: 100px; HEIGHT: 14px" align="left"></TD></TR><TR><TD align=left colSpan=3>&nbsp;
                            <asp:Button id="btnPromotion" onclick="btnPromotion_Click" runat="server" Width="125px" Font-Size="8pt" Text="Get Promotion" CssClass="Button" /> 
                            <asp:Button id="btnNew" runat="server" Width="125px" Font-Size="8pt" Text="New Promotion" OnClick="btnNew_Click" CssClass="Button" /> </TD></TR></TBODY></TABLE>

            <cc1:CalendarExtender id="CalendarExtender1" runat="server" TargetControlID="txtFromdate" PopupButtonID="ImgBntFromCalc" EnableViewState="False" Format = "dd-MMM-yyyy">
                            </cc1:CalendarExtender> <cc1:CalendarExtender id="CalendarExtender2" runat="server" TargetControlID="txttoDate" PopupButtonID="btnToDate" EnableViewState="False" Format = "dd-MMM-yyyy">
                            </cc1:CalendarExtender> 

            </td>
        </tr>
        <tr>
            <td >
            <asp:UpdatePanel id="UpdatePanel1" runat="server">
                    <contenttemplate>
<TABLE class="tblhead"><TBODY><TR><TD style="color:White;font-weight:bold;">
<asp:Label id="Label10" runat="server" Width="94px" Text="Searching Type"></asp:Label> </TD><TD style="WIDTH: 170px; HEIGHT: 21px" align=left><asp:DropDownList id="ddSearchType" runat="server" Width="154px" CssClass="DropList"><asp:ListItem Value="SKU_code">All Records</asp:ListItem>
<asp:ListItem Value="SCHEME_DESC">Scheme</asp:ListItem>
<asp:ListItem Value="PROMOTION_ID">Promotion Id</asp:ListItem>
<asp:ListItem Value="PROMOTION_CODE">Promotion Code</asp:ListItem>
<asp:ListItem Value="PROMOTION_DESCRIPTION">Description</asp:ListItem>
<asp:ListItem>Principal</asp:ListItem>
<asp:ListItem Value="Promotion_Class_Code">Promotion Class Code</asp:ListItem>
<asp:ListItem Value="Promotion_Class_Name">Promotion Class Name</asp:ListItem>
<asp:ListItem Value="GROUP_NAME">GROUP NAME</asp:ListItem>
</asp:DropDownList> </TD><TD style="WIDTH: 224px; HEIGHT: 21px" align=left><asp:TextBox id="txtSeach" runat="server" Width="180px" CssClass="txtBox "></asp:TextBox> </TD><TD style="HEIGHT: 21px" align=left width=250><asp:Button id="btnFilter" onclick="btnFilter_Click" runat="server" Width="85px" Font-Size="8pt" Text="Filter"></asp:Button> </TD></TR></TBODY></TABLE><asp:Panel id="Panel2" runat="server" Width="100%" Height="300px" ScrollBars="Vertical" BorderColor="Silver" BorderStyle="Groove" BorderWidth="1px">
                            <asp:GridView id="Grid_pricedetails" runat="server" Width="100%" ForeColor="SteelBlue" CssClass="gridRow2" BackColor="White" BorderColor="White" HorizontalAlign="Center" AutoGenerateColumns="False" OnRowEditing="Grid_pricedetails_RowEditing" OnRowDeleting="Grid_pricedetails_RowDeleting">
<PagerSettings FirstPageText="" LastPageText="" Mode="NextPrevious" NextPageText="Next" PreviousPageText="Previous"></PagerSettings>
<Columns>
<asp:BoundField DataField="SCHEME_ID" HeaderText="Scheme Id">
    <HeaderStyle HorizontalAlign="Left" />
    <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
</asp:BoundField>
<asp:BoundField DataField="PROMOTION_ID" HeaderText="Promotion Id">
<ItemStyle BorderColor="Silver" BorderWidth="1px" BorderStyle="Solid"></ItemStyle>
    <HeaderStyle HorizontalAlign="Left" />
</asp:BoundField>
<asp:BoundField DataField="SCHEME_DESC" HeaderText="Scheme">
<ItemStyle BorderColor="Silver" BorderWidth="1px" BorderStyle="Solid"></ItemStyle>
    <HeaderStyle HorizontalAlign="Left" />
</asp:BoundField>
<asp:BoundField DataField="PROMOTION_CODE" HeaderText="Promotion Name">
<ItemStyle BorderColor="Silver" BorderWidth="1px" BorderStyle="Solid"></ItemStyle>
    <HeaderStyle HorizontalAlign="Left" />
</asp:BoundField>
<asp:BoundField DataField="PROMOTION_DESCRIPTION" HeaderText="Description">
<ItemStyle BorderColor="Silver" BorderWidth="1px" BorderStyle="Solid"></ItemStyle>
    <HeaderStyle HorizontalAlign="Left" />
</asp:BoundField>
<asp:BoundField DataField="START_DATE" HeaderText="Start Date">
<ItemStyle BorderColor="Silver" BorderWidth="1px" BorderStyle="Solid"></ItemStyle>
    <HeaderStyle HorizontalAlign="Left" />
</asp:BoundField>
<asp:BoundField DataField="END_DATE" HeaderText="End Date">
<ItemStyle BorderColor="Silver" BorderWidth="1px" BorderStyle="Solid"></ItemStyle>
    <HeaderStyle HorizontalAlign="Left" />
</asp:BoundField>
<asp:BoundField DataField="Principal" HeaderText="Principal">
<ItemStyle BorderColor="Silver" BorderWidth="1px" BorderStyle="Solid"></ItemStyle>
    <HeaderStyle HorizontalAlign="Left" />
</asp:BoundField>
<asp:BoundField DataField="IS_ACTIVE" HeaderText="Status">
<ItemStyle BorderColor="Silver" BorderWidth="1px" BorderStyle="Solid"></ItemStyle>
    <HeaderStyle HorizontalAlign="Left" />
</asp:BoundField>
<asp:CommandField ShowEditButton="True" HeaderText="Edit">
<ItemStyle BorderColor="Silver" BorderWidth="1px" BorderStyle="Solid"></ItemStyle>
</asp:CommandField>
<asp:TemplateField HeaderText="Delete"><ItemTemplate>
<asp:LinkButton id="btnDelete" runat="server" Text="Delete" OnClientClick="javascript:return confirm('Are you sure you want to Delete?');return false;" CommandName="Delete"></asp:LinkButton>
</ItemTemplate>
</asp:TemplateField>
</Columns>
<HeaderStyle CssClass="tblhead"></HeaderStyle>
</asp:GridView> 
                        </asp:Panel> 
</contenttemplate>
                </asp:UpdatePanel>
            </td>
        </tr>
    </table>
    </div> 
</asp:Content>
