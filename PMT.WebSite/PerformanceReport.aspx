<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="PerformanceReport.aspx.cs" Inherits="PMT.PerformanceReport" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <ContentTemplate>
            <asp:Panel runat="server" ID="pnlQuery" ClientIDMode="Static">
                <table class="data" cellpadding="2">
                    <tbody>
                    <tr>
                        <td>
                            <h2>Select the date range to generate the performance report</h2>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Start:&nbsp;&nbsp;
                            <asp:TextBox runat="server" ID="txtStartDate" ClientIDMode="Static" Width="120px" AutoPostBack="true"/>&nbsp;&nbsp;&nbsp;&nbsp;
                            Finish:&nbsp;&nbsp;
                            <asp:TextBox runat="server" ID="txtFinishDate" ClientIDMode="Static" Width="120px" AutoPostBack="true"/>&nbsp;&nbsp;
                            <asp:Button runat="server" ID="btnGo" Width="95px" Text="Go" OnClick="btnGo_Click" UseSubmitBehavior="true" />&nbsp;&nbsp;&nbsp;&nbsp;
                            <%--<asp:RequiredFieldValidator ControlToValidate="txtStartDate" runat="server" ID="rfvStartDate" Display="Dynamic" ErrorMessage="Start Date cannot be empty or null" ForeColor="Red" />--%>
                            <%--<asp:RequiredFieldValidator ControlToValidate="txtFinishDate" runat="server" ID="rfvFinishDate" Display="Dynamic" ErrorMessage="Finish Date cannot be empty or null" ForeColor="Red" />--%>
                            <%--<asp:RegularExpressionValidator runat="server" ID="revFromDate" ValidationExpression="((0?[1-9]|1[012])/0?[1-9]|[12][0-9]|3[01])/((19|20)\\d\\d)" ControlToValidate="txtStartDate" ErrorMessage="Enter date with valid format (MM/dd/yyyy)" ForeColor="Red" Display="Dynamic" />--%>
                            <%--<asp:RegularExpressionValidator runat="server" ID="revToDate" ValidationExpression="((0?[1-9]|1[012])/0?[1-9]|[12][0-9]|3[01])/((19|20)\\d\\d)" ControlToValidate="txtFinishDate" ErrorMessage="Enter date with valid format (MM/dd/yyyy)" ForeColor="Red" Display="Dynamic" />--%>
                            <%--<asp:CompareValidator id="cvDate" runat="server" ControlToCompare="txtStartDate" cultureinvariantvalues="true" display="Dynamic" enableclientscript="true"  ControlToValidate="txtFinishDate" ErrorMessage="Start date must be earlier than finish date" type="Date" setfocusonerror="true" Operator="GreaterThanEqual" text="Start date must be earlier than finish date" ForeColor="Red" />  --%>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </asp:Panel>

            <asp:Panel runat="server" ID="pnlResult" ClientIDMode="Static">
                <table class="data" cellpadding="2">
                    <tbody>
                    <tr>
                        <td>
                            <h2 runat="server" id="lblPerformanceReportHeaderText">Performance Report for the date range</h2>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Button runat="server" ID="btnGoBack" ClientIDMode="Static" Text="Back" Width="95px" OnClick="btnBack_Click"/>&nbsp;&nbsp;&nbsp;&nbsp;
                            Report Variables: <asp:Label runat="server" ID="lblNumberOfDays" />&nbsp;days&nbsp;(<asp:Label runat="server" ID="lblNumberOfWorkingHrs" />&nbsp;Hrs)
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:GridView runat="server" ID="grdPerformanceReport" EmptyDataText="No performance report found." AutoGenerateColumns="false" onrowdatabound="grdPerformanceReport_RowDataBound"
                                CellPadding="2" ForeColor="#333333"  BorderColor="Gray" BorderWidth="1px"
                                GridLines="Both" 
                                DataKeyNames="EmployeeId"              
                                HeaderStyle-BackColor="Blue" HeaderStyle-ForeColor="White" 
                                Width="100%">
                                <Columns>
                                    <asp:BoundField DataField="full_name" HeaderText="Employee Name"/>
                                    <asp:BoundField DataField="total_billable_hrs" HeaderText="Billable Hrs" DataFormatString="{0:F2}" ItemStyle-HorizontalAlign="Right"/>
                                    <asp:BoundField DataField="billable_hrs_percentage" HeaderText="Billable Hrs %" DataFormatString="{0:F2}" ItemStyle-HorizontalAlign="Right"/>
                                    <asp:BoundField DataField="total_training_hrs" HeaderText="Training Hrs" DataFormatString="{0:F2}" ItemStyle-HorizontalAlign="Right"/>
                                    <asp:BoundField DataField="training_hrs_percentage" HeaderText="Training Hrs %" DataFormatString="{0:F2}" ItemStyle-HorizontalAlign="Right"/>
                                    <asp:BoundField DataField="total_meeting_hrs" HeaderText="Meeting Hrs" DataFormatString="{0:F2}" ItemStyle-HorizontalAlign="Right"/>
                                    <asp:BoundField DataField="meeting_hrs_percentage" HeaderText="Meeting Hrs %" DataFormatString="{0:F2}" ItemStyle-HorizontalAlign="Right"/>
                                    <asp:BoundField DataField="total_leave_hrs" HeaderText="Leave Hrs" DataFormatString="{0:F2}" ItemStyle-HorizontalAlign="Right"/>
                                    <asp:BoundField DataField="leave_hrs_percentage" HeaderText="Leave Hrs %" DataFormatString="{0:F2}" ItemStyle-HorizontalAlign="Right"/>
                                    <asp:BoundField DataField="total_indirect_hrs" HeaderText="Indirect Hrs" DataFormatString="{0:F2}" ItemStyle-HorizontalAlign="Right"/>
                                    <asp:BoundField DataField="indirect_hrs_percentage" HeaderText="Indirect Hrs %" DataFormatString="{0:F2}" ItemStyle-HorizontalAlign="Right"/>                                
                                    <asp:BoundField DataField="total_other_hrs" HeaderText="Other Hrs" DataFormatString="{0:F2}" ItemStyle-HorizontalAlign="Right"/>
                                    <asp:BoundField DataField="other_hrs_percentage" HeaderText="Other Hrs %" DataFormatString="{0:F2}" ItemStyle-HorizontalAlign="Right"/>
                                </Columns>
                            </asp:GridView>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </asp:Panel>
        </ContentTemplate>
</asp:Content>

