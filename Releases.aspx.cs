using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class Releases : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.User.Identity.IsAuthenticated)
        {
            Response.Redirect("Account/login.aspx");
        }

        if (Request.QueryString["AppId"] != null)
        {
            SqlDataSourceApplication.SelectCommand = "SELECT aspnet_Applications.* FROM aspnet_Applications WHERE aspnet_Applications.ApplicationId = '" + Request.QueryString["AppId"] + "'";
        }
    }

    protected void ListBox1_SelectedIndexChanged(object sender, EventArgs e)
    {
        string queryString = "SELECT aspnet_Releases.* FROM aspnet_Releases";
        if (!ListBox1.SelectedValue.Equals("0"))
        {
            queryString = queryString + " where ApplicationId = '" + ListBox1.SelectedValue + "'";
            SqlDataSourceApplication.SelectCommand = "SELECT aspnet_Applications.* FROM aspnet_Applications WHERE aspnet_Applications.ApplicationId = '" + ListBox1.SelectedValue + "'";
            AddButton.Visible = true;
        }
        else
        {
            SqlDataSourceApplication.SelectCommand = "";
            AddButton.Visible = false;
        }
        SqlDataSource2.SelectCommand = queryString;
        FormViewApplication.ChangeMode(FormViewMode.ReadOnly);
        FormViewApplication.DataBind();
        GridView1.DataBind();
    }

    protected void ListBox1_DataBound(object sender, EventArgs e)
    {
        string SourceAppId = Request.QueryString["AppId"];

        if (SourceAppId != null)
        {
            if (ListBox1.SelectedValue != null)
            {
                ListBox1.SelectedValue = SourceAppId;
                ListBox1_SelectedIndexChanged(ListBox1, e);
            }
        }
    }

    protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
    {
        Server.Transfer("Release.aspx?RelId=" + GridView1.SelectedRow.Cells[0].Text + "&AppId=" + ListBox1.SelectedValue);
    }

    protected void btReturn_Click(object sender, EventArgs e)
    {
        Response.Redirect("Applications.aspx");
    }
    protected void CancelButton_Click(object sender, EventArgs e)
    {
        SqlDataSourceApplication.SelectCommand = "SELECT aspnet_Applications.* FROM aspnet_Applications WHERE aspnet_Applications.ApplicationId = '" + ListBox1.SelectedValue + "'";
    }
    protected void EditButton_Click(object sender, EventArgs e)
    {
        SqlDataSourceApplication.SelectCommand = "SELECT aspnet_Applications.* FROM aspnet_Applications WHERE aspnet_Applications.ApplicationId = '" + ListBox1.SelectedValue + "'";
    }
    protected void FormViewApplication_ItemUpdating1(object sender, FormViewUpdateEventArgs e)
    {
        SqlDataSourceApplication.UpdateCommand = "Update aspnet_Applications SET [ApplicationName] = @ApplicationName, [LoweredApplicationName] = @LoweredApplicationName, [Description] = @Description WHERE [ApplicationId] = '" + ListBox1.SelectedValue + "'";
    }

    protected void FormViewApplication_ItemUpdated(object sender, EventArgs e)
    {
        SqlDataSourceApplication.SelectCommand = "SELECT aspnet_Applications.* FROM aspnet_Applications WHERE aspnet_Applications.ApplicationId = '" + ListBox1.SelectedValue + "'";
    }

    protected void SqlDataSourceApplication_Updated(object sender, SqlDataSourceStatusEventArgs e)
    {
        ListBox1.Items.Clear();
        ListBox1.Items.Add(new ListItem("All", "0"));
        ListBox1.DataBind();
        ListBox1.SelectedValue = Convert.ToString(FormViewApplication.SelectedValue);//Tengo que pasar el valor de la ApplicationId del FormViewApplication
    }

    protected void RelNameCV_ServerValidate(object source, ServerValidateEventArgs args)
    {
        SqlDataSource SqlDataSourceRelNameCV = new SqlDataSource();
        SqlDataSourceRelNameCV.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["ApplicationServices"].ConnectionString;
        SqlDataSourceRelNameCV.SelectCommand = "Select COUNT(ReleaseName) from aspnet_Releases where ReleaseName = '" + args.Value + "'";

        DataView dv = (DataView)SqlDataSourceRelNameCV.Select(DataSourceSelectArguments.Empty);

        if (dv[0].Row[0].ToString().Equals("0"))
        {
            args.IsValid = true;
        }
        else
        {
            args.IsValid = false;
        }
    }

    protected void GridView1_Sorting(object sender, GridViewSortEventArgs e)
    {
        SqlDataSource2.SelectCommand = "SELECT aspnet_Releases.* FROM aspnet_Releases";
    }

    protected void AppNameCV_ServerValidate(object source, ServerValidateEventArgs args)
    {
        SqlDataSource SqlDataSourceAppNameCV = new SqlDataSource();
        SqlDataSourceAppNameCV.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["ApplicationServices"].ConnectionString;
        SqlDataSourceAppNameCV.SelectCommand = "Select COUNT(ApplicationName) from aspnet_Applications where ApplicationName = '" + args.Value + "' and ApplicationId <> '" + ListBox1.SelectedValue + "'";

        DataView dv = (DataView)SqlDataSourceAppNameCV.Select(DataSourceSelectArguments.Empty);

        if (dv[0].Row[0].ToString().Equals("0"))
        {
            args.IsValid = true;
        }
        else
        {
            args.IsValid = false;
        }
    }

    protected void LoweredAppNameCV_ServerValidate(object source, ServerValidateEventArgs args)
    {
        SqlDataSource SqlDataSourceLoweredAppNameCV = new SqlDataSource();
        SqlDataSourceLoweredAppNameCV.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["ApplicationServices"].ConnectionString;
        SqlDataSourceLoweredAppNameCV.SelectCommand = "Select COUNT(LoweredApplicationName) from aspnet_Applications where LoweredApplicationName = '" + args.Value + "' and ApplicationId <> '" + ListBox1.SelectedValue + "'";

        DataView dv = (DataView)SqlDataSourceLoweredAppNameCV.Select(DataSourceSelectArguments.Empty);

        if (dv[0].Row[0].ToString().Equals("0"))
        {
            args.IsValid = true;
        }
        else
        {
            args.IsValid = false;
        }
    }

    protected void AddRelease_Load(object sender, EventArgs e)
    {
        SqlDataSourceAddRelease.InsertCommand = @"INSERT INTO [dbo].[aspnet_Releases]
                ([ApplicationId]
                ,[ReleaseName]
                ,[State]
                ,[CodeLines]
                ,[EstimatedDevTime]
                ,[RealDevTime]
                ,[EstimatedQATime]
                ,[RealQATime]
                ,[EstimatedAnaTime]
                ,[RealAnaTime]
                ,[TestCases]
                ,[TestRuns]
                ,[AnalistsNumber]
                ,[DevelopersNumber]
                ,[TestersNumber]
                ,[BuildsNumber]
                ,[BaseLinesNumber]
                ,[ReleasedPlannedDate]
                ,[ReleasedRealDate]
                ,[ErrorAnaP1Found]
                ,[ErrorAnaP2Found]
                ,[ErrorAnaP3Found]
                ,[ErrorAnaP4Found]
                ,[ErrorAnaP1Unresolved]
                ,[ErrorAnaP2Unresolved]
                ,[ErrorAnaP3Unresolved]
                ,[ErrorAnaP4Unresolved]
                ,[ErrorDesP1Found]
                ,[ErrorDesP2Found]
                ,[ErrorDesP3Found]
                ,[ErrorDesP4Found]
                ,[ErrorDesP1Unresolved]
                ,[ErrorDesP2Unresolved]
                ,[ErrorDesP3Unresolved]
                ,[ErrorDesP4Unresolved])

                VALUES
                ('" + ListBox1.SelectedValue + @"'
                ,@ReleaseName
                ,@State
                ,@CodeLines
                ,@EstimatedDevTime
                ,@RealDevTime
                ,@EstimatedQATime
                ,@RealQATime
                ,@EstimatedAnaTime
                ,@RealAnaTime
                ,@TestCases
                ,@TestRuns
                ,@AnalistsNumber
                ,@DevelopersNumber
                ,@TestersNumber
                ,@BuildsNumber
                ,@BaseLinesNumber
                ,@ReleasedPlannedDate
                ,@ReleasedRealDate
                ,@ErrorAnaP1Found
                ,@ErrorAnaP2Found
                ,@ErrorAnaP3Found
                ,@ErrorAnaP4Found
                ,@ErrorAnaP1Unresolved
                ,@ErrorAnaP2Unresolved
                ,@ErrorAnaP3Unresolved
                ,@ErrorAnaP4Unresolved
                ,@ErrorDesP1Found
                ,@ErrorDesP2Found
                ,@ErrorDesP3Found
                ,@ErrorDesP4Found
                ,@ErrorDesP1Unresolved
                ,@ErrorDesP2Unresolved
                ,@ErrorDesP3Unresolved
                ,@ErrorDesP4Unresolved)";
    }

    protected void AddButton_Click(object sender, EventArgs e)
    {
        ModalReleasePanel.Visible = true;
    }

    protected void CloseButton_Click(object sender, EventArgs e)
    {
        AddRelease.DataBind();
        ModalReleasePanel.Visible = false;
    }

    protected void LinkCalendarReleasedPlannedDate_Click(object sender, EventArgs e)
    {
        AddRelease.FindControl("ModalCalendarPanelReleasedPlannedDate").Visible = true;
    }

    protected void CloseCalendarPanelReleasedPlannedDate_Click(object sender, EventArgs e)
    {
        AddRelease.FindControl("ModalCalendarPanelReleasedPlannedDate").Visible = false;
    }
    protected void CalendarPlannedDate_SelectionChanged(object sender, EventArgs e)
    {
        ((TextBox)AddRelease.FindControl("ReleasedPlannedDate")).Text = ((Calendar)AddRelease.FindControl("CalendarPlannedDate")).SelectedDate.ToString("dd/MM/yyyy");
        CloseCalendarPanelReleasedPlannedDate_Click(this, e);
        ((LinkButton)AddRelease.FindControl("LinkCalendarReleasedPlannedDate")).Focus();
    }

    protected void LinkCalendarReleasedRealDate_Click(object sender, EventArgs e)
    {
        AddRelease.FindControl("ModalCalendarPanelReleasedRealDate").Visible = true;
    }

    protected void CloseCalendarPanelReleasedRealDate_Click(object sender, EventArgs e)
    {
        AddRelease.FindControl("ModalCalendarPanelReleasedRealDate").Visible = false;
    }
    protected void CalendarRealDate_SelectionChanged(object sender, EventArgs e)
    {
        ((TextBox)AddRelease.FindControl("ReleasedRealDate")).Text = ((Calendar)AddRelease.FindControl("CalendarRealDate")).SelectedDate.ToString("dd/MM/yyyy");
        CloseCalendarPanelReleasedRealDate_Click(this, e);
        ((LinkButton)AddRelease.FindControl("LinkButtonReleasedRealDate")).Focus();
    }

    protected void CalendarDate_DayRender(object sender, DayRenderEventArgs e)
    {

        if (e.Day.IsOtherMonth)
        {
            e.Cell.Text = "";
            e.Cell.Attributes.Add("font-underline", "false");
        }
    }
    protected void SqlDataSourceAddRelease_Inserted(object sender, SqlDataSourceStatusEventArgs e)
    {
        SqlDataSource2.SelectCommand = "SELECT aspnet_Releases.* FROM aspnet_Releases where ApplicationId = '" + ListBox1.SelectedValue + "'";
        ModalReleasePanel.Visible = false;
        AddRelease.DataBind();
    }

    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        switch (e.Row.Cells[2].Text)
        {
            case "1":
                e.Row.Cells[2].Text = "Planned";
                break;
            case "2":
                e.Row.Cells[2].Attributes.Add("bgcolor", "Orange");
                e.Row.Cells[2].Text = "In Progress";
                break;
            case "3":
                e.Row.Cells[2].Attributes.Add("bgcolor", "LightGreen");
                e.Row.Cells[2].Text = "Released";
                break;
        }
    }
}
