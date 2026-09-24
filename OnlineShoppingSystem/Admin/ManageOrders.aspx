<%@ Page Title="Manage Orders" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="ManageOrders.aspx.cs" Inherits="OnlineShoppingSystem.Admin.ManageOrders" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="AdminContent" runat="server">
    <div style="margin-bottom: 40px;">
        <div class="card" style="padding: 28px;">
            <div class="section-header" style="margin-bottom: 20px;">
                <div>
                    <h3 style="font-size: 1.4rem; color: var(--primary);">Customer Order Management</h3>
                    <p style="color: var(--text-muted); font-size: 0.88rem;">Track shipments, review customer addresses, and update fulfillment status</p>
                </div>
                <div style="color: var(--text-muted); font-size: 0.9rem;">
                    Total Orders: <strong style="color: var(--primary);"><asp:Literal ID="litOrderCount" runat="server">0</asp:Literal></strong>
                </div>
            </div>

            <!-- Alert Notification -->
            <asp:Panel ID="pnlAlert" runat="server" Visible="false">
                <div class="alert alert-success">
                    <i class="fa-solid fa-circle-check"></i>
                    <asp:Literal ID="litAlertMsg" runat="server"></asp:Literal>
                </div>
            </asp:Panel>

            <!-- Status Filter -->
            <div class="flex items-center gap-3" style="margin-bottom: 20px;">
                <label class="form-label" style="margin-bottom: 0;">Filter Status:</label>
                <asp:DropDownList ID="ddlStatusFilter" runat="server" CssClass="form-control" style="width: auto;" AutoPostBack="true" OnSelectedIndexChanged="ddlStatusFilter_SelectedIndexChanged">
                    <asp:ListItem Value="All" Text="All Orders"></asp:ListItem>
                    <asp:ListItem Value="Pending" Text="Pending"></asp:ListItem>
                    <asp:ListItem Value="Processing" Text="Processing"></asp:ListItem>
                    <asp:ListItem Value="Shipped" Text="Shipped"></asp:ListItem>
                    <asp:ListItem Value="Delivered" Text="Delivered"></asp:ListItem>
                    <asp:ListItem Value="Cancelled" Text="Cancelled"></asp:ListItem>
                </asp:DropDownList>
            </div>

            <!-- ASP.NET GridView -->
            <div class="table-responsive">
                <asp:GridView ID="gvOrders" runat="server" AutoGenerateColumns="False" 
                    DataKeyNames="OrderId" CssClass="gridview-modern" GridLines="None"
                    OnRowCommand="gvOrders_RowCommand" EmptyDataText="No orders found.">
                    <Columns>
                        <asp:TemplateField HeaderText="Order ID" ItemStyle-Width="90px">
                            <ItemTemplate>
                                <strong style="color: var(--accent);">#<%# Eval("OrderId") %></strong>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Customer">
                            <ItemTemplate>
                                <strong><%# Eval("FullName") %></strong><br />
                                <span style="font-size: 0.8rem; color: var(--text-muted);"><%# Eval("Email") %></span>
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

                        <asp:TemplateField HeaderText="Current Status">
                            <ItemTemplate>
                                <span class='<%# "badge-status badge-" + Eval("OrderStatus").ToString().ToLower() %>'>
                                    <%# Eval("OrderStatus") %>
                                </span>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Update Fulfillment" ItemStyle-Width="260px">
                            <ItemTemplate>
                                <div class="flex items-center gap-1">
                                    <asp:DropDownList ID="ddlNewStatus" runat="server" CssClass="form-control" style="padding: 4px 8px; font-size: 0.85rem; width: 130px;">
                                        <asp:ListItem Value="Pending">Pending</asp:ListItem>
                                        <asp:ListItem Value="Processing">Processing</asp:ListItem>
                                        <asp:ListItem Value="Shipped">Shipped</asp:ListItem>
                                        <asp:ListItem Value="Delivered">Delivered</asp:ListItem>
                                        <asp:ListItem Value="Cancelled">Cancelled</asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:Button ID="btnUpdateStatus" runat="server" Text="Update" 
                                        CommandName="UpdateStatus" 
                                        CommandArgument='<%# Container.DataItemIndex %>' 
                                        CssClass="btn btn-primary btn-sm" />
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </div>
</asp:Content>
