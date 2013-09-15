<%@ Page Title="Applications" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeFile="Applications.aspx.cs" Inherits="Applications" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">    
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">

    <!-- Busqueda -->
    <script type="text/javascript" src="Scripts/jquery-1.7.2.js">
    </script>
    <script type="text/javascript">
        $(document).ready(function () {
            //
            // Client Side Search (Autocomplete)
            // Get the search Key from the TextBox
            // Iterate through the 1st Column.
            // td:nth-child(1) - Filters only the 1st Column
            // If there is a match show the row [$(this).parent() gives the Row]
            // Else hide the row [$(this).parent() gives the Row]

            $('#MainContent_filterTextBox').keyup(function (event) {
                var searchKey = $(this).val().toLowerCase();
                var exists = false;
                var showrow = false;
                var number = 0;
                //alert('Dentro');
                $("#MainContent_GridView1 tr:not(:first-child)").each(function () {
                    //alert('Fila');
                    //alert($(this).children("td").text());
                    $(this).children("td").each(function () {
                        //alert($(this).text());
                        var cellText = $(this).text().toLowerCase();
                        if (cellText.indexOf(searchKey) >= 0) {
                            showrow = true;
                        }
                        else {
                        }
                    });
                    //alert(showrow);
                    if (!showrow) {
                        $(this).hide();
                        showrow = false;
                    }
                    else {
                        $(this).show();
                        showrow = false;
                        number++;
                        var mod = number % 2;
                        //alert(mod == 1);
                        if (mod == 1)
                            $(this).css("background", "#EFEFEF");
                        else
                            $(this).css("background", "white");
                    }
                });
            });
        });
    </script>
    <!-- Fin de Busqueda-->

    <h2>
        Applications
    </h2>
    <p>
        List of applications
    </p>
    
    <!-- Aqui va la parte del pop up para añadir las aplicaciones -->
    <asp:linkbutton ID="AddButton" runat="server" class="AddButton" OnClick="AddButton_Click">&nbsp;Add&nbsp;</asp:linkbutton>
    <asp:Panel runat="server" id="ModalApplicationRelease" class="modalDialogApplication" Visible="false">
	    <div>
		    <asp:LinkButton runat="server" id="CloseButton" class="close" OnClick="CloseButton_Click" CausesValidation="false">X</asp:LinkButton>
		    <h2>Add Application</h2>
		    <p>
            </p>               
            <asp:SqlDataSource ID="SqlDataSourceAddApplication" runat="server"
                ConnectionString="<%$ ConnectionStrings:ApplicationServices%>"                    
                insertcommand="Insert Into aspnet_Applications ([ApplicationName], [LoweredApplicationName], [Description]) VALUES (@ApplicationName, @LoweredApplicationName, @Description)" 
                oninserted="SqlDataSourceAddApplication_Inserted">
                <InsertParameters>                    
                    <asp:Parameter Name="ApplicationName" ConvertEmptyStringToNull="true" />
                    <asp:Parameter Name="LoweredApplicationName" ConvertEmptyStringToNull="true" />
                    <asp:Parameter Name="Description" ConvertEmptyStringToNull="true" />
                </InsertParameters>
            </asp:SqlDataSource>
            <asp:FormView ID="AddApplication" DefaultMode="Insert"
                DataSourceID="SqlDataSourceAddApplication"
                runat="server" Enabled="True" OnItemInserted="AddApplication_ItemInserted">
                <InsertItemTemplate>
                    <table>
                        <tr>
                            <td class="textBoxLabel" style="width:130px">Application Name:</td>
                            <td>
                                <asp:TextBox CssClass="TextBox" id="ApplicationName" runat="server" Text='<%# Bind("ApplicationName") %>' BorderStyle="NotSet" Width="300" MaxLength="50" />
                                <asp:RequiredFieldValidator runat="server"
                                    ControlToValidate="ApplicationName"
                                    ErrorMessage="*"
                                    ForeColor="Red" SetFocusOnError="True" />
                                <asp:CustomValidator ID="AppNameCV" runat="server"
                                    ErrorMessage="Unique" ForeColor="Red" OnServerValidate="AppNameCV_ServerValidate"
                                    ControlToValidate="ApplicationName" ValidateEmptyText="true" SetFocusOnError="true" >
                                </asp:CustomValidator>                                                    
                            </td>
                        </tr>
                        <tr>
                            <td class="textBoxLabel" style="width:130px">Short Name:</td>
                            <td>
                                <asp:TextBox CssClass="TextBox" id="LoweredApplicationName" runat="server" Text='<%# Bind("LoweredApplicationName") %>' BorderStyle="NotSet" Width="300" MaxLength="25" />
                                <asp:RequiredFieldValidator runat="server"
                                    ControlToValidate="LoweredApplicationName"
                                    ErrorMessage="*"
                                    ForeColor="Red" SetFocusOnError="True" />
                                <asp:CustomValidator ID="LoweredAppNameCV" runat="server"
                                    ErrorMessage="Unique" ForeColor="Red" OnServerValidate="LoweredAppNameCV_ServerValidate"
                                    ControlToValidate="LoweredApplicationName" ValidateEmptyText="true" SetFocusOnError="true" >
                                </asp:CustomValidator>
                            </td>
                        </tr>
                        <tr>
                            <td class="textBoxLabel">Description:</td>
                            <td><asp:TextBox id="Description" runat="server" Text='<%# Bind("Description") %>' BorderStyle="NotSet" Width="300" MaxLength="256" TextMode="MultiLine" Height="100" CssClass="TextArea" /></td>
                        </tr>
                        <tr>
                    </table>
                <p>
                    <asp:LinkButton ID="InsertButton" Text="&nbsp;Save&nbsp;" CommandName="Insert" RunAt="server" class="SaveButton" />                     
                </p>
                </InsertItemTemplate>                    
            </asp:FormView>                       
	    </div>
    </asp:Panel>
    <!-- Final Pop Up -->

    <p>Search:
        <asp:TextBox ID="filterTextBox" runat="server"></asp:TextBox>
    </p>
    <p>        
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:ApplicationServices %>" 
            
            SelectCommand="SELECT aspnet_Applications.* FROM aspnet_Applications WHERE aspnet_Applications.ApplicationId != 'eac1e9cc-ebe7-46fe-a3c5-9ef9d9a2067a'" >
        </asp:SqlDataSource>
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
            DataKeyNames="ApplicationId" DataSourceID="SqlDataSource1" Width="100%" 
            AllowSorting="True" CssClass="gridView" 
            onselectedindexchanged="GridView1_SelectedIndexChanged">
            <Columns>                
                <asp:BoundField DataField="ApplicationId" HeaderText="Id" 
                    SortExpression="ApplicationId"  ItemStyle-CssClass="boundfield-hidden" HeaderStyle-CssClass="boundfield-hidden"/>
                <asp:BoundField DataField="ApplicationName" HeaderText="Name" 
                    SortExpression="ApplicationName" ItemStyle-Width="200"/>
                <asp:BoundField DataField="LoweredApplicationName" HeaderText="Short Name" 
                    SortExpression="LoweredApplicationName" ItemStyle-Width="100"/>
                <asp:BoundField DataField="Description" HeaderText="Description" 
                    SortExpression="Description" ItemStyle-Width="500"/>
                <asp:CommandField ShowSelectButton="true" ButtonType="Link" Visible="true"
                    SelectText="<img src='images/Ok.png' />" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="50"/>   
            </Columns>
            <HeaderStyle BackColor="#546E96" CssClass="gridViewHeader" ForeColor="White" />            
        </asp:GridView>        
    </p>    
    </asp:Content>
