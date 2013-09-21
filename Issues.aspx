<%@ Page Title="Issues" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeFile="Issues.aspx.cs" Inherits="Issues" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">    
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">    
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
                    }
                });
            });
        });
    </script>
    
    <h2>
        Issues</h2>
    <p>
        Application   
        &nbsp;<asp:SqlDataSource ID="SqlApplications" runat="server" 
            ConnectionString="<%$ ConnectionStrings:ApplicationServices %>" 
            SelectCommand="SELECT aspnet_Applications.* FROM aspnet_Applications">
        </asp:SqlDataSource>
        <asp:ListBox ID="ListBox1" runat="server" DataSourceID="SqlApplications" DataTextField="ApplicationName"
        DataValueField="ApplicationId" Rows="1" AppendDataBoundItems="true" 
            onselectedindexchanged="ListBox1_SelectedIndexChanged" AutoPostBack="True" 
            ondatabound="ListBox1_DataBound">
            <asp:ListItem Enabled="true" Text="ALL" Value="0"></asp:ListItem>
        </asp:ListBox>        
        &nbsp;&nbsp;&nbsp;&nbsp;Release
        &nbsp;<asp:SqlDataSource ID="SqlReleases" runat="server" 
            ConnectionString="<%$ ConnectionStrings:ApplicationServices %>" 
            SelectCommand="SELECT aspnet_Releases.* FROM aspnet_Releases">
        </asp:SqlDataSource>
        <asp:ListBox ID="ListBox2" runat="server" DataSourceID="SqlReleases" DataTextField="ReleaseName"
        DataValueField="ReleaseId" Rows="1" AppendDataBoundItems="true" 
            onselectedindexchanged="ListBox2_SelectedIndexChanged" AutoPostBack="True" 
            ondatabound="ListBox2_DataBound">
            <asp:ListItem Enabled="true" Text="ALL" Value="0"></asp:ListItem>  
        </asp:ListBox>       
    </p>
        <asp:Button id="btReturn" runat="server" onclick="btReturn_Click" 
            BorderStyle="None" Visible="false" Text="Return" />
    <hr />

    <p>
        List of issues
    </p>

    <!-- Panel under Construction Add Release -->
    <!-- Aqui mostramos una capa para añadir los errores -->
    <asp:LinkButton runat="server" id="AddIssueButton" class="AddButton" OnClick="AddIssueButton_Click" CausesValidation="false" Visible="true" >&nbsp;Add&nbsp;</asp:LinkButton>
    <asp:Panel runat="server" id="ModalAddIssue" class="modalDialogUnderConstruction" Visible="false">
	    <div>
            <asp:LinkButton runat="server" id="ModalAddIssueClose" class="close" OnClick="ModalAddIssueClose_Click" CausesValidation="false">X</asp:LinkButton>
            <p><img src="images/under_construction_transparentBG_0.png" /></p>
        </div>
    </asp:Panel>
    <!-- Fin Panel under Construction -->

    <p>Search:
        <asp:TextBox ID="filterTextBox" runat="server"></asp:TextBox>
    </p>
    <p>      
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
            ConnectionString="<%$ ConnectionStrings:ApplicationServices %>" 
            SelectCommand="SELECT vw_Errors_ErrorStates.* FROM vw_Errors_ErrorStates">
        </asp:SqlDataSource>        
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
            DataKeyNames="ErrorId" DataSourceID="SqlDataSource2" Width="100%" 
            CssClass="gridView" AllowSorting="true"
            onselectedindexchanged="GridView1_SelectedIndexChanged" 
            ondatabound="GridView1_DataBound">
            <Columns>
                <asp:BoundField DataField="ErrorId" HeaderText="Id" 
                    SortExpression="ErrorId" ItemStyle-CssClass="boundfield-hidden" HeaderStyle-CssClass="boundfield-hidden" />                    
                <asp:BoundField DataField="ErrorCT" HeaderText="CT" 
                    SortExpression="ErrorCT" ItemStyle-Width="70px"/>
                <asp:BoundField DataField="ErrorSpiraId" HeaderText="Spira Id" 
                    SortExpression="ErrorSpiraId" ItemStyle-Width="70px"/>
                <asp:BoundField DataField="ErrorName" HeaderText="Name" 
                    SortExpression="ErrorName" ItemStyle-Width="150px" />
                <asp:BoundField DataField="ErrorDescription" HeaderText="Description" 
                    SortExpression="ErrorDescription" ItemStyle-Width="200px" />
                <asp:BoundField DataField="ErrorType" HeaderText="Type" 
                    SortExpression="ErrorType" ItemStyle-Width="50px" />
                <asp:BoundField DataField="ErrorPriority" HeaderText="Priority" 
                    SortExpression="ErrorPriority" ItemStyle-Width="50px" />
                <asp:BoundField DataField="State" HeaderText="State" 
                    SortExpression="State" ItemStyle-Width="50px" />
                <asp:BoundField DataField="ErrorFoundRelease" HeaderText="Found in" 
                    SortExpression="ErrorFoundRelease" ItemStyle-CssClass="boundfield-hidden" HeaderStyle-CssClass="boundfield-hidden" />
                <asp:BoundField DataField="ErrorResolvedRelease" HeaderText="Resolved in" 
                    SortExpression="ErrorResolvedRelease" ItemStyle-CssClass="boundfield-hidden" HeaderStyle-CssClass="boundfield-hidden" />
                <asp:BoundField DataField="ErrorFoundDate" DataFormatString="{0:dd/MM/yyyy}" HeaderText="Found date" 
                    SortExpression="ErrorFoundDate" ItemStyle-Width="70px" />
                <asp:BoundField DataField="ErrorResolvedDate" DataFormatString="{0:dd/MM/yyyy}" HeaderText="Resolved date" 
                    SortExpression="ErrorResolvedDate" ItemStyle-CssClass="boundfield-hidden" HeaderStyle-CssClass="boundfield-hidden" />
                <asp:BoundField DataField="ErrorAffectedClients" HeaderText="Affected clients" 
                    SortExpression="ErrorAffectedClients" ItemStyle-Width="60px" />
                <asp:CommandField ShowSelectButton="true" ButtonType="Link" Visible="true"
                    SelectText="<img src='images/Ok.png' />" ItemStyle-Width="30px" ItemStyle-HorizontalAlign="Center" />                  
            </Columns>
            <HeaderStyle BackColor="#546E96" ForeColor="White" />
        </asp:GridView>        
    </p>
    </asp:Content>
