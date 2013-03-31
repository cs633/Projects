using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using PMT.DataAccessProvider;
using System.Drawing;

namespace PMT
{
    public class BasePage : Page
    {
        protected override void OnLoad(EventArgs e)
        {
            base.OnLoad(e);

            if (Session["LoggedInUser"] == null)
                Response.Redirect("login.aspx", true);
        }

        private Label _LabelMessage;
        protected Label LabelMessage
        {
            get
            {
                if (_LabelMessage == null)
                    _LabelMessage = (Label)this.Master.FindControl("lblMessage");
                return _LabelMessage;
            }
        }

        private Employee _LoggedInUser;
        public Employee LoggedInUser
        {
            get 
            { 
                if(_LoggedInUser == null)
                    _LoggedInUser = (Employee)Session["LoggedInUser"];
                return _LoggedInUser;
            }
        }

        /// <summary>
        /// Show Login Validation Errors
        /// </summary>
        /// <param name="msg"></param>
        /// <param name="args"></param>
        protected void ShowErrorMessage(String msg)
        {
            this.LabelMessage.Text = msg;
            this.LabelMessage.Visible = true;
            this.LabelMessage.ForeColor = Color.Red;
        }

        /// <summary>
        /// Show Success Messages
        /// </summary>
        /// <param name="msg"></param>
        /// <param name="args"></param>
        protected void ShowSuccessMessage(String msg)
        {
            this.LabelMessage.Text = msg;
            this.LabelMessage.Visible = true;
            this.LabelMessage.ForeColor = Color.Green;
        }
    }
}