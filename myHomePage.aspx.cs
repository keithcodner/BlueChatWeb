using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Text;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.IO;

using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;
using System.Web.Security;
using System.Net.Mail;




public partial class myHomePage : System.Web.UI.Page
{
    static string getTheContactList;
    static string getMessages;
    static string getPrivateMessages;
    static string getLoginDateTime;
    static string getFirstLoginTimeDate;
    static string _callBackStatus;
    static string[] globalContactArray;
    static int gets;
    static string checkAlert;
    static string getMyPrivateMsgID;
    static string doIRefresh;
   

    protected void Page_Load(object sender, EventArgs e)
    {
        //Session
        if (Session["userSessionU"] == null)
        {
            Response.Redirect("blueChatLogin.aspx");
        }
        else
        {
            welcomeName.Text = Session["userSessionU"].ToString();
        }


        try
        {
            lbl1.Value = Session["thisIsATest"].ToString();
        }
        catch (Exception ex)
        {
            
            
        }
       
        notification.Visible = false;
        //Visuals for block screen
        //blockScreen.Attributes.CssStyle.Add("opacity", "0.6");
        blockScreen.Style.Add("width", "100%");
        blockScreen.Style.Add("height", "100%");

        newChatWindow.Visible = false;

        //this will not change, the first time/date the user logs in
        getFirstLoginTimeDate = Session["loginTimeDateConstant"].ToString();

        if (Session["alertCheck"] != null)
        {
            checkingAlert.Text = Session["alertCheck"].ToString();
        }

        //if in private change make the chat window visiable at all times
        if ((Session["inPrivate"] == "true") && (Session["inPrivate"] != null))
        {
            try
            {
                //put ur partners username in the chat window
                getEndUserName.Text = Session["keepTrackOfYourPartner"].ToString();
                notification.Visible = false;

                //************************************************************
                //************************************************************
                //****get message for private chat
                getMyPrivateMsgID = fetchFromDB("SELECT uPrivateMsgID FROM users WHERE uusername = '" + welcomeName.Text + "'");

                //get the messages
                try
                {
                    getPrivateMessages = fetchFromDB("SELECT  GROUP_CONCAT(msgText ORDER BY msgDate ASC SEPARATOR '~') FROM userMessages WHERE msgDate BETWEEN '" + Session["loginTimeDate"].ToString() + "' AND NOW() AND (msgPrivate = 'Yes' AND msgPrivateMsgID = '" + getMyPrivateMsgID + "') ;");

                    getAllMyPrivateText.Text = getPrivateMessages;

                    // test.Text = getMessages;
                }
                catch (Exception ex)
                {

                    // Response.Write(ex.ToString());
                }





            }
            catch (Exception ex) { }
            //update ooo users ucoming alert to null
            performDBCMD("UPDATE users SET uIncomingAlert='No' WHERE uusername = '" + welcomeName.Text + "' ;");

            Session["alertCheck"] = false;


        }
        else
        {

        }

        if (Session["userSessionU"] != null)
        {

            performDBCMD("UPDATE bluechat.users SET onlineStatus = 'Online' WHERE uusername = '" + Session["userSessionU"].ToString() + "';");

        }

        getTheContactList = fetchFromDB("SELECT  GROUP_CONCAT(uusername ORDER BY uusername ASC SEPARATOR ',') FROM users WHERE onlineStatus = 'Online';");



        try
        {
            //separate the list and put it into an arrays
            char[] splitOn = { ',' };
            //split the string into a array
            string[] contactArray = getTheContactList.Split(splitOn);

            globalContactArray = contactArray;

            //the not is postback if clause is was solved the double click listbox issue
            //can now star the open chat window one on one user interface
            if (!IsPostBack)
            {
                //populate the listbox
                getContacts.DataSource = contactArray;
                getContacts.DataBind();
            }

        }
        catch (Exception ex)
        {

        }
        ////////////////////////////////////////////////////////////////////
        /////////////////////////////////////////////////////////////////////
        ////////////////////////////////////////////////////////////////////////

        //Response.Write(Session["loginTimeDate"].ToString());

        //get the messages

        getMessages = fetchFromDB("SELECT  GROUP_CONCAT(msgText ORDER BY msgDate ASC SEPARATOR '~') FROM userMessages WHERE msgDate BETWEEN '" + Session["loginTimeDate"].ToString() + "' AND NOW() AND msgPrivate = 'null' ;");


        try
        {
            //*********** this works
            getAllText.Text = getMessages;
            getMessages = getMessages.Replace("~", "\n");

            //this stuff is needed tho
            Label1.Text = getMessages;



        }
        catch (Exception)
        {


        }


        /////////////////////////////////////////////////////////////
        //////////////Double Click list box

        getContacts.Attributes.Add("ondblClick", "{document.getElementById('" + BtnTwo.UniqueID + "').click();return false; } ");



        //////////////////////////////////////////////
        ////show the chat window
        try
        {
            string didUserInitiateChat = Session["oneOnoneChat"].ToString();

            if (didUserInitiateChat == "true")
            {

                newChatWindow.Visible = true;
                getEndUserName.Text = Session["myPartner"].ToString() + "!";
            }
        }
        catch (Exception ez)
        {


        }

    }
    protected void Button1_Click(object sender, EventArgs e)
    {

        //////////////////////////////////////////////
        ////save chatWindow location positions
        try
        {
            ScriptManager.RegisterStartupScript(
                            null,
                            this.GetType(),
                            "MyActions",
                            "getDraggableDivAttr();",
                            true);

        }
        catch (Exception ex)
        {

        }


        string gotTopValue = topValue.Value;
        string getLeftValue = leftValue.Value;
        Session["cwTopValue"] = gotTopValue;
        Session["cwLeftValue"] = getLeftValue;



        //////////////////////////////////////////


        if (msgUserText.Text.Length == 0)
        {
            //////////////////////////////////////////////
            ////save chatWindow location positions
            try
            {
                ScriptManager.RegisterStartupScript(
                                null,
                                this.GetType(),
                                "MyActions",
                                "getDraggableDivAttr();",
                                true);

            }
            catch (Exception ex)
            {

            }


            string gotTopValues = topValue.Value;
            string getLeftValues = leftValue.Value;
            Session["cwTopValue"] = gotTopValue;
            Session["cwLeftValue"] = getLeftValue;
            Response.Redirect("myHomePage.aspx");
        }
        else
        {
            // Response.Write("gets this far");
            //get date and time
            String years = DateTime.Now.Year.ToString();
            String months = DateTime.Now.Month.ToString();
            String days = DateTime.Now.Day.ToString();
            String hours = DateTime.Now.Hour.ToString();
            String mins = DateTime.Now.Minute.ToString();
            String secs = DateTime.Now.Second.ToString();
            String fullDate = years + "-" + months + "-" + days + " ";
            String fullTime = hours + ":" + mins + ":" + secs;


            //set the user to offline
            performDBCMD("INSERT INTO userMessages(msgUserID, msgDate, msgText) VALUES('" + Session["userSessionU"].ToString() + "','" + fullDate + fullTime + "','{}" + Session["userSessionU"].ToString() + ":{{ " + msgUserText.Text.Replace("'", "''").Replace("~", "!") + "')");


            //Label1.Text = Label1.Text + "\n" + Session["userSessionU"].ToString() + ": " + msgUserText.Text.Replace("'", "''");
            // msgUserText.Text = "";
            Response.Redirect("myHomePage.aspx");




        }
    }
    protected void logoutBtn_Click1(object sender, EventArgs e)
    {


        //set the user to offline
        performDBCMD("UPDATE users SET onlineStatus = 'Offline' WHERE uusername = '" + Session["userSessionU"].ToString() + "' AND upassword = '" + Session["userSessionPW"].ToString() + "'; ");

       
        // getCurrentUserMsg.Items.Clear();

        Session.Remove("loginTimeDate");
        Session.Remove("userSessionU");
        //kill all sessions
        Session.Contents.RemoveAll();
        if (Session["userSessionU"] == null)
        {
            
            Response.Redirect("blueChatLogin.aspx");
        }
    }
    protected void Button2_Click(object sender, EventArgs e)
    {
        Label1.Text = TextBox3.Text;
    }
    protected void Label1_TextChanged(object sender, EventArgs e)
    {

    }
    protected void Timer1_Tick(object sender, EventArgs e)
    {
        //check if there are any incoming alerts
        try
        {

            checkAlert = fetchFromDB("SELECT uIncomingAlert FROM users WHERE uusername = '" + welcomeName.Text + "';");

            if (checkAlert == "No")
            {
                Session["alertCheck"] = "false";
                checkingAlert.Text = "false";

                Session["counter"] = "1";
                notification.Visible = false;
            }
            else
            {
                alertName.Text = checkAlert + " ";
                checkingAlert.Text = "true";
                Session["alertCheck"] = "true";
                notification.Visible = true;

                string counterCheck = Session["counter"].ToString();

                if (counterCheck == "1")
                {
                    doIRefresh = "true";
                }
                

            }
        }
        catch (Exception ex)
        {
            Response.Write(ex.ToString());
        }



        //////////////////////////////////////////////
        ////save chatWindow location positions
        try
        {
            ScriptManager.RegisterStartupScript(
                            null,
                            this.GetType(),
                            "MyActions",
                            "getDraggableDivAttr();",
                            true);

        }
        catch (Exception ex)
        {

        }


        string gotTopValue = topValue.Value;
        string getLeftValue = leftValue.Value;
        Session["cwTopValue"] = gotTopValue;
        Session["cwLeftValue"] = getLeftValue;


        try
        {
            getContacts.SelectedIndex = int.Parse(Session["abc"].ToString());
        }
        catch (Exception ex)
        {

        }


        //populate the listbox
        getContacts.DataSource = globalContactArray;
        getContacts.DataBind();






        //dont know why but this stopes the text in the text box from disappearing
        string b;
        b = msgUserText.Text;
        Response.Write(b.ToString());





        try
        {

            //get the messages
            getMessages = fetchFromDB("SELECT  GROUP_CONCAT(msgText ORDER BY msgDate ASC SEPARATOR '~') FROM userMessages WHERE msgDate BETWEEN '" + Session["loginTimeDate"].ToString() + "' AND NOW() AND msgPrivate = 'null';");

            getAllText.Text = getMessages;
            // test.Text = getMessages;

        }
        catch (Exception ex)
        {

            // Response.Write(ex.ToString());
        }



        // this runs the javascript, running the text generator, every time the tick event fires
        try
        {
            ScriptManager.RegisterStartupScript(
                            UpdatePanel2,
                            this.GetType(),
                            "MyActionaaaaa",
                            "getTextGenerator();",
                            true);

        }
        catch (Exception ex)
        {

        }

        performDBCMD("UPDATE bluechat.users SET onlineStatus = 'Online' WHERE uusername = '" + Session["userSessionU"].ToString() + "';");


        if (getContacts.SelectedIndex.ToString() != null)
        {
            Session["getContactsIndex"] = getContacts.SelectedIndex.ToString();
            //Response.Write(Session["getContactsIndex"].ToString());
            getContacts.SelectedIndex = int.Parse(Session["getContactsIndex"].ToString());
        }

        if(doIRefresh == "true")
        {
                doIRefresh = "false";
                Session["counter"] = "0";
                Response.Redirect("myHomePage.aspx");
               // Response.AddHeader("REFRESH", "2;URL=myHomePage.aspx");
               // UpdatePanel2.Update();
               // ScriptManager.RegisterStartupScript(null, this.GetType(), "v", "refreshs();", true);  
        }

    }
    protected void Timer3_Tick(object sender, EventArgs e)
    {

        string b;
        b = OOOMsg.Text;
        Response.Write(b.ToString());

        string myCurrentPartner = Session["keepTrackOfYourPartner"].ToString();

        getMyPrivateMsgID = fetchFromDB("SELECT uPrivateMsgID FROM users WHERE uusername = '" + welcomeName.Text + "'");

        //get the messages
        try
        {
            getPrivateMessages = fetchFromDB("SELECT  GROUP_CONCAT(msgText ORDER BY msgDate ASC SEPARATOR '~') FROM userMessages WHERE msgDate BETWEEN '" + Session["loginTimeDate"].ToString() + "' AND NOW() AND (msgPrivate = 'Yes' AND msgPrivateMsgID = '" + getMyPrivateMsgID + "') ;");

            getAllMyPrivateText.Text = getPrivateMessages;

            // test.Text = getMessages;
        }
        catch (Exception ex)
        {

            Response.Write(ex.ToString());
        }




        // this runs the javascript, running the text generator, every time the tick event fires
        try
        {
            ScriptManager.RegisterStartupScript(
                            OOOUP,
                            this.GetType(),
                            "MyActionaaaaa",
                            "getTextGeneratorTwo();",
                            true);

        }
        catch (Exception ex)
        {

        }
    }
    protected void Timer2_Tick(object sender, EventArgs e)
    {

    }
    protected void BtnOne_Click1(object sender, EventArgs e)
    {
        //////////////////////////////////////////////
        ////save chatWindow location positions
        try
        {
            ScriptManager.RegisterStartupScript(
                            null,
                            this.GetType(),
                            "MyActions",
                            "getDraggableDivAttr();",
                            true);

        }
        catch (Exception ex)
        {

        }

        string gotTopValue = topValue.Value;
        string getLeftValue = leftValue.Value;
        Session["cwTopValue"] = gotTopValue;
        Session["cwLeftValue"] = getLeftValue;

        //initiate to retrieve chat for user that initially started chat
        //******TEST*******WORKING FORN NOW
        //makes chat window present at each page load
        Session["inPrivate"] = "true";
        //set the visibility of chat window true
        Session["oneOnoneChat"] = "true";
        //sets the name of the partners into a session
        Session["keepTrackOfYourPartner"] = alertName.Text;
        Session["alertCheck"] = "true";
        notification.Visible = false;



        try
        {
            int _callBackStatus = getContacts.SelectedIndex;

            //Response.Write(getContacts.SelectedItem.ToString());
            getEndUserName.Text = getContacts.SelectedItem.ToString();
            Session["myPartner"] = getEndUserName.Text;

            if (getEndUserName.Text == welcomeName.Text)
            {
                try
                {
                    ScriptManager.RegisterStartupScript(
                                    null,
                                    this.GetType(),
                                    "sameUsers",
                                    "sameUser();",
                                    true);

                }
                catch (Exception ex)
                {

                }
            }
            else
            {
                //update ooo users ucoming alert
                performDBCMD("UPDATE users SET uIncomingAlert='" + welcomeName.Text + "' WHERE uusername = '" + getEndUserName.Text + "' ;");

                Session["oneOnoneChat"] = "true";
                Response.Redirect("myhomePage.aspx");
            }


        }
        catch (Exception ex)
        {
            //  Response.Write(ex.ToString());
        }
    }
    protected void BtnTwo_Click2(object sender, EventArgs e)
    {
        try
        {
            //get the double click name from the listbox
            getEndUserName.Text = getContacts.SelectedItem.ToString();


            if (getEndUserName.Text == welcomeName.Text)
            {
                try
                {
                    ScriptManager.RegisterStartupScript(null, this.GetType(), "sameUsers", "sameUser();", true);
                   
                }
                catch (Exception ex)
                {

                }
            }
            else
            {
                string busy = fetchFromDB("SELECT uIncomingAlert FROM users WHERE  uusername = '" + getEndUserName.Text + "'; ");
                // Response.Write(busy );
                //update ooo users ucoming alert
                if (busy == "No")
                {
                    //get my requester
            
            //get rid of the notificatoion
            
            //change alert to default value
            

            //get prev private chat ID's to append for me and my partner

            string myPrivateMsgIDs = fetchFromDB("SELECT uprivatemsgid FROM users WHERE uusername = '" + welcomeName.Text + "';");

            string myPartnerPrivateMsgIDs = fetchFromDB("SELECT uprivatemsgid FROM users WHERE uusername = '" + getEndUserName.Text + "';");

            
            /* THIS METHOD OF PRIVATE MESSAGE IDS IS NOT CONISTANT, METHOD OF USE WILL BE REQESTERS NAME THEN THE REQUESTED, WITH A DASH IN BETWEEN THEM, THIS SHOULD MAKE UNIQUE AND CONSITANT KEYS
            /////////////////////////////////////////////////////////
            //private msg operation
            //1.get the highest number from the message
            string getPCID = fetchFromDB("SELECT value2 FROM config WHERE configID = '3';");
            //2.convert the string to an int
            int convertToInt = int.Parse(getPCID.ToString());
            //3.increment the int
            convertToInt++;
            //4. convert back to string
            string incrementedGetHighestNum = convertToInt.ToString();
            //5. update both the source and destination users
            performDBCMD("UPDATE config SET value2 = '" + incrementedGetHighestNum.ToString() + "' WHERE configID='3';");

            */

            /////////////////////////////////////////////////////////
            //appending operation
            string getLastPMID = welcomeName.Text + "-" + getEndUserName.Text ;           
            privateChatIDHF.Value = getLastPMID;

            //right below this comment is the private chat id but with the requested users username
            //myPrivateMsgIDs =   myPrivateMsgIDs + "*" + incrementedGetHighestNum + "-" + welcomeName.Text;
            myPartnerPrivateMsgIDs = myPartnerPrivateMsgIDs + "*" + welcomeName.Text + "-" + getEndUserName.Text;

            //update the two users with the incremented private msg id's
            performDBCMD("UPDATE users SET uPrivateMsgID = '" + myPartnerPrivateMsgIDs + "' WHERE uusername = '" + getEndUserName.Text + "'; UPDATE users SET uPrivateMsgID = '" + myPartnerPrivateMsgIDs + "' WHERE uusername = '" + welcomeName.Text + "';");


                    /////////////////////////////////////////////////////////
                    ////////////////////////////////////////////////////////////////


                    //privateChatIDHF
                    //string getPrivateChatID = 

                    // Response.Write("oooVerfied should have fired");
                    performDBCMD("UPDATE users SET uIncomingAlert='" + welcomeName.Text + "' WHERE uusername = '" + getEndUserName.Text + "' ;");
                    requestedName.Text = getEndUserName.Text;
                    Response.Write(requestedName.Text);


                    ScriptManager.RegisterStartupScript(this, this.GetType(), "a", "storeRequestedName();", true);
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "b", "myFunction();", true);
                    // requestedName.Text = "";
                    //create the php file

                    //get variables from client, split them and use them in custom php file/script for the window
                    string getWindowValue = hiddenWindowTemp.Value;
                    char[] splitForPhp = { ',' };           
                    string[] phpVaraibles = getWindowValue.Split(splitForPhp);
                    //beep.Text = phpVaraibles[0];

                    //create php file and assigning variables**************************************************

                    //for querying data
                    try{
                    var file = new List<string>(System.IO.File.ReadAllLines(Server.MapPath("~/users/" +welcomeName.Text + "/userData/"+phpVaraibles[0]+".php")));
                    file.RemoveAt(0);
                    File.WriteAllLines(Server.MapPath("~/users/" +welcomeName.Text + "/userData/"+phpVaraibles[0]+".php"), file.ToArray());
                    }
                    catch(Exception ex)
                    {
                         

                    }

                    //for inserting data
                    try
                    {
                        var file = new List<string>(System.IO.File.ReadAllLines(Server.MapPath("~/users/" + welcomeName.Text + "/insertData/" + phpVaraibles[0] + ".php")));
                        file.RemoveAt(0);
                        File.WriteAllLines(Server.MapPath("~/users/" + welcomeName.Text + "/insertData/" + phpVaraibles[0] + ".php"), file.ToArray());


                    }
                    catch (Exception ex)
                    {


                    }

                    //write the file for getting and querying data
            try
            {
           using (StreamWriter testData = new StreamWriter(Server.MapPath("~/users/" + welcomeName.Text + "/userData/" + phpVaraibles[0] + ".php"), true))
            {
                string start = "   $con=mysqli_connect(\"localhost\",\"root\",\"root\",\"bluechat\"); if (mysqli_connect_errno()) { echo \"Failed to connect to MySQL: \" . mysqli_connect_error(); }" +
                    " $result = mysqli_query($con,\"SELECT  GROUP_CONCAT(msgtext ORDER BY msgid ASC SEPARATOR \'~\') FROM usermessages WHERE msguserid = \'rford\'; \"); ";
                
               string end = "while($row = mysqli_fetch_array($result)){ echo $row[0]; } mysqli_close($con);";


                testData.WriteLine("<?php "+ start + end +" ?>"); // Write the file.
            }

             }
            catch (Exception ex)
            {


            }


            //write the file for inserting the data
            try
            {
           using (StreamWriter testData = new StreamWriter(Server.MapPath("~/users/" + welcomeName.Text + "/insertData/" + phpVaraibles[0] + ".php"), true))
            {
                //get the date and time 
                string start = " $a = date(\"d-m-y\", time());  $b = date(\"G:i:s\", time());   $timeDate = $a.\" \".$b;  "+

                //set up the sql connection and getting variables from post
                "$goingOutText = $_POST['goOutText']; $privateChatID = $_POST['PMID']; $getUName = '"+ welcomeName.Text +"'; $con=mysqli_connect(\"localhost\",\"root\",\"root\",\"bluechat\"); if (mysqli_connect_errno()) { echo \"Failed to connect to MySQL: \" . mysqli_connect_error();}    "+

                //modify the query
               "$sql=\"INSERT INTO userMessages (msgUserID, msgDate, msgText, msgPrivate, msgPrivateMsgID ) VALUES ('\".$getUName.\"','\".$timeDate.\"','\".$goingOutText.\"','Yes','\".$privateChatID.\"')\"   ";
                
                //rest of the php
               string end = "if (!mysqli_query($con,$sql)){ die('Error: ' . mysqli_error($con)); } mysqli_close($con); ";


                testData.WriteLine("<?php "+ start + end +" ?>"); // Write the file.
            }

             }
            catch (Exception ex)
            {


            }

                    Response.AddHeader("REFRESH", "0;URL=myHomePage.aspx");
                    // Response.Redirect("myHomePage.aspx");
                }
                else
                {
                    Response.Write("This user is busy with an invite, try again in a couple seconds.");

                    //this is the proper way to use the script manager...semi-colon is needed at the end*****************************************8
                    //ScriptManager.RegisterStartupScript(this, this.GetType(), "busyUser", "busyUser();", true);
                }

            }


        }
        catch (Exception ex)
        {

            Response.Write(ex.ToString());
        }
    }
    protected void multiChatClick_Click1(object sender, EventArgs e)
    {

        try
        {
            int _callBackStatus = getContacts.SelectedIndex;

            //Response.Write(getContacts.SelectedItem.ToString());
            getEndUserName.Text = getContacts.SelectedItem.ToString();


            if (getEndUserName.Text == welcomeName.Text)
            {
                try
                {
                    ScriptManager.RegisterStartupScript(null, this.GetType(), "sameUsers", "sameUser();", true);

                }
                catch (Exception ex)
                {

                }
            }
            else
            {
                string busy = fetchFromDB("SELECT uIncomingAlert FROM users WHERE  uusername = '" + getEndUserName.Text + "'; ");
                //update ooo users ucoming alert
                if (true)
                {
                    performDBCMD("UPDATE users SET uIncomingAlert='" + welcomeName.Text + "' WHERE uusername = '" + getEndUserName.Text + "' ;");


                    Response.Redirect("myhomePage.aspx");
                }
                else
                {
                    Response.Write("This user is busy with an invite, try again in a coi");
                }

            }


        }
        catch (Exception ex)
        {
            //  Response.Write(ex.ToString());
        }
    }
    protected void getContacts_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
    protected void anotherButton_Click(object sender, EventArgs e)
    {

        int _callBackStatus = getContacts.SelectedIndex;

        Response.Write(getContacts.SelectedItem.ToString());
        rl.Text = getContacts.SelectedItem.ToString();


    }
    protected void Button4_Click(object sender, EventArgs e)
    {
        try
        {
            //update ooo users ucoming alert
            // performDBCMD("UPDATE users SET uIncomingAlert='No' WHERE uusername = '" + Session["myPartner"].ToString() + "' ;");
            performDBCMD("UPDATE users SET uIncomingAlert='No' WHERE uusername = '" + welcomeName.Text + "' ;");

            Session["alertCheck"] = false;
            newChatWindow.Visible = false;
            //newChatWindow.Style.Add("z-index", "1");
            Session["oneOnoneChat"] = "false";
            Session["inPrivate"] = "false";
            Session.Remove("keepTrackOfYourPartner");
            Response.Redirect("myhomePage.aspx");

        }
        catch (Exception ex)
        {

        }

        getAllMyPrivateText.Text = "";
    }
    protected void acceptAlert_Click(object sender, EventArgs e)
    {

        //makes chat window present at each page load
        Session["inPrivate"] = "true";
        //set the visibility of chat window true
        Session["oneOnoneChat"] = "true";
        //sets the name of the partners into a session
        Session["keepTrackOfYourPartner"] = alertName.Text;
        Session["alertCheck"] = "true";
        notification.Visible = false;

        try
        {

            /////////////////////////////////////////////////////////
            //private msg operation
            //1.get the highest number from the message
            string getHighestNum = fetchFromDB("SELECT MAX(msgprivatemsgid) FROM usermessages;");
            //2.convert the string to an int
            int convertToInt = int.Parse(getHighestNum.ToString());
            //3.increment the int
            convertToInt++;
            //4. convert back to string
            string incrementedGetHighestNum = convertToInt.ToString();
            //5. update both the source and destination users


            //update the two users with the incremented private msg id's
            performDBCMD("UPDATE users SET uPrivateMsgID = '" + incrementedGetHighestNum + "' WHERE uusername = '" + Session["keepTrackOfYourPartner"].ToString() + "'; UPDATE users SET uPrivateMsgID = '" + incrementedGetHighestNum + "' WHERE uusername = '" + welcomeName.Text + "';");
        }
        catch (Exception ex)
        {

            Response.Write(ex.ToString());
        }


        Response.Redirect("myHomePage.aspx");


    }
    protected void alternantAcceptAlert_Click(object sender, EventArgs e)
    {

        try
        {
            string myRequester = fetchFromDB("SELECT uIncomingAlert FROM users WHERE uusername = '" + welcomeName.Text + "';");
            requesterName.Text = myRequester;
            notification.Visible = false;
            performDBCMD("UPDATE users SET uIncomingAlert = 'No' WHERE uusername='" + welcomeName.Text + "';");

            string getLastPMID  =  myRequester + "-" + welcomeName.Text; 
            privateChatIDHF.Value = getLastPMID;

            ScriptManager.RegisterStartupScript(this, this.GetType(), "d", "storeRequesterName();", true);
            ScriptManager.RegisterStartupScript(this, this.GetType(), "c", "myFunction();", true);


            //get the private msg id last******************************************************
            

            //get variables from client, split them and use them in custom php file/script for the window
            string getWindowValue = hiddenWindowTemp.Value;
            char[] splitForPhp = { ',' };
            string[] phpVaraibles = getWindowValue.Split(splitForPhp);
            //beep.Text = phpVaraibles[0];

            //create php file and assigning variables**************************************************

            //for querying and getting the data
            try
            {
                var file = new List<string>(System.IO.File.ReadAllLines(Server.MapPath("~/users/" + welcomeName.Text + "/userData/" + phpVaraibles[0] + ".php")));
                file.RemoveAt(0);
                File.WriteAllLines(Server.MapPath("~/users/" + welcomeName.Text + "/userData/" + phpVaraibles[0] + ".php"), file.ToArray());


            }
            catch (Exception ex)
            {


            }

            //for inserting data
            try
            {
                var file = new List<string>(System.IO.File.ReadAllLines(Server.MapPath("~/users/" + welcomeName.Text + "/insertData/" + phpVaraibles[0] + ".php")));
                file.RemoveAt(0);
                File.WriteAllLines(Server.MapPath("~/users/" + welcomeName.Text + "/insertData/" + phpVaraibles[0] + ".php"), file.ToArray());


            }
            catch (Exception ex)
            {


            }


            //write the file for querying and getting the data
            try
            {
           using (StreamWriter testData = new StreamWriter(Server.MapPath("~/users/" + welcomeName.Text + "/userData/" + phpVaraibles[0] + ".php"), true))
            {
                string start = "$con=mysqli_connect(\"localhost\",\"root\",\"root\",\"bluechat\"); if (mysqli_connect_errno()) { echo \"Failed to connect to MySQL: \" . mysqli_connect_error(); }" +
                    " $result = mysqli_query($con,\"SELECT  GROUP_CONCAT(msgtext ORDER BY msgid ASC SEPARATOR \'~\') FROM usermessages WHERE msguserid = \'rford\'; \"); ";
                
               string end = "while($row = mysqli_fetch_array($result)){ echo $row[0]; } mysqli_close($con);";


                testData.WriteLine("<?php "+ start + end +" ?>"); // Write the file.
            }

             }
            catch (Exception ex)
            {


            }

            //write the file for inserting the data
            try
            {
           using (StreamWriter testData = new StreamWriter(Server.MapPath("~/users/" + welcomeName.Text + "/insertData/" + phpVaraibles[0] + ".php"), true))
            {
                string start = " " +
                    " ";
                
               string end = "";


                testData.WriteLine("<?php "+ start + end +" ?>"); // Write the file.
            }

             }
            catch (Exception ex)
            {


            }

            

        }
        catch (Exception ex)
        {

            Response.Write(ex.ToString());
        }
        // Response.AddHeader("REFRESH", "2;URL=myHomePage.aspx");
    }
    protected void declineAlert_Click(object sender, EventArgs e)
    {
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


        //set the user to offline
        performDBCMD("INSERT INTO userMessages(msgUserID, msgDate, msgText, msgPrivate, msgPrivateMsgID) VALUES('" + Session["userSessionU"].ToString() + "','" + fullDate + fullTime + "','{@}" + welcomeName.Text + " has declined your invite. {@@}" + "', 'Yes' ,'" + getMyPrivateMsgID + "')");

        //update ooo users ucoming alert to null
        performDBCMD("UPDATE users SET uIncomingAlert='No' WHERE uusername = '" + welcomeName.Text + "' ;");

        Session["alertCheck"] = "false";

        Response.Redirect("myHomePage.aspx");
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
    protected void privateChatBtn_Click1(object sender, EventArgs e)
    {
        //////////////////////////////////////////////
        ////save chatWindow location positions
        try
        {
            ScriptManager.RegisterStartupScript(
                            null,
                            this.GetType(),
                            "MyActionzzzs",
                            "getDraggableDivAttr();",
                            true);

        }
        catch (Exception ex)
        {

        }


        string gotTopValue = topValue.Value;
        string getLeftValue = leftValue.Value;
        Session["cwTopValues"] = gotTopValue;
        Session["cwLeftValues"] = getLeftValue;

        //************************************************


        //*************************************************

        if (OOOMsg.Text.Length == 0)
        {
            //////////////////////////////////////////////
            ////save chatWindow location positions
            try
            {
                ScriptManager.RegisterStartupScript(
                                null,
                                this.GetType(),
                                "MyActionsza",
                                "getDraggableDivAttr();",
                                true);

            }
            catch (Exception ex)
            {

            }


            string gotTopValues = topValue.Value;
            string getLeftValues = leftValue.Value;
            Session["cwTopValues"] = gotTopValue;
            Session["cwLeftValues"] = getLeftValue;
            Response.Redirect("myHomePage.aspx");
        }
        else
        {
            // Response.Write("gets this far");
            //get date and time
            String years = DateTime.Now.Year.ToString();
            String months = DateTime.Now.Month.ToString();
            String days = DateTime.Now.Day.ToString();
            String hours = DateTime.Now.Hour.ToString();
            String mins = DateTime.Now.Minute.ToString();
            String secs = DateTime.Now.Second.ToString();
            String fullDate = years + "-" + months + "-" + days + " ";
            String fullTime = hours + ":" + mins + ":" + secs;


            //set the user to offline
            performDBCMD("INSERT INTO userMessages(msgUserID, msgDate, msgText, msgPrivate, msgPrivateMsgID) VALUES('" + Session["userSessionU"].ToString() + "','" + fullDate + fullTime + "','{}" + Session["userSessionU"].ToString() + ":{{ " + OOOMsg.Text.Replace("'", "''").Replace("~", "!") + "','Yes' ,'" + getMyPrivateMsgID + "')");


            //Label1.Text = Label1.Text + "\n" + Session["userSessionU"].ToString() + ": " + msgUserText.Text.Replace("'", "''");
            // msgUserText.Text = "";
            Response.Redirect("myHomePage.aspx");




        }
    }
public int getRandomID ()

{

Random r = new Random();

return r.Next(10000,99999);

}



    protected void thisTest_Click(object sender, EventArgs e)
    {
        /*
        ScriptManager.RegisterStartupScript(this, this.GetType(), "g", "getTextAreaID();", true);
        string gotTextAreaID = getTextAreaID.Text;
        Response.Write(gotTextAreaID);
        //ScriptManager.RegisterStartupScript(this, this.GetType(), "f", "sendTextToServer();", true);
        */
        if (lbl1.Value != "")
        {
            performDBCMD("UPDATE config SET Value2 = '" + lbl1.Value + "' WHERE configID = 4; ");
        }
        else if (lbl2.Value != "")
        {
            performDBCMD("UPDATE config SET Value2 = '" + lbl2.Value + "' WHERE configID = 4; ");
        }
        else if (lbl3.Value != "")
        {
            performDBCMD("UPDATE config SET Value2 = '" + lbl3.Value + "' WHERE configID = 4; ");
        }
        else if (lbl4.Value != "")
        {
            performDBCMD("UPDATE config SET Value2 = '" + lbl4.Value + "' WHERE configID = 4; ");
        }
        else if (lbl5.Value != "")
        {
            performDBCMD("UPDATE config SET Value2 = '" + lbl5.Value + "' WHERE configID = 4; ");
        }
        else if (lbl6.Value != "")
        {
            performDBCMD("UPDATE config SET Value2 = '" + lbl6.Value + "' WHERE configID = 4; ");
        }
        else
        {
             Response.Write("Did absolutely nothing!");
        }

        Response.Write(lbl1.Value + ", " + lbl2.Value + ", " + lbl3.Value + ", " + lbl4.Value + ", " + lbl5.Value + ", " + lbl6.Value);
        
    }
}