using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PMT
{
    public partial class LogOut : System.Web.UI.Page
    {
        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);
            if (Session["LoggedInUser"] != null)
                lblLogout.Text = "Logging out the user " + Session["LoggedInUser"].ToString() + "...";

            Session.Clear();

            Response.Redirect("login.aspx", true);
        }
    }
}