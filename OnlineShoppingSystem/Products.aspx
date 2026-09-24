<%@ Page Title="All Products" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Products.aspx.cs" Inherits="OnlineShoppingSystem.Products" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <style>
        .filter-bar {
            background: #ffffff;
            border: 1px solid var(--border-color);
            border-radius: var(--radius-lg);
            padding: 18px 24px;
            margin: 24px 0 32px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            flex-wrap: wrap;
            gap: 16px;
        }
        .search-input-wrapper {
            position: relative;
            flex-grow: 1;
            max-width: 400px;
        }
        .search-input-wrapper i {
            position: absolute;
            left: 14px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--text-light);
        }
        .search-input-wrapper input {
            padding-left: 38px;
        }
        .category-pills {
            display: flex;
            align-items: center;
            gap: 8px;
            flex-wrap: wrap;
        }
        .category-pill {
            padding: 6px 14px;
            border-radius: var(--radius-full);
            background: var(--bg-page);
            border: 1px solid var(--border-color);
            color: var(--text-muted);
            font-size: 0.85rem;
            font-weight: 600;
            text-decoration: none;
            transition: var(--transition);
        }
        .category-pill:hover, .category-pill.active {
            background: var(--accent);
            color: #ffffff;
            border-color: var(--accent);
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container">
        <!-- Toast Notification Panel for Cart Actions -->
        <asp:Panel ID="pnlAlert" runat="server" Visible="false" style="margin-top: 20px;">
            <div class="alert alert-success">
                <i class="fa-solid fa-circle-check"></i>
                <asp:Literal ID="litAlertMsg" runat="server"></asp:Literal>
                <a href="Cart.aspx" style="margin-left: auto; font-weight: 700; text-decoration: underline;">View Cart &rarr;</a>
            </div>
        </asp:Panel>

        <!-- Page Header -->
        <div style="margin-top: 30px;">
            <h1 style="font-size: 2.2rem; color: var(--primary);">Explore Our Catalog</h1>
            <p style="color: var(--text-muted); margin-top: 4px;">Browse top-tier electronics, fashion, lifestyle items, and more.</p>
        </div>

        <!-- Filter & Search Bar -->
        <div class="filter-bar">
            <!-- Search Box -->
            <div class="search-input-wrapper">
                <i class="fa-solid fa-magnifying-glass"></i>
                <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Search products by name..."></asp:TextBox>
            </div>

            <!-- Category Selector Dropdown -->
            <div class="flex items-center gap-2">
                <label class="form-label" style="margin-bottom: 0; white-space: nowrap;">Category:</label>
                <asp:DropDownList ID="ddlCategories" runat="server" CssClass="form-control" style="width: auto; min-width: 160px;">
                </asp:DropDownList>
            </div>

            <!-- Sort By -->
            <div class="flex items-center gap-2">
                <label class="form-label" style="margin-bottom: 0; white-space: nowrap;">Sort By:</label>
                <asp:DropDownList ID="ddlSort" runat="server" CssClass="form-control" style="width: auto; min-width: 150px;">
                    <asp:ListItem Value="newest" Text="Newest First"></asp:ListItem>
                    <asp:ListItem Value="price_asc" Text="Price: Low to High"></asp:ListItem>
                    <asp:ListItem Value="price_desc" Text="Price: High to Low"></asp:ListItem>
                    <asp:ListItem Value="name_asc" Text="Name: A to Z"></asp:ListItem>
                </asp:DropDownList>
            </div>

            <!-- Filter Submit Buttons -->
            <div class="flex gap-2">
                <asp:Button ID="btnFilter" runat="server" Text="Apply Filter" CssClass="btn btn-primary btn-sm" OnClick="btnFilter_Click" />
                <asp:Button ID="btnReset" runat="server" Text="Reset" CssClass="btn btn-outline btn-sm" OnClick="btnReset_Click" />
            </div>
        </div>

        <!-- Products Status Count -->
        <div class="flex justify-between items-center" style="margin-bottom: 20px;">
            <span style="color: var(--text-muted); font-size: 0.95rem;">
                Showing <strong style="color: var(--primary);"><asp:Literal ID="litProductCount" runat="server">0</asp:Literal></strong> products found
            </span>
        </div>

        <!-- No Products Found Panel -->
        <asp:Panel ID="pnlNoProducts" runat="server" Visible="false" style="text-align: center; padding: 60px 20px; background: #ffffff; border-radius: var(--radius-lg); border: 1px solid var(--border-color); margin-bottom: 40px;">
            <i class="fa-solid fa-box-open" style="font-size: 3rem; color: #cbd5e1; margin-bottom: 16px;"></i>
            <h3 style="color: var(--primary); margin-bottom: 8px;">No Products Found</h3>
            <p style="color: var(--text-muted); margin-bottom: 20px;">Try adjusting your search criteria or category filter.</p>
            <asp:Button ID="btnResetSearch" runat="server" Text="Clear Filters" CssClass="btn btn-primary btn-sm" OnClick="btnReset_Click" />
        </asp:Panel>

        <!-- Product Cards Grid -->
        <div class="products-grid">
            <asp:Repeater ID="rptProducts" runat="server" OnItemCommand="rptProducts_ItemCommand">
                <ItemTemplate>
                    <div class="product-card">
                        <%# Convert.ToBoolean(Eval("IsFeatured")) ? "<span class='product-badge'>Featured</span>" : "" %>
                        
                        <div class="product-image-box">
                            <a href='ProductDetails.aspx?id=<%# Eval("ProductId") %>'>
                                <img src='<%# Eval("ImageUrl") %>' alt='<%# Eval("ProductName") %>' />
                            </a>
                        </div>

                        <div class="product-details">
                            <span class="product-category-tag"><%# Eval("CategoryName") %></span>
                            <h3 class="product-title" title='<%# Eval("ProductName") %>'>
                                <a href='ProductDetails.aspx?id=<%# Eval("ProductId") %>'><%# Eval("ProductName") %></a>
                            </h3>
                            <p class="product-description-short"><%# Eval("Description") %></p>
                            
                            <div class="product-price-row">
                                <span class="product-price">$<%# Convert.ToDecimal(Eval("Price")).ToString("F2") %></span>
                                <span class="product-stock">
                                    <i class="fa-solid fa-check"></i> Stock: <%# Eval("StockQuantity") %>
                                </span>
                            </div>

                            <div class="product-actions">
                                <a href='ProductDetails.aspx?id=<%# Eval("ProductId") %>' class="btn btn-outline btn-sm">
                                    View Details
                                </a>
                                <asp:LinkButton ID="btnAddCart" runat="server" 
                                    CommandName="AddToCart" 
                                    CommandArgument='<%# Eval("ProductId") %>' 
                                    CssClass="btn btn-primary btn-sm">
                                    <i class="fa-solid fa-cart-plus"></i> Add to Cart
                                </asp:LinkButton>
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </div>
</asp:Content>
