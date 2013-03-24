using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

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
            //// 1. Verify the Application
            //ApplicationDto appDto = Repository.GetApplicationByName(ConfigurationManager.AppSettings["ApplicationName"]);
            //if (appDto != null)
            //    Session.Add("ApplicationDto", appDto);
            //else
            //{
            //    ShowValidationError("Unknown Application.", args);
            //    return;
            //}

            //// 2. Authenticate the User
            //UserDto user = Repository.AuthenticateUser(TextBoxUsername.Text, TextBoxPassword.Text);
            //if (String.IsNullOrEmpty(user.UserName))
            //{
            //    ShowValidationError("User Authentication failed.", args);
            //    return;
            //}

            //// 3. Authorize the User                   
            //if (user.IsSuperUser)
            //{
            //    // Authorized automatically               
            //}
            //else
            //{
            //    // Get the access information for the User to the Application              
            //    user.ControlAccess = Repository.GetUserAccessInfoDtoByUser(user.UserGuid, appDto.ApplicationGuid);
            //    if (user.ControlAccess == null || user.ControlAccess.Where(a => a.AllowAccess == true).ToList().Count == 0)
            //    {
            //        ShowValidationError("This user does not have access to any of the pages.", args);
            //        return;
            //    }
            //}

            ////Set the User properties
            //user.Role = Repository.GetUserRoleStudioDtoByUser(user.UserGuid);
            //user.UserStudios = userStudios;
            //if (userStudios.Count == 1)
            //{
            //    user.LoggedInStudio = userStudios[0];
            //    Session.Add("Studio", user.LoggedInStudio);
            //}

            //Add the user object into the session
            Session.Add("LoggedInUser", txtUserName.Text);

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