<%@ Page Title="My Profile" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Profile.aspx.cs" Inherits="OnlineShoppingSystem.Profile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <style>
        .profile-header-card {
            background: linear-gradient(135deg, #0f172a 0%, #1e3a8a 100%);
            border-radius: var(--radius-lg);
            padding: 36px 40px;
            color: #ffffff;
            margin: 24px 0 32px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            flex-wrap: wrap;
            gap: 24px;
        }
        .profile-avatar {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            background: #ffffff;
            color: var(--accent);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 2.2rem;
            box-shadow: 0 4px 14px rgba(0,0,0,0.2);
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container">
        <!-- Profile Banner Card -->
        <div class="profile-header-card">
            <div class="flex items-center gap-4">
                <div class="profile-avatar">
                    <i class="fa-solid fa-user"></i>
                </div>
                <div>
                    <h1 style="font-size: 1.8rem; color: #ffffff; margin-bottom: 4px;">
                        <asp:Literal ID="litFullName" runat="server"></asp:Literal>
                    </h1>
                    <div style="color: #93c5fd; font-size: 0.95rem;">
                        <i class="fa-regular fa-envelope" style="margin-right: 6px;"></i>
                        <asp:Literal ID="litEmail" runat="server"></asp:Literal>
                    </div>
                </div>
            </div>

            <div class="flex gap-2">
                <a href="EditProfile.aspx" class="btn btn-outline" style="color: #ffffff; border-color: rgba(255,255,255,0.4);">
                    <i class="fa-solid fa-pen-to-square"></i> Edit Profile
                </a>
                <a href="Logout.aspx" class="btn btn-danger">
                    <i class="fa-solid fa-arrow-right-from-bracket"></i> Logout
                </a>
            </div>
        </div>

        <!-- Account Info Summary Cards -->
        <div class="stats-grid" style="margin-bottom: 32px;">
            <div class="stat-card">
                <div class="stat-icon blue">
                    <i class="fa-solid fa-box-archive"></i>
                </div>
                <div>
                    <div class="stat-value"><asp:Literal ID="litTotalOrders" runat="server">0</asp:Literal></div>
                    <div class="stat-label">Total Orders Placed</div>
                </div>
            </div>

            <div class="stat-card">
                <div class="stat-icon green">
                    <i class="fa-solid fa-user-shield"></i>
                </div>
                <div>
                    <div class="stat-value" style="font-size: 1.4rem;"><asp:Literal ID="litRole" runat="server">Customer</asp:Literal></div>
                    <div class="stat-label">Account Privilege</div>
                </div>
            </div>

            <div class="stat-card">
                <div class="stat-icon purple">
                    <i class="fa-solid fa-calendar-check"></i>
                </div>
                <div>
                    <div class="stat-value" style="font-size: 1.3rem;"><asp:Literal ID="litJoinedDate" runat="server">-</asp:Literal></div>
                    <div class="stat-label">Member Since</div>
                </div>
            </div>
        </div>

        <!-- Order History Section -->
        <div class="card" style="padding: 28px; margin-bottom: 60px;">
            <div class="section-header" style="margin-bottom: 20px;">
                <div>
                    <h3 style="font-size: 1.3rem; color: var(--primary);">Your Order History</h3>
                    <p style="color: var(--text-muted); font-size: 0.9rem;">Track past purchases, delivery status, and order invoices</p>
                </div>
                <a href="Products.aspx" class="btn btn-outline btn-sm">Shop More &rarr;</a>
            </div>

            <asp:Panel ID="pnlNoOrders" runat="server" Visible="false" style="text-align: center; padding: 40px; color: var(--text-muted);">
                <i class="fa-solid fa-receipt" style="font-size: 2.5rem; color: #cbd5e1; margin-bottom: 12px; display: block;"></i>
                No orders have been placed yet. Explore our catalog to make your first purchase!
            </asp:Panel>

            <div class="table-responsive">
                <asp:GridView ID="gvOrders" runat="server" AutoGenerateColumns="False" 
                    CssClass="gridview-modern" GridLines="None" EmptyDataText="">
                    <Columns>
                        <asp:TemplateField HeaderText="Order ID">
                            <ItemTemplate>
                                <strong style="color: var(--accent);">#<%# Eval("OrderId") %></strong>
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

                        <asp:TemplateField HeaderText="Payment Method">
                            <ItemTemplate>
                                <%# Eval("PaymentMethod") %>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Shipping Destination">
                            <ItemTemplate>
                                <span style="font-size: 0.85rem; color: var(--text-muted);"><%# Eval("ShippingAddress") %></span>
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
    </div>
</asp:Content>
