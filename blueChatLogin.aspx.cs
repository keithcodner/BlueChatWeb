using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Text;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;
using System.Web.Security;
using System.Net.Mail;
using System.IO;


public partial class blueChatLogin : System.Web.UI.Page
{

    //registration values
    static string userOrAdmin = "User";
    static string userStatus = "Active";
    static string getPasswordHash;

    //get password and validation strings
    static string getPassword;
    static string getValidation;
    static string hashPasswordForComparison;
    //static string hashPasswordFromDBForComparison;

    //initialize Random
    private static readonly Random Random = new Random();

    //check if super user
    static string checkIfSuperUser = "False";
    static string getCheckIfSuperUser;

    //login variables
    static string getUsernameFromDb;
    static string getPasswordFromDb;
    static string checkIfUserisValid;
    static string getAccountTypeFromDb;
    static string getHashedPasswordFromUser;
    static string validLogin = "False";

    static string getLoginDateTime;


    protected void Page_Load(object sender, EventArgs e)
    {

    }
    public string fetchFromDB(string selectCmd)
    {
        string getTheResult = "";
        //get the messages
        try
        {
            MySqlConnection con = new MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["pmsConnectionString"].ConnectionString);
            con.Open();
            MySqlCommand cmd = new MySqlCommand(selectCmd);
            cmd.Connection = con;
            getTheResult = ((string)cmd.ExecuteScalar().ToString());
            con.Close(); con.Dispose();


        }
        catch (Exception ex)
        {

            // Response.Write(ex.ToString());
        }
        return getTheResult.ToString();
    }
    public void performDBCMD(string QueryCmd)
    {
        try
        {


            MySqlConnection con1 = new MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["pmsConnectionString"].ConnectionString);
            con1.Open();
            MySqlCommand cmd1 = new MySqlCommand(QueryCmd);
            cmd1.Connection = con1;
            MySqlDataReader reader3 = cmd1.ExecuteReader();
            con1.Close(); con1.Dispose();
        }
        catch (Exception ex)
        {
            Response.Write(ex.ToString());
        }

    }

    
    protected void loginBtn_Click(object sender, EventArgs e)
    {

        //hash password from user passwordTxt usernameTxt
        getHashedPasswordFromUser = FormsAuthentication.HashPasswordForStoringInConfigFile(passwordTxt.Text + "-2>/z>.L0~TstH(39%@l2)E xAAo _=IOa8u<D?0cE", "SHA1");


        //get the username
        try
        {
         getUsernameFromDb =   fetchFromDB("SELECT uusername FROM users WHERE uusername = '" + usernameTxt.Text + "' AND upassword = '" + passwordTxt.Text + "' ;");
           

        }
        catch (Exception ex)
        {

            Response.Write(ex.ToString());
        }

        // get the password
        try
        {
            getPasswordFromDb = fetchFromDB("SELECT upassword FROM users WHERE uusername = '" + usernameTxt.Text + "' AND upassword = '" + passwordTxt.Text + "';");

        }
        catch (Exception ex)
        {

            Response.Write(ex.ToString());
        }

        Response.Write(getPasswordFromDb);
        Response.Write(getUsernameFromDb);

        //get date and time
        String years = DateTime.Now.Year.ToString();
        String months = DateTime.Now.Month.ToString();
        String days = DateTime.Now.Day.ToString();
        String hours = DateTime.Now.Hour.ToString();
        String mins = DateTime.Now.Minute.ToString();
        String secs = DateTime.Now.Second.ToString();
        String fullDate = years + "-" + months + "-" + days + " ";
        String fullTime = hours + ":" + mins + ":" + secs;
        getLoginDateTime = fullDate + fullTime;


        //perform if check to see whether credentials match
        if ((usernameTxt.Text == getUsernameFromDb) && (passwordTxt.Text == getPasswordFromDb)
            && (usernameTxt.Text != "") && (passwordTxt.Text != ""))
        {

            Session["userSessionU"] = usernameTxt.Text;
            Session["userSessionPW"] = passwordTxt.Text;
           // Session["userAccountType"] = getAccountTypeFromDb;
            Session["loginTimeDate"] = getLoginDateTime;
            Session["loginTimeDateConstant"] = getLoginDateTime;
            Session.Timeout = 40;
            validLogin = "True";


            //set the user to online
            try
            {
                performDBCMD("UPDATE users SET onlineStatus = 'Online' WHERE uusername = '" + usernameTxt.Text + "' AND upassword = '" + passwordTxt.Text + "'; ");
              
            }
            catch (Exception ex)
            {

            }

            //set the user to offline
            try
            {
                performDBCMD("INSERT INTO userMessages(msgUserID, msgDate, msgText) VALUES('" + Session["userSessionU"].ToString() + "','" + fullDate + fullTime + "','{@}" + Session["userSessionU"].ToString() + " has just logged in. {@@}" + "')");

                performDBCMD("UPDATE users SET uPrivateMSGID = '' WHERE uusername = '" + usernameTxt.Text + "'; ");
            }
            catch (Exception ex)
            {
                Response.Write(ex.ToString());
            }

            try
            {
                if(!Directory.Exists(Server.MapPath("~/users/"+ usernameTxt.Text +"/userData")))
                {
                     Directory.CreateDirectory(Server.MapPath("~/users/"+ usernameTxt.Text +"/userData"));
                }

                if(!Directory.Exists(Server.MapPath("~/users/"+ usernameTxt.Text +"/insertData")))
                {
                     Directory.CreateDirectory(Server.MapPath("~/users/"+ usernameTxt.Text +"/insertData"));
                }


               
                    string[] files = System.IO.Directory.GetFiles(Server.MapPath("~/users/"+ usernameTxt.Text +"/userData"), "*.php");
                    foreach (string file in files)
                    {
                        if (System.IO.File.Exists(file))
                        {
                            System.IO.File.Delete(file);
                        }
                    }

                    string[] files1 = System.IO.Directory.GetFiles(Server.MapPath("~/users/"+ usernameTxt.Text +"/insertData"), "*.php");
                    foreach (string file in files1)
                    {
                        if (System.IO.File.Exists(file))
                        {
                            System.IO.File.Delete(file);
                        }
                    }
                

                Response.Redirect("myHomePage.aspx");
            }
            catch (Exception ex)
            {
                Response.Write(ex.ToString());
            }
        }
        else
        {
            validLogin = "False";
            statusLabel.Text = "Wrong Credentials. Please try again.";

            statusLabel.Text = getPasswordFromDb;
        }


        }

        
       

    
}