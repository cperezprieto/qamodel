using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Issues : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void ListBox1_SelectedIndexChanged(object sender, EventArgs e)
    {
        string queryString = "SELECT aspnet_Releases.* FROM aspnet_Releases";
        if (!ListBox1.SelectedValue.Equals("0"))
        {
             queryString = queryString + " where ApplicationId = '" + ListBox1.SelectedValue + "'";            
        }       

        SqlReleases.SelectCommand = queryString;
        ListBox2.Items.Clear();
        ListBox2.Items.Insert(0, new ListItem("All","0"));
        ListBox2.SelectedIndex = 0;
        ListBox2.DataBind();
        ListBox2_SelectedIndexChanged(this, e);
    }

    protected void ListBox2_SelectedIndexChanged(object sender, EventArgs e)
    {
        string queryString = "SELECT vw_Errors_ErrorStates.* FROM vw_Errors_ErrorStates";
        if (ListBox1.SelectedValue.Equals("0"))
        {
            if (ListBox2.SelectedValue.Equals("0"))
            {
                queryString = queryString + " WHERE ErrorFoundRelease IN (Select ReleaseId FROM aspnet_Releases) OR ErrorResolvedRelease IN (Select ReleaseId FROM aspnet_Releases)";
            }
            else
            {
                queryString = queryString + " WHERE ErrorFoundRelease = '" + ListBox2.SelectedValue + "' OR ErrorResolvedRelease = '" + ListBox2.SelectedValue + "'";
            }

        }
        else
        {
            if (ListBox2.SelectedValue.Equals("0"))
            {
                queryString = queryString + " WHERE ErrorFoundRelease IN (Select ReleaseId FROM aspnet_Releases WHERE ApplicationId ='" + ListBox1.SelectedValue +"') OR ErrorResolvedRelease IN (Select ReleaseId FROM aspnet_Releases WHERE ApplicationId ='" + ListBox1.SelectedValue +"')";
            }
            else
            {
                queryString = queryString + " where ErrorFoundRelease = '" + ListBox2.SelectedValue + "' OR ErrorResolvedRelease = '" + ListBox2.SelectedValue + "'";
            }
        }
        
        SqlDataSource2.SelectCommand = queryString;
        GridView1.DataBind();
    }
   
    protected void ListBox1_DataBound(object sender, EventArgs e)
    {
        String SourceAppId = Request.QueryString["AppId"];
        if (SourceAppId != null)
        {
            ListBox1.SelectedValue = SourceAppId;
            ListBox1_SelectedIndexChanged(ListBox1, e);
        }
    }

    protected void ListBox2_DataBound(object sender, EventArgs e)
    {
        String SourceRelId = Request.QueryString["RelId"];
        if (SourceRelId != null)
        {
            ListBox2.SelectedValue = SourceRelId;
            ListBox2_SelectedIndexChanged(ListBox2, e);
        }
    }

    protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
    {
        Server.Transfer("Issue.aspx?IssId=" + GridView1.SelectedRow.Cells[0].Text + "&AppId=" + ListBox1.SelectedValue + "&RelId=" + ListBox2.SelectedValue + "&Sender=Issues");   
    }
    protected void GridView1_DataBound(object sender, EventArgs e)
    {
        
    }
    protected void btReturn_Click(object sender, EventArgs e)
    {
        Response.Redirect("Applications.aspx");
    }
}
