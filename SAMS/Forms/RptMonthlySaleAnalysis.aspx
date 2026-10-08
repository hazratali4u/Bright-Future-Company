<%@ Page Language="C#" MasterPageFile="~/Forms/PageMaster.master" AutoEventWireup="true"
    CodeFile="RptMonthlySaleAnalysis.aspx.cs" Inherits="Forms_RptMonthlySaleAnalysis"
    Title="SAMS :: Monthly Sale Report" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" runat="server" ContentPlaceHolderID="cphPage">
    <script language="javascript" type="text/javascript">
        function onCalendarShown() {
            var cal = $find("calendar1");
            cal._switchMode("years", true);
            if (cal._yearsBody) {
                for (var i = 0; i < cal._yearsBody.rows.length; i++) {
                    var row = cal._yearsBody.rows[i];
                    for (var j = 0; j < row.cells.length; j++) {
                        Sys.UI.DomEvent.addHandler(row.cells[j].firstChild, "click", call);
                    }
                }
            }
        }

        function onCalendarHidden() {
            var cal = $find("calendar1");
            if (cal._yearsBody) {
                for (var i = 0; i < cal._yearsBody.rows.length; i++) {
                    var row = cal._yearsBody.rows[i];
                    for (var j = 0; j < row.cells.length; j++) {
                        Sys.UI.DomEvent.removeHandler(row.cells[j].firstChild, "click", call);
                    }
                }
            }
        }

        function call(eventElement) {
            var target = eventElement.target;
            switch (target.mode) {
                case "year":
                    var cal = $find("calendar1");
                    cal.set_selectedDate(target.date);
                    cal._blur.post(true);
                    cal.raiseDateSelectionChanged(); break;
            }
        }


        function onCalendarShown2() {
            var cal = $find("calendar2");
            cal._switchMode("years", true);
            if (cal._yearsBody) {
                for (var i = 0; i < cal._yearsBody.rows.length; i++) {
                    var row = cal._yearsBody.rows[i];
                    for (var j = 0; j < row.cells.length; j++) {
                        Sys.UI.DomEvent.addHandler(row.cells[j].firstChild, "click", call2);
                    }
                }
            }
        }

        function onCalendarHidden2() {
            var cal = $find("calendar2");
            if (cal._yearsBody) {
                for (var i = 0; i < cal._yearsBody.rows.length; i++) {
                    var row = cal._yearsBody.rows[i];
                    for (var j = 0; j < row.cells.length; j++) {
                        Sys.UI.DomEvent.removeHandler(row.cells[j].firstChild, "click", call2);
                    }
                }
            }
        }

        function call2(eventElement) {
            var target = eventElement.target;
            switch (target.mode) {
                case "year":
                    var cal = $find("calendar2");
                    cal.set_selectedDate(target.date);
                    cal._blur.post(true);
                    cal.raiseDateSelectionChanged(); break;
            }
        }


        function onCalendarShown3() {
            var cal = $find("calendar3");
            cal._switchMode("months", true);
            if (cal._monthsBody) {
                for (var i = 0; i < cal._monthsBody.rows.length; i++) {
                    var row = cal._monthsBody.rows[i];
                    for (var j = 0; j < row.cells.length; j++) {
                        Sys.UI.DomEvent.addHandler(row.cells[j].firstChild, "click", call3);
                    }
                }
            }
        }

        function onCalendarHidden3() {
            var cal = $find("calendar3");

            if (cal._monthsBody) {
                for (var i = 0; i < cal._monthsBody.rows.length; i++) {
                    var row = cal._monthsBody.rows[i];
                    for (var j = 0; j < row.cells.length; j++) {
                        Sys.UI.DomEvent.removeHandler(row.cells[j].firstChild, "click", call3);
                    }
                }
            }
        }

        function call3(eventElement) {
            var target = eventElement.target;
            switch (target.mode) {
                case "month":
                    var cal = $find("calendar3");
                    cal._visibleDate = target.date;
                    cal.set_selectedDate(target.date);
                    cal._switchMonth(target.date);
                    cal._blur.post(true);
                    cal.raiseDateSelectionChanged();
                    break;
            }
        }


        function onCalendarShown4() {
            var cal = $find("calendar4");
            cal._switchMode("months", true);
            if (cal._monthsBody) {
                for (var i = 0; i < cal._monthsBody.rows.length; i++) {
                    var row = cal._monthsBody.rows[i];
                    for (var j = 0; j < row.cells.length; j++) {
                        Sys.UI.DomEvent.addHandler(row.cells[j].firstChild, "click", call4);
                    }
                }
            }
        }

        function onCalendarHidden4() {
            var cal = $find("calendar4");

            if (cal._monthsBody) {
                for (var i = 0; i < cal._monthsBody.rows.length; i++) {
                    var row = cal._monthsBody.rows[i];
                    for (var j = 0; j < row.cells.length; j++) {
                        Sys.UI.DomEvent.removeHandler(row.cells[j].firstChild, "click", call4);
                    }
                }
            }
        }

        function call4(eventElement) {
            var target = eventElement.target;
            switch (target.mode) {
                case "month":
                    var cal = $find("calendar4");
                    cal._visibleDate = target.date;
                    cal.set_selectedDate(target.date);
                    cal._switchMonth(target.date);
                    cal._blur.post(true);
                    cal.raiseDateSelectionChanged();
                    break;
            }
        }

    </script>
    <script language="JavaScript" type="text/javascript">
        function ValidateForm() {
            return true;
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
                                        <td style="height: 12px" align="left" colspan="4">
                                            <asp:Label ID="lblErrorMsg" runat="server" ForeColor="Red" Font-Bold="True"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="left">
                                        </td>
                                        <td valign="top" align="left">
                                            <strong>
                                                <asp:Label ID="Label7" runat="server" Width="118px" Text="Rate Impelement" CssClass="lblbox"></asp:Label></strong>
                                        </td>
                                        <td style="width: 1px" align="left">
                                        </td>
                                        <td style="width: 201px; height: 25px" align="left">
                                            <asp:RadioButtonList ID="RadioButtonList1" runat="server" Width="210px" RepeatDirection="Horizontal">
                                                <asp:ListItem Selected="True">Trade Price</asp:ListItem>
                                                <asp:ListItem>Purchase Price</asp:ListItem>
                                            </asp:RadioButtonList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="left">
                                        </td>
                                        <td align="left">
                                            <strong>
                                                <asp:Label ID="Label1" runat="server" Width="78px" Text="Report Type" CssClass="lblbox"></asp:Label></strong>
                                        </td>
                                        <td style="width: 1px" align="left">
                                        </td>
                                        <td style="width: 201px; height: 25px" align="left">
                                            <asp:DropDownList ID="DrpReportType" runat="server" Width="200px" CssClass="DropList">
                                                <asp:ListItem Value="0" Text="Gross Sale"></asp:ListItem>
                                                <asp:ListItem Value="1" Text="Sales Return"></asp:ListItem>
                                                <asp:ListItem Value="2" Text="Purchase"></asp:ListItem>
                                                <asp:ListItem Value="3" Text="Closing Credit"></asp:ListItem>
                                                <asp:ListItem Value="4" Text="Credit Sale"></asp:ListItem>
                                                <asp:ListItem Value="5" Text="Net Sale"></asp:ListItem>
                                                <asp:ListItem Value="6" Text="Transfer In"></asp:ListItem>
                                                <asp:ListItem Value="7" Text="Transfer Out"></asp:ListItem>
                                                <asp:ListItem Value="8" Text="Closing Stock"></asp:ListItem>
                                                <%--<asp:ListItem Value="9" Text="Opening Stock"></asp:ListItem>--%>
                                                <asp:ListItem Value="10" Text="Extra Discount"></asp:ListItem>
                                                <asp:ListItem Value="11" Text="Standard Discount"></asp:ListItem>
                                                <asp:ListItem Value="12" Text="Purchase Return"></asp:ListItem>
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="left">
                                        </td>
                                        <td align="left">
                                            <strong>
                                                <asp:Label ID="Label5" runat="server" Width="78px" Text="Value Type" CssClass="lblbox"></asp:Label></strong>
                                        </td>
                                        <td style="width: 1px" align="left">
                                        </td>
                                        <td style="width: 201px; height: 25px" align="left">
                                            <asp:DropDownList ID="DrpUnitType" runat="server" Width="200px" CssClass="DropList"
                                                AutoPostBack="True" OnSelectedIndexChanged="DrpUnitType_SelectedIndexChanged">
                                                <asp:ListItem Value="0">Year Wise</asp:ListItem>
                                                <asp:ListItem Value="1">Month Wise</asp:ListItem>
                                                <asp:ListItem Value="2">Date Wise</asp:ListItem>
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="left">
                                        </td>
                                        <td align="left">
                                            <strong>
                                                <asp:Label ID="Label2" runat="server" Width="78px" Text="Location Type" CssClass="lblbox"></asp:Label></strong>
                                        </td>
                                        <td style="width: 1px" align="left">
                                        </td>
                                        <td style="width: 201px; height: 25px" align="left">
                                            <asp:DropDownList ID="ddDistributorType" runat="server" Width="200px" CssClass="DropList"
                                                AutoPostBack="True" OnSelectedIndexChanged="ddDistributorType_SelectedIndexChanged">
                                            </asp:DropDownList>
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
                                            <asp:DropDownList ID="drpDistributor" runat="server" Width="200px" CssClass="DropList">
                                            </asp:DropDownList>
                                        </td>
                                    </tr>                                    
                                    <tr>
                                        <td style="height: 68px" align="left" colspan="4">
                                            <div id="divYear" class="divYear" runat="server">
                                                <table width="100%">
                                                    <tbody>
                                                        <tr>
                                                            <td style="padding-left: 5px; width: 8px; height: 25px">
                                                                <strong>
                                                                    <asp:Label ID="Label3" runat="server" Width="70px" Text="From Year" __designer:wfdid="w70"></asp:Label></strong>
                                                            </td>
                                                            <td style="width: 20px">
                                                            </td>
                                                            <td style="padding-left: 7px; width: 204px; height: 25px" align="left">
                                                                &nbsp;
                                                                <asp:TextBox ID="txtStartYear" onkeyup="BlockStartDateKeyPress()" runat="server"
                                                                    Width="50px" CssClass="txtBox" __designer:wfdid="w65" MaxLength="10"></asp:TextBox>
                                                                <asp:ImageButton ID="ibtnStartYear" runat="server" Width="16px" __designer:wfdid="w66"
                                                                    ImageUrl="~/App_Themes/Granite/Images/date.gif"></asp:ImageButton>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="padding-left: 5px; width: 8px">
                                                                <strong>
                                                                    <asp:Label ID="Label4" runat="server" Width="80px" Text="To Year" __designer:wfdid="w71"></asp:Label></strong>
                                                            </td>
                                                            <td style="width: 10px">
                                                            </td>
                                                            <td style="padding-left: 7px; width: 204px; height: 25px">
                                                                &nbsp;
                                                                <asp:TextBox ID="txtEndYear" onkeyup="BlockEndDateKeyPress()" runat="server" Width="50px"
                                                                    CssClass="txtBox " __designer:wfdid="w68" MaxLength="10"></asp:TextBox>
                                                                <asp:ImageButton ID="ibtnEndYear" runat="server" Width="16px" __designer:wfdid="w69"
                                                                    ImageUrl="~/App_Themes/Granite/Images/date.gif"></asp:ImageButton>
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </div>
                                            <div id="divDate" class="divDate" runat="server">
                                                <table width="100%">
                                                    <tbody>
                                                        <tr>
                                                            <td style="padding-left: 5px; width: 8px; height: 25px">
                                                                <strong>
                                                                    <asp:Label ID="lblFromDate" runat="server" Width="78px" Text="From Date"></asp:Label></strong>
                                                            </td>
                                                            <td style="width: 20px">
                                                            </td>
                                                            <td style="padding-left: 7px; width: 204px; height: 25px" align="left">
                                                                &nbsp;
                                                                <asp:TextBox ID="txtStartDate" onkeyup="BlockStartDateKeyPress()" runat="server"
                                                                    Width="100px" CssClass="txtBox" MaxLength="10"></asp:TextBox>
                                                                <asp:ImageButton ID="ibtnStartDate" runat="server" Width="16px" ImageUrl="~/App_Themes/Granite/Images/date.gif">
                                                                </asp:ImageButton>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="padding-left: 5px; width: 8px; height: 25px">
                                                                <strong>
                                                                    <asp:Label ID="lblToDate" runat="server" Width="78px" Text="To Date" CssClass="lblbox"></asp:Label></strong>
                                                            </td>
                                                            <td style="width: 1px">
                                                            </td>
                                                            <td style="padding-left: 7px; width: 204px; height: 25px">
                                                                &nbsp;
                                                                <asp:TextBox ID="txtEndDate" onkeyup="BlockStartDateKeyPress()" runat="server" Width="100px"
                                                                    CssClass="txtBox" MaxLength="10"></asp:TextBox>
                                                                <asp:ImageButton ID="ibtnEndDate" runat="server" Width="16px" ImageUrl="~/App_Themes/Granite/Images/date.gif">
                                                                </asp:ImageButton>
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </div>
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
                                                                    Width="70px" CssClass="txtBox" MaxLength="10"></asp:TextBox>
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
                                                                    Width="70px" CssClass="txtBox" MaxLength="10"></asp:TextBox>
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
                                            <cc1:CalendarExtender ID="CEStartYear" runat="server" BehaviorID="calendar1" OnClientShown="onCalendarShown"
                                                OnClientHidden="onCalendarHidden" Format="yyyy" PopupButtonID="ibtnStartYear"
                                                TargetControlID="txtStartYear">
                                            </cc1:CalendarExtender>
                                            <cc1:CalendarExtender ID="CEEndYear" runat="server" BehaviorID="calendar2" OnClientShown="onCalendarShown2"
                                                OnClientHidden="onCalendarHidden2" Format="yyyy" PopupButtonID="ibtnEndYear"
                                                TargetControlID="txtEndYear">
                                            </cc1:CalendarExtender>
                                            <cc1:CalendarExtender ID="CEStartMonth" runat="server" __designer:wfdid="w62" BehaviorID="calendar3"
                                                OnClientShown="onCalendarShown3" OnClientHidden="onCalendarHidden3" Format="MMM-yyyy"
                                                PopupButtonID="ibtnStartMonth" TargetControlID="txtFromMonth">
                                            </cc1:CalendarExtender>
                                            <cc1:CalendarExtender ID="CESEndMonth" runat="server" __designer:wfdid="w63" BehaviorID="calendar4"
                                                OnClientShown="onCalendarShown4" OnClientHidden="onCalendarHidden4" Format="MMM-yyyy"
                                                PopupButtonID="ibtnEndMonth" TargetControlID="txtToMonth">
                                            </cc1:CalendarExtender>
                                            <cc1:CalendarExtender ID="CEStartDate" runat="server" __designer:wfdid="w78" Format="dd-MMM-yyyy"
                                                PopupButtonID="ibtnStartDate" TargetControlID="txtStartDate">
                                            </cc1:CalendarExtender>
                                            <cc1:CalendarExtender ID="CEEndDate" runat="server" __designer:wfdid="w79" Format="dd-MMM-yyyy"
                                                PopupButtonID="ibtnEndDate" TargetControlID="txtEndDate">
                                            </cc1:CalendarExtender>
                                            &nbsp;&nbsp;&nbsp;
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
