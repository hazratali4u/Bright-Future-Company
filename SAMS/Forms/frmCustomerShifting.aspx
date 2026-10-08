<%@ Page Language="C#" MasterPageFile="~/Forms/PageMaster.master" AutoEventWireup="true"
    CodeFile="frmCustomerShifting.aspx.cs" Inherits="Forms_frmCustomerShifting" Title="SAMS :: Customer Shifting" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphPage" runat="Server">
    <script language="javascript" type="text/javascript">
        function UnCheckRouteAll() {
            var chkBox = document.getElementById('<%= ChbSelectAll.ClientID %>');
            var chkBoxList = document.getElementById('<%= ChbAreaList.ClientID %>');
            var chkBoxCount = chkBoxList.getElementsByTagName("input");
            var count = 0;
            for (var i = 0; i < chkBoxCount.length; i++) {
                if (chkBoxCount[i].checked == false) {
                    count += 1;
                }
            }
            if (count > 0) {
                chkBox.checked = false;
            }
            else {
                chkBox.checked = true;
            }
        }

        function CheckBoxListSelect() {
            var chkBoxList = document.getElementById('<%= ChbAreaList.ClientID %>');
            var chkBox = document.getElementById('<%= ChbSelectAll.ClientID %>');
            if (chkBox.checked == true) {
                var chkBoxCount = chkBoxList.getElementsByTagName("input");

                for (var i = 0; i < chkBoxCount.length; i++) {
                    chkBoxCount[i].checked = true;
                }
            }
            else {
                var chkBoxCount = chkBoxList.getElementsByTagName("input");

                for (var i = 0; i < chkBoxCount.length; i++) {
                    chkBoxCount[i].checked = false;
                }
            }

        }
 
    </script>
    <div id="right_data">
        <table width="100%">
            <tr>
                <td>
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate>
                            <table>
                                <tbody>
                                    <tr>
                                        <td style="height: 25px; width:90px;" align="left">
                                            <strong>
                                                From Locaton</strong>
                                        </td>
                                        <td style="height: 10px">
                                            <asp:DropDownList ID="drpfromDistributor" runat="server" Width="220px" CssClass="DropList"
                                                AutoPostBack="True" OnSelectedIndexChanged="drpfromDistributor_SelectedIndexChanged">
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="height: 25px" align="left">
                                            <strong>
                                                From Area</strong>
                                        </td>
                                        <td style="height: 25px">
                                            <asp:DropDownList ID="DrpfromRoute" runat="server" Width="220px" CssClass="DropList"
                                                AutoPostBack="True" OnSelectedIndexChanged="DrpfromRoute_SelectedIndexChanged">
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="height: 25px" align="left">
                                            <strong>
                                                From Sub Area</strong>
                                        </td>
                                        <td style="height: 25px">
                                            <asp:DropDownList ID="DrpFromMarket" runat="server" Width="220px" 
                                            AutoPostBack="True" OnSelectedIndexChanged="DrpFromMarket_SelectedIndexChanged">
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="height: 25px" align="left">
                                            <strong>
                                                To Location</strong>
                                        </td>
                                        <td style="height: 25px">
                                            <asp:DropDownList ID="DrptoDistributor" runat="server" Width="220px" CssClass="DropList"
                                                AutoPostBack="True" OnSelectedIndexChanged="DrptoDistributor_SelectedIndexChanged">
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="height: 25px" align="left">
                                            <strong>
                                                To Area</strong>
                                        </td>
                                        <td style="height: 25px">
                                            <asp:DropDownList ID="drptoRoute" runat="server" Width="220px" CssClass="DropList"
                                                AutoPostBack="True" OnSelectedIndexChanged="drptoRoute_SelectedIndexChanged">
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="height: 25px" align="left">
                                            <strong>
                                                To Sub Area</strong>
                                        </td>
                                        <td style="height: 25px">
                                            <asp:DropDownList ID="DrpToMarket" runat="server" Width="220px" CssClass="DropList"
                                               >
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                        <ContentTemplate>
                            <table>
                                <tr>
                                    <td align="left" rowspan="1">
                                        &nbsp;<asp:CheckBox ID="ChbSelectAll" runat="server" Text="Select All" onclick="CheckBoxListSelect()" />
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left" rowspan="3">
                                        <asp:Panel ID="Panel1" runat="server" BackColor="White" BorderColor="Silver" BorderStyle="Groove"
                                            BorderWidth="1px" Height="220px" ScrollBars="Vertical" Width="500px">
                                            <asp:CheckBoxList ID="ChbAreaList" onclick="UnCheckRouteAll()" runat="server">
                                            </asp:CheckBoxList>
                                        </asp:Panel>
                                    </td>
                                </tr>
                                <tr>
                                </tr>
                            </table>
                            <asp:Button ID="btnSave" runat="server" Font-Size="8pt" OnClick="btnSave_Click" Text="Shift"
                                ValidationGroup="vg" Width="82px" CssClass="Button" OnClientClick="javascript:return confirm('Are you sure you want to Shift?');return false;"/>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
