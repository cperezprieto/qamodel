using System;
using System.Data;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Issue : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.User.Identity.IsAuthenticated)
        {
            Response.Redirect("Account/login.aspx");
        }

        SqlDataSourceIssue.SelectCommand = "SELECT * FROM aspnet_Errors WHERE ErrorId='" + Request.QueryString["IssId"] + "'";
    }    
    
    protected void btReturn_Click(object sender, EventArgs e)
    {
        if (Request.QueryString["Sender"].Equals("Issues"))
            Response.Redirect("Issues.aspx?AppId=" + Request.QueryString["AppId"] + "&RelId=" + Request.QueryString["RelId"]);
        else
            Server.Transfer("Release.aspx?RelId=" + Request.QueryString["RelId"] + "&AppId=" + Request.QueryString["AppId"]);
    }
    
    protected void ReleaseFormView_DataBound(object sender, EventArgs e)
    {

    }
    protected void btViewAssignmentHistory_Click(object sender, EventArgs e)
    {
        if (btViewAssignmentHistory.Text == "Show")
        {
            btViewAssignmentHistory.Text = "Hide";
            SqlDataSource3.SelectCommand = "SELECT * FROM aspnet_ErrorStates WHERE ErrorId='" + Request.QueryString["IssId"] + "'";
            GridView1.DataBind();
        }
        else
        {
            btViewAssignmentHistory.Text = "Show";
            SqlDataSource3.SelectCommand = "";
            GridView1.DataBind();
        }

        MoveBottom();
        
    }    

    protected void GridView1_Sorting(object sender, GridViewSortEventArgs e)
    {
        SqlDataSource3.SelectCommand = "Select * FROM aspnet_ErrorStates where ErrorId='" + Request.QueryString["IssId"] + "'";
        GridView1.DataBind();
        MoveBottom();
    }    

    protected void MoveBottom()
    {
        string script = @"<script type='text/javascript'>window.scrollTo(0, document.body.scrollHeight);</script>";

        ScriptManager.RegisterStartupScript(this, typeof(Page), "invocarfuncion", script, false);
    }
    protected void EditButton_Click(object sender, EventArgs e)
    {
        ModalEditIssue.Visible = true;
    }
    protected void CloseButton_Click(object sender, EventArgs e)
    {
        ModalEditIssue.Visible = false;
    }
}
