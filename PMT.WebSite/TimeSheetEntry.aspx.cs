using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Drawing;
using PMT.DataAccessProvider;

namespace PMT
{
    public partial class TimeSheetEntry : BasePage
    {
        protected override void OnLoad(EventArgs e)
        {
            base.OnLoad(e);

            if (!IsPostBack)
            {
                txtDate.Text = DateTime.Now.ToString("MM/dd/yyyy");

                FillProjectsAndWorkCategories();

                txtDate.Focus();

                PopulateHrs();
            }
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
            ddlWorkCategory.SelectedIndex = 0;
            ddlProjects.SelectedIndex = 0;
            txtDate.Focus();
        }

        protected void ddlProjects_SelectedIndexChanged(object sender, EventArgs e)
        {
            PopulateHrs();
            ScriptManager.GetCurrent(Page).SetFocus(ddlProjects);
        }

        protected void txtDate_TextChanged(object sender, EventArgs e)
        {
            PopulateHrs();
            ScriptManager.GetCurrent(Page).SetFocus((Control)sender);
        }

        private void PopulateHrs()
        {
            DateTime dateTimeEntry = DateTime.Now;
            if (string.IsNullOrEmpty(txtDate.Text))
                return;
            try
            {
                LabelMessage.Text = string.Empty;
                dateTimeEntry = Convert.ToDateTime(txtDate.Text);
            }
            catch 
            {
                LabelMessage.Text = "Enter date with valid format (MM/dd/yyyy)";
                LabelMessage.ForeColor = Color.Red;
                return;
            }
            
            try
            {
                using (PMTDataContext dataContext = new PMTDataContext())
                {
                    int employeeID = this.LoggedInUser.ID;
                    int projectID = int.Parse(ddlProjects.SelectedValue);

                    TimeSheet timeSheet = (from t in dataContext.TimeSheets
                                            where t.DateTimeEntry == dateTimeEntry
                                            && t.EmpoyeeID == employeeID
                                            && t.ProjectID == projectID
                                            select t).SingleOrDefault();

                    if (timeSheet != null)
                    {
                        if (timeSheet.BillableHrs != null)
                            txtBillingHrs.Text = timeSheet.BillableHrs.ToString();
                        else
                            txtBillingHrs.Text =string.Empty;

                        if (timeSheet.IndirectHrs != null)
                            txtIndirectHrs.Text = timeSheet.IndirectHrs.ToString();
                        else
                            txtIndirectHrs.Text = string.Empty;

                        if (timeSheet.LeaveHrs != null)
                            txtLeaveHrs.Text = timeSheet.LeaveHrs.ToString();
                        else
                            txtLeaveHrs.Text = string.Empty;

                        if (timeSheet.MeetingHrs != null)
                            txtMeetingHrs.Text = timeSheet.MeetingHrs.ToString();
                        else
                            txtMeetingHrs.Text = string.Empty;

                        if (timeSheet.OtherHrs != null)
                            txtOtherHrs.Text = timeSheet.OtherHrs.ToString();
                        else
                            txtOtherHrs.Text = string.Empty;

                        if (timeSheet.TrainingHrs != null)
                            txtTrainingHrs.Text = timeSheet.TrainingHrs.ToString();
                        else
                            txtTrainingHrs.Text = string.Empty;

                        if (timeSheet.PersonalHrs != null)
                            txtPersonalHrs.Text = timeSheet.PersonalHrs.ToString();
                        else
                            txtPersonalHrs.Text = string.Empty;
                    }
                }
            }
            catch (Exception ex)
            {
                LabelMessage.Text = ex.Message;
                LabelMessage.ForeColor = Color.Red;
            }
        }

        private void SaveTimeSheetData()
        {
            if (!Page.IsValid)
                ShowErrorMessage("Page validation is failed. Please provide valid inputs.");

            //Check the whether the data exist in the datbase table or not
            using (PMTDataContext dataContext = new PMTDataContext())
            {
                DateTime dateTimeEntry = Convert.ToDateTime(txtDate.Text);
                int employeeID = this.LoggedInUser.ID;
                int projectID = int.Parse(ddlProjects.SelectedValue);
                TimeSheet timeSheet = (from t in dataContext.TimeSheets
                                       where t.DateTimeEntry == dateTimeEntry
                                       && t.EmpoyeeID == employeeID
                                       && t.ProjectID == projectID
                                       select t).SingleOrDefault();

                if (timeSheet == null)
                {
                    timeSheet = new TimeSheet();
                    timeSheet.EmpoyeeID = employeeID;
                    timeSheet.DateTimeEntry = dateTimeEntry;
                    timeSheet.ProjectID = projectID;
                    if(!string.IsNullOrEmpty(txtBillingHrs.Text))
                        timeSheet.BillableHrs = decimal.Parse(txtBillingHrs.Text);
                    if(!string.IsNullOrEmpty(txtIndirectHrs.Text))
                        timeSheet.IndirectHrs = decimal.Parse(txtIndirectHrs.Text);
                    if(!string.IsNullOrEmpty(txtLeaveHrs.Text))
                        timeSheet.LeaveHrs = decimal.Parse(txtLeaveHrs.Text);
                    if(!string.IsNullOrEmpty(txtMeetingHrs.Text))
                        timeSheet.MeetingHrs = decimal.Parse(txtMeetingHrs.Text);
                    if(!string.IsNullOrEmpty(txtOtherHrs.Text))
                        timeSheet.OtherHrs = decimal.Parse(txtOtherHrs.Text);
                    if(!string.IsNullOrEmpty(txtTrainingHrs.Text))
                        timeSheet.TrainingHrs = decimal.Parse(txtTrainingHrs.Text);
                    if (!string.IsNullOrEmpty(txtPersonalHrs.Text))
                        timeSheet.PersonalHrs = decimal.Parse(txtPersonalHrs.Text);

                    dataContext.TimeSheets.AddObject(timeSheet);
                }
                else
                {
                    if (!string.IsNullOrEmpty(txtBillingHrs.Text))
                        timeSheet.BillableHrs = decimal.Parse(txtBillingHrs.Text);
                    if (!string.IsNullOrEmpty(txtIndirectHrs.Text))
                        timeSheet.IndirectHrs = decimal.Parse(txtIndirectHrs.Text);
                    if (!string.IsNullOrEmpty(txtLeaveHrs.Text))
                        timeSheet.LeaveHrs = decimal.Parse(txtLeaveHrs.Text);
                    if (!string.IsNullOrEmpty(txtMeetingHrs.Text))
                        timeSheet.MeetingHrs = decimal.Parse(txtMeetingHrs.Text);
                    if (!string.IsNullOrEmpty(txtOtherHrs.Text))
                        timeSheet.OtherHrs = decimal.Parse(txtOtherHrs.Text);
                    if (!string.IsNullOrEmpty(txtTrainingHrs.Text))
                        timeSheet.TrainingHrs = decimal.Parse(txtTrainingHrs.Text);
                    if (!string.IsNullOrEmpty(txtPersonalHrs.Text))
                        timeSheet.PersonalHrs = decimal.Parse(txtPersonalHrs.Text);
                }

                dataContext.SaveChanges();
            }
        }

        private void FillProjectsAndWorkCategories()
        {
            using(PMTDataContext dataContext = new PMTDataContext())
            {
                Dictionary<string, string> projects = (from e in dataContext.Employees
                          join ep in dataContext.EmployeeProjects on e.ID equals ep.EmployeeID
                          join p in dataContext.Projects on ep.ProjectID equals p.ID
                          where e.ID == LoggedInUser.ID
                          select new {p.ID, p.Name }).ToDictionary(p => p.ID.ToString(), p => p.Name);


                ddlProjects.DataSource = projects;
                ddlProjects.DataTextField = "Value";
                ddlProjects.DataValueField = "Key";
                ddlProjects.DataBind();



                Dictionary<string, string> workCategories = (from w in dataContext.WorkCategories
                                                          select w).ToDictionary(w => w.ID.ToString(), w => w.Name);

                ddlWorkCategory.DataSource = workCategories;
                ddlWorkCategory.DataTextField = "Value";
                ddlWorkCategory.DataValueField = "Key";
                ddlWorkCategory.DataBind();
            }
        }

    }
}