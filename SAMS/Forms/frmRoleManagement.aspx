<%@ Page Language="C#" MasterPageFile="~/Forms/PageMaster.master" AutoEventWireup="true"
    CodeFile="frmRoleManagement.aspx.cs" Inherits="frmRoleManagement" Title="SAMS :: Role Management" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphPage" runat="Server">
    <div id="right_data">
        <table width="100%">
            <tr>
                <td>
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate>
                            <table>
                                <tbody>
                                    <tr>
                                        <td style="width: 82px; height: 17px">
                                            <asp:Label ID="lblmsg" runat="server" Visible="False" Width="114px" ForeColor="Red"></asp:Label>
                                        </td>
                                        <td>
                                            &nbsp;
                                        </td>
                                        <td style="height: 17px">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <strong>
                                                <asp:Label ID="Label1" runat="server" Width="107px" Text="Role Description" CssClass="lblbox"></asp:Label></strong>
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="ddRole" runat="server" Width="200px" CssClass="DropList" OnSelectedIndexChanged="ddRole_SelectedIndexChanged"
                                                AutoPostBack="True">
                                            </asp:DropDownList>
                                            <asp:TextBox ID="TextBox1" runat="server" Visible="False" Width="195px" CssClass="txtBox "
                                                Enabled="False"></asp:TextBox>
                                        </td>
                                        <td style="width: 40px;">
                                        </td>
                                        <td>
                                            <asp:Button ID="btnNew" OnClick="btnNew_Click" runat="server" Width="55px" Font-Size="8pt"
                                                Text="New" CssClass="Button" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <strong>
                                                <asp:Label ID="Label11" runat="server" Width="112px" Text="Module 1st Layer" CssClass="lblbox"></asp:Label></strong>
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="DrpModule1stLayer" runat="server" Width="200px" CssClass="DropList"
                                                OnSelectedIndexChanged="DrpModule1stLayer_SelectedIndexChanged" AutoPostBack="True">
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="height: 24px">
                                            <strong>
                                                <asp:Label ID="Label2" runat="server" Width="112px" Text="Module 2nd Layer" CssClass="lblbox"></asp:Label></strong>
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="DrpModule2ndLayer" runat="server" Width="200px" CssClass="DropList"
                                                OnSelectedIndexChanged="DrpModule2ndLayer_SelectedIndexChanged" AutoPostBack="True">
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="height: 16px">
                                            <strong>
                                                <asp:Label ID="Label3" runat="server" Width="112px" Text="Module 3rd Layer" CssClass="lblbox"></asp:Label></strong>
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="DrpModule3rdLayer" runat="server" Width="200px" CssClass="DropList"
                                                OnSelectedIndexChanged="DrpModule3rdLayer_SelectedIndexChanged" AutoPostBack="True">
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                            <asp:Panel ID="pnl_module" runat="server" Width="390px">
                                <fieldset>
                                    <table>
                                        <tr>
                                            <td align="center" colspan="2">
                                                <strong>
                                                    <asp:Label ID="Label4" runat="server" Width="752px" Text="Module Assignment" CssClass="lblbox"></asp:Label></strong>
                                                &nbsp;
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="height: 181px" colspan="2">
                                                <table>
                                                    <tbody>
                                                        <tr>
                                                            <td style="width: 100px" rowspan="4">
                                                                <asp:ListBox ID="lstUnAssignModule" runat="server" Width="350px" Height="200px" CssClass="DropList">
                                                                </asp:ListBox>
                                                            </td>
                                                            <td>
                                                            </td>
                                                            <td style="width: 102px" rowspan="4">
                                                                <asp:ListBox ID="lstAssignModule" runat="server" Width="350px" Height="200px" CssClass="DropList">
                                                                </asp:ListBox>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="center">
                                                                <asp:Button ID="btnAssign" runat="server" Width="30px" Font-Size="8pt" Text=">>"
                                                                    OnClick="btnAssign_Click" CssClass="Button" />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="center">
                                                                <asp:Button ID="btnUnAssign" runat="server" Width="30px" Font-Size="8pt" Text="<<"
                                                                    OnClick="btnUnAssign_Click" CssClass="Button" />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="width: 75px">
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </td>
                                        </tr>
                                    </table>
                                </fieldset>
                            </asp:Panel>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </td>
            </tr>
            <tr>
                <td align="left" width="10%">
                    <asp:Button ID="btnReport" runat="server" Text="View Report" OnClick="btnReport_Click"
                        Width="120px" CssClass="Button" />
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
