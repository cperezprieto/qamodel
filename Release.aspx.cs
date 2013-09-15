﻿using System;
using System.Data;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Release : System.Web.UI.Page
{    
    protected void Page_Load(object sender, EventArgs e)
    {
        
    }
    protected void ListBox1_SelectedIndexChanged(object sender, EventArgs e)
    {
        string queryString = "SELECT aspnet_Releases.* FROM aspnet_Releases";
        if (!ListBox1.SelectedValue.Equals("0"))
        {
            queryString = queryString + " where aspnet_Releases.ReleaseId = '" + ListBox1.SelectedValue + "'";
        }
        colapseAll();
    }
   
    protected void ListBox1_DataBound(object sender, EventArgs e)
    {
        String SourceRelId = Request.QueryString["RelId"];
        if (SourceRelId != null)
        {
            ListBox1.SelectedValue = SourceRelId;
            ListBox1_SelectedIndexChanged(ListBox1,e);
        }
    }

    protected void ReleaseFormView_Load(object sender, EventArgs e)
    {
        if (divInformation.Visible)
        {
            string actualRelease = ListBox1.SelectedValue;

            if (actualRelease.Equals(""))
            {
                actualRelease = Request.QueryString["RelId"];
            }
            SqlDataSourceReleaseInformation.SelectCommand = "SELECT * FROM vw_AllReleasesErrorsCounters WHERE vw_AllReleasesErrorsCounters.ReleaseId = '" + actualRelease + "'";
        }
    }

    protected void ReturnButton_Click(object sender, EventArgs e)
    {
        Response.Redirect("Releases.aspx?&AppId=" + Request.QueryString["AppId"]);
    }

    protected void EditButton_Click(object sender, EventArgs e)
    {
        if(ReleaseFormView.Enabled == false)
        {
            ReleaseFormView.Enabled = true;
            EditButton.Text = "&nbsp;Cancel&nbsp;";
        }
        else
        {
            ReleaseFormView.Enabled = false;
            EditButton.Text = "&nbsp;Edit&nbsp;";
        }
    }

    protected void ReleaseFormView_DataBound(object sender, EventArgs e)
    {

    }

    protected void colapseAll()
    {
        btViewRequirements.Text = "Show";
        SqlDataSource3.SelectCommand = "";
        GridView1.EmptyDataText = "";
        GridView1.DataBind();

        btViewErrorsFound.Text = "Show";
        SqlDataSource4.SelectCommand = "";
        GridView2.EmptyDataText = "";
        GridView2.DataBind();

        btViewErrorsResolved.Text = "Show";
        SqlDataSource5.SelectCommand = "";
        GridView3.EmptyDataText = "";
        GridView3.DataBind();
    }

    protected void btViewRequirements_Click(object sender, EventArgs e)
    {        
        if (btViewRequirements.Text == "Show")
        {
            btViewRequirements.Text = "Hide";
            SqlDataSource3.SelectCommand = "Select * FROM aspnet_Requirements where ReleaseId='" + ListBox1.SelectedValue + "'";
            GridView1.EmptyDataText = "No data";
            GridView1.DataBind();
        }
        else
        {
            btViewRequirements.Text = "Show";
            SqlDataSource3.SelectCommand = "";
            GridView1.EmptyDataText = "";
            GridView1.DataBind();
        }

        MoveBottom();
        
    }
    protected void btViewErrorsFound_Click(object sender, EventArgs e)
    {        
        if (btViewErrorsFound.Text == "Show")
        {
            btViewErrorsFound.Text = "Hide";
            SqlDataSource4.SelectCommand = "SELECT * FROM vw_Errors_ErrorStates WHERE ErrorFoundRelease='" + ListBox1.SelectedValue + "' or ErrorResolvedRelease='" + ListBox1.SelectedValue + "'";
            GridView2.EmptyDataText = "No data";
            GridView2.DataBind();
        }
        else
        {
            btViewErrorsFound.Text = "Show";
            SqlDataSource4.SelectCommand = "";
            GridView2.EmptyDataText = "";
            GridView2.DataBind();
        }

        MoveBottom();
        
    }

    protected void btViewErrorsResolved_Click(object sender, EventArgs e)
    {
        if (btViewErrorsResolved.Text == "Show")
        {
            btViewErrorsResolved.Text = "Hide";
            SqlDataSource5.SelectCommand = "SELECT * FROM vw_Errors_ErrorStates WHERE ErrorResolvedRelease='" + ListBox1.SelectedValue + "'";
            GridView3.EmptyDataText = "No data";
            GridView3.DataBind();
        }
        else
        {
            btViewErrorsResolved.Text = "Show";
            SqlDataSource5.SelectCommand = "";
            GridView3.EmptyDataText = "";
            GridView3.DataBind();
        }
        
        MoveBottom();
    }

    protected void GridView1_Sorting(object sender, GridViewSortEventArgs e)
    {
        SqlDataSource3.SelectCommand = "Select * FROM aspnet_Requirements where ReleaseId='" + ListBox1.SelectedValue + "'";
        MoveBottom();
    }
    protected void GridView2_Sorting(object sender, GridViewSortEventArgs e)
    {
        SqlDataSource4.SelectCommand = "SELECT * FROM vw_Errors_ErrorStates WHERE ErrorFoundRelease='" + ListBox1.SelectedValue + "'";        
        MoveBottom();
    }
   
    protected void GridView3_Sorting(object sender, GridViewSortEventArgs e)
    {
        SqlDataSource5.SelectCommand = "SELECT * FROM vw_Errors_ErrorStates WHERE ErrorResolvedRelease='" + ListBox1.SelectedValue + "'";
        MoveBottom();
    }

    protected void GridView2_SelectedIndexChanged(object sender, EventArgs e)
    {
        Server.Transfer("Issue.aspx?IssId=" + GridView2.SelectedRow.Cells[0].Text + "&RelId=" + ListBox1.SelectedValue + "&AppId=" + Request.QueryString["AppId"] + "&Sender=Release");
    }

    protected void GridView3_SelectedIndexChanged(object sender, EventArgs e)
    {
        Server.Transfer("Issue.aspx?IssId=" + GridView3.SelectedRow.Cells[0].Text + "&RelId=" + ListBox1.SelectedValue + "&AppId=" + Request.QueryString["AppId"] + "&Sender=Release");
    }

    protected void MoveBottom()
    {
        string script = @"<script type='text/javascript'>window.scrollTo(0, document.body.scrollHeight);</script>";

        ScriptManager.RegisterStartupScript(this, typeof(Page), "invocarfuncion", script, false);
    }
    protected void ReleaseMenu_MenuItemClick(object sender, MenuEventArgs e)
    {
        if (e.Item.Text.Equals("Information"))
        {
            divInformation.Visible = true;
            divDashboard.Visible = false;
        }
        else
        {            
            divInformation.Visible = false;
            divDashboard.Visible = true;
            cargarGraficos(this, e);
        }
    }
    protected void UserIssuesFoundByRelease_Load(object sender, EventArgs e)
    {
        if (divDashboard.Visible)
        {   
            SqlDataSourceUserIssuesFoundByRelease.SelectCommand = "EXEC UserIssuesFoundByRelease '" + ListBox1.SelectedValue + "'";                      
        }
    }

    protected void UserIssuesFoundByCodeLines_Load(object sender, EventArgs e)
    {
        if (divDashboard.Visible)
        {  
            SqlDataSourceUserIssuesFoundByCodeLines.SelectCommand = "EXEC UserIssuesFoundByCodeLines '" + ListBox1.SelectedValue + "'";           
        }
    }

    protected void UserIssuesFoundWeightedByTesters_Load(object sender, EventArgs e)
    {
        if (divDashboard.Visible)
        {
            SqlDataSourceUserIssuesFoundWeightedByTesters.SelectCommand = "EXEC UserIssuesFoundWeightedByTesters '" + ListBox1.SelectedValue + "'";
        }
    }

    protected void UserIssuesFoundWeightedByDevelopers_Load(object sender, EventArgs e)
    {
        if (divDashboard.Visible)
        {
            SqlDataSourceUserIssuesFoundWeightedByDevelopers.SelectCommand = "EXEC UserIssuesFoundWeightedByDevelopers '" + ListBox1.SelectedValue + "'";
        }
    }

    protected void ReleaseTimeDesviation_Load(object sender, EventArgs e)
    {
        if (divDashboard.Visible)
        {
            SqlDataSourceReleaseTimeDesviation.SelectCommand = "EXEC ReleaseTimeDesviation '" + ListBox1.SelectedValue + "'";
        }
    }

    protected void ReleaseTimeEffortPercentage_Load(object sender, EventArgs e)
    {
        if (divDashboard.Visible)
        {
            SqlDataSourceReleaseTimeEffortPercentage.SelectCommand = "EXEC ReleaseTimeEffortPercentage '" + ListBox1.SelectedValue + "'";
        }
    }

    protected void cargarGraficos(object sender, EventArgs e)
    {
        UserIssuesFoundByRelease_Load(this, e);
        UserIssuesFoundByCodeLines_Load(this, e);
        UserIssuesFoundWeightedByTesters_Load(this, e);
        UserIssuesFoundWeightedByDevelopers_Load(this, e);
        ReleaseTimeDesviation_Load(this, e);
        ReleaseTimeEffortPercentage_Load(this, e);
    }
}
