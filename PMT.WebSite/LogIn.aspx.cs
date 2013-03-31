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
    public partial class Login : System.Web.UI.Page
    {
        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);

            Session.RemoveAll();
            Session.Clear();
            txtUserName.Focus();
        }

        /// <summary>
        /// OnLoad method of the Page Life cycle 
        /// </summary>
        /// <param name="e"></param>
        protected override void OnLoad(EventArgs e)
        {
            base.OnLoad(e);
            if (!IsPostBack)
                FillFormDataFromCookie();
        }

        /// <summary>
        /// This is the Routine that will Validate the User ( Authentication and Authorization)
        /// </summary>
        /// <param name="source"></param>
        /// <param name="args"></param>
        public void LoginValidation(Object source, ServerValidateEventArgs args)
        {
            using (PMTDataContext dataContext = new PMTDataContext())
            {
                IQueryable<Employee> employees = from e in dataContext.Employees
                               where e.UserName == txtUserName.Text.Trim()
                               && e.Password == txtPassword.Text.Trim()
                               select e;

                if (employees.Count() <= 0)
                {
                    ShowValidationError("User authentication failed.", args);
                    return;
                }

                if (employees.Count() > 1)
                {
                    ShowValidationError("Ambiguous user information found.", args);
                    return;
                }

                Employee employee = employees.FirstOrDefault();

                //Add the user object into the session
                Session.Add("LoggedInUser", employee);

            }
            
            args.IsValid = true;
        }

        /// <summary>
        /// Login Button Click Event Processing
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected virtual void btnLogin_Click(Object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                AddCredentialsToCookie(txtUserName.Text);
                Response.Redirect("Home.aspx");
            }
        }

        #region Protected methods

        /// <summary>
        /// Show Login Validation Errors
        /// </summary>
        /// <param name="msg"></param>
        /// <param name="args"></param>
        protected void ShowValidationError(String msg, ServerValidateEventArgs args)
        {
            args.IsValid = false;
            loginValidator.Text = msg;
            loginValidator.Visible = true;
            loginValidator.ForeColor = Color.Red;
        }

        /// <summary>
        /// Add User Credentials to the Cookie
        /// </summary>
        /// <param name="username"></param>
        protected void AddCredentialsToCookie(String username)
        {
            HttpCookie cookie = Request.Cookies["UserCredentials"];
            if (cookie == null)
            {
                cookie = new HttpCookie("UserCredentials");
            }
            cookie["username"] = username;
            cookie.Expires = DateTime.Now.AddYears(1);
            Response.Cookies.Add(cookie);
        }

        /// <summary>
        /// Fill User data from cookie
        /// </summary>
        protected void FillFormDataFromCookie()
        {
            try
            {
                HttpCookie cookie = Request.Cookies["UserCredentials"];
                if (cookie != null)
                {
                    if (!string.IsNullOrEmpty(cookie["username"]))
                    {
                        txtUserName.Text = cookie["username"];
                    }
                }
            }
            catch { } //just to prevent app from crashing in case there are already some credentials present which are not encoded, legacy cms user's browsers
        }

        private void DeleteCookieData()
        {
            try
            {
                HttpCookie loginCookie = Request.Cookies["UserCredentials"];
                if (loginCookie != null)
                {
                    loginCookie.Expires = DateTime.Now.AddDays(-1d);
                    Response.Cookies.Add(loginCookie);
                }
            }
            catch
            {

            }
        }

        #endregion

    }
}