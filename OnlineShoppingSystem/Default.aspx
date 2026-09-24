<%@ Page Title="Home" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="OnlineShoppingSystem.Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
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

        <!-- Large Hero Banner -->
        <section class="hero-section">
            <div class="container">
                <div class="hero-grid">
                    <div class="hero-content">
                        <span style="display: inline-block; padding: 6px 14px; background: rgba(59, 130, 246, 0.2); color: #93c5fd; border-radius: var(--radius-full); font-size: 0.85rem; font-weight: 700; text-transform: uppercase; margin-bottom: 16px;">
                            <i class="fa-solid fa-bolt" style="margin-right: 6px;"></i> Curated Collection 2026
                        </span>
                        <h1>Discover Products You'll Love</h1>
                        <p>Explore premium gadgets, designer fashion, and lifestyle essentials. Handcrafted quality backed by seamless shopping and fast delivery.</p>
                        
                        <div class="flex gap-3">
                            <a href="Products.aspx" class="btn btn-accent btn-lg">
                                Shop Now <i class="fa-solid fa-arrow-right" style="margin-left: 6px;"></i>
                            </a>
                            <a href="Products.aspx?cat=1" class="btn btn-outline btn-lg" style="color: #ffffff; border-color: rgba(255,255,255,0.3);">
                                Browse Categories
                            </a>
                        </div>

                        <div class="hero-badges">
                            <div class="hero-badge-item">
                                <i class="fa-solid fa-truck-fast"></i>
                                <span>Free Shipping over $50</span>
                            </div>
                            <div class="hero-badge-item">
                                <i class="fa-solid fa-shield-check"></i>
                                <span>1 Year Warranty</span>
                            </div>
                            <div class="hero-badge-item">
                                <i class="fa-solid fa-rotate-left"></i>
                                <span>30-Day Returns</span>
                            </div>
                        </div>
                    </div>

                    <div class="hero-image-wrapper">
                        <img src="https://images.unsplash.com/photo-1498049794561-7780e7231661?w=700&auto=format&fit=crop&q=80" alt="Premium Gadgets and Accessories" />
                    </div>
                </div>
            </div>
        </section>

        <!-- Popular Categories Section -->
        <section style="margin-top: 50px;">
            <div class="section-header">
                <div>
                    <h2 class="section-title">Popular Categories</h2>
                    <p class="section-subtitle">Find what you're looking for by browsing our curated categories</p>
                </div>
                <a href="Products.aspx" class="btn btn-outline btn-sm">View All Categories &rarr;</a>
            </div>

            <div class="categories-grid">
                <asp:Repeater ID="rptCategories" runat="server">
                    <ItemTemplate>
                        <a href='Products.aspx?cat=<%# Eval("CategoryId") %>' class="category-card">
                            <img src='<%# Eval("ImageUrl") %>' alt='<%# Eval("CategoryName") %>' class="category-img" />
                            <div class="category-info">
                                <div class="category-name"><%# Eval("CategoryName") %></div>
                                <div class="category-count"><%# Eval("Description") %></div>
                            </div>
                        </a>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </section>

        <!-- Featured Products Section -->
        <section style="margin-top: 30px;">
            <div class="section-header">
                <div>
                    <h2 class="section-title">Featured Products</h2>
                    <p class="section-subtitle">Top rated picks loved by our customers this week</p>
                </div>
                <a href="Products.aspx" class="btn btn-outline btn-sm">Explore All Products &rarr;</a>
            </div>

            <div class="products-grid">
                <asp:Repeater ID="rptFeatured" runat="server" OnItemCommand="rptFeatured_ItemCommand">
                    <ItemTemplate>
                        <div class="product-card">
                            <span class="product-badge">Featured</span>
                            
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
                                    <span class="product-stock"><i class="fa-solid fa-check"></i> In Stock</span>
                                </div>

                                <div class="product-actions">
                                    <a href='ProductDetails.aspx?id=<%# Eval("ProductId") %>' class="btn btn-outline btn-sm">
                                        Details
                                    </a>
                                    <asp:LinkButton ID="btnAddCart" runat="server" 
                                        CommandName="AddToCart" 
                                        CommandArgument='<%# Eval("ProductId") %>' 
                                        CssClass="btn btn-primary btn-sm">
                                        <i class="fa-solid fa-cart-plus"></i> Add
                                    </asp:LinkButton>
                                </div>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </section>

        <!-- Promotional Section Banner -->
        <section class="promo-banner">
            <div class="promo-content">
                <span style="background: rgba(255,255,255,0.15); padding: 4px 12px; border-radius: var(--radius-full); font-size: 0.8rem; font-weight: 700; text-transform: uppercase;">
                    Limited Time Offer
                </span>
                <h3 style="margin-top: 10px;">Upgrade Your Workspace &amp; Everyday Carry</h3>
                <p>Enjoy up to 25% off selected electronics and handcrafted leather essentials. Available exclusively this season.</p>
                <a href="Products.aspx?cat=1" class="btn btn-accent btn-lg">Explore Electronics Deals</a>
            </div>
            <div style="font-size: 6rem; color: rgba(255,255,255,0.1); margin-right: 20px;">
                <i class="fa-solid fa-tags"></i>
            </div>
        </section>
    </div>
</asp:Content>
