<%@ Page Language="C#" AutoEventWireup="true" CodeFile="frmHHPosting.aspx.cs" Inherits="Forms_frmHHPosting"  MasterPageFile="~/Forms/PageMaster.master" Title="SAMS :: HHT Order Posting"%>

<asp:Content ID="Content1" ContentPlaceHolderID="cphPage" Runat="Server">
<div id="right_data">
 <asp:UpdatePanel id="UpdatePanel3" runat="server">
                        <contenttemplate>
<DIV class="container"><H2>&nbsp;HHT Order Posting&nbsp; </H2><DIV class="container"><TABLE style="WIDTH: 404px; HEIGHT: 76px"><TBODY><TR><TD style="WIDTH: 32px"></TD><TD style="WIDTH: 327px"></TD><TD style="WIDTH: 327px">
<strong><asp:Label id="Label1" runat="server" Width="262px" ForeColor="Transparent"></asp:Label></strong></TD></TR><TR><TD style="WIDTH: 32px; HEIGHT: 32px">
<strong><asp:Label id="lblSalesForce" runat="server" Width="81px" Height="18px" Text="Sales Force" CssClass="lblbox"></asp:Label></strong></TD><TD style="WIDTH: 327px; HEIGHT: 32px" align=left><asp:DropDownList id="ddSalesForce" runat="server" Width="200px" CssClass="DropList"></asp:DropDownList></TD><TD style="WIDTH: 327px; HEIGHT: 32px" align=left>&nbsp;
<asp:Button id="btnGetOrders" onclick="btnGetOrders_Click1" runat="server" Text="Get Orders" CssClass="Button" /> </TD><TD style="HEIGHT: 32px" align=left></TD></TR></TBODY></TABLE></DIV><DIV id="DivGrid" class="container" runat="server" visible="false"><TABLE><TBODY><TR><TD style="WIDTH: 101px" align=left><asp:CheckBox id="chkSelectAll" runat="server" Visible="False" Width="99px" Text="Select All" AutoPostBack="True" OnCheckedChanged="chkSelectAll_CheckedChanged"></asp:CheckBox></TD></TR><TR><TD align=left></TD></TR></TBODY></TABLE><asp:Panel id="Panel2" runat="server" Width="100%" Height="250px" ScrollBars="Vertical">
        <asp:GridView id="GridSalesOrder" runat="server" Width="735px" Height="1px" ForeColor="SteelBlue" CssClass="gridRow2" BorderStyle="Solid" AutoGenerateColumns="False" BackColor="White" BorderColor="Gray" HorizontalAlign="Center">
<PagerSettings PreviousPageText="Previous" Mode="NextPrevious" LastPageText="" FirstPageText="" NextPageText="Next"></PagerSettings>

<FooterStyle BackColor="White"></FooterStyle>
<Columns>
<asp:TemplateField HeaderText="SaleOrder">
<ItemStyle BorderStyle="Solid" BorderWidth="1px" BorderColor="Silver" HorizontalAlign="Center"></ItemStyle>
<ItemTemplate>
   <asp:CheckBox ID="ChbSelect" runat="server" />                      
</ItemTemplate>
</asp:TemplateField>

<asp:BoundField DataField="DocumentDate" HeaderText="Order Date" HtmlEncode="False"  DataFormatString="{0:dd-MM-yyyy}" >
<ItemStyle BorderStyle="Solid" BorderWidth="1px" BorderColor="Silver"></ItemStyle>
</asp:BoundField>

<asp:BoundField DataField="HHSaleOrderId" HeaderText="Order No">
<ItemStyle BorderStyle="Solid" BorderWidth="1px" BorderColor="Silver"></ItemStyle>
</asp:BoundField>
<asp:BoundField DataField="CustomerId" HeaderText="CustomerId">
<ItemStyle CssClass="HidePanel "></ItemStyle>

<HeaderStyle CssClass="HidePanel"></HeaderStyle>
</asp:BoundField>
<asp:BoundField DataField="DISTRIBUTOR_ID" HeaderText="DISTRIBUTOR_ID">
<ItemStyle CssClass="HidePanel "></ItemStyle>

<HeaderStyle CssClass="HidePanel"></HeaderStyle>
</asp:BoundField>
<asp:BoundField DataField="CUSTOMER_NAME" HeaderText="Customer Name">
<ItemStyle BorderStyle="Solid" BorderWidth="1px" BorderColor="Silver"></ItemStyle>
</asp:BoundField>
<asp:BoundField HtmlEncode="False" DataFormatString="{0:F2}" DataField="TotalAmount" HeaderText="Gross Amount">
<ItemStyle BorderStyle="Solid" BorderWidth="1px" BorderColor="Silver"></ItemStyle>
</asp:BoundField>
<asp:BoundField HtmlEncode="False" DataFormatString="{0:F2}" DataField="SchDiscountAmount" HeaderText="Scheme Amount">
<ItemStyle BorderStyle="Solid" BorderWidth="1px" BorderColor="Silver"></ItemStyle>
</asp:BoundField>
<asp:BoundField HtmlEncode="False" DataFormatString="{0:F2}" DataField="StdDiscountAmount" HeaderText="Discount Amount">
<ItemStyle BorderStyle="Solid" BorderWidth="1px" BorderColor="Silver"></ItemStyle>
</asp:BoundField>
<asp:BoundField HtmlEncode="False" DataFormatString="{0:F2}" DataField="GSTAmount" HeaderText="GST Amount">
<ItemStyle BorderStyle="Solid" BorderWidth="1px" BorderColor="Silver"></ItemStyle>
</asp:BoundField>
<asp:BoundField HtmlEncode="False" DataFormatString="{0:F2}" DataField="TotalNetAmount" HeaderText="Net Amount">
<ItemStyle BorderStyle="Solid" BorderWidth="1px" BorderColor="Silver"></ItemStyle>
</asp:BoundField>
</Columns>
<HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" CssClass="tblhead"></HeaderStyle>
</asp:GridView>
    </asp:Panel> </DIV><DIV class="container"><TABLE style="WIDTH: 404px"><TBODY><TR><TD style="WIDTH: 32px; HEIGHT: 19px">
    <strong><asp:Label id="Label2" runat="server" Width="81px" Height="18px" Text="Order Type" CssClass="lblbox"></asp:Label></strong></TD><TD style="WIDTH: 327px; HEIGHT: 19px"><asp:DropDownList id="DrpOrderType" runat="server" Width="200px" CssClass="DropList"><asp:ListItem Value="214">Cash</asp:ListItem>
<asp:ListItem Value="215">Credit</asp:ListItem>
<asp:ListItem Value="216">Advance</asp:ListItem>
</asp:DropDownList></TD><TD style="WIDTH: 327px; HEIGHT: 19px">
<strong><asp:Label id="Label3" runat="server" Width="262px" ForeColor="Transparent"></asp:Label></strong></TD></TR><TR><TD style="WIDTH: 32px; HEIGHT: 27px">
<strong><asp:Label id="Label4" runat="server" Width="81px" Height="18px" Text="Delivery Man" CssClass="lblbox"></asp:Label></strong></TD><TD style="WIDTH: 327px; HEIGHT: 27px" align=left><asp:DropDownList id="ddDilverMan" runat="server" Width="200px" CssClass="DropList" Enabled="False"></asp:DropDownList></TD><TD style="WIDTH: 327px; HEIGHT: 27px" align=left>&nbsp;
<asp:Button id="btnSave" onclick="btnSave_Click" runat="server" Text="Save" Enabled="False" CssClass="Button" /> </TD><TD style="HEIGHT: 27px" align=left></TD></TR></TBODY></TABLE></DIV></DIV>&nbsp; 
</contenttemplate>
         </asp:UpdatePanel>    
</div>
</asp:Content>