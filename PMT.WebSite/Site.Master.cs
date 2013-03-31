using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using PMT.DataAccessProvider;

namespace PMT
{
    public partial class Site : System.Web.UI.MasterPage
    {

        protected override void  OnLoad(EventArgs e)
        {
 	         base.OnLoad(e);

            if (Session["LoggedInUser"] != null)
             {
                 Employee employee = (Employee)Session["LoggedInUser"];
                 lblSessionUser.Text = "Welcome " + employee.FirstName + " " + employee.LastName + " (" + employee.Title + ").";
             }
        }

        protected void mnuPMT_MenuItemClick(object sender, MenuEventArgs e)
        {

        }
    }
}