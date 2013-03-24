using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PMT
{
    public partial class Site : System.Web.UI.MasterPage
    {

        protected override void  OnLoad(EventArgs e)
        {
 	         base.OnLoad(e);

            if (Session["LoggedInUser"] != null)
             {
                 string userName = Session["LoggedInUser"].ToString();
                 lblSessionUser.Text = "Welcome " + userName + " (Developer).";
             }

        }

        protected void mnuPMT_MenuItemClick(object sender, MenuEventArgs e)
        {

        }
    }
}