<%@ Page Title="Dashboard" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="OnlineShoppingSystem.Admin.Dashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="AdminContent" runat="server">
    <!-- Stat Counter Cards -->
    <div class="stats-grid">
        <!-- Total Users Card -->
        <div class="stat-card">
            <div class="stat-icon blue">
                <i class="fa-solid fa-users"></i>
            </div>
            <div>
                <div class="stat-value"><asp:Literal ID="litTotalUsers" runat="server">0</asp:Literal></div>
                <div class="stat-label">Total Users</div>
            </div>
        </div>

        <!-- Total Products Card -->
        <div class="stat-card">
            <div class="stat-icon green">
                <i class="fa-solid fa-box-open"></i>
            </div>
            <div>
                <div class="stat-value"><asp:Literal ID="litTotalProducts" runat="server">0</asp:Literal></div>
                <div class="stat-label">Total Products</div>
            </div>
        </div>

        <!-- Total Orders Card -->
        <div class="stat-card">
            <div class="stat-icon amber">
                <i class="fa-solid fa-cart-shopping"></i>
            </div>
            <div>
                <div class="stat-value"><asp:Literal ID="litTotalOrders" runat="server">0</asp:Literal></div>
                <div class="stat-label">Total Orders</div>
            </div>
        </div>

        <!-- Total Categories Card -->
        <div class="stat-card">
            <div class="stat-icon purple">
                <i class="fa-solid fa-layer-group"></i>
            </div>
            <div>
                <div class="stat-value"><asp:Literal ID="litTotalCategories" runat="server">0</asp:Literal></div>
                <div class="stat-label">Total Categories</div>
            </div>
        </div>
    </div>

    <!-- Quick Actions Row -->
    <div class="flex items-center gap-3" style="margin-bottom: 28px;">
        <a href="AddProduct.aspx" class="btn btn-primary btn-sm">
            <i class="fa-solid fa-plus-circle"></i> Add New Product
        </a>
        <a href="ManageProducts.aspx" class="btn btn-outline btn-sm">
            <i class="fa-solid fa-list-check"></i> Manage Product Inventory
        </a>
        <a href="ManageOrders.aspx" class="btn btn-outline btn-sm">
            <i class="fa-solid fa-truck-fast"></i> Process Customer Orders
        </a>
    </div>

    <!-- Recent Orders Section with ASP.NET GridView -->
    <div class="card" style="padding: 28px; margin-bottom: 30px;">
        <div class="section-header" style="margin-bottom: 20px;">
            <div>
                <h3 style="font-size: 1.25rem; color: var(--primary);">Recent Customer Orders</h3>
                <p style="color: var(--text-muted); font-size: 0.88rem;">Latest purchases submitted by registered shoppers</p>
            </div>
            <a href="ManageOrders.aspx" class="btn btn-outline btn-sm">View All Orders &rarr;</a>
        </div>

        <div class="table-responsive">
            <asp:GridView ID="gvRecentOrders" runat="server" AutoGenerateColumns="False" 
                CssClass="gridview-modern" GridLines="None" EmptyDataText="No orders registered yet.">
                <Columns>
                    <asp:TemplateField HeaderText="Order ID">
                        <ItemTemplate>
                            <strong style="color: var(--accent);">#<%# Eval("OrderId") %></strong>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Customer">
                        <ItemTemplate>
                            <div>
                                <strong><%# Eval("FullName") %></strong><br />
                                <span style="font-size: 0.8rem; color: var(--text-muted);"><%# Eval("Email") %></span>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Date">
                        <ItemTemplate>
                            <%# Convert.ToDateTime(Eval("OrderDate")).ToString("MMM dd, yyyy") %>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Total">
                        <ItemTemplate>
                            <strong>$<%# Convert.ToDecimal(Eval("TotalAmount")).ToString("F2") %></strong>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Payment">
                        <ItemTemplate>
                            <%# Eval("PaymentMethod") %>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Status">
                        <ItemTemplate>
                            <span class='<%# "badge-status badge-" + Eval("OrderStatus").ToString().ToLower() %>'>
                                <%# Eval("OrderStatus") %>
                            </span>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
    </div>
</asp:Content>
