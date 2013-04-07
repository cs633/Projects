using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Drawing;
using PMT.DataAccessProvider;
using System.Data;
using System.Web.UI.DataVisualization.Charting;

namespace PMT
{
    public partial class PerformanceReport : BasePage
    {
        protected override void OnLoad(EventArgs e)
        {
            base.OnLoad(e);

            if (!IsPostBack)
            {
                pnlQuery.Visible = true;
                pnlResult.Visible = false;                
            }
        }

        protected void btnGo_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
                return;

            try
            {
                bool result;
                DateTime startDate;
                DateTime finishDate;
                result = DateTime.TryParse(txtStartDate.Text, out startDate);
                if (!result)
                    throw new Exception("Enter a valid start date.");
                
                result = DateTime.TryParse(txtFinishDate.Text, out finishDate);
                if(!result)
                    throw new Exception("Enter a valid end date.");

                result = startDate < finishDate;
                if (!result)
                    throw new Exception("Start date must be earlier than finish date");


                int noOfDays = Weekdays(startDate, finishDate);
                int noOfWorkingHrs = (noOfDays * 8);
                lblNumberOfDays.Text = noOfDays.ToString();
                lblNumberOfWorkingHrs.Text = noOfWorkingHrs.ToString();
                lblPerformanceReportHeaderText.InnerText = "Performance Report for the date range between " + txtStartDate.Text + " and " + txtFinishDate.Text;

                System.Globalization.CultureInfo culInfo = new System.Globalization.CultureInfo("en-US");
                using (PMTDataContext dataContext = new PMTDataContext())
                {
                    finishDate = finishDate.AddMinutes(1439);
                    List<GetPerformanceReport_Result> performanceReportResultList = dataContext.GetPerformanceReport(startDate, finishDate, noOfWorkingHrs).ToList();
                    //Bind the chart first
                    BindChart(performanceReportResultList);

                    if (performanceReportResultList.Count > 0)
                    {
                        double totalBillableHrs = 0;
                        double totalBillableHrsPct = 0;
                        double totalTrainingHrs = 0;
                        double totalTrainingHrsPct = 0;
                        double totalMeetingHrs = 0;
                        double totalMeetingHrsPct = 0;
                        double totalLeavHrs = 0;
                        double totalLeavHrsPct = 0;
                        double totalIndirectHrs = 0;
                        double totalIndirectHrsPct = 0;
                        double totalOtherHrs = 0;
                        double totalOtherHrsPct = 0;

                        foreach (GetPerformanceReport_Result performanceReport in performanceReportResultList)
                        {
                            totalBillableHrs = totalBillableHrs + (double)(performanceReport.total_billable_hrs == null ? 0 : performanceReport.total_billable_hrs.Value);
                            totalBillableHrsPct = totalBillableHrsPct + (double)(performanceReport.billable_hrs_percentage == null ? 0 : performanceReport.billable_hrs_percentage.Value);
                            totalTrainingHrs = totalTrainingHrs + (double)(performanceReport.total_training_hrs == null ? 0 : performanceReport.total_training_hrs.Value);
                            totalTrainingHrsPct = totalTrainingHrsPct + (double)(performanceReport.training_hrs_percentage == null ? 0 : performanceReport.training_hrs_percentage.Value);
                            totalMeetingHrs = totalMeetingHrs + (double)(performanceReport.total_meeting_hrs == null ? 0 : performanceReport.total_meeting_hrs.Value);
                            totalMeetingHrsPct = totalMeetingHrsPct + (double)(performanceReport.meeting_hrs_percentage == null ? 0 : performanceReport.meeting_hrs_percentage.Value);
                            totalLeavHrs = totalLeavHrs + (double)(performanceReport.total_leave_hrs == null ? 0 : performanceReport.total_leave_hrs.Value);
                            totalLeavHrsPct = totalLeavHrsPct + (double)(performanceReport.leave_hrs_percentage == null ? 0 : performanceReport.leave_hrs_percentage.Value);
                            totalIndirectHrs = totalIndirectHrs + (double)(performanceReport.total_indirect_hrs == null ? 0 : performanceReport.total_indirect_hrs.Value);
                            totalIndirectHrsPct = totalIndirectHrsPct + (double)(performanceReport.indirect_hrs_percentage == null ? 0 : performanceReport.indirect_hrs_percentage.Value);
                            totalOtherHrs = totalOtherHrs + (double)(performanceReport.total_other_hrs == null ? 0 : performanceReport.total_other_hrs.Value);
                            totalOtherHrsPct = totalOtherHrsPct + (double)(performanceReport.other_hrs_percentage == null ? 0 : performanceReport.other_hrs_percentage.Value);
                        }

                        GetPerformanceReport_Result performanceReport1 = new GetPerformanceReport_Result();
                        performanceReport1.full_name = "Total";
                        performanceReport1.total_billable_hrs = (decimal)totalBillableHrs;
                        performanceReport1.billable_hrs_percentage = (decimal)totalBillableHrsPct;
                        performanceReport1.total_training_hrs = (decimal)totalTrainingHrs;
                        performanceReport1.training_hrs_percentage = (decimal)totalTrainingHrsPct;
                        performanceReport1.total_meeting_hrs = (decimal)totalMeetingHrs;
                        performanceReport1.meeting_hrs_percentage = (decimal)totalMeetingHrsPct;
                        performanceReport1.total_leave_hrs = (decimal)totalLeavHrs;
                        performanceReport1.leave_hrs_percentage = (decimal)totalLeavHrsPct;
                        performanceReport1.total_indirect_hrs = (decimal)totalIndirectHrs;
                        performanceReport1.indirect_hrs_percentage = (decimal)totalIndirectHrsPct;
                        performanceReport1.total_other_hrs = (decimal)totalOtherHrs;
                        performanceReport1.other_hrs_percentage = (decimal)totalOtherHrsPct;

                        performanceReportResultList.Add(performanceReport1);
                    }

                    grdPerformanceReport.DataSource = performanceReportResultList;
                    grdPerformanceReport.DataBind();

                }
                



                pnlQuery.Visible = false;
                pnlResult.Visible = true;

            }
            catch (Exception ex)
            {
                LabelMessage.Text = ex.Message;
                LabelMessage.ForeColor = Color.Red;
                LabelMessage.Visible = true;
            }
        }

        private void BindChart(List<GetPerformanceReport_Result> performanceReportResult)
        {
            //Create a DataTable as the data source of the Chart control
            DataTable dt = new DataTable();

            //Add the columns to the DataTable
            dt.Columns.Add("Name");
            dt.Columns.Add("BillableHrsPercentage");
            dt.Columns.Add("TrainingHrsPercentage");
            dt.Columns.Add("MeetingHrsPercentage");
            dt.Columns.Add("LeaveHrsPercentage");
            dt.Columns.Add("IndirectHrsPercentage");
            dt.Columns.Add("OtherHrsPercentage");

            DataRow dr;
            foreach (GetPerformanceReport_Result result in performanceReportResult)
            {
                dr = dt.NewRow();
                dr["Name"]=result.short_name;
                if(result.billable_hrs_percentage != null)
                    dr["BillableHrsPercentage"] = Math.Round(result.billable_hrs_percentage.Value, 2);
                if(result.training_hrs_percentage != null)
                    dr["TrainingHrsPercentage"] = Math.Round(result.training_hrs_percentage.Value, 2);
                if(result.meeting_hrs_percentage != null )
                    dr["MeetingHrsPercentage"] = Math.Round(result.meeting_hrs_percentage.Value, 2);
                if(result.leave_hrs_percentage != null)
                    dr["LeaveHrsPercentage"] = Math.Round(result.leave_hrs_percentage.Value, 2);
                if(result.indirect_hrs_percentage != null)
                    dr["IndirectHrsPercentage"] = Math.Round(result.indirect_hrs_percentage.Value, 2);
                if (result.other_hrs_percentage != null)
                    dr["OtherHrsPercentage"] = Math.Round(result.other_hrs_percentage.Value, 2);
                dt.Rows.Add(dr);
            }

            Chart1.DataSource = dt;
            Chart1.Series[0].YValueMembers = "BillableHrsPercentage";
            Chart1.Series[1].YValueMembers = "TrainingHrsPercentage";
            Chart1.Series[2].YValueMembers = "MeetingHrsPercentage";
            Chart1.Series[3].YValueMembers = "LeaveHrsPercentage";
            Chart1.Series[4].YValueMembers = "IndirectHrsPercentage";
            Chart1.Series[5].YValueMembers = "OtherHrsPercentage";

            Chart1.Series[0].XValueMember = "Name";

            Chart1.DataBind();

        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            pnlQuery.Visible = true;
            pnlResult.Visible = false;
        }

        protected void grdPerformanceReport_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {

            }
        }


        private static int Weekdays(DateTime dtmStart, DateTime dtmEnd)
        {
            // This function includes the start and end date in the count if they fall on a weekday
            int dowStart = ((int)dtmStart.DayOfWeek == 0 ? 7 : (int)dtmStart.DayOfWeek);
            int dowEnd = ((int)dtmEnd.DayOfWeek == 0 ? 7 : (int)dtmEnd.DayOfWeek);
            TimeSpan tSpan = dtmEnd - dtmStart;
            if (dowStart <= dowEnd)
            {
                return (((tSpan.Days / 7) * 5) + Math.Max((Math.Min((dowEnd + 1), 6) - dowStart), 0));
            }
            return (((tSpan.Days / 7) * 5) + Math.Min((dowEnd + 6) - Math.Min(dowStart, 6), 5));
        }
    }
}