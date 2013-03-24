<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="TimeSheetEntry.aspx.cs" Inherits="PMT.TimeSheetEntry" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h2>
        Please input your time sheet information.
    </h2>    
    <table class="data" cellpadding="2">
        <tbody>
        <tr>
            <td class="tdLeft">Employee ID:</td>
            <td class="tdRight"><asp:Label ID="lblEmployeeId" runat="server">000172279</asp:Label></td>
        </tr>
        <tr>
            <td class="tdLeft">Date:</td>
            <td class="tdRight">
                <asp:TextBox runat="server" ID="txtDate" ClientIDMode="Static" Width="120px"></asp:TextBox>&nbsp;
                <a style="display:inline; position:absolute" onclick="showCalendarControl(txtDate)" href="#"><img alt="calendar" src=calendar.gif style="width: 34px; height: 23px" border=0 /></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:RegularExpressionValidator runat="server" ID="revDate" ValidationExpression="(((0[1-9]|[12][0-9]|3[01])([-./])(0[13578]|10|12)([-./])(\d{4}))|(([0][1-9]|[12][0-9]|30)([-./])(0[469]|11)([-./])(\d{4}))|((0[1-9]|1[0-9]|2[0-8])([-./])(02)([-./])(\d{4}))|((29)(\.|-|\/)(02)([-./])([02468][048]00))|((29)([-./])(02)([-./])([13579][26]00))|((29)([-./])(02)([-./])([0-9][0-9][0][48]))|((29)([-./])(02)([-./])([0-9][0-9][2468][048]))|((29)([-./])(02)([-./])([0-9][0-9][13579][26])))" ControlToValidate="txtDate" ErrorMessage="Enter date with valid format (MM-dd-yyyy)" ForeColor="Red" Display="Dynamic" />
            </td>
        </tr>
        <tr>
            <td class="tdLeft">Project:</td>
            <td class="tdRight">
                <asp:DropDownList runat="server" ID="ddlProjects" ClientIDMode="Static">
                    <asp:ListItem Text="Rewards Zone" Selected="True"/>
                    <asp:ListItem Text="Gas Buddy"/>
                    <asp:ListItem Text="Google Mashup"/>
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td class="tdLeft">Department:</td>
            <td class="tdRight">
                <asp:DropDownList runat="server" ID="ddlDepartment" ClientIDMode="Static">
                    <asp:ListItem Text="Engineering" Selected="True"/>
                    <asp:ListItem Text="Operation"/>
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td class="tdLeft">Billing Hrs:</td>
            <td class="tdRight">
                <asp:TextBox runat="server" ID="txtBillingHrs" Width="50px" ClientIDMode="Static"  CausesValidation="true" MaxLength="5" style="text-align:right" />
                <asp:RegularExpressionValidator runat="server" ID="revBillingHrs" 
                            ControlToValidate="txtBillingHrs" ErrorMessage="Enter Numeric Values only" 
                            ForeColor="Red" Display="Dynamic" ValidationExpression="^\d*\.?\d*$" />
            </td>
        </tr>
        <tr>
            <td class="tdLeft">Indirect Hrs:</td>
            <td class="tdRight">
                <asp:TextBox runat="server" ID="txtIndirectHrs" Width="50px" ClientIDMode="Static"  CausesValidation="true" MaxLength="5" style="text-align:right" />
                <asp:RegularExpressionValidator runat="server" ID="revIndirectHrs" 
                            ControlToValidate="txtIndirectHrs" ErrorMessage="Enter Numeric Values only" 
                            ForeColor="Red" Display="Dynamic" ValidationExpression="^\d*\.?\d*$" />
            </td>
        </tr>
        <tr>
            <td class="tdLeft">Meeting Hrs:</td>
            <td class="tdRight">
                <asp:TextBox runat="server" ID="txtMeetingHrs" Width="50px" ClientIDMode="Static"  CausesValidation="true" MaxLength="5" style="text-align:right" />
                <asp:RegularExpressionValidator runat="server" ID="revMeetingHrs" 
                            ControlToValidate="txtMeetingHrs" ErrorMessage="Enter Numeric Values only" 
                            ForeColor="Red" Display="Dynamic" ValidationExpression="^\d*\.?\d*$" />
            </td>

        </tr>
        <tr>
            <td class="tdLeft">Training Hrs:</td>
            <td class="tdRight">
                <asp:TextBox runat="server" ID="txtTrainingHrs" Width="50px" ClientIDMode="Static"  CausesValidation="true" MaxLength="5" style="text-align:right" />
                <asp:RegularExpressionValidator runat="server" ID="revTrainingHrs" 
                            ControlToValidate="txtTrainingHrs" ErrorMessage="Enter Numeric Values only" 
                            ForeColor="Red" Display="Dynamic" ValidationExpression="^\d*\.?\d*$" />
            </td>
        </tr>
        <tr>
            <td class="tdLeft">Personal Hrs:</td>
            <td class="tdRight">
                <asp:TextBox runat="server" ID="txtPersonalHrs" Width="50px" ClientIDMode="Static"  CausesValidation="true" MaxLength="5" style="text-align:right" />
                <asp:RegularExpressionValidator runat="server" ID="revPersonalHrs" 
                            ControlToValidate="txtPersonalHrs" ErrorMessage="Enter Numeric Values only" 
                            ForeColor="Red" Display="Dynamic" ValidationExpression="^\d*\.?\d*$" />
            </td>
        </tr>
        <tr>
            <td class="tdLeft">Other Hrs:</td>
            <td class="tdRight">
                <asp:TextBox runat="server" ID="txtOtherHrs" Width="50px" ClientIDMode="Static"  CausesValidation="true" MaxLength="5" style="text-align:right" />
                <asp:RegularExpressionValidator runat="server" ID="revOtherHrs" 
                            ControlToValidate="txtOtherHrs" ErrorMessage="Enter Numeric Values only" 
                            ForeColor="Red" Display="Dynamic" ValidationExpression="^\d*\.?\d*$" />
            </td>
        </tr>
        <tr>
            <td class="tdLeft">Leave Hrs:</td>
            <td class="tdRight">
                <asp:TextBox runat="server" ID="txtLeaveHrs" Width="50px" ClientIDMode="Static"  CausesValidation="true" MaxLength="5" style="text-align:right" />
                <asp:RegularExpressionValidator runat="server" ID="revtLeaveHrs" 
                            ControlToValidate="txtLeaveHrs" ErrorMessage="Enter Numeric Values only" 
                            ForeColor="Red" Display="Dynamic" ValidationExpression="^\d*\.?\d*$" />
            </td>
        </tr>
        <tr>
            <td class="tdLeft"></td>
            <td class="tdRight">
                <table style="width:200px; margin-left:-3px">
                    <tr>
                        <td>
                            <asp:Button runat="server" ID="btnSave" OnClick="btnSave_Click" Text="Save" Width="90px" UseSubmitBehavior="true" CausesValidation="true" />&nbsp;&nbsp;
                            <asp:Button runat="server" ID="btnReset" OnClick="btnReset_Click" Text="Reset" Width="90px" CausesValidation="false" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        </tbody>
    </table>
</asp:Content>
