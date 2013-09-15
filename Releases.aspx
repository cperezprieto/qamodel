<%@ Page Title="Releases" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeFile="Releases.aspx.cs" Inherits="Releases" %>

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
                        if(mod == 1)
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
        Releases</h2>
    <p>
        Application   
        &nbsp;<asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:ApplicationServices %>" 
            SelectCommand="SELECT aspnet_Applications.* FROM aspnet_Applications WHERE aspnet_Applications.ApplicationId != 'eac1e9cc-ebe7-46fe-a3c5-9ef9d9a2067a'">            
        </asp:SqlDataSource>
        <asp:ListBox ID="ListBox1" runat="server" DataSourceID="SqlDataSource1" DataTextField="ApplicationName"
        DataValueField="ApplicationId" Rows="1" AppendDataBoundItems="true" 
            onselectedindexchanged="ListBox1_SelectedIndexChanged" AutoPostBack="True" 
            ondatabound="ListBox1_DataBound">
            <asp:ListItem Enabled="true" Text="ALL" Value="0" />
        </asp:ListBox>        
    </p>        
    <hr />    
        <asp:SqlDataSource ID="SqlDataSourceApplication" runat="server"
            ConnectionString="<%$ ConnectionStrings:ApplicationServices%>"
            SelectCommand="" OnUpdated="SqlDataSourceApplication_Updated" >
            <UpdateParameters>
                <asp:Parameter Name="ApplicationName" ConvertEmptyStringToNull="true" />
                <asp:Parameter Name="LoweredApplicationName" ConvertEmptyStringToNull="true" />
                <asp:Parameter Name="Description" ConvertEmptyStringToNull="true" />
            </UpdateParameters>
        </asp:SqlDataSource>
        <asp:FormView ID="FormViewApplication" DataSourceID="SqlDataSourceApplication"
            runat="server" datakeynames="ApplicationId" DefaultMode="ReadOnly"
            EmptyDataText="All Applications Information" EmptyDataRowStyle-HorizontalAlign="Center"
            EmptyDataRowStyle-VerticalAlign="Middle" EmptyDataRowStyle-Width="920px" Width="920px"
            EditRowStyle-CssClass="nodata" EmptyDataRowStyle-ForeColor="Gray"
            EmptyDataRowStyle-BackColor="White" EmptyDataRowStyle-BorderWidth="0" OnItemUpdating="FormViewApplication_ItemUpdating1" OnItemUpdated="FormViewApplication_ItemUpdated" >
            <ItemTemplate>
                <asp:LinkButton id="EditButton" runat="server" class="EditButton" Text="&nbsp;Edit&nbsp;" CommandName="Edit" OnClick="EditButton_Click" />
                <table>
                    <tr>
                        <td class="textBoxLabel" style="width:130px">Application Name:</td>
                        <td>
                            <asp:TextBox CssClass="TextBoxDisabled" id="ApplicationName" runat="server" Text='<%# Eval("ApplicationName") %>' BorderStyle="NotSet" Width="300" MaxLength="50" />                            
                        </td>
                    </tr>
                    <tr>
                        <td class="textBoxLabel" style="width:130px">Short Name:</td>
                        <td>
                            <asp:TextBox CssClass="TextBoxDisabled" id="LoweredApplicationName" runat="server" Text='<%# Eval("LoweredApplicationName") %>' BorderStyle="NotSet" Width="300" MaxLength="25" />                            
                        </td>
                    </tr>
                    <tr>
                        <td class="textBoxLabel">Description:</td>
                        <td><asp:TextBox CssClass="TextAreaDisabled" id="Description" runat="server" Text='<%# Eval("Description") %>' BorderStyle="NotSet" Width="770" MaxLength="256" TextMode="MultiLine" Height="65" /></td>
                    </tr>
                    <tr>
                </table>
            <p>                
            </p>
            </ItemTemplate>
            <EditItemTemplate>
                <asp:LinkButton id="CancelButton" runat="server" class="CancelButton" Text="&nbsp;Cancel&nbsp;" CommandName="Cancel" OnClick="CancelButton_Click" CausesValidation="False" />
                <asp:LinkButton id="SaveButton" runat="server" class="SaveButton" Text="&nbsp;Save&nbsp;" CommandName="Update" />               
                <table>
                    <tr>
                        <td class="textBoxLabel" style="width:130px">Application Name:</td>
                        <td>
                            <asp:TextBox CssClass="TextBox" id="ApplicationName" runat="server" Text='<%# Bind("ApplicationName") %>'
                                BorderStyle="NotSet" Width="300" MaxLength="256" />
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
                            <asp:TextBox CssClass="TextBox" id="LoweredApplicationName" runat="server" Text='<%# Bind("LoweredApplicationName") %>' BorderStyle="NotSet" Width="300" MaxLength="256" />
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
                        <td><asp:TextBox CssClass="TextArea" id="Description" runat="server" Text='<%# Bind("Description") %>' BorderStyle="NotSet" Width="770" MaxLength="256" TextMode="MultiLine" Height="65" /></td>
                    </tr>
                    <tr>
                </table>
            <p>                
            </p>
            </EditItemTemplate>                   
        </asp:FormView>
    <hr />
    <p>
        List of releases
    </p>
    <!-- Aqui va la parte del pop up para añadir las releases -->
    <asp:LinkButton runat="server" id="AddButton" class="AddButton" Visible="false" OnClick="AddButton_Click">&nbsp;Add&nbsp;</asp:LinkButton>
    <asp:Panel runat="server" id="ModalReleasePanel" class="modalDialogRelease" visible="false">
	    <div>
		    <asp:LinkButton runat="server" id="CloseButton" class="close" OnClick="CloseButton_Click" CausesValidation="false">X</asp:LinkButton>
		    <h2>Add Release</h2>		                 
            <asp:SqlDataSource ID="SqlDataSourceAddRelease" runat="server"
                ConnectionString="<%$ ConnectionStrings:ApplicationServices%>" OnInserted="SqlDataSourceAddRelease_Inserted">
                <InsertParameters>
                    <asp:Parameter name="ReleaseName" ConvertEmptyStringToNull="true" />
                    <asp:Parameter name="State" ConvertEmptyStringToNull="true" />
                    <asp:Parameter name="CodeLines" ConvertEmptyStringToNull="true" />
                    <asp:Parameter name="BuildsNumber" ConvertEmptyStringToNull="true" />
                    <asp:Parameter name="BaseLinesNumber" ConvertEmptyStringToNull="true" />
                    <asp:Parameter name="ReleasedPlannedDate" ConvertEmptyStringToNull="true" />
                    <asp:Parameter name="ReleasedRealDate" ConvertEmptyStringToNull="true" />
                    <asp:Parameter name="TestCases" ConvertEmptyStringToNull="true" />
                    <asp:Parameter name="TestRuns" ConvertEmptyStringToNull="true" />
                    <asp:Parameter name="ErrorAnaP1Found" ConvertEmptyStringToNull="true" />
                    <asp:Parameter name="ErrorAnaP2Found" ConvertEmptyStringToNull="true" />
                    <asp:Parameter name="ErrorAnaP3Found" ConvertEmptyStringToNull="true" />
                    <asp:Parameter name="ErrorAnaP4Found" ConvertEmptyStringToNull="true" />
                    <asp:Parameter name="ErrorDesP1Found" ConvertEmptyStringToNull="true" />
                    <asp:Parameter name="ErrorDesP2Found" ConvertEmptyStringToNull="true" />
                    <asp:Parameter name="ErrorDesP3Found" ConvertEmptyStringToNull="true" />
                    <asp:Parameter name="ErrorDesP4Found" ConvertEmptyStringToNull="true" />
                    <asp:Parameter name="ErrorAnaP1Unresolved" ConvertEmptyStringToNull="true" />
                    <asp:Parameter name="ErrorAnaP2Unresolved" ConvertEmptyStringToNull="true" />
                    <asp:Parameter name="ErrorAnaP3Unresolved" ConvertEmptyStringToNull="true" />
                    <asp:Parameter name="ErrorAnaP4Unresolved" ConvertEmptyStringToNull="true" />
                    <asp:Parameter name="ErrorDesP1Unresolved" ConvertEmptyStringToNull="true" />
                    <asp:Parameter name="ErrorDesP2Unresolved" ConvertEmptyStringToNull="true" />
                    <asp:Parameter name="ErrorDesP3Unresolved" ConvertEmptyStringToNull="true" />
                    <asp:Parameter name="ErrorDesP4Unresolved" ConvertEmptyStringToNull="true" />
                    <asp:Parameter name="AnalistsNumber" ConvertEmptyStringToNull="true" />
                    <asp:Parameter name="DevelopersNumber" ConvertEmptyStringToNull="true" />
                    <asp:Parameter name="TestersNumber" ConvertEmptyStringToNull="true" />
                    <asp:Parameter name="EstimatedAnaTime" ConvertEmptyStringToNull="true" />
                    <asp:Parameter name="RealAnaTime" ConvertEmptyStringToNull="true" />
                    <asp:Parameter name="EstimatedDevTime" ConvertEmptyStringToNull="true" />
                    <asp:Parameter name="RealDevTime" ConvertEmptyStringToNull="true" />                    
                    <asp:Parameter name="EstimatedQATime" ConvertEmptyStringToNull="true" />
                    <asp:Parameter name="RealQATime" ConvertEmptyStringToNull="true" />
                </InsertParameters>                                
            </asp:SqlDataSource>
            <asp:FormView ID="AddRelease" DefaultMode="Insert"
                DataSourceID="SqlDataSourceAddRelease"
                runat="server" Enabled="True" OnLoad="AddRelease_Load">
                <InsertItemTemplate>                    
                    <table>
                        <tr style="vertical-align:top">
                            <td style="width:60%">
                                <p style="background-color:Gray;color:White">&nbsp;<span class="textSpanBoldUnderline">Release Information</span></p>                                
                                <table>                                    
                                    <tr>
                                        
                                        <td class="textBoxLabel" style="width:140px">Release Name:</td>
                                        <td>
                                            <asp:TextBox id="ReleaseName" runat="server" Text='<%# Bind("ReleaseName") %>' BorderStyle="NotSet" MaxLength="50" />
                                            <asp:RequiredFieldValidator runat="server"
                                                ControlToValidate="ReleaseName"
                                                ErrorMessage="*"
                                                ForeColor="Red" SetFocusOnError="True" />
                                            <asp:CustomValidator ID="RelNameCV" runat="server"
                                                ErrorMessage="Unique" ForeColor="Red" OnServerValidate="RelNameCV_ServerValidate"
                                                ControlToValidate="ReleaseName" ValidateEmptyText="true" SetFocusOnError="true" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="textBoxLabel">State:</td>
                                        <td>                            
                                            <asp:ListBox id="State" Rows="1" runat="server" Text='<%# Bind("State") %>'>
                                                <asp:ListItem Text="" Value="" />
                                                <asp:ListItem Text="Active" Value="1" />
                                                <asp:ListItem Text="In Progress" Value="2" />
                                                <asp:ListItem Text="Closed" Value="3" />
                                            </asp:ListBox>                                            
                                            <asp:RequiredFieldValidator runat="server"
                                                ControlToValidate="State"
                                                ErrorMessage="*"
                                                ForeColor="Red" SetFocusOnError="True" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="textBoxLabel">Code Lines:</td>
                                        <td>
                                            <asp:TextBox id="CodeLines" runat="server" Text='<%# Bind("CodeLines") %>' />
                                            <asp:CompareValidator runat="server" ControlToValidate="CodeLines" Type="Integer"
                                                Operator="DataTypeCheck" ErrorMessage="Integer" ForeColor="Red" Font-Size="XX-Small" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="textBoxLabel">Builds number:</td>
                                        <td>
                                            <asp:TextBox id="BuildsNumber" runat="server" Text='<%# Bind("BuildsNumber") %>' />
                                            <asp:CompareValidator runat="server" ControlToValidate="BuildsNumber" Type="Integer"
                                                Operator="DataTypeCheck" ErrorMessage="Integer" ForeColor="Red" Font-Size="XX-Small" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="textBoxLabel">BaseLines Number:</td>
                                        <td>
                                            <asp:TextBox id="BaseLinesNumber" runat="server" Text='<%# Bind("BaseLinesNumber") %>' />
                                            <asp:CompareValidator runat="server" ControlToValidate="BaseLinesNumber" Type="Integer"
                                                Operator="DataTypeCheck" ErrorMessage="Integer" ForeColor="Red" Font-Size="XX-Small" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="textBoxLabel">Planned Date:</td>
                                        <td>
                                            <asp:TextBox ID="ReleasedPlannedDate" runat="server" Text='<%# Bind("ReleasedPlannedDate", "{0: dd/MM/yyyy}") %>' />
                                            <asp:LinkButton runat="server" id="LinkCalendarReleasedPlannedDate" OnClick="LinkCalendarReleasedPlannedDate_Click" CausesValidation="false"><img src="images/calendar.png" alt="Calendar"/></asp:LinkButton>
                                            <asp:RequiredFieldValidator runat="server"
                                                ControlToValidate="ReleasedPlannedDate"
                                                ErrorMessage="*"
                                                ForeColor="Red" SetFocusOnError="True" />
                                            <asp:CompareValidator runat="server" ControlToValidate="ReleasedPlannedDate" Type="Date"
                                                Operator="DataTypeCheck" ErrorMessage="dd/mm/aaaa" ForeColor="Red" Font-Size="XX-Small" />
                                            <asp:Panel runat="server" id="ModalCalendarPanelReleasedPlannedDate" class="modalDialogCalendar" visible="false">
                                                <div>
                                                    <asp:LinkButton runat="server" id="CloseCalendarPanelReleasedPlannedDate" class="close" OnClick="CloseCalendarPanelReleasedPlannedDate_Click" CausesValidation="false">X</asp:LinkButton>
                                                    <asp:Calendar ID="CalendarPlannedDate" runat="server" BorderWidth="2px" BackColor="#e0e0e0" Width="220px"
                                                        ForeColor="#546E96" Height="100px" Font-Size="10pt" Font-Names="Verdana" BorderColor="White"
                                                        BorderStyle="None" DayNameFormat="FirstTwoLetters" CellPadding="4" Font-Bold="true" Font-Underline="false" OnSelectionChanged="CalendarPlannedDate_SelectionChanged"
                                                        NextPrevFormat="CustomText" OtherMonthDayStyle-ForeColor="#919191" PrevMonthText="<img src=images/Arrow1_Left.png >" NextMonthText="<img src=images/Arrow1_Right.png >" OnDayRender="CalendarDate_DayRender">
                                                        <TitleStyle BackColor="#546E96" ForeColor="White" Font-Bold="true"></TitleStyle>                                                        
                                                        <SelectedDayStyle Font-Bold="true" BackColor="white" ForeColor="#546E96"></SelectedDayStyle>
                                                        <DayHeaderStyle Font-Size="7pt" Font-Bold="True" BackColor="#546E96" ForeColor="White" BorderColor="#e0e0e0" BorderWidth="1px"></DayHeaderStyle>                                                        
                                                    </asp:Calendar>
                                                </div>
                                            </asp:Panel>                                                                                    
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="textBoxLabel">Released Date:</td>
                                        <td>
                                            <asp:TextBox id="ReleasedRealDate" runat="server" Text='<%# Bind("ReleasedRealDate", "{0: dd/MM/yyyy}") %>' />
                                            <asp:LinkButton runat="server" id="LinkButtonReleasedRealDate" OnClick="LinkCalendarReleasedRealDate_Click" CausesValidation="false"><img src="images/calendar.png" alt="Calendar"/></asp:LinkButton>                                            
                                            <asp:CompareValidator runat="server" ControlToValidate="ReleasedRealDate" Type="Date"
                                                Operator="DataTypeCheck" ErrorMessage="dd/mm/aaaa" ForeColor="Red" Font-Size="XX-Small" />
                                            <asp:Panel runat="server" id="ModalCalendarPanelReleasedRealDate" class="modalDialogCalendar" visible="false">
                                                <div>
                                                    <asp:LinkButton runat="server" id="CloseCalendarPanelReleasedRealDate" class="close" OnClick="CloseCalendarPanelReleasedRealDate_Click" CausesValidation="false">X</asp:LinkButton>
                                                    <asp:Calendar ID="CalendarRealDate" runat="server" BorderWidth="2px" BackColor="#e0e0e0" Width="220px"
                                                        ForeColor="#546E96" Height="100px" Font-Size="10pt" Font-Names="Verdana" BorderColor="White"
                                                        BorderStyle="None" DayNameFormat="FirstTwoLetters" CellPadding="4" Font-Bold="true" Font-Underline="false" OnSelectionChanged="CalendarRealDate_SelectionChanged"
                                                        NextPrevFormat="CustomText" OtherMonthDayStyle-ForeColor="#919191" PrevMonthText="<img src=images/Arrow1_Left.png >" NextMonthText="<img src=images/Arrow1_Right.png >" OnDayRender="CalendarDate_DayRender">
                                                        <TitleStyle BackColor="#546E96" ForeColor="White" Font-Bold="true"></TitleStyle>                                                        
                                                        <SelectedDayStyle Font-Bold="true" BackColor="white" ForeColor="#546E96" ></SelectedDayStyle>
                                                        <DayHeaderStyle Font-Size="7pt" Font-Bold="True" BackColor="#546E96" ForeColor="White" BorderColor="#e0e0e0" BorderWidth="1px"></DayHeaderStyle>                                                        
                                                    </asp:Calendar>
                                                </div>
                                            </asp:Panel>
                                        </td>
                                    </tr>                                                                              
                                </table>                                        
                            </td>
                            <td style="width:5%">
                            </td>
                            <td style="width:35%">
                                <p style="background-color:Gray;color:White">&nbsp;<span class="textSpanBoldUnderline">Testing</span></p>                                        
                                <table>
                                    <tr>
                                        <td>
                                            <table style="margin:-3px">                                                                                                    
                                                <tr>
                                                    <td class="textBoxLabel" style="width:130px">Test Cases Number:</td>
                                                    <td>
                                                        <asp:TextBox id="TestCases" runat="server" Text='<%# Bind("TestCases") %>' />
                                                        <asp:CompareValidator runat="server" ControlToValidate="TestCases" Type="Integer"
                                                            Operator="DataTypeCheck" ErrorMessage="Integer" ForeColor="Red" Font-Size="XX-Small" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="textBoxLabel">Test Runs Number:</td>
                                                    <td>
                                                        <asp:TextBox id="TestRuns" runat="server" Text='<%# Bind("TestRuns") %>' />
                                                        <asp:CompareValidator runat="server" ControlToValidate="TestRuns" Type="Integer"
                                                            Operator="DataTypeCheck" ErrorMessage="Integer" ForeColor="Red" Font-Size="XX-Small" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>                                            
                                    <tr>
                                        <td class="textBoxLabel">
                                            <br />
                                            Testing Issues Found:                                                
                                            <table>
                                                <tr>
                                                    <td>
                                                    </td>                                           
                                                    <td>
                                                        Priority 1
                                                    </td>                                            
                                                    <td>
                                                        Priority 2
                                                    </td>
                                                    <td>
                                                        Priority 3
                                                    </td>
                                                    <td>
                                                        Priority 4
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>Design:</td>
                                                    <td>
                                                        <asp:TextBox id="ErrorAnaP1Found" style="max-width:60px" runat="server" Text='<%# Bind("ErrorAnaP1Found") %>' />
                                                        <asp:CompareValidator runat="server" ControlToValidate="ErrorAnaP1Found" Type="Integer"
                                                            Operator="DataTypeCheck" ErrorMessage="Integer" ForeColor="Red" Font-Size="XX-Small" />
                                                    </td>
                                                    <td>
                                                        <asp:TextBox id="ErrorAnaP2Found" style="max-width:60px" runat="server" Text='<%# Bind("ErrorAnaP2Found") %>' />
                                                        <asp:CompareValidator runat="server" ControlToValidate="ErrorAnaP2Found" Type="Integer"
                                                            Operator="DataTypeCheck" ErrorMessage="Integer" ForeColor="Red" Font-Size="XX-Small" />
                                                    </td>
                                                    <td>
                                                        <asp:TextBox id="ErrorAnaP3Found" style="max-width:60px" runat="server" Text='<%# Bind("ErrorAnaP3Found") %>' />
                                                        <asp:CompareValidator runat="server" ControlToValidate="ErrorAnaP3Found" Type="Integer"
                                                            Operator="DataTypeCheck" ErrorMessage="Integer" ForeColor="Red" Font-Size="XX-Small" />
                                                    </td>
                                                    <td>
                                                        <asp:TextBox id="ErrorAnaP4Found" style="max-width:60px" runat="server" Text='<%# Bind("ErrorAnaP4Found") %>' />
                                                        <asp:CompareValidator runat="server" ControlToValidate="ErrorAnaP4Found" Type="Integer"
                                                            Operator="DataTypeCheck" ErrorMessage="Integer" ForeColor="Red" Font-Size="XX-Small" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>Development:</td>
                                                    <td>
                                                        <asp:TextBox id="ErrorDesP1Found" style="max-width:60px" runat="server" Text='<%# Bind("ErrorDesP1Found") %>' />
                                                        <asp:CompareValidator runat="server" ControlToValidate="ErrorDesP1Found" Type="Integer"
                                                            Operator="DataTypeCheck" ErrorMessage="Integer" ForeColor="Red" Font-Size="XX-Small" />
                                                    </td>
                                                    <td>
                                                        <asp:TextBox id="ErrorDesP2Found" style="max-width:60px" runat="server" Text='<%# Bind("ErrorDesP2Found") %>' />
                                                        <asp:CompareValidator runat="server" ControlToValidate="ErrorDesP2Found" Type="Integer"
                                                            Operator="DataTypeCheck" ErrorMessage="Integer" ForeColor="Red" Font-Size="XX-Small" />
                                                    </td>
                                                    <td>
                                                        <asp:TextBox id="ErrorDesP3Found" style="max-width:60px" runat="server" Text='<%# Bind("ErrorDesP3Found") %>' />
                                                        <asp:CompareValidator runat="server" ControlToValidate="ErrorDesP3Found" Type="Integer"
                                                            Operator="DataTypeCheck" ErrorMessage="Integer" ForeColor="Red" Font-Size="XX-Small" />
                                                    </td>
                                                    <td>
                                                        <asp:TextBox id="ErrorDesP4Found" style="max-width:60px" runat="server" Text='<%# Bind("ErrorDesP4Found") %>' />
                                                        <asp:CompareValidator runat="server" ControlToValidate="ErrorDesP4Found" Type="Integer"
                                                            Operator="DataTypeCheck" ErrorMessage="Integer" ForeColor="Red" Font-Size="XX-Small" />
                                                    </td>
                                                </tr>                                            
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="textBoxLabel">
                                            <br />
                                            Testing Issues Unresolved:                                                
                                            <table>
                                                <tr>
                                                    <td>
                                                    </td>                                           
                                                    <td>
                                                        Priority 1
                                                    </td>                                            
                                                    <td>
                                                        Priority 2
                                                    </td>
                                                    <td>
                                                        Priority 3
                                                    </td>
                                                    <td>
                                                        Priority 4
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>Design:</td>
                                                    <td>
                                                        <asp:TextBox id="ErrorAnaP1Unresolved" style="max-width:60px" runat="server" Text='<%# Bind("ErrorAnaP1Unresolved") %>' />
                                                        <asp:CompareValidator runat="server" ControlToValidate="ErrorAnaP1Unresolved" Type="Integer"
                                                            Operator="DataTypeCheck" ErrorMessage="Integer" ForeColor="Red" Font-Size="XX-Small" />
                                                    </td>
                                                    <td>
                                                        <asp:TextBox id="ErrorAnaP2Unresolved" style="max-width:60px" runat="server" Text='<%# Bind("ErrorAnaP2Unresolved") %>' />
                                                        <asp:CompareValidator runat="server" ControlToValidate="ErrorAnaP2Unresolved" Type="Integer"
                                                            Operator="DataTypeCheck" ErrorMessage="Integer" ForeColor="Red" Font-Size="XX-Small" />
                                                    </td>
                                                    <td>
                                                        <asp:TextBox id="ErrorAnaP3Unresolved" style="max-width:60px" runat="server" Text='<%# Bind("ErrorAnaP3Unresolved") %>' />
                                                        <asp:CompareValidator runat="server" ControlToValidate="ErrorAnaP3Unresolved" Type="Integer"
                                                            Operator="DataTypeCheck" ErrorMessage="Integer" ForeColor="Red" Font-Size="XX-Small" />
                                                    </td>
                                                    <td>
                                                        <asp:TextBox id="ErrorAnaP4Unresolved" style="max-width:60px" runat="server" Text='<%# Bind("ErrorAnaP4Unresolved") %>' />
                                                        <asp:CompareValidator runat="server" ControlToValidate="ErrorAnaP4Unresolved" Type="Integer"
                                                            Operator="DataTypeCheck" ErrorMessage="Integer" ForeColor="Red" Font-Size="XX-Small" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>Development:</td>
                                                    <td>
                                                        <asp:TextBox id="ErrorDesP1Unresolved" style="max-width:60px" runat="server" Text='<%# Bind("ErrorDesP1Unresolved") %>' />
                                                        <asp:CompareValidator runat="server" ControlToValidate="ErrorDesP1Unresolved" Type="Integer"
                                                            Operator="DataTypeCheck" ErrorMessage="Integer" ForeColor="Red" Font-Size="XX-Small" />
                                                    </td>
                                                    <td>
                                                        <asp:TextBox id="ErrorDesP2Unresolved" style="max-width:60px" runat="server" Text='<%# Bind("ErrorDesP2Unresolved") %>' />
                                                        <asp:CompareValidator runat="server" ControlToValidate="ErrorDesP2Unresolved" Type="Integer"
                                                            Operator="DataTypeCheck" ErrorMessage="Integer" ForeColor="Red" Font-Size="XX-Small" />
                                                    </td>
                                                    <td>
                                                        <asp:TextBox id="ErrorDesP3Unresolved" style="max-width:60px" runat="server" Text='<%# Bind("ErrorDesP3Unresolved") %>' />
                                                        <asp:CompareValidator runat="server" ControlToValidate="ErrorDesP3Unresolved" Type="Integer"
                                                            Operator="DataTypeCheck" ErrorMessage="Integer" ForeColor="Red" Font-Size="XX-Small" />
                                                    </td>
                                                    <td>
                                                        <asp:TextBox id="ErrorDesP4Unresolved" style="max-width:60px" runat="server" Text='<%# Bind("ErrorDesP4Unresolved") %>' />
                                                        <asp:CompareValidator runat="server" ControlToValidate="ErrorDesP4Unresolved" Type="Integer"
                                                            Operator="DataTypeCheck" ErrorMessage="Integer" ForeColor="Red" Font-Size="XX-Small" />
                                                    </td>
                                                </tr>                                            
                                            </table>
                                        </td>
                                    </tr>
                                </table>                                        
                            </td>
                        </tr>
                        <tr style="vertical-align:top">
                            <td style="width:60%">
                                <p style="background-color:Gray;color:White">&nbsp;<span class="textSpanBoldUnderline">Participants</span></p>                                        
                                <table>
                                    <tr>
                                        <td class="textBoxLabel" style="width:145px">Designers Number:</td>
                                        <td>
                                            <asp:TextBox id="AnalistsNumber" runat="server" Text='<%# Bind("AnalistsNumber") %>' />
                                            <asp:CompareValidator runat="server" ControlToValidate="AnalistsNumber" Type="Double"
                                                Operator="DataTypeCheck" ErrorMessage="Number" ForeColor="Red" Font-Size="XX-Small" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="textBoxLabel">Developers Number:</td>
                                        <td>
                                            <asp:TextBox id="DevelopersNumber" runat="server" Text='<%# Bind("DevelopersNumber") %>' />
                                            <asp:CompareValidator runat="server" ControlToValidate="DevelopersNumber" Type="Double"
                                                Operator="DataTypeCheck" ErrorMessage="Number" ForeColor="Red" Font-Size="XX-Small" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="textBoxLabel">Testers Number:</td>
                                        <td>
                                            <asp:TextBox id="TestersNumber" runat="server" Text='<%# Bind("TestersNumber") %>' />
                                            <asp:CompareValidator runat="server" ControlToValidate="TestersNumber" Type="Double"
                                                Operator="DataTypeCheck" ErrorMessage="Number" ForeColor="Red" Font-Size="XX-Small" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td style="width:5%">
                            </td>
                            <td style="width:35%">
                                <p style="background-color:Gray;color:White">&nbsp;<span class="textSpanBoldUnderline">Time Effort</span></p>                                        
                                <table>
                                    <tr>
                                        <td>
                                        </td>                                           
                                        <td>
                                            <b>Estimated</b>
                                        </td>                                            
                                        <td>
                                            <b>Real</b>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="textBoxLabel">Design:</td>
                                        <td>
                                            <asp:TextBox id="EstimatedAnaTime" runat="server" Text='<%# Bind("EstimatedAnaTime") %>' />
                                            <asp:RequiredFieldValidator runat="server"
                                                ControlToValidate="EstimatedAnaTime"
                                                ErrorMessage="*"
                                                ForeColor="Red" SetFocusOnError="True" />
                                            <asp:CompareValidator runat="server" ControlToValidate="EstimatedAnaTime" Type="Double"
                                                Operator="DataTypeCheck" ErrorMessage="Number" ForeColor="Red" Font-Size="XX-Small" />
                                        </td>
                                        <td>
                                            <asp:TextBox id="RealAnaTime" runat="server" Text='<%# Bind("RealAnaTime") %>' />
                                            <asp:CompareValidator runat="server" ControlToValidate="RealAnaTime" Type="Double"
                                                Operator="DataTypeCheck" ErrorMessage="Number" ForeColor="Red" Font-Size="XX-Small" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="textBoxLabel">Development:</td>
                                        <td>
                                            <asp:TextBox id="EstimatedDevTime" runat="server" Text='<%# Bind("EstimatedDevTime") %>' />
                                            <asp:RequiredFieldValidator runat="server"
                                                ControlToValidate="EstimatedDevTime"
                                                ErrorMessage="*"
                                                ForeColor="Red" SetFocusOnError="True" />
                                            <asp:CompareValidator runat="server" ControlToValidate="EstimatedDevTime" Type="Double"
                                                Operator="DataTypeCheck" ErrorMessage="Number" ForeColor="Red" Font-Size="XX-Small" />
                                        </td>
                                        <td>
                                            <asp:TextBox id="RealDevTime" runat="server" Text='<%# Bind("RealDevTime") %>' />
                                            <asp:CompareValidator runat="server" ControlToValidate="RealDevTime" Type="Double"
                                                Operator="DataTypeCheck" ErrorMessage="Number" ForeColor="Red" Font-Size="XX-Small" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="textBoxLabel">Testing:</td>
                                        <td>
                                            <asp:TextBox id="EstimatedQATime" runat="server" Text='<%# Bind("EstimatedQATime") %>' />
                                            <asp:RequiredFieldValidator runat="server"
                                                ControlToValidate="EstimatedQATime"
                                                ErrorMessage="*"
                                                ForeColor="Red" SetFocusOnError="True" />
                                            <asp:CompareValidator runat="server" ControlToValidate="EstimatedQATime" Type="Double"
                                                Operator="DataTypeCheck" ErrorMessage="Number" ForeColor="Red" Font-Size="XX-Small" />
                                        </td>
                                        <td>
                                            <asp:TextBox id="RealQATime" runat="server" Text='<%# Bind("RealQATime") %>' />
                                            <asp:CompareValidator runat="server" ControlToValidate="RealQATime" Type="Double"
                                                Operator="DataTypeCheck" ErrorMessage="Number" ForeColor="Red" Font-Size="XX-Small" />                                          
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                    <asp:LinkButton ID="InsertButton" Text="&nbsp;Save&nbsp;" CommandName="Insert" RunAt="server" class="SaveButton"/>
                </InsertItemTemplate>                    
            </asp:FormView>                       
	    </div>    
    </asp:Panel>
    <!-- Final Pop Up -->

    <p>Search:
        <asp:TextBox ID="filterTextBox" runat="server"></asp:TextBox>
    </p>
    <p>      
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
            ConnectionString="<%$ ConnectionStrings:ApplicationServices %>" 
            SelectCommand="SELECT aspnet_Releases.* FROM aspnet_Releases">
        </asp:SqlDataSource>        
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
            DataKeyNames="ReleaseId" DataSourceID="SqlDataSource2" Width="100%" AllowSorting="true" OnSorting="GridView1_Sorting"
            CssClass="gridView" onselectedindexchanged="GridView1_SelectedIndexChanged" 
            EmptyDataText="No data">
            <Columns>
                <asp:BoundField DataField="ReleaseId" HeaderText="Id" 
                    SortExpression="ReleaseId"  ItemStyle-CssClass="boundfield-hidden"
                    HeaderStyle-CssClass="boundfield-hidden" />
                <asp:BoundField DataField="ReleaseName" HeaderText="Name" 
                    SortExpression="ReleaseName" ItemStyle-Width="400"/>
                <asp:BoundField DataField="State" HeaderText="State" 
                    SortExpression="State" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="100" />
                <asp:BoundField DataField="ReleasedPlannedDate" DataFormatString="{0: dd/MM/yyyy}" HeaderText="Planned Date" 
                    SortExpression="ReleasedPlannedDate" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="100" />
                <asp:BoundField DataField="ReleasedRealDate" DataFormatString="{0: dd/MM/yyyy}" HeaderText="Released Date" 
                    SortExpression="ReleasedRealDate" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="100" />
                <asp:CommandField ShowSelectButton="true" ButtonType="Link" Visible="true"
                    SelectText="<img src='images/Ok.png' />" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="50"/>
            </Columns>
            <EmptyDataRowStyle CssClass="nodata" HorizontalAlign="Center" VerticalAlign="Middle" BorderStyle="None" BackColor="White" ForeColor="Gray" />
            <HeaderStyle BackColor="#546E96" ForeColor="White" />
        </asp:GridView>        
    </p>
    </asp:Content>
