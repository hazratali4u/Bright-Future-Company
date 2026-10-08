<%@ Page Language="C#" MasterPageFile="~/Forms/PageMaster.master" AutoEventWireup="true" CodeFile="frmAccountHead.aspx.cs" Inherits="Forms_frmAccountHead" Title="SAMS :: Chart of Account" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphPage" Runat="Server">
     <script language="JavaScript" type="text/javascript">
     
       Sys.WebForms.PageRequestManager.getInstance().add_beginRequest( startRequest );

        Sys.WebForms.PageRequestManager.getInstance().add_endRequest( endRequest );

        function startRequest( sender, e )
        { 
            
            document.getElementById('<%=btnAccountType.ClientID%>').disabled = true;
            document.getElementById('<%=btnAccountSubType.ClientID%>').disabled = true;
            document.getElementById('<%=btnAccountDetailType.ClientID%>').disabled = true;
            document.getElementById('<%=btnSave.ClientID%>').disabled = true;

        }

        function endRequest( sender, e ) 
        { 
           
            document.getElementById('<%=btnAccountType.ClientID%>').disabled = false;
            document.getElementById('<%=btnAccountSubType.ClientID%>').disabled = false;
            document.getElementById('<%=btnAccountDetailType.ClientID%>').disabled = false;
            document.getElementById('<%=btnSave.ClientID%>').disabled = false;
        }
        
  </script>
     <div id="right_data">
         <table width="100%">
             <tr>
                 <td>
                     <cc1:TabContainer ID="TabContainer1" runat="server" ActiveTabIndex="0" Height="400px"
                         Width="650px">
                         <cc1:TabPanel ID="TabPanel1" runat="server">
                             <HeaderTemplate>
                                 Main Type
                             </HeaderTemplate>
                             <ContentTemplate>
                                 <table width="100%">
                                     <tr>
                                         <td style="width: 100px">
                                         </td>
                                         <td style="width: 100px">
                                             &nbsp;
                                         </td>
                                         <td style="width: 100px">
                                         </td>
                                     </tr>
                                     <tr>
                                         <td style="width: 100px">
                                         </td>
                                         <td style="width: 100px">
                                             <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                                 <ContentTemplate>
<TABLE width="100%"><TBODY><TR><TD style="WIDTH: 100px"></TD><TD style="WIDTH: 49px"></TD><TD style="WIDTH: 100px"></TD><TD style="WIDTH: 100px"></TD></TR><TR><TD style="WIDTH: 100px">
<strong><asp:Label id="Label3" runat="server" Width="118px" Text="Account Category " __designer:wfdid="w123" CssClass="lblbox"></asp:Label></strong></TD><TD colSpan=2><asp:DropDownList id="DrpAccountCategory" runat="server" Width="265px" __designer:wfdid="w124" CssClass="DropList" AutoPostBack="True" OnSelectedIndexChanged="DrpAccountCategory_SelectedIndexChanged"><asp:ListItem>Balance Sheet Account</asp:ListItem>
<asp:ListItem>Income Statment Account</asp:ListItem>
</asp:DropDownList></TD><TD style="WIDTH: 100px"></TD></TR><TR><TD style="WIDTH: 100px; HEIGHT: 28px">
<strong><asp:Label id="Label1" runat="server" Width="119px" Text="Main Account Type " __designer:wfdid="w125" CssClass="lblbox"></asp:Label></strong></TD><TD style="WIDTH: 49px; HEIGHT: 28px"><asp:TextBox id="txtAtypeCode" runat="server" Width="77px" __designer:wfdid="w126" CssClass="txtBox " MaxLength="2" ReadOnly="True"></asp:TextBox></TD><TD style="WIDTH: 100px; HEIGHT: 28px"><asp:TextBox id="txtAtypeName" runat="server" Width="170px" __designer:wfdid="w127" CssClass="txtBox "></asp:TextBox></TD><TD style="WIDTH: 100px; HEIGHT: 28px"></TD></TR><TR><TD style="WIDTH: 100px; HEIGHT: 37px"></TD><TD style="HEIGHT: 37px" align=left colSpan=2>
<asp:Button id="btnAccountType" onclick="btnAccountType_Click" runat="server" Width="125px" Font-Size="8pt" Text="New Account Type" __designer:wfdid="w128" CssClass="Button" /> </TD><TD style="WIDTH: 100px; HEIGHT: 37px"></TD></TR></TBODY></TABLE>
</ContentTemplate>
                                             </asp:UpdatePanel>
                                         </td>
                                         <td style="width: 100px">
                                         </td>
                                     </tr>
                                     <tr>
                                         <td align="left" colspan="3">
                                             <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                                                 <ContentTemplate>
<asp:GridView id="GrdMainType" runat="server" Width="100%" ForeColor="SteelBlue" __designer:wfdid="w130" CssClass="gridRow2" OnRowDeleting="GrdMainType_RowDeleting" BorderColor="White" HorizontalAlign="Center" BackColor="White" AutoGenerateColumns="False" OnRowEditing="GrdMainType_RowEditing">
                                                         <PagerSettings FirstPageText="" LastPageText="" Mode="NextPrevious" NextPageText="Next"
                                                             PreviousPageText="Previous" />
                                                         <Columns>
                                                             <asp:BoundField DataField="ACCOUNT_HEAD_ID" HeaderText="ACCOUNT_HEAD_ID">
                                                                 <HeaderStyle CssClass="HidePanel" />
                                                                 <ItemStyle CssClass="HidePanel" />
                                                             </asp:BoundField>
                                                             <asp:BoundField DataField="Account_Code" HeaderText="Account Code">
                                                                 <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                                                 <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                                             </asp:BoundField>
                                                             <asp:BoundField DataField="Account_Name" HeaderText="Account Name">
                                                                 <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                                             </asp:BoundField>
                                                             <asp:BoundField DataField="ACCOUNT_CATEGORY" HeaderText="ACCOUNT_CATEGORY">
                                                                 <FooterStyle CssClass="HidePanel" />
                                                                 <HeaderStyle CssClass="HidePanel" />
                                                                 <ItemStyle CssClass="HidePanel" />
                                                             </asp:BoundField>
                                                             <asp:CommandField ShowEditButton="True" HeaderText="Edit">
                                                                 <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                                             </asp:CommandField>
                                                             <asp:TemplateField HeaderText="Delete">
                                                                 <ItemTemplate>
                                                                     <asp:LinkButton ID="btnDelete" runat="server" CommandName="Delete" OnClientClick="javascript:return confirm('Are you sure you want to Delete?');return false;"
                                                                         Text="Delete"></asp:LinkButton>
                                                                 </ItemTemplate>
                                                                 <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                                             </asp:TemplateField>
                                                         </Columns>
                                                         <HeaderStyle CssClass="tblhead"/>
                                                     </asp:GridView> 
</ContentTemplate>
                                             </asp:UpdatePanel>
                                         </td>
                                     </tr>
                                 </table>
                             </ContentTemplate>
                         </cc1:TabPanel>
                         <cc1:TabPanel ID="TabPanel2" runat="server">
                             <HeaderTemplate>
                                 Sub Type
                             </HeaderTemplate>
                             <ContentTemplate>
                                 <table width="100%">
                                     <tr>
                                         <td style="width: 100px">
                                         </td>
                                         <td align="left" style="width: 100px">
                                             &nbsp; &nbsp;
                                         </td>
                                         <td style="width: 100px">
                                         </td>
                                     </tr>
                                     <tr>
                                         <td style="width: 100px">
                                         </td>
                                         <td align="left" style="width: 100px">
                                             <asp:UpdatePanel ID="UpdatePanel4" runat="server">
                                                 <ContentTemplate>
<TABLE width="100%"><TBODY><TR><TD style="WIDTH: 100px" align=left>
<strong><asp:Label id="Label8" runat="server" Width="123px" Text="Main Account Type" CssClass="lblbox" __designer:wfdid="w105"></asp:Label></strong></TD><TD colSpan=2><asp:DropDownList id="ddAccountType1" runat="server" Width="268px" CssClass="DropList" __designer:wfdid="w106" OnSelectedIndexChanged="ddAccountType1_SelectedIndexChanged" AutoPostBack="True">
                                                                     </asp:DropDownList></TD><TD style="WIDTH: 100px"></TD></TR><TR><TD style="WIDTH: 100px; HEIGHT: 28px" align=left>
                                                                     <strong><asp:Label id="Label2" runat="server" Width="124px" Text="Sub Account Type" CssClass="lblbox" __designer:wfdid="w107"></asp:Label></strong></TD><TD style="WIDTH: 49px; HEIGHT: 28px"><asp:TextBox id="txtASubTypeCode" runat="server" Width="81px" CssClass="txtBox " __designer:wfdid="w108" ReadOnly="True" MaxLength="2"></asp:TextBox></TD><TD style="WIDTH: 100px; HEIGHT: 28px"><asp:TextBox id="txtSubTypeName" runat="server" Width="170px" CssClass="txtBox " __designer:wfdid="w109"></asp:TextBox></TD><TD style="WIDTH: 100px; HEIGHT: 28px"></TD></TR><TR><TD style="WIDTH: 100px; HEIGHT: 29px"></TD><TD style="HEIGHT: 29px" align=left colSpan=2>
                                                                     <asp:Button id="btnAccountSubType" onclick="btnAccountSubType_Click" runat="server" Width="125px" Font-Size="8pt" Text="New Sub Type" __designer:wfdid="w110" CssClass="Button" /> </TD><TD style="WIDTH: 100px; HEIGHT: 29px"></TD></TR></TBODY></TABLE>
</ContentTemplate>
                                             </asp:UpdatePanel>
                                         </td>
                                         <td style="width: 100px">
                                         </td>
                                     </tr>
                                     <tr>
                                         <td style="width: 100px">
                                         </td>
                                         <td align="left" style="width: 100px">
                                             <asp:UpdatePanel ID="UpdatePanel5" runat="server">
                                                 <ContentTemplate>
<asp:GridView id="GrdSubType" runat="server" Width="100%" ForeColor="SteelBlue" CssClass="gridRow2" __designer:wfdid="w112" OnRowEditing="GrdSubType_RowEditing" AutoGenerateColumns="False" BackColor="White" HorizontalAlign="Center" BorderColor="White" OnRowDeleting="GrdSubType_RowDeleting">
                                                         <PagerSettings FirstPageText="" LastPageText="" Mode="NextPrevious" NextPageText="Next"
                                                             PreviousPageText="Previous" />
                                                         <Columns>
                                                             <asp:BoundField DataField="ACCOUNT_HEAD_ID" HeaderText="ACCOUNT_HEAD_ID">
                                                                 <HeaderStyle CssClass="HidePanel" />
                                                                 <ItemStyle CssClass="HidePanel" />
                                                             </asp:BoundField>
                                                             <asp:BoundField DataField="Account_Code" HeaderText="Account Code">
                                                                 <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                                                 <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                                             </asp:BoundField>
                                                             <asp:BoundField DataField="Account_Name" HeaderText="Account Name">
                                                                 <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                                             </asp:BoundField>
                                                             <asp:BoundField DataField="ACCOUNT_CATEGORY" HeaderText="ACCOUNT_CATEGORY">
                                                                 <FooterStyle CssClass="HidePanel" />
                                                                 <HeaderStyle CssClass="HidePanel" />
                                                                 <ItemStyle CssClass="HidePanel" />
                                                             </asp:BoundField>
                                                             <asp:CommandField ShowEditButton="True" HeaderText="Edit">
                                                                 <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                                             </asp:CommandField>
                                                             <asp:TemplateField HeaderText="Delete">
                                                                 <ItemTemplate>
                                                                     <asp:LinkButton ID="btnDelete" runat="server" CommandName="Delete" OnClientClick="javascript:return confirm('Are you sure you want to Delete?');return false;"
                                                                         Text="Delete"></asp:LinkButton>
                                                                 </ItemTemplate>
                                                                 <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                                             </asp:TemplateField>
                                                         </Columns>
                                                         <HeaderStyle CssClass="tblhead" />
                                                     </asp:GridView> 
</ContentTemplate>
                                             </asp:UpdatePanel>
                                         </td>
                                         <td style="width: 100px">
                                         </td>
                                     </tr>
                                     <tr>
                                         <td align="left" colspan="3">
                                             &nbsp;</td>
                                     </tr>
                                 </table>
                                 <br />
                                 &nbsp;
                             </ContentTemplate>
                         </cc1:TabPanel>
                         <cc1:TabPanel ID="TabPanel3" runat="server" HeaderText="TabPanel3">
                             <HeaderTemplate>
                                 Detail Type
                             </HeaderTemplate>
                             <ContentTemplate>
                                 <table width="100%">
                                     <tr>
                                         <td style="width: 100px">
                                         </td>
                                         <td align="center" style="width: 100px">
                                             &nbsp;</td>
                                         <td style="width: 100px">
                                         </td>
                                     </tr>
                                     <tr>
                                         <td style="width: 100px">
                                         </td>
                                         <td align="center" style="width: 100px">
                                             <asp:UpdatePanel ID="UpdatePanel6" runat="server">
                                                 <ContentTemplate>
<TABLE width="100%"><TBODY><TR><TD style="WIDTH: 100px; HEIGHT: 16px" align=left>
<strong><asp:Label id="Label81" runat="server" Width="123px" Text="Main Account Type" CssClass="lblbox" __designer:wfdid="w84"></asp:Label></strong></TD><TD style="HEIGHT: 28px" align=left colSpan=2><asp:DropDownList id="ddAccountType2" runat="server" Width="250px" CssClass="DropList" __designer:wfdid="w85" OnSelectedIndexChanged="ddAccountType2_SelectedIndexChanged" AutoPostBack="True">
                                                                     </asp:DropDownList></TD><TD style="WIDTH: 100px; HEIGHT: 16px"></TD></TR><TR><TD style="WIDTH: 100px; HEIGHT: 8px" align=left>
                                                                     <strong><asp:Label id="Label4" runat="server" Width="123px" Text="Sub Account Type" CssClass="lblbox" __designer:wfdid="w86"></asp:Label></strong></TD><TD style="HEIGHT: 28px" align=left colSpan=2><asp:DropDownList id="ddAccountSubType1" runat="server" Width="250px" CssClass="DropList" __designer:wfdid="w87" OnSelectedIndexChanged="ddAccountSubType1_SelectedIndexChanged" AutoPostBack="True">
                                                                     </asp:DropDownList></TD><TD style="WIDTH: 100px; HEIGHT: 8px"></TD></TR><TR><TD style="WIDTH: 100px; HEIGHT: 8px" align=left>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                                                     <strong><asp:Label id="Label5" runat="server" Width="116px" Text="Detail Account Type" CssClass="lblbox" __designer:wfdid="w88"></asp:Label></strong> &nbsp; &nbsp; </TD><TD style="WIDTH: 49px; HEIGHT: 28px" align=left><asp:TextBox id="txtADetailTypeCode" runat="server" Width="62px" CssClass="txtBox " __designer:wfdid="w89" ReadOnly="True" MaxLength="2"></asp:TextBox></TD><TD align=left><asp:TextBox id="txtDetailTypeName" runat="server" Width="170px" CssClass="txtBox " __designer:wfdid="w90"></asp:TextBox></TD><TD style="WIDTH: 100px; HEIGHT: 8px"></TD></TR><TR><TD style="WIDTH: 100px; HEIGHT: 37px"></TD><TD align=left colSpan=2>
                                                                     <asp:Button id="btnAccountDetailType" onclick="btnAccountDetailType_Click" runat="server" Width="125px" Font-Size="8pt" Text="New Detail Type" __designer:wfdid="w91" CssClass="Button" /> </TD><TD style="WIDTH: 100px; HEIGHT: 37px"></TD></TR></TBODY></TABLE>
</ContentTemplate>
                                             </asp:UpdatePanel>
                                         </td>
                                         <td style="width: 100px">
                                         </td>
                                     </tr>
                                     <tr>
                                         <td colspan="3">
                                                     <asp:Panel ID="Panel4" runat="server" Height="150px" ScrollBars="Vertical" Width="100%">
                                             <asp:UpdatePanel ID="UpdatePanel7" runat="server">
                                                 <ContentTemplate>
<asp:GridView id="GrdDetailType" runat="server" Width="100%" ForeColor="SteelBlue" CssClass="gridRow2" __designer:wfdid="w94" OnRowEditing="GrdDetailType_RowEditing" AutoGenerateColumns="False" BackColor="White" HorizontalAlign="Center" BorderColor="White" OnRowDeleting="GrdDetailType_RowDeleting">
                                                             <PagerSettings FirstPageText="" LastPageText="" Mode="NextPrevious" NextPageText="Next"
                                                             PreviousPageText="Previous" />
                                                             <Columns>
                                                                 <asp:BoundField DataField="ACCOUNT_HEAD_ID" HeaderText="ACCOUNT_HEAD_ID">
                                                                     <HeaderStyle CssClass="HidePanel" />
                                                                     <ItemStyle CssClass="HidePanel" />
                                                                 </asp:BoundField>
                                                                 <asp:BoundField DataField="Account_Code" HeaderText="Account Code">
                                                                     <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                                                     <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                                                 </asp:BoundField>
                                                                 <asp:BoundField DataField="Account_Name" HeaderText="Account Name">
                                                                     <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                                                 </asp:BoundField>
                                                                 <asp:BoundField DataField="ACCOUNT_CATEGORY" HeaderText="ACCOUNT_CATEGORY">
                                                                     <FooterStyle CssClass="HidePanel" />
                                                                     <HeaderStyle CssClass="HidePanel" />
                                                                     <ItemStyle CssClass="HidePanel" />
                                                                 </asp:BoundField>
                                                                 <asp:CommandField ShowEditButton="True" HeaderText="Edit">
                                                                     <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                                                 </asp:CommandField>
                                                                 <asp:TemplateField HeaderText="Delete">
                                                                     <ItemTemplate>
                                                                         <asp:LinkButton ID="btnDelete" runat="server" CommandName="Delete" OnClientClick="javascript:return confirm('Are you sure you want to Delete?');return false;"
                                                                             Text="Delete"></asp:LinkButton>
                                                                     </ItemTemplate>
                                                                     <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                                                 </asp:TemplateField>
                                                             </Columns>
                                                             <HeaderStyle CssClass="tblhead" />
                                                         </asp:GridView> 
</ContentTemplate>
                                             </asp:UpdatePanel>
                                                     </asp:Panel>
                                             &nbsp;
                                         </td>
                                     </tr>
                                     <tr>
                                         <td align="left" colspan="3">
                                             &nbsp;</td>
                                     </tr>
                                 </table>
                             </ContentTemplate>
                         </cc1:TabPanel>
                         <cc1:TabPanel ID="TabPanel4" runat="server" HeaderText="TabPanel4">
                             <HeaderTemplate>
                                 Account Head&nbsp;
                             </HeaderTemplate>
                             <ContentTemplate>
                                 <table width="100%">
                                     <tr>
                                         <td style="width: 100px">
                                         </td>
                                         <td align="center" style="width: 100px">
                                             &nbsp;</td>
                                         <td style="width: 100px">
                                         </td>
                                     </tr>
                                     <tr>
                                         <td style="width: 100px">
                                         </td>
                                         <td align="center" style="width: 100px">
                                             <asp:UpdatePanel ID="UpdatePanel8" runat="server">
                                                 <ContentTemplate>
<TABLE width="100%"><TBODY><TR><TD style="WIDTH: 100px; HEIGHT: 16px" align=left>
<strong><asp:Label id="Label34" runat="server" Width="119px" Text="Main Account Type" CssClass="lblbox" __designer:wfdid="w58"></asp:Label></strong></TD><TD style="HEIGHT: 28px" align=left colSpan=2><asp:DropDownList id="ddAccountType3" runat="server" Width="280px" CssClass="DropList" __designer:wfdid="w59" OnSelectedIndexChanged="ddAccountType3_SelectedIndexChanged" AutoPostBack="True">
                                                                     </asp:DropDownList></TD><TD style="WIDTH: 100px; HEIGHT: 16px"></TD></TR><TR><TD style="WIDTH: 100px; HEIGHT: 16px" align=left>
                                                                     <strong><asp:Label id="Label62" runat="server" Width="120px" Text="Sub Account Type" CssClass="lblbox" __designer:wfdid="w60"></asp:Label></strong></TD><TD style="HEIGHT: 28px" align=left colSpan=2><asp:DropDownList id="ddAccountSubType2" runat="server" Width="280px" CssClass="DropList" __designer:wfdid="w61" OnSelectedIndexChanged="ddAccountSubType2_SelectedIndexChanged" AutoPostBack="True">
                                                                     </asp:DropDownList></TD><TD style="WIDTH: 100px; HEIGHT: 16px"></TD></TR><TR><TD style="WIDTH: 100px; HEIGHT: 16px" align=left>
                                                                     <strong><asp:Label id="Label71" runat="server" Width="120px" Text="Detail Account Type" CssClass="lblbox" __designer:wfdid="w62"></asp:Label></strong></TD><TD style="HEIGHT: 28px" align=left colSpan=2><asp:DropDownList id="drpAccountTypeDetail" runat="server" Width="280px" CssClass="DropList" __designer:wfdid="w63" OnSelectedIndexChanged="drpAccountTypeDetail_SelectedIndexChanged" AutoPostBack="True"></asp:DropDownList></TD><TD style="WIDTH: 100px; HEIGHT: 16px"></TD></TR><TR><TD style="WIDTH: 100px; HEIGHT: 8px" align=left>
                                                                     <strong><asp:Label id="Label6" runat="server" Width="120px" Text="Account Head" CssClass="lblbox" __designer:wfdid="w64"></asp:Label></strong></TD><TD style="WIDTH: 49px; HEIGHT: 28px" align=left><asp:TextBox id="txtAccountCode" runat="server" Width="90px" CssClass="txtBox " __designer:wfdid="w65" ReadOnly="True" MaxLength="4"></asp:TextBox></TD><TD align=left><asp:TextBox id="txtAccountHead" runat="server" Width="175px" CssClass="txtBox " __designer:wfdid="w66"></asp:TextBox></TD><TD style="WIDTH: 100px; HEIGHT: 8px"></TD></TR><TR><TD style="WIDTH: 100px; HEIGHT: 37px"></TD><TD align=right>
                                                                     <asp:Button id="btnSave" onclick="btnSave_Click" runat="server" Width="94px" Font-Size="8pt" Text="New" __designer:wfdid="w67" CssClass="Button" /> </TD><TD align=left></TD><TD style="WIDTH: 100px; HEIGHT: 37px"></TD></TR></TBODY></TABLE>
</ContentTemplate>
                                             </asp:UpdatePanel>
                                         </td>
                                         <td style="width: 100px">
                                         </td>
                                     </tr>
                                     <tr>
                                         <td align="left" colspan="3">
                                             <asp:Panel ID="Panel12" runat="server" Height="150px" ScrollBars="Vertical" Width="100%">
                                                 <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                         <ContentTemplate>
<asp:GridView id="GridAccountHead" runat="server" Width="100%" ForeColor="SteelBlue" CssClass="gridRow2" __designer:wfdid="w70" OnRowEditing="GridAccountHead_RowEditing" AutoGenerateColumns="False" BackColor="White" HorizontalAlign="Center" BorderColor="White" OnRowDeleting="GridAccountHead_RowDeleting">
<PagerSettings FirstPageText="" LastPageText="" Mode="NextPrevious" NextPageText="Next" PreviousPageText="Previous"></PagerSettings>

<Columns>
<asp:BoundField DataField="ACCOUNT_HEAD_ID" HeaderText="ACCOUNT_HEAD_ID">
<HeaderStyle CssClass="HidePanel"></HeaderStyle>

<ItemStyle CssClass="HidePanel"></ItemStyle>
</asp:BoundField>
<asp:BoundField DataField="Account_Code" HeaderText="Account Code">
<HeaderStyle BorderColor="Silver" BorderWidth="1px" BorderStyle="Solid"></HeaderStyle>

<ItemStyle BorderColor="Silver" BorderWidth="1px" BorderStyle="Solid"></ItemStyle>
</asp:BoundField>
<asp:BoundField DataField="Account_Name" HeaderText="Account Name">
<ItemStyle BorderColor="Silver" BorderWidth="1px" BorderStyle="Solid"></ItemStyle>
</asp:BoundField>
<asp:CommandField ShowEditButton="True" HeaderText="Edit">
<ItemStyle BorderColor="Silver" BorderWidth="1px" BorderStyle="Solid"></ItemStyle>
</asp:CommandField>
    <asp:TemplateField HeaderText="Delete">
        <ItemTemplate>
            <asp:LinkButton ID="btnDelete" runat="server" CommandName="Delete" OnClientClick="javascript:return confirm('Are you sure you want to Delete?');return false;"
                Text="Delete"></asp:LinkButton>
        </ItemTemplate>
        <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
    </asp:TemplateField>
</Columns>
<HeaderStyle CssClass="tblhead"></HeaderStyle>
</asp:GridView> 
</ContentTemplate>
                     </asp:UpdatePanel>
                                             </asp:Panel>
                                         </td>
                                     </tr>
                                 </table>
                             </ContentTemplate>
                         </cc1:TabPanel>
                     </cc1:TabContainer></td>
             </tr>
         </table>
     </div>
</asp:Content>
