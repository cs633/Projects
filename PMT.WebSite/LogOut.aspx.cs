using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using PMT.DataAccessProvider;

namespace PMT
{
    public partial class LogOut : System.Web.UI.Page
    {
        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);
            if (Session["LoggedInUser"] != null)
            {
                Employee employee = (Employee)Session["LoggedInUser"];
                lblLogout.Text = "Logging out the user " + employee.FirstName + " "  + employee.LastName + "...";
            }

            Session.Clear();

            Response.Redirect("login.aspx", true);
        }
    }
}