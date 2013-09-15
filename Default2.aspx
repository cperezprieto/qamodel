<%@ Page language="C#" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
  <head id="Head1" runat="server">
    <title>FormView Example</title>
</head>
<body>
    <form id="form1" runat="server">

      <h3>FormView Example</h3>

      <asp:formview id="EmployeeFormView"
        datasourceid="EmployeeSource"
        allowpaging="true"
        datakeynames="ApplicationId"
        emptydatatext="No employees found."  
        runat="server">

        <rowstyle backcolor="LightGreen"
          wrap="false"/>
        <editrowstyle backcolor="LightBlue"
          wrap="false"/>

        <itemtemplate>
          <table>            
            <tr>
              <td>
                <b>Name:</b>
              </td>
              <td>
                <%# Eval("ApplicationName") %>
              </td>
            </tr>
            <tr>
              <td>
                <b>Title:</b>
              </td>
              <td>
                <%# Eval("LoweredApplicationName") %>
              </td>
            </tr>
            <tr>
              <td colspan="2">
                <asp:linkbutton id="Edit"
                  text="Edit"
                  commandname="Edit"
                  runat="server"/> 
              </td>
            </tr>
          </table>       
        </itemtemplate>
        <edititemtemplate>
          <table>            
            <tr>
              <td>
                <b>Name:</b>
              </td>
              <td>
                <asp:textbox id="ApplicationName"
                  text='<%# Bind("ApplicationName") %>'
                  runat="server"/>                
              </td>
            </tr>
            <tr>
              <td>
                <b>Title:</b>
              </td>
              <td>
                <asp:textbox id="LoweredApplicationName"
                  text='<%# Bind("LoweredApplicationName") %>'
                  runat="server"/> 
              </td>
            </tr>
            <tr>
              <td colspan="2">
                <asp:linkbutton id="UpdateButton"
                  text="Update"
                  commandname="Update"
                  runat="server"/>
                <asp:linkbutton id="CancelButton"
                  text="Cancel"
                  commandname="Cancel"
                  runat="server"/> 
              </td>
            </tr>
          </table>       
        </edititemtemplate> 

      </asp:formview>

      <!-- This example uses Microsoft SQL Server and connects  -->
      <!-- to the Northwind sample database. Use an ASP.NET     -->
      <!-- expression to retrieve the connection string value   -->
      <!-- from the Web.config file.                            -->
      <asp:sqldatasource id="EmployeeSource"
        selectcommand="Select [ApplicationId], [ApplicationName], [LoweredApplicationName] From [aspnet_Applications]"
        updatecommand="Update [aspnet_Applications] Set [ApplicationName]=@ApplicationName, [LoweredApplicationName]=@LoweredApplicationName Where [ApplicationId]=@ApplicationId"
        connectionstring="<%$ ConnectionStrings:ApplicationServices%>"
        runat="server"/>

    </form>
  </body>
</html>