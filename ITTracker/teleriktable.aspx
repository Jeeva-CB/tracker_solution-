<%@ Page Title="" Language="C#" AutoEventWireup="true" CodeBehind="teleriktable.aspx.cs" Inherits="ITTracker.teleriktable" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns='http://www.w3.org/1999/xhtml'>
<head runat="server">
    <title>Telerik ASP.NET Example</title>
    <link href="styles.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
    <telerik:RadScriptManager runat="server" ID="RadScriptManager1" />
    <telerik:RadSkinManager ID="RadSkinManager1" runat="server" ShowChooser="true" />
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="RadGrid1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="RadAjaxLoadingPanel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" />
    <telerik:RadFormDecorator RenderMode="Lightweight" runat="server" DecorationZoneID="demo" EnableRoundedCorners="false" DecoratedControls="All" />
    <div id="demo" class="demo-container no-bg">
        <telerik:RadGrid RenderMode="Lightweight" ID="RadGrid1" runat="server" DataSourceID="EntityDataSourceCustomers"
            AllowPaging="True" AllowAutomaticUpdates="True" AllowAutomaticInserts="True"
            AllowAutomaticDeletes="true" AllowSorting="true" OnItemCreated="RadGrid1_ItemCreated"
            OnItemInserted="RadGrid1_ItemInserted" OnPreRender="RadGrid1_PreRender" OnInsertCommand="RadGrid1_InsertCommand">
            <PagerStyle Mode="NextPrevAndNumeric" />
            <MasterTableView DataSourceID="EntityDataSourceCustomers" AutoGenerateColumns="False"
                DataKeyNames="CustomerID" CommandItemDisplay="Top">
                <Columns>
                    <telerik:GridEditCommandColumn UniqueName="EditCommandColumn">
                    </telerik:GridEditCommandColumn>
                    <telerik:GridBoundColumn DataField="CustomerID" HeaderText="CustomerID" SortExpression="CustomerID"
                        UniqueName="CustomerID" Visible="false" MaxLength="5">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="ContactName" HeaderText="ContactName" SortExpression="ContactName"
                        UniqueName="ContactName">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="CompanyName" HeaderText="CompanyName" SortExpression="CompanyName"
                        UniqueName="CompanyName">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="ContactTitle" HeaderText="ContactTitle" SortExpression="ContactTitle"
                        UniqueName="ContactTitle">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="Phone" HeaderText="Phone" SortExpression="Phone"
                        UniqueName="Phone">
                    </telerik:GridBoundColumn>
                    <telerik:GridButtonColumn Text="Delete" CommandName="Delete" />
                </Columns>    
            </MasterTableView>
        </telerik:RadGrid>
    </div>
    <asp:EntityDataSource ID="EntityDataSourceCustomers" runat="server" ConnectionString="name=NorthwindReadWriteEntities"
        DefaultContainerName="NorthwindReadWriteEntities" EntitySetName="Customers" OrderBy="it.[ContactName]"
        EntityTypeFilter="Customer" EnableDelete="True" EnableFlattening="False" EnableInsert="True" EnableUpdate="True">
    </asp:EntityDataSource>
    </form>
</body>
</html>