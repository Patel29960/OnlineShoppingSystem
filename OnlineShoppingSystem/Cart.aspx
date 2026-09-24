<%@ Page Title="Shopping Cart" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Cart.aspx.cs" Inherits="OnlineShoppingSystem.Cart" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <style>
        .qty-btn-group {
            display: inline-flex;
            align-items: center;
            border: 1px solid var(--border-color);
            border-radius: var(--radius-md);
            overflow: hidden;
            background: #ffffff;
        }
        .qty-btn {
            background: transparent;
            border: none;
            padding: 6px 12px;
            font-size: 0.9rem;
            cursor: pointer;
            color: var(--text-muted);
            transition: var(--transition);
        }
        .qty-btn:hover {
            background: var(--bg-page);
            color: var(--primary);
        }
        .qty-num {
            min-width: 32px;
            text-align: center;
            font-weight: 700;
            font-size: 0.92rem;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container">
        <!-- Page Header -->
        <div style="margin: 30px 0 10px;">
            <h1 style="font-size: 2.2rem; color: var(--primary);">Your Shopping Cart</h1>
            <p style="color: var(--text-muted); margin-top: 4px;">Review your selected items before proceeding to checkout</p>
        </div>

        <!-- Alert Notification -->
        <asp:Panel ID="pnlAlert" runat="server" Visible="false" style="margin-top: 15px;">
            <div class="alert alert-info">
                <i class="fa-solid fa-circle-info"></i>
                <asp:Literal ID="litAlertMsg" runat="server"></asp:Literal>
            </div>
        </asp:Panel>

        <!-- Empty Cart Panel -->
        <asp:Panel ID="pnlEmptyCart" runat="server" Visible="false" style="text-align: center; padding: 70px 20px; background: #ffffff; border-radius: var(--radius-lg); border: 1px solid var(--border-color); margin: 30px 0 50px;">
            <i class="fa-solid fa-cart-shopping" style="font-size: 4rem; color: #cbd5e1; margin-bottom: 20px;"></i>
            <h2 style="color: var(--primary); margin-bottom: 8px;">Your cart is currently empty</h2>
            <p style="color: var(--text-muted); margin-bottom: 24px;">Looks like you haven't added anything to your cart yet.</p>
            <a href="Products.aspx" class="btn btn-primary btn-lg">
                <i class="fa-solid fa-arrow-left"></i> Start Shopping Now
            </a>
        </asp:Panel>

        <!-- Active Cart Layout -->
        <asp:Panel ID="pnlCartContent" runat="server">
            <div class="cart-layout">
                <!-- Cart Items Table -->
                <div class="card" style="padding: 0; overflow: hidden;">
                    <div class="table-responsive">
                        <table class="cart-table">
                            <thead>
                                <tr>
                                    <th>Product</th>
                                    <th>Price</th>
                                    <th>Quantity</th>
                                    <th>Subtotal</th>
                                    <th style="text-align: right;">Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <asp:Repeater ID="rptCartItems" runat="server" OnItemCommand="rptCartItems_ItemCommand">
                                    <ItemTemplate>
                                        <tr>
                                            <td>
                                                <div class="cart-item-preview">
                                                    <img src='<%# Eval("ImageUrl") %>' alt='<%# Eval("ProductName") %>' class="cart-thumb" />
                                                    <div>
                                                        <h4 style="font-size: 0.95rem; margin-bottom: 4px;">
                                                            <a href='ProductDetails.aspx?id=<%# Eval("ProductId") %>' style="color: var(--primary);">
                                                                <%# Eval("ProductName") %>
                                                            </a>
                                                        </h4>
                                                        <span style="font-size: 0.8rem; color: var(--accent); font-weight: 600;"><%# Eval("CategoryName") %></span>
                                                    </div>
                                                </div>
                                            </td>
                                            <td>
                                                <span style="font-weight: 600; color: var(--text-main);">$<%# Convert.ToDecimal(Eval("Price")).ToString("F2") %></span>
                                            </td>
                                            <td>
                                                <div class="qty-btn-group">
                                                    <asp:LinkButton ID="btnMinus" runat="server" 
                                                        CommandName="Decrease" 
                                                        CommandArgument='<%# Eval("CartId") %>' 
                                                        CssClass="qty-btn" title="Decrease Quantity">
                                                        <i class="fa-solid fa-minus"></i>
                                                    </asp:LinkButton>
                                                    <span class="qty-num"><%# Eval("Quantity") %></span>
                                                    <asp:LinkButton ID="btnPlus" runat="server" 
                                                        CommandName="Increase" 
                                                        CommandArgument='<%# Eval("CartId") %>' 
                                                        CssClass="qty-btn" title="Increase Quantity">
                                                        <i class="fa-solid fa-plus"></i>
                                                    </asp:LinkButton>
                                                </div>
                                            </td>
                                            <td>
                                                <span style="font-weight: 800; color: var(--primary); font-size: 1.05rem;">
                                                    $<%# (Convert.ToDecimal(Eval("Price")) * Convert.ToInt32(Eval("Quantity"))).ToString("F2") %>
                                                </span>
                                            </td>
                                            <td style="text-align: right;">
                                                <asp:LinkButton ID="btnRemove" runat="server" 
                                                    CommandName="Remove" 
                                                    CommandArgument='<%# Eval("CartId") %>' 
                                                    CssClass="btn btn-danger btn-sm"
                                                    OnClientClick="return confirm('Are you sure you want to remove this item?');">
                                                    <i class="fa-solid fa-trash-can"></i> Remove
                                                </asp:LinkButton>
                                            </td>
                                        </tr>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </tbody>
                        </table>
                    </div>

                    <div style="padding: 16px 24px; background: #f8fafc; border-top: 1px solid var(--border-color); display: flex; justify-content: space-between; align-items: center;">
                        <a href="Products.aspx" class="btn btn-outline btn-sm">
                            <i class="fa-solid fa-arrow-left"></i> Continue Shopping
                        </a>
                        <asp:Button ID="btnClearCart" runat="server" Text="Clear Cart" CssClass="btn btn-danger btn-sm" OnClick="btnClearCart_Click" OnClientClick="return confirm('Clear all items from your cart?');" />
                    </div>
                </div>

                <!-- Order Summary Card -->
                <div>
                    <div class="cart-summary-card">
                        <h3 style="font-size: 1.25rem; color: var(--primary); margin-bottom: 20px;">Order Summary</h3>
                        
                        <div class="summary-row">
                            <span>Items Subtotal</span>
                            <span>$<asp:Literal ID="litSubtotal" runat="server">0.00</asp:Literal></span>
                        </div>

                        <div class="summary-row">
                            <span>Estimated Shipping</span>
                            <span style="color: var(--success); font-weight: 600;">FREE</span>
                        </div>

                        <div class="summary-row">
                            <span>Estimated Tax</span>
                            <span>$0.00</span>
                        </div>

                        <div class="summary-row total">
                            <span>Grand Total</span>
                            <span>$<asp:Literal ID="litGrandTotal" runat="server">0.00</asp:Literal></span>
                        </div>

                        <div style="margin-top: 24px;">
                            <a href="Checkout.aspx" class="btn btn-accent btn-lg" style="width: 100%; display: flex;">
                                Proceed to Checkout <i class="fa-solid fa-arrow-right" style="margin-left: 8px;"></i>
                            </a>
                        </div>

                        <div style="margin-top: 20px; font-size: 0.82rem; color: var(--text-muted); text-align: center;">
                            <i class="fa-solid fa-lock" style="color: var(--success); margin-right: 4px;"></i> 256-bit Encrypted Secure Checkout
                        </div>
                    </div>
                </div>
            </div>
        </asp:Panel>
    </div>
</asp:Content>
