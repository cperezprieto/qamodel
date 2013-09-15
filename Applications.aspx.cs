using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class Applications : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
    {
        Response.Redirect("Releases.aspx?AppId=" + GridView1.SelectedRow.Cells[0].Text);
    }

    protected void SqlDataSourceAddApplication_Inserted(object sender, SqlDataSourceStatusEventArgs e)
    {
        GridView1.DataBind();
    }
        
    protected void AddButton_Click(object sender, EventArgs e)
    {
        ModalApplicationRelease.Visible = true;
    }

    protected void CloseButton_Click(object sender, EventArgs e)
    {        
        ModalApplicationRelease.Visible = false;
        AddApplication.DataBind();
    }

    protected void AddApplication_ItemInserted(object sender, FormViewInsertedEventArgs e)
    {
        ModalApplicationRelease.Visible = false;        
        AddApplication.DataBind();
    }

    protected void AppNameCV_ServerValidate(object source, ServerValidateEventArgs args)
    {
        SqlDataSource SqlDataSourceAppNameCV = new SqlDataSource();
        SqlDataSourceAppNameCV.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["ApplicationServices"].ConnectionString;
        SqlDataSourceAppNameCV.SelectCommand = "Select COUNT(ApplicationName) from aspnet_Applications where ApplicationName = '" + args.Value + "'";

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
        SqlDataSourceLoweredAppNameCV.SelectCommand = "Select COUNT(LoweredApplicationName) from aspnet_Applications where LoweredApplicationName = '" + args.Value + "'";

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
}