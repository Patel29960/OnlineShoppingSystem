<%@ Page Title="Manage Products" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="ManageProducts.aspx.cs" Inherits="OnlineShoppingSystem.Admin.ManageProducts" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <style>
        .grid-thumb {
            width: 48px;
            height: 48px;
            object-fit: cover;
            border-radius: var(--radius-sm);
            border: 1px solid var(--border-color);
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="AdminContent" runat="server">
    <div style="margin-bottom: 40px;">
        <div class="card" style="padding: 28px;">
            <div class="section-header" style="margin-bottom: 20px;">
                <div>
                    <h3 style="font-size: 1.4rem; color: var(--primary);">Product Inventory</h3>
                    <p style="color: var(--text-muted); font-size: 0.88rem;">Manage, update pricing, edit stock quantities, or delete products</p>
                </div>
                <a href="AddProduct.aspx" class="btn btn-primary btn-sm">
                    <i class="fa-solid fa-plus-circle"></i> Add New Product
                </a>
            </div>

            <!-- Alert Notification -->
            <asp:Panel ID="pnlAlert" runat="server" Visible="false">
                <div class="alert alert-success">
                    <i class="fa-solid fa-circle-check"></i>
                    <asp:Literal ID="litAlertMsg" runat="server"></asp:Literal>
                </div>
            </asp:Panel>

            <!-- Search and Filter Bar -->
            <div class="flex items-center justify-between" style="margin-bottom: 20px; flex-wrap: wrap; gap: 14px;">
                <div class="flex items-center gap-2" style="max-width: 320px; width: 100%;">
                    <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Search product name..."></asp:TextBox>
                    <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-outline btn-sm" OnClick="btnSearch_Click" />
                </div>
                <div style="color: var(--text-muted); font-size: 0.9rem;">
                    Total Products: <strong style="color: var(--primary);"><asp:Literal ID="litCount" runat="server">0</asp:Literal></strong>
                </div>
            </div>

            <!-- ASP.NET GridView -->
            <div class="table-responsive">
                <asp:GridView ID="gvProducts" runat="server" AutoGenerateColumns="False" 
                    DataKeyNames="ProductId" CssClass="gridview-modern" GridLines="None"
                    OnRowCommand="gvProducts_RowCommand" EmptyDataText="No products found in database.">
                    <Columns>
                        <asp:TemplateField HeaderText="ID" ItemStyle-Width="60px">
                            <ItemTemplate>
                                <span style="font-weight: 700; color: var(--text-muted);">#<%# Eval("ProductId") %></span>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Image" ItemStyle-Width="70px">
                            <ItemTemplate>
                                <img src='<%# Eval("ImageUrl") %>' alt='<%# Eval("ProductName") %>' class="grid-thumb" />
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Product Name">
                            <ItemTemplate>
                                <strong><%# Eval("ProductName") %></strong>
                                <%# Convert.ToBoolean(Eval("IsFeatured")) ? "<span class='badge-status' style='background:#dbeafe; color:#1d4ed8; margin-left:6px;'>Featured</span>" : "" %>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Category">
                            <ItemTemplate>
                                <span style="color: var(--accent); font-weight: 600;"><%# Eval("CategoryName") %></span>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Price">
                            <ItemTemplate>
                                <strong>$<%# Convert.ToDecimal(Eval("Price")).ToString("F2") %></strong>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Stock">
                            <ItemTemplate>
                                <span style='<%# Convert.ToInt32(Eval("StockQuantity")) < 5 ? "color: #ef4444; font-weight:700;" : "color: var(--success); font-weight:600;" %>'>
                                    <%# Eval("StockQuantity") %> units
                                </span>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Actions" ItemStyle-HorizontalAlign="Right" ItemStyle-Width="180px">
                            <ItemTemplate>
                                <a href='EditProduct.aspx?id=<%# Eval("ProductId") %>' class="btn btn-outline btn-sm" style="margin-right: 6px;">
                                    <i class="fa-solid fa-pen-to-square"></i> Edit
                                </a>
                                <asp:LinkButton ID="btnDelete" runat="server" 
                                    CommandName="DeleteProduct" 
                                    CommandArgument='<%# Eval("ProductId") %>' 
                                    CssClass="btn btn-danger btn-sm"
                                    OnClientClick="return confirm('Are you sure you want to delete this product? All related cart records will be removed.');">
                                    <i class="fa-solid fa-trash"></i>
                                </asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </div>
</asp:Content>
