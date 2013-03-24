using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

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

        protected Label LabelMessage
        {
            get
            {
                return (Label)this.Master.FindControl("lblMessage");
            }
        }
    }
}