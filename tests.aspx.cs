using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


public partial class tests : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

       
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
         Label1.Text = "yo face";

        try{
        var file = new List<string>(System.IO.File.ReadAllLines(Server.MapPath("~/data.php")));
        file.RemoveAt(0);
        File.WriteAllLines(Server.MapPath("~/data.php"), file.ToArray());
        }
        catch(Exception ex)
        {
             

        }

        using (StreamWriter testData = new StreamWriter(Server.MapPath("~/data.php"), true))
        {
            testData.WriteLine("<?php echo \"  " + lbl3.Value + " \"; ?>"); // Write the file.
        } 
    }
}