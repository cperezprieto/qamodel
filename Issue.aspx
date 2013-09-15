<%@ Page Title="Issue" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeFile="Issue.aspx.cs" Inherits="Issue" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
    <style type="text/css">
        .style1
        {
            width: 842px;
        }
    </style>
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent" EnableViewState="False">
    <h2>
        Issue
    
    &nbsp;</h2>
    <p>
        <asp:linkbutton ID="btReturn" runat="server" class="ReturnButton" onclick="btReturn_Click">&nbsp;Return&nbsp;</asp:linkbutton>        
    </p>    
    <hr />

    <asp:linkbutton id="btEdit" runat="server" class="EditButton" onclick="btEdit_Click">&nbsp;Edit&nbsp;</asp:linkbutton>
    
    <table> 
        <tr>
            <asp:SqlDataSource ID="SqlDataSourceIssue" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices %>">
            </asp:SqlDataSource>
            <td style="width:920px">              
                <asp:FormView ID="ReleaseFormView"
                    DataSourceID="SqlDataSourceIssue"
                    DataKeyNames="ErrorId"
                    runat="server" Enabled="False" Width="920px">

                    <HeaderStyle forecolor="white" backcolor="Blue" />                

                    <ItemTemplate>
                        <table>
                            <tr style="vertical-align:top">
                                <td style="width:920px">
                                    <p style="background-color:Gray;color:White">&nbsp;<span Class="textSpanBoldUnderline">Issue information</span></p>                                        
                                    <table>
                                        <tr>
                                            <td class="textBoxLabel">Issue Id:</td>
                                            <td><asp:TextBox id="ErrorId" runat="server" Text='<%# Eval("ErrorId") %>' BorderStyle="NotSet" Width="300px" /></td>
                                        </tr>
                                        <tr>
                                            <td class="textBoxLabel">CT:</td>
                                            <td><asp:TextBox id="ErrorCT" runat="server" Text='<%# Eval("ErrorCT") %>' BorderStyle="NotSet" /></td>
                                        </tr>
                                        <tr>
                                            <td class="textBoxLabel">Spira ID:</td>
                                            <td>                            
                                                <asp:TextBox id="ErrorSpiraId" runat="server" Text='<%# Eval("ErrorSpiraId") %>' CausesValidation="False" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="textBoxLabel">Title:</td>
                                            <td><asp:TextBox id="ErrorName" runat="server" Text='<%# Eval("ErrorName") %>' Width="780px"/></td>
                                        </tr>
                                        <tr>
                                            <td class="textBoxLabel">Description:</td>                                            
                                            <td><asp:TextBox id="ErrorDescription" TextMode="MultiLine" CssClass="text" runat="server" Text='<%# Eval("ErrorDescription") %>' Width="780px" Height="150px" style="Resize:none"  /></td>
                                        </tr>
                                        <tr>
                                            <td class="textBoxLabel">Type:</td>
                                            <td><asp:TextBox id="ErrorType" runat="server" Text='<%# Eval("ErrorType") %>' /></td>
                                        </tr>
                                        <tr>
                                            <td class="textBoxLabel">Priority:</td>
                                            <td><asp:TextBox id="ErrorPriority" runat="server" Text='<%# Eval("ErrorPriority") %>' /></td>
                                        </tr>
                                        <tr>
                                            <td class="textBoxLabel">Found in:</td>
                                            <td><asp:TextBox id="ErrorFoundRelease" runat="server" Text='<%# Eval("ErrorFoundRelease") %>' Width="300px" /></td>
                                        </tr>
                                        <tr>
                                            <td class="textBoxLabel">Resolved in:</td>
                                            <td><asp:TextBox id="ErrorResolvedRelease" runat="server" Text='<%# Eval("ErrorResolvedRelease") %>' Width="300px" /></td>
                                        </tr>
                                        <tr>
                                            <td class="textBoxLabel">Found date:</td>
                                            <td><asp:TextBox id="ErrorFoundDate" runat="server" Text='<%# Eval("ErrorFoundDate", "{0: dd/MM/yyyy}") %>' /></td>
                                        </tr>
                                        <tr>
                                            <td class="textBoxLabel">Resolved date:</td>
                                            <td><asp:TextBox id="ErrorResolvedDate" runat="server" Text='<%# Eval("ErrorResolvedDate", "{0: dd/MM/yyyy}") %>' /></td>
                                        </tr>
                                        <tr>
                                            <td class="textBoxLabel">Affected clients:</td>
                                            <td><asp:TextBox id="ErrorAffectedClients" runat="server" Text='<%# Eval("ErrorAffectedClients") %>' /></td>
                                        </tr>                                                                                                                          
                                    </table>                                        
                                </td>
                            </tr>
                            <tr style="vertical-align:top">
                                <td style="width:920px">                                    
                                </td>                                
                            </tr>
                        </table>               
                    </ItemTemplate>
                </asp:FormView>                
            </td>
        </tr>            
        <tr>            
            <td style="width:920px">
                <br />
                <table style="background-color:Gray; color:White; width: 920px;">
                    <tr>
                        <td style="width: 842px">
                            &nbsp;<span Class="textSpanBoldUnderline">Assignment history</span>
                        </td>
                        <td style="vertical-align:middle; text-align:center">
                            <asp:Button id="btViewAssignmentHistory" runat="server" BorderStyle="none" 
                                    Text="Show" onclick="btViewAssignmentHistory_Click" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td>
                <asp:SqlDataSource ID="SqlDataSource3" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:ApplicationServices %>">
                </asp:SqlDataSource>                    
                <div id="divAssignmentHistory" style="visibility:visible; max-width:920px">
                        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
                        DataKeyNames="StateId" DataSourceID="SqlDataSource3" Width="920px" 
                        AllowSorting="True" CssClass="gridView" onsorting="GridView1_Sorting">                            
                        <Columns>                
                            <asp:BoundField DataField="StateId" HeaderText="Id" 
                                SortExpression="StateId" ItemStyle-CssClass="boundfield-hidden" HeaderStyle-CssClass="boundfield-hidden" />
                            <asp:BoundField DataField="AssignedTo" HeaderText="Assigned To" 
                                SortExpression="AssignedTo" />
                            <asp:BoundField DataField="AssignmentDate" DataFormatString="{0: dd/MM/yyyy}" HeaderText="Assignment Date" 
                                SortExpression="AssignmentDate" />
                            <asp:BoundField DataField="Comments" HeaderText="Comments" 
                                SortExpression="Comments" />
                            <asp:BoundField DataField="State" HeaderText="State" 
                                SortExpression="State" />
                            <asp:BoundField DataField="ResolutionType" HeaderText="Resolution Type" 
                                SortExpression="ResolutionType" />
                            <asp:BoundField DataField="Resolution" HeaderText="Resolution" 
                                SortExpression="Resolution" />
                            <asp:BoundField DataField="UserId" HeaderText="User Id" 
                                SortExpression="UserId" />
                        </Columns>
                        <HeaderStyle BackColor="#546E96" CssClass="gridViewHeader" ForeColor="White" />            
                    </asp:GridView>
                </div>                   
            </td>
        </tr>
    </table>    
</asp:Content>
