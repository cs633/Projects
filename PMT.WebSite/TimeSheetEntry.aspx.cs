using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Drawing;

namespace PMT
{
    public partial class TimeSheetEntry : BasePage
    {
        protected override void OnLoad(EventArgs e)
        {
            base.OnLoad(e);

            if (!IsPostBack)
                txtDate.Text = DateTime.Now.ToString("MM-dd-yyyy");

            txtDate.Focus();
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            try
            {
                SaveTimeSheetData();

                btnReset_Click(sender, e);

                LabelMessage.Text = "Timesheet data save successfully.";
                LabelMessage.ForeColor = Color.DarkGreen;
            }
            catch (Exception ex)
            {
                LabelMessage.Text = ex.Message;
                LabelMessage.ForeColor = Color.Red;
            }
        }

        private void SaveTimeSheetData()
        {
            throw new NotImplementedException("Method is not implemented.");
        }

        protected void btnReset_Click(object sender, EventArgs e)
        {
            txtDate.Text = string.Empty;
            txtBillingHrs.Text = string.Empty;
            txtIndirectHrs.Text = string.Empty;
            txtMeetingHrs.Text = string.Empty;
            txtTrainingHrs.Text = string.Empty;
            txtPersonalHrs.Text = string.Empty;
            txtOtherHrs.Text = string.Empty;
            txtLeaveHrs.Text = string.Empty;
            LabelMessage.Text = string.Empty;
            ddlDepartment.SelectedIndex = 0;
            ddlProjects.SelectedIndex = 0;
        }
    }
}