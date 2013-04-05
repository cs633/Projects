using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Drawing;

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
                lblNumberOfDays.Text = noOfDays.ToString();
                lblNumberOfWorkingHrs.Text = (noOfDays * 8).ToString();
                lblPerformanceReportHeaderText.InnerText = "Performance Report for the date range between " + txtStartDate.Text + " and " + txtFinishDate.Text;

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

        protected void btnBack_Click(object sender, EventArgs e)
        {
            pnlQuery.Visible = true;
            pnlResult.Visible = false;
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