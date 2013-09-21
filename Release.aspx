<%@ Page Title="Release" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeFile="Release.aspx.cs" Inherits="Release" %>

<%@ Register Assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI.DataVisualization.Charting" TagPrefix="asp" %>

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
        Release
    
    &nbsp;<asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:ApplicationServices %>" 
            SelectCommand="SELECT aspnet_Releases.* FROM aspnet_Releases">
        </asp:SqlDataSource>
        <asp:ListBox ID="ListBox1" runat="server" DataSourceID="SqlDataSource1" DataTextField="ReleaseName"
        DataValueField="ReleaseId" Rows="1" AppendDataBoundItems="true" 
            onselectedindexchanged="ListBox1_SelectedIndexChanged" AutoPostBack="True" 
            ondatabound="ListBox1_DataBound">            
        </asp:ListBox>        
    </h2>
    <p>
        <asp:LinkButton class="ReturnButton" id="ReturnButton" runat="server" onclick="ReturnButton_Click" Text="&nbsp;Return&nbsp;" />
    </p>
    <div class="clear hideSkiplink">
        <asp:Menu ID="ReleaseMenu" runat="server" CssClass="menu" 
            EnableViewState="False" IncludeStyleBlock="False" Orientation="Horizontal" OnMenuItemClick="ReleaseMenu_MenuItemClick">                                
            <Items>                
                <asp:MenuItem Text="Information" Value="Information">                      
                </asp:MenuItem>
                <asp:MenuItem Text="Dashboard" Value="Dashboard" >                                    
                </asp:MenuItem>
            </Items>
        </asp:Menu>
    </div>  
    <div id="divDashboard" runat="server" visible="false">        
        <h1 class="divTitle">DashBoard</h1>        
        <table>            
            <tr>
                <td>
                    <asp:SqlDataSource ID="SqlDataSourceUserIssuesFoundByRelease" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:ApplicationServices %>">
                    </asp:SqlDataSource>
                    <asp:Chart ID="UserIssuesFoundByRelease" runat="server" Width="300" Height="170" 
                        DataSourceID="SqlDataSourceUserIssuesFoundByRelease" BorderlineWidth="1" BorderlineDashStyle="Solid" BorderlineColor="DarkGray"
                        onload="UserIssuesFoundByRelease_Load" BackColor="White">
                        <Titles>
                            <asp:Title Text="User Issues By Release" Docking="Top" Alignment="TopCenter" ForeColor="#CCCCCC" BackColor="#465C71" />
                        </Titles>
                        <Series>
                            <asp:Series ChartArea="ChartArea1" ChartType="Column" 
                                Name="Release" 
                                IsVisibleInLegend="True"                             
                                Palette="BrightPastel" IsValueShownAsLabel="True" 
                                LabelForeColor="DarkGray" XAxisType="Primary" YAxisType="Primary" XValueMember="ENVIRONMENT" YValueMembers="COUNTER">                                
                            </asp:Series>                            
                        </Series>
                        <ChartAreas>
                            <asp:ChartArea Name="ChartArea1">
                                <Area3DStyle Enable3D="False" LightStyle="Realistic" />
                                <AxisX LineColor="Gray" IsMarginVisible="False">  
                                    <MajorGrid Enabled="false" />  
                                    <LabelStyle ForeColor="DarkGray" />                                      
                                </AxisX>  
                                <AxisY Enabled="False" IsLabelAutoFit="False">  
                                    <MajorGrid LineColor="DarkGray" />  
                                    <LabelStyle ForeColor="DarkGray" />                                    
                                </AxisY>
                            </asp:ChartArea>
                        </ChartAreas>
                    </asp:Chart>                    
                </td>
                <td>                    
                    <asp:SqlDataSource ID="SqlDataSourceUserIssuesFoundByCodeLines" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:ApplicationServices %>">
                    </asp:SqlDataSource>
                    <asp:Chart ID="UserIssuesFoundByCodeLines" runat="server" Width="300" Height="170" 
                        DataSourceID="SqlDataSourceUserIssuesFoundByCodeLines" BorderlineWidth="1" BorderlineDashStyle="Solid" BorderlineColor="DarkGray" 
                        onload="UserIssuesFoundByCodeLines_Load" >
                        <Titles>
                            <asp:Title Text="User Issues By Code Lines (x 10.000)"  ForeColor="#CCCCCC" BackColor="#465C71"
                                Docking="Top" Alignment="TopCenter"/>                            
                        </Titles>
                        <Series>
                            <asp:Series ChartArea="ChartArea1" ChartType="Column" 
                                Name="Release" 
                                IsVisibleInLegend="True"                             
                                Palette="BrightPastel" IsValueShownAsLabel="True" 
                                LabelForeColor="DarkGray" XAxisType="Primary" YAxisType="Primary" XValueMember="ENVIRONMENT" YValueMembers="COUNTER">                                
                            </asp:Series>                            
                        </Series>
                        <ChartAreas>
                            <asp:ChartArea Name="ChartArea1">
                                <Area3DStyle Enable3D="False" LightStyle="Realistic" />
                                <AxisX LineColor="Gray" IsMarginVisible="false">  
                                    <MajorGrid Enabled="false" />  
                                    <LabelStyle ForeColor="DarkGray" />                                      
                                </AxisX>  
                                <AxisY Enabled="False" IsLabelAutoFit="False">  
                                    <MajorGrid Enabled="true" LineColor="DarkGray" />  
                                    <LabelStyle ForeColor="DarkGray" />                                    
                                </AxisY>
                            </asp:ChartArea>
                        </ChartAreas>
                    </asp:Chart>                    
                </td>
                <td>
                    <asp:SqlDataSource ID="SqlDataSourceUserIssuesFoundWeightedByTesters" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:ApplicationServices %>">
                    </asp:SqlDataSource>
                    <asp:Chart ID="UserIssuesFoundWeightedByTesters" runat="server" Width="300" Height="170" 
                        DataSourceID="SqlDataSourceUserIssuesFoundWeightedByTesters" BorderlineWidth="1" BorderlineDashStyle="Solid" BorderlineColor="DarkGray" 
                        onload="UserIssuesFoundWeightedByTesters_Load">
                        <Titles>
                            <asp:Title Text="User Issues Weighted By Testers"  ForeColor="#CCCCCC" BackColor="#465C71"
                                Docking="Top" Alignment="TopCenter"/>                            
                        </Titles>
                        <Series>
                            <asp:Series ChartArea="ChartArea1" ChartType="Column" 
                                Name="Release" 
                                IsVisibleInLegend="True"                             
                                Palette="BrightPastel" IsValueShownAsLabel="True" 
                                LabelForeColor="DarkGray" XAxisType="Primary" YAxisType="Primary" XValueMember="ENVIRONMENT" YValueMembers="COUNTER">                                
                            </asp:Series>                            
                        </Series>
                        <ChartAreas>
                            <asp:ChartArea Name="ChartArea1">
                                <Area3DStyle Enable3D="False" LightStyle="Realistic" />
                                <AxisX LineColor="Gray" IsMarginVisible="false">  
                                    <MajorGrid Enabled="false" />  
                                    <LabelStyle ForeColor="DarkGray" />                                      
                                </AxisX>  
                                <AxisY Enabled="False" IsLabelAutoFit="False">  
                                    <MajorGrid Enabled="true" LineColor="DarkGray" />  
                                    <LabelStyle ForeColor="DarkGray" />                                    
                                </AxisY>
                            </asp:ChartArea>
                        </ChartAreas>
                    </asp:Chart>                    
                </td>
            </tr>
            <tr>
                <td>
                    <asp:SqlDataSource ID="SqlDataSourceUserIssuesFoundWeightedByDevelopers" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:ApplicationServices %>">
                    </asp:SqlDataSource>
                    <asp:Chart ID="UserIssuesFoundWeightedByDevelopers" runat="server" Width="300" Height="170" 
                        DataSourceID="SqlDataSourceUserIssuesFoundWeightedByDevelopers" BorderlineWidth="1" BorderlineDashStyle="Solid" BorderlineColor="DarkGray" 
                        onload="UserIssuesFoundWeightedByDevelopers_Load">
                        <Titles>
                            <asp:Title Text="User Issues Weighted By Developers"  ForeColor="#CCCCCC" BackColor="#465C71"
                                Docking="Top" Alignment="TopCenter"/>                            
                        </Titles>
                        <Series>
                            <asp:Series ChartArea="ChartArea1" ChartType="Column" 
                                Name="Release" 
                                IsVisibleInLegend="True"                             
                                Palette="BrightPastel" IsValueShownAsLabel="True" 
                                LabelForeColor="DarkGray" XAxisType="Primary" YAxisType="Primary" XValueMember="ENVIRONMENT" YValueMembers="COUNTER">                                
                            </asp:Series>                            
                        </Series>
                        <ChartAreas>
                            <asp:ChartArea Name="ChartArea1">
                                <Area3DStyle Enable3D="False" LightStyle="Realistic" />
                                <AxisX LineColor="Gray" IsMarginVisible="false" LabelAutoFitMaxFontSize="10">  
                                    <MajorGrid Enabled="false" />  
                                    <LabelStyle ForeColor="DarkGray" />                                      
                                </AxisX>  
                                <AxisY Enabled="False" IsLabelAutoFit="False">  
                                    <MajorGrid Enabled="true" LineColor="DarkGray" />  
                                    <LabelStyle ForeColor="DarkGray" />                                    
                                </AxisY>
                            </asp:ChartArea>
                        </ChartAreas>
                    </asp:Chart>                    
                </td>
                <td colspan="2">
                    <asp:SqlDataSource ID="SqlDataSourceReleaseTimeDesviation" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:ApplicationServices %>">
                    </asp:SqlDataSource>
                    <asp:Chart ID="ReleaseTimeDesviation" runat="server" Width="604px" Height="170" 
                        DataSourceID="SqlDataSourceReleaseTimeDesviation" BorderlineWidth="1" BorderlineDashStyle="Solid" BorderlineColor="DarkGray" 
                        onload="ReleaseTimeDesviation_Load">
                        <Legends>
                            <asp:Legend Name="Legend1" LegendStyle="Row" Alignment="Center" Docking="Top" >
                            </asp:Legend>
                        </Legends>
                        <Titles>
                            <asp:Title Text="Time Desviation"  ForeColor="#CCCCCC" BackColor="#465C71"
                                Docking="Top" Alignment="TopCenter"/>                            
                        </Titles>                        
                        <Series>
                            <asp:Series ChartArea="ChartArea1" Legend="Legend1" Name="Development" IsValueShownAsLabel="True"
                                LabelForeColor="DarkGray" XValueMember="ENVIRONMENT" YValueMembers="Development" IsVisibleInLegend="False" ToolTip="Development">
                            </asp:Series>
                            <asp:Series ChartArea="ChartArea1" Legend="Legend1" Name="Quality Assurance" IsValueShownAsLabel="True"
                                LabelForeColor="DarkGray" XValueMember="ENVIRONMENT" YValueMembers="Quality Assurance" IsVisibleInLegend="False" ToolTip="Quality Assurance">
                            </asp:Series>
                            <asp:Series ChartArea="ChartArea1" Legend="Legend1" Name="Design" IsValueShownAsLabel="True"
                                LabelForeColor="DarkGray" XValueMember="ENVIRONMENT" YValueMembers="Design" IsVisibleInLegend="False" ToolTip="Design">
                            </asp:Series>
                        </Series>
                        <ChartAreas>
                            <asp:ChartArea Name="ChartArea1">                                
                                <Area3DStyle Enable3D="False" LightStyle="Realistic" />
                                <AxisX LineColor="Gray" IsMarginVisible="false" LabelAutoFitMaxFontSize="9">  
                                    <MajorGrid Enabled="false" />  
                                    <LabelStyle ForeColor="DarkGray" />                                      
                                </AxisX>  
                                <AxisY Enabled="False" IsLabelAutoFit="False">  
                                    <MajorGrid Enabled="true" LineColor="DarkGray" />  
                                    <LabelStyle ForeColor="DarkGray" />                                    
                                </AxisY>
                            </asp:ChartArea>
                        </ChartAreas>
                    </asp:Chart> 
                </td>                
            </tr>
            <tr>
                <td colspan="3">
                    <asp:SqlDataSource ID="SqlDataSourceReleaseTimeEffortPercentage" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:ApplicationServices %>">
                    </asp:SqlDataSource>
                    <asp:Chart ID="ReleaseTimeEffortPercentage" runat="server" Width="908px" Height="250" 
                        DataSourceID="SqlDataSourceReleaseTimeEffortPercentage" BorderlineWidth="1" BorderlineDashStyle="Solid" BorderlineColor="DarkGray" 
                        onload="ReleaseTimeEffortPercentage_Load">
                        <Legends>
                            <asp:Legend Name="Legend1" LegendStyle="Row" Alignment="Center" Docking="Top" >
                            </asp:Legend>
                        </Legends>
                        <Titles>
                            <asp:Title Text="Time Effort Percentage"  ForeColor="#CCCCCC" BackColor="#465C71"
                                Docking="Top" Alignment="TopCenter"/>
                            <asp:Title Text="All Applications" ForeColor="DarkGray" Docking="Bottom" DockedToChartArea="ChartArea1" IsDockedInsideChartArea="false" />
                            <asp:Title Text="Application" ForeColor="DarkGray" Docking="Bottom" DockedToChartArea="ChartArea2" IsDockedInsideChartArea="false" />
                            <asp:Title Text="Release" ForeColor="DarkGray" Docking="Bottom" DockedToChartArea="ChartArea3" IsDockedInsideChartArea="false" />
                        </Titles>                        
                        <Series>
                            <asp:Series ChartArea="ChartArea1" ChartType="Pie" Legend="Legend1" Name="All Applications" IsValueShownAsLabel="True"
                                LabelForeColor="DarkGray" XValueMember="ENVIRONMENT" YValueMembers="All Applications" IsVisibleInLegend="True" ToolTip="">
                            </asp:Series>
                            <asp:Series ChartArea="ChartArea2" ChartType="Pie" Legend="Legend1" Name="Application" IsValueShownAsLabel="True"
                                LabelForeColor="DarkGray" XValueMember="ENVIRONMENT" YValueMembers="Application" IsVisibleInLegend="False">
                            </asp:Series>
                            <asp:Series ChartArea="ChartArea3" ChartType="Pie" Legend="Legend1" Name="Release" IsValueShownAsLabel="True"
                                LabelForeColor="DarkGray" XValueMember="ENVIRONMENT" YValueMembers="Release" IsVisibleInLegend="False">
                            </asp:Series>
                        </Series>
                        <ChartAreas>
                            <asp:ChartArea Name="ChartArea1" AlignmentOrientation="Horizontal">                                
                                <Position Height="65" Width="30" X="1" Y="25" Auto="False" />
                                <Area3DStyle Enable3D="False" LightStyle="Realistic" />
                                <AxisX LineColor="Gray" IsMarginVisible="false">                                      
                                    <MajorGrid Enabled="false" />  
                                    <LabelStyle ForeColor="DarkGray" />                                      
                                </AxisX>  
                                <AxisY Enabled="False" IsLabelAutoFit="False">  
                                    <MajorGrid Enabled="true" LineColor="DarkGray" />  
                                    <LabelStyle ForeColor="DarkGray" />                                    
                                </AxisY>
                            </asp:ChartArea>
                            <asp:ChartArea Name="ChartArea2" AlignmentOrientation="Horizontal">
                                <Position Height="65" Width="30" X="35" Y="25" Auto="False" />
                                <Area3DStyle Enable3D="False" LightStyle="Realistic" />
                                <AxisX LineColor="Gray" IsMarginVisible="false">  
                                    <MajorGrid Enabled="false" />  
                                    <LabelStyle ForeColor="DarkGray" />                                      
                                </AxisX>  
                                <AxisY Enabled="False" IsLabelAutoFit="False">  
                                    <MajorGrid Enabled="true" LineColor="DarkGray" />  
                                    <LabelStyle ForeColor="DarkGray" />                                    
                                </AxisY>
                            </asp:ChartArea>
                            <asp:ChartArea Name="ChartArea3" AlignmentOrientation="Horizontal">
                                <Position Height="65" Width="30" X="70" Y="25" Auto="False" />
                                <Area3DStyle Enable3D="False" LightStyle="Realistic" />
                                <AxisX LineColor="Gray" IsMarginVisible="false">  
                                    <MajorGrid Enabled="false" />  
                                    <LabelStyle ForeColor="DarkGray" />                                      
                                </AxisX>  
                                <AxisY Enabled="False" IsLabelAutoFit="False">  
                                    <MajorGrid Enabled="true" LineColor="DarkGray" />  
                                    <LabelStyle ForeColor="DarkGray" />                                    
                                </AxisY>
                            </asp:ChartArea>
                        </ChartAreas>
                    </asp:Chart>
                </td>
            </tr>
        </table>        
    </div>
    <div id="divInformation" runat="server" visible="true">
        <h1 class="divTitle">Information</h1>   
        <asp:LinkButton id="EditButton" runat="server" class="EditButton" Text="&nbsp;Edit&nbsp;" CommandName="Edit" onclick="EditButtonRelease_Click"/>
            
            <!-- Panel under Construction aqui no iria un panel, sino que se habilitaria
                la edicion del formulario.
                Cuando se habilita la edicion, que debe cambiar el boton a Cancelar, hay que mostrar dos acciones
                que si que van con div, Cambiar Estado y Asignar a, esto dentro de la opcion que nuestra
                el estado y el propietario (que tampoco esta hecho)-->
            <asp:Panel runat="server" id="ModalEditRelease" class="modalDialogUnderConstruction" Visible="false">
	            <div>
                    <asp:LinkButton runat="server" id="CloseButton" class="close" OnClick="CloseButtonRelease_Click" CausesValidation="false">X</asp:LinkButton>
                    <p><img src="images/under_construction_transparentBG_0.png" /></p>
                </div>
            </asp:Panel>
            <!-- Fin Panel under Construction -->

        <asp:SqlDataSource ID="SqlDataSourceReleaseInformation" runat="server" ConnectionString="<%$ ConnectionStrings:ApplicationServices%>">
        </asp:SqlDataSource>        
        <table style="width:920px"> 
            <tr>               
                <td>              
                    <asp:FormView ID="ReleaseFormView"
                        DataSourceID="SqlDataSourceReleaseInformation"                        
                        DataKeyNames="ReleaseId"
                        runat="server" Enabled="False" Width="920px" onload="ReleaseFormView_Load">

                        <HeaderStyle forecolor="white" backcolor="Blue" />                

                        <ItemTemplate>
                            <table>
                                <tr style="vertical-align:top">
                                    <td style="width:60%">
                                        <p style="background-color:Gray;color:White">&nbsp;<span class="textSpanBoldUnderline">Release Information</span></p>
                                        
                                        <table>                                            
                                            <tr>
                                                <td class="textBoxLabel">Release Name:</td>
                                                <td><asp:TextBox id="ReleaseName" runat="server" Text='<%# Eval("ReleaseName") %>' BorderStyle="NotSet" /></td>
                                            </tr>
                                            <tr>
                                                <td class="textBoxLabel">State:</td>
                                                <td>                            
                                                    <asp:TextBox id="State" runat="server" Text='<%# Eval("State") %>' CausesValidation="False" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="textBoxLabel">Code Lines:</td>
                                                <td><asp:TextBox id="CodeLines" runat="server" Text='<%# Eval("CodeLines") %>' /></td>
                                            </tr>
                                            <tr>
                                                <td class="textBoxLabel">Builds number:</td>
                                                <td><asp:TextBox id="BuildsNumber" runat="server" Text='<%# Eval("BuildsNumber") %>' /></td>
                                            </tr>
                                            <tr>
                                                <td class="textBoxLabel">BaseLines Number:</td>
                                                <td><asp:TextBox id="BaseLinesNumber" runat="server" Text='<%# Eval("BaseLinesNumber") %>' /></td>
                                            </tr>
                                            <tr>
                                                <td class="textBoxLabel">Planned Date:</td>
                                                <td><asp:TextBox id="ReleasedPlannedDate" runat="server" Text='<%# Eval("ReleasedPlannedDate", "{0: dd/MM/yyyy}") %>' /></td>
                                            </tr>
                                            <tr>
                                                <td class="textBoxLabel">Released Date:</td>
                                                <td><asp:TextBox id="ReleasedRealDate" runat="server" Text='<%# Eval("ReleasedRealDate", "{0: dd/MM/yyyy}") %>' /></td>
                                            </tr>
                                            <tr>
                                                <td class="textBoxLabel">Requirements Planned:</td>
                                                <td>
                                                    <asp:TextBox id="RequirementsAsociated" runat="server" Text='<%# Eval("RequirementsAsociated") %>' />                                                     
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="textBoxLabel">Requirements Done:</td>
                                                <td>
                                                    <asp:TextBox id="RequirementsDone" runat="server" Text='<%# Eval("RequirementsDone") %>' />                                                    
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
                                                            <td><asp:TextBox id="TestCases" runat="server" Text='<%# Eval("TestCases") %>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td class="textBoxLabel">Test Runs Number:</td>
                                                            <td><asp:TextBox id="TestRuns" runat="server" Text='<%# Eval("TestRuns") %>' /></td>
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
                                                            <td><asp:TextBox id="ErrorAnaP1Found" style="max-width:60px" runat="server" Text='<%# Eval("ErrorAnaP1Found") %>' /></td>
                                                            <td><asp:TextBox id="ErrorAnaP2Found" style="max-width:60px" runat="server" Text='<%# Eval("ErrorAnaP2Found") %>' /></td>
                                                            <td><asp:TextBox id="ErrorAnaP3Found" style="max-width:60px" runat="server" Text='<%# Eval("ErrorAnaP3Found") %>' /></td>
                                                            <td><asp:TextBox id="ErrorAnaP4Found" style="max-width:60px" runat="server" Text='<%# Eval("ErrorAnaP4Found") %>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td>Development:</td>
                                                            <td><asp:TextBox id="ErrorDesP1Found" style="max-width:60px" runat="server" Text='<%# Eval("ErrorDesP1Found") %>' /></td>
                                                            <td><asp:TextBox id="ErrorDesP2Found" style="max-width:60px" runat="server" Text='<%# Eval("ErrorDesP2Found") %>' /></td>
                                                            <td><asp:TextBox id="ErrorDesP3Found" style="max-width:60px" runat="server" Text='<%# Eval("ErrorDesP3Found") %>' /></td>
                                                            <td><asp:TextBox id="ErrorDesP4Found" style="max-width:60px" runat="server" Text='<%# Eval("ErrorDesP4Found") %>' /></td>
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
                                                            <td><asp:TextBox id="ErrorAnaP1Unresolved" style="max-width:60px" runat="server" Text='<%# Eval("ErrorAnaP1Unresolved") %>' /></td>
                                                            <td><asp:TextBox id="ErrorAnaP2Unresolved" style="max-width:60px" runat="server" Text='<%# Eval("ErrorAnaP2Unresolved") %>' /></td>
                                                            <td><asp:TextBox id="ErrorAnaP3Unresolved" style="max-width:60px" runat="server" Text='<%# Eval("ErrorAnaP3Unresolved") %>' /></td>
                                                            <td><asp:TextBox id="ErrorAnaP4Unresolved" style="max-width:60px" runat="server" Text='<%# Eval("ErrorAnaP4Unresolved") %>' /></td>
                                                        </tr>
                                                        <tr>
                                                            <td>Development:</td>
                                                            <td><asp:TextBox id="ErrorDesP1Unresolved" style="max-width:60px" runat="server" Text='<%# Eval("ErrorDesP1Unresolved") %>' /></td>
                                                            <td><asp:TextBox id="ErrorDesP2Unresolved" style="max-width:60px" runat="server" Text='<%# Eval("ErrorDesP2Unresolved") %>' /></td>
                                                            <td><asp:TextBox id="ErrorDesP3Unresolved" style="max-width:60px" runat="server" Text='<%# Eval("ErrorDesP3Unresolved") %>' /></td>
                                                            <td><asp:TextBox id="ErrorDesP4Unresolved" style="max-width:60px" runat="server" Text='<%# Eval("ErrorDesP4Unresolved") %>' /></td>
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
                                                <td><asp:TextBox id="AnalistsNumber" runat="server" Text='<%# Eval("AnalistsNumber") %>' /></td>
                                            </tr>
                                            <tr>
                                                <td class="textBoxLabel">Developers Number:</td>
                                                <td><asp:TextBox id="DevelopersNumber" runat="server" Text='<%# Eval("DevelopersNumber") %>' /></td>
                                            </tr>
                                            <tr>
                                                <td class="textBoxLabel">Testers Number:</td>
                                                <td><asp:TextBox id="TestersNumber" runat="server" Text='<%# Eval("TestersNumber") %>' /></td>
                                            </tr>
                                        </table>
                                    </td>
                                    <td style="width:5%">
                                    </td>
                                    <td style="width:35%">
                                        <p style="background-color:Gray;color:White">&nbsp;<span Class="textSpanBoldUnderline">Time Effort</span></p>                                        
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
                                                <td><asp:TextBox id="EstimatedAnaTime" runat="server" Text='<%# Eval("EstimatedAnaTime") %>' /></td>
                                                <td><asp:TextBox id="RealAnaTime" runat="server" Text='<%# Eval("RealAnaTime") %>' /></td>
                                            </tr>
                                            <tr>
                                                <td class="textBoxLabel">Development:</td>
                                                <td><asp:TextBox id="EstimatedDevTime" runat="server" Text='<%# Eval("EstimatedDevTime") %>' /></td>
                                                <td><asp:TextBox id="RealDevTime" runat="server" Text='<%# Eval("RealDevTime") %>' /></td>
                                            </tr>
                                            <tr>
                                                <td class="textBoxLabel">Testing:</td>
                                                <td><asp:TextBox id="EstimatedQATime" runat="server" Text='<%# Eval("EstimatedQATime") %>' /></td>
                                                <td><asp:TextBox id="RealQATime" runat="server" Text='<%# Eval("RealQATime") %>' /></td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>               
                        </ItemTemplate>
                    </asp:FormView>                
                </td>
            </tr>            
            <tr>            
                <td>
                    <br />
                    <table style="background-color:Gray; color:White; width: 920px;">
                        <tr>
                            <td style="width: 842px">
                                &nbsp;<span Class="textSpanBoldUnderline">Requirements</span>
                            </td>
                            <td style="vertical-align:middle; text-align:center">
                                <asp:Button id="btViewRequirements" runat="server" BorderStyle="none" 
                                        Text="Show" onclick="btViewRequirements_Click" />
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
                    <div id="divRequirements" style="visibility:visible; max-width:920px">
                        <!-- Panel under Construction Add Release -->
                        <!-- Aqui mostramos una capa con un grid con varios elementos selecionables en el que aparecen
                            todas los Requisitos asociados a esta Aplicación cuyo estado es Done = False.
                            Además tendra la opcion de añadir un nuevo Requisito -->
                        <asp:LinkButton runat="server" id="AddReleaseButton" class="AddButton" OnClick="AddReleaseButton_Click" CausesValidation="false" Visible="false" >&nbsp;Add&nbsp;</asp:LinkButton>
                        <asp:Panel runat="server" id="ModalAddRelease" class="modalDialogUnderConstruction" Visible="false">
	                        <div>
                                <asp:LinkButton runat="server" id="AddReleaseClose" class="close" OnClick="AddReleaseClose_Click" CausesValidation="false">X</asp:LinkButton>
                                <p><img src="images/under_construction_transparentBG_0.png" /></p>
                            </div>
                        </asp:Panel>
                        <!-- Fin Panel under Construction -->
                        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
                            DataKeyNames="RequirementId" DataSourceID="SqlDataSource3" Width="920px" 
                            AllowSorting="True" CssClass="gridView" onsorting="GridView1_Sorting">                            
                            <Columns>                
                                <asp:BoundField DataField="RequirementId" HeaderText="Id" 
                                    SortExpression="RequirementId"  ItemStyle-CssClass="boundfield-hidden" 
                                    HeaderStyle-CssClass="boundfield-hidden" >
                                <HeaderStyle CssClass="boundfield-hidden"></HeaderStyle>

                                <ItemStyle CssClass="boundfield-hidden"></ItemStyle>
                                </asp:BoundField>
                                <asp:BoundField DataField="RequirementName" HeaderText="Name" 
                                    SortExpression="RequirementName" ItemStyle-Width="300" />
                                <asp:BoundField DataField="RequirementDescription" HeaderText="Description" 
                                    SortExpression="RequirementDescription" ItemStyle-Width="550" />
                                <asp:TemplateField HeaderText="Done" ItemStyle-HorizontalAlign="Center">                                    
                                    <ItemTemplate>
                                        <asp:CheckBox enabled="false" ID="RequirementDone" runat="server" Checked='<%# ((int)Eval("RequirementDone")) == 1 ? true : false  %>' ItemStyle-Width="20" />
                                    </ItemTemplate>
                                </asp:TemplateField>                                    
                            </Columns>
                            <EmptyDataRowStyle CssClass="nodata" HorizontalAlign="Center" VerticalAlign="Middle" BorderStyle="None" BackColor="White" ForeColor="Gray" />
                            <HeaderStyle BackColor="#546E96" CssClass="gridViewHeader" ForeColor="White" />            
                        </asp:GridView>
                    </div>                   
                </td>
            </tr>        
            <tr>               
                <td>
                    <br />
                    <table style="background-color:Gray; color:White; width: 920px;">
                        <tr>
                            <td style="width: 842px">
                                &nbsp;<span Class="textSpanBoldUnderline">Client Issues Resolved</span>
                            </td>
                            <td style="vertical-align:middle; text-align:center">
                                <asp:Button id="btViewErrorsResolved" runat="server" BorderStyle="None"
                                        Text="Show" onclick="btViewErrorsResolved_Click" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td>                                          
                    <asp:SqlDataSource ID="SqlDataSource5" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:ApplicationServices %>">
                    </asp:SqlDataSource>                
                    <div id="div1" style="visibility:visible;max-width:920px">
                        <asp:GridView ID="GridView3" runat="server" AutoGenerateColumns="False" 
                            DataKeyNames="ErrorId" DataSourceID="SqlDataSource5" Width="920px" 
                            AllowSorting="True" CssClass="gridView" onsorting="GridView3_Sorting"
                            onselectedindexchanged="GridView3_SelectedIndexChanged">
                            <Columns>                
                                <asp:BoundField DataField="ErrorId" HeaderText="Id" 
                                    SortExpression="ErrorId" Visible="true"  
                                    ItemStyle-CssClass="boundfield-hidden" 
                                    HeaderStyle-CssClass="boundfield-hidden" >                                
                                <HeaderStyle CssClass="boundfield-hidden"></HeaderStyle>
                                <ItemStyle CssClass="boundfield-hidden"></ItemStyle>
                                </asp:BoundField>
                                <asp:BoundField DataField="ErrorCT" HeaderText="CT" 
                                    SortExpression="ErrorCT" ItemStyle-Width="70" />
                                <asp:BoundField DataField="ErrorSpiraId" HeaderText="Spira Id" 
                                    SortExpression="ErrorSpiraId" ItemStyle-Width="70" />
                                <asp:BoundField DataField="ErrorName" HeaderText="Name" 
                                    SortExpression="ErrorName" ItemStyle-Width="150" />
                                <asp:BoundField DataField="ErrorDescription" HeaderText="Description" 
                                    SortExpression="ErrorDescription" ItemStyle-Width="250" />
                                <asp:BoundField DataField="ErrorType" HeaderText="Type" 
                                    SortExpression="ErrorType" ItemStyle-Width="50" ItemStyle-HorizontalAlign="Right" />
                                <asp:BoundField DataField="ErrorPriority" HeaderText="Priority" 
                                    SortExpression="ErrorPriority" ItemStyle-Width="50" ItemStyle-HorizontalAlign="Right" />                            
                                <asp:BoundField DataField="ErrorFoundRelease" HeaderText="Found in" 
                                    SortExpression="ErrorFoundRelease" ItemStyle-CssClass="boundfield-hidden" 
                                    HeaderStyle-CssClass="boundfield-hidden" />
                                <asp:BoundField DataField="ErrorResolvedRelease" HeaderText="Resolved in" 
                                    SortExpression="ErrorResolvedRelease" ItemStyle-CssClass="boundfield-hidden" 
                                    HeaderStyle-CssClass="boundfield-hidden" />
                                <asp:BoundField DataField="ErrorFoundDate" DataFormatString="{0:dd/MM/yyyy}" HeaderText="Found date" 
                                    SortExpression="ErrorFoundDate" ItemStyle-CssClass="boundfield-hidden" 
                                    HeaderStyle-CssClass="boundfield-hidden" />
                                <asp:BoundField DataField="ErrorResolvedDate" DataFormatString="{0:dd/MM/yyyy}" HeaderText="Resolved date" 
                                    SortExpression="ErrorResolvedDate" ItemStyle-CssClass="boundfield-hidden" 
                                    HeaderStyle-CssClass="boundfield-hidden" />
                                <asp:BoundField DataField="ErrorAffectedClients" HeaderText="Affected clients" 
                                    SortExpression="ErrorAffectedClients" ItemStyle-Width="50" ItemStyle-HorizontalAlign="Right" />
                                <asp:BoundField DataField="State" HeaderText="State" 
                                    SortExpression="State" ItemStyle-Width="50" ItemStyle-HorizontalAlign="Right" />
                                <asp:CommandField ShowSelectButton="true" ButtonType="Link" Visible="true"
                                    SelectText="<img src='images/Ok.png' />" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="30" >                       
                                <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                </asp:CommandField>
                            </Columns>
                            <EmptyDataRowStyle CssClass="nodata" HorizontalAlign="Center" VerticalAlign="Middle" BorderStyle="None" BackColor="White" ForeColor="Gray" />
                            <HeaderStyle BackColor="#546E96" CssClass="gridViewHeader" ForeColor="White" />            
                        </asp:GridView>
                    </div>                
                </td>
            </tr>
            <tr>               
                <td>
                    <br />
                    <table style="background-color:Gray; color:White; width: 920px;">
                        <tr>
                            <td style="width: 842px">
                                &nbsp;<span class="textSpanBoldUnderline">Client Issues Found</span>
                            </td>
                            <td style="vertical-align:middle; text-align:center">
                                <asp:Button id="btViewErrorsFound" runat="server" BorderStyle="None"
                                        Text="Show" onclick="btViewErrorsFound_Click" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td>                         
                    <asp:SqlDataSource ID="SqlDataSource4" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:ApplicationServices %>">
                    </asp:SqlDataSource>                    
                    <div id="divViewErrors" style="visibility:visible;max-width:920px">
                        <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" 
                            DataKeyNames="ErrorId" DataSourceID="SqlDataSource4" Width="920px" 
                            AllowSorting="True" CssClass="gridView" onsorting="GridView2_Sorting"
                            onselectedindexchanged="GridView2_SelectedIndexChanged">                            
                            <Columns>                
                                <asp:BoundField DataField="ErrorId" HeaderText="Id" 
                                    SortExpression="ErrorId" Visible="true"  
                                    ItemStyle-CssClass="boundfield-hidden" 
                                    HeaderStyle-CssClass="boundfield-hidden" >                                
                                    <HeaderStyle CssClass="boundfield-hidden"></HeaderStyle>
                                    <ItemStyle CssClass="boundfield-hidden"></ItemStyle>
                                </asp:BoundField>
                                <asp:BoundField DataField="ErrorCT" HeaderText="CT" 
                                    SortExpression="ErrorCT" ItemStyle-Width="70" />
                                <asp:BoundField DataField="ErrorSpiraId" HeaderText="Spira Id" 
                                    SortExpression="ErrorSpiraId" ItemStyle-Width="70" />
                                <asp:BoundField DataField="ErrorName" HeaderText="Name" 
                                    SortExpression="ErrorName" ItemStyle-Width="150" />
                                <asp:BoundField DataField="ErrorDescription" HeaderText="Description" 
                                    SortExpression="ErrorDescription" ItemStyle-Width="250" />
                                <asp:BoundField DataField="ErrorType" HeaderText="Type" 
                                    SortExpression="ErrorType" ItemStyle-Width="50" ItemStyle-HorizontalAlign="Right" />
                                <asp:BoundField DataField="ErrorPriority" HeaderText="Priority" 
                                    SortExpression="ErrorPriority" ItemStyle-Width="50" ItemStyle-HorizontalAlign="Right" />                            
                                <asp:BoundField DataField="ErrorFoundRelease" HeaderText="Found in" 
                                    SortExpression="ErrorFoundRelease" ItemStyle-CssClass="boundfield-hidden" 
                                    HeaderStyle-CssClass="boundfield-hidden"/>
                                <asp:BoundField DataField="ErrorResolvedRelease" HeaderText="Resolved in" 
                                    SortExpression="ErrorResolvedRelease" ItemStyle-CssClass="boundfield-hidden" 
                                    HeaderStyle-CssClass="boundfield-hidden"/>
                                <asp:BoundField DataField="ErrorFoundDate" DataFormatString="{0:dd/MM/yyyy}" HeaderText="Found date" 
                                    SortExpression="ErrorFoundDate" ItemStyle-CssClass="boundfield-hidden" 
                                    HeaderStyle-CssClass="boundfield-hidden" />
                                <asp:BoundField DataField="ErrorResolvedDate" DataFormatString="{0:dd/MM/yyyy}" HeaderText="Resolved date" 
                                    SortExpression="ErrorResolvedDate" ItemStyle-CssClass="boundfield-hidden" 
                                    HeaderStyle-CssClass="boundfield-hidden" />
                                <asp:BoundField DataField="ErrorAffectedClients" HeaderText="Affected clients" 
                                    SortExpression="ErrorAffectedClients" ItemStyle-Width="50" ItemStyle-HorizontalAlign="Right" />
                                <asp:BoundField DataField="State" HeaderText="State" 
                                    SortExpression="State" ItemStyle-Width="50" ItemStyle-HorizontalAlign="Right" />
                                <asp:CommandField ShowSelectButton="true" ButtonType="Link" Visible="true"
                                    SelectText="<img src='images/Ok.png' />" ItemStyle-HorizontalAlign="Center"  ItemStyle-Width="30" >
                                <ItemStyle HorizontalAlign="Center"></ItemStyle>
                                </asp:CommandField>
                            </Columns>
                            <EmptyDataRowStyle CssClass="nodata" HorizontalAlign="Center" VerticalAlign="Middle" BorderStyle="None" BackColor="White" ForeColor="Gray" />
                            <HeaderStyle BackColor="#546E96" CssClass="gridViewHeader" ForeColor="White" />            
                        </asp:GridView>
                    </div>                   
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
