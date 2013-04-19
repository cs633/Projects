<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="TimeSheetEntry.aspx.cs" Inherits="PMT.TimeSheetEntry" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
 <script type="text/javascript">
     $(function () {
         $("#txtDate").datepicker();
     });
  </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<asp:ScriptManager runat="server" ID="ScriptManager1"/> 
<asp:UpdatePanel runat="server" ID="UpdatePanel1">
  <ContentTemplate>
       <asp:Label runat="server" ClientIDMode="Static" ID="lblMessage"/>
       <table class="data" cellpadding="2">
        <tbody>
        <tr>
            <td colspan="2">
                <h2>
                    Please input your time sheet information.
                </h2>                
            </td>
        </tr>
        <tr>
            <td class="tdLeft">Date :</td>
            <td class="tdRight">
                <asp:TextBox runat="server" ID="txtDate" ClientIDMode="Static" Width="120px" AutoPostBack="true" OnTextChanged="txtDate_TextChanged"/>&nbsp;&nbsp;
                <%--<a style="display:inline; position:absolute" onclick="showCalendarControl(txtDate)" href="#"><img alt="calendar" src="calendar.gif" style="width: 34px; height: 23px" border="0" /></a>--%>
                <%--<asp:RegularExpressionValidator runat="server" ID="revDate" ValidationExpression="/(0[1-9]|1[012])[- \/.](0[1-9]|[12][0-9]|3[01])[- \/.](19|20)\d\d/" ControlToValidate="txtDate" ErrorMessage="Enter date with valid format (MM/dd/yyyy)" ForeColor="Red" Display="Dynamic" />--%>
            </td>
        </tr>
        <tr>
            <td class="tdLeft">Project:</td>
            <td class="tdRight">
                <asp:DropDownList runat="server" ID="ddlProjects" ClientIDMode="Static" AutoPostBack="true" OnSelectedIndexChanged="ddlProjects_SelectedIndexChanged"/>
            </td>
        </tr>
        <tr>
            <td class="tdLeft">Work Category:</td>
            <td class="tdRight">
                <asp:DropDownList runat="server" ID="ddlWorkCategory" ClientIDMode="Static"/>
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
  </ContentTemplate>
</asp:UpdatePanel>
</asp:Content>
