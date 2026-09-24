<%@ Page Title="Product Details" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ProductDetails.aspx.cs" Inherits="OnlineShoppingSystem.ProductDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <style>
        .breadcrumb {
            display: flex;
            align-items: center;
            gap: 8px;
            font-size: 0.9rem;
            color: var(--text-muted);
            margin: 20px 0 10px;
        }
        .breadcrumb a {
            color: var(--text-muted);
        }
        .breadcrumb a:hover {
            color: var(--accent);
        }
        .feature-bullets {
            list-style: none;
            margin: 20px 0;
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 12px;
        }
        .feature-bullets li {
            font-size: 0.9rem;
            color: var(--text-muted);
            display: flex;
            align-items: center;
            gap: 8px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container">
        <!-- Breadcrumb Navigation -->
        <div class="breadcrumb">
            <a href="Default.aspx">Home</a>
            <i class="fa-solid fa-chevron-right" style="font-size: 0.75rem;"></i>
            <a href="Products.aspx">Products</a>
            <i class="fa-solid fa-chevron-right" style="font-size: 0.75rem;"></i>
            <span style="color: var(--primary); font-weight: 600;"><asp:Literal ID="litBreadcrumbName" runat="server"></asp:Literal></span>
        </div>

        <!-- Alert Notification -->
        <asp:Panel ID="pnlAlert" runat="server" Visible="false" style="margin-top: 15px;">
            <div class="alert alert-success">
                <i class="fa-solid fa-circle-check"></i>
                <asp:Literal ID="litAlertMsg" runat="server"></asp:Literal>
                <a href="Cart.aspx" style="margin-left: auto; font-weight: 700; text-decoration: underline;">Go to Cart &rarr;</a>
            </div>
        </asp:Panel>

        <!-- Product Details Layout Container -->
        <div class="product-details-container">
            <!-- Left Large Image View -->
            <div class="details-image-box">
                <asp:Image ID="imgProduct" runat="server" CssClass="img-fluid" AlternateText="Product Image" />
            </div>

            <!-- Right Product Specifications and Purchase Actions -->
            <div class="details-content">
                <div class="details-category">
                    <asp:Literal ID="litCategory" runat="server"></asp:Literal>
                </div>

                <h1 class="details-title">
                    <asp:Literal ID="litProductName" runat="server"></asp:Literal>
                </h1>

                <div class="flex items-center gap-3" style="margin-bottom: 16px;">
                    <div class="flex gap-1" style="color: #f59e0b; font-size: 0.95rem;">
                        <i class="fa-solid fa-star"></i>
                        <i class="fa-solid fa-star"></i>
                        <i class="fa-solid fa-star"></i>
                        <i class="fa-solid fa-star"></i>
                        <i class="fa-solid fa-star-half-stroke"></i>
                    </div>
                    <span style="color: var(--text-muted); font-size: 0.88rem;">4.8 (124 Customer Reviews)</span>
                </div>

                <div class="details-price">
                    <asp:Literal ID="litPrice" runat="server"></asp:Literal>
                </div>

                <div class="details-desc">
                    <asp:Literal ID="litDescription" runat="server"></asp:Literal>
                </div>

                <div style="margin-bottom: 24px;">
                    <div style="font-size: 0.9rem; font-weight: 600; color: var(--primary); margin-bottom: 8px;">Availability:</div>
                    <span class="product-stock" style="font-size: 0.95rem;">
                        <i class="fa-solid fa-circle-check"></i> In Stock (<asp:Literal ID="litStock" runat="server"></asp:Literal> units available)
                    </span>
                </div>

                <!-- Quantity Selector and Action Buttons -->
                <div class="flex items-center gap-4" style="margin-bottom: 30px; flex-wrap: wrap;">
                    <div class="flex items-center gap-2">
                        <label class="form-label" style="margin-bottom: 0;">Quantity:</label>
                        <asp:TextBox ID="txtQuantity" runat="server" TextMode="Number" Text="1" min="1" max="50" CssClass="form-control" style="width: 75px; text-align: center; font-weight: 700;"></asp:TextBox>
                    </div>

                    <asp:Button ID="btnAddToCart" runat="server" Text="Add to Cart" CssClass="btn btn-primary btn-lg" OnClick="btnAddToCart_Click" />
                    <a href="Products.aspx" class="btn btn-outline btn-lg">
                        <i class="fa-solid fa-arrow-left"></i> Back to Products
                    </a>
                </div>

                <!-- Guarantee Highlights -->
                <ul class="feature-bullets">
                    <li><i class="fa-solid fa-shield-check" style="color: var(--accent);"></i> Genuine Authentic Product</li>
                    <li><i class="fa-solid fa-truck" style="color: var(--accent);"></i> Free Delivery on Eligible Orders</li>
                    <li><i class="fa-solid fa-rotate-left" style="color: var(--accent);"></i> 7 Days Replacement Policy</li>
                    <li><i class="fa-solid fa-lock" style="color: var(--accent);"></i> Secure Payment Processing</li>
                </ul>
            </div>
        </div>
    </div>
</asp:Content>
