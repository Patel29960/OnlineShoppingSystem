<%@ Page Title="Checkout" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Checkout.aspx.cs" Inherits="OnlineShoppingSystem.Checkout" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <style>
        .checkout-grid {
            display: grid;
            grid-template-columns: 1.6fr 1fr;
            gap: 32px;
            margin: 30px 0 60px;
        }
        .payment-methods {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 14px;
            margin-top: 10px;
        }
        .payment-card {
            border: 1px solid var(--border-color);
            border-radius: var(--radius-md);
            padding: 14px;
            display: flex;
            align-items: center;
            gap: 10px;
            cursor: pointer;
            transition: var(--transition);
        }
        .payment-card:hover {
            border-color: var(--accent);
            background-color: var(--accent-subtle);
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container">
        <!-- Page Header -->
        <div style="margin: 30px 0 10px;">
            <h1 style="font-size: 2.2rem; color: var(--primary);">Secure Checkout</h1>
            <p style="color: var(--text-muted); margin-top: 4px;">Enter your delivery address and choose payment method</p>
        </div>

        <!-- Alert Notification -->
        <asp:Panel ID="pnlAlert" runat="server" Visible="false">
            <div class="alert alert-danger">
                <i class="fa-solid fa-circle-exclamation"></i>
                <asp:Literal ID="litAlertMsg" runat="server"></asp:Literal>
            </div>
        </asp:Panel>

        <div class="checkout-grid">
            <!-- Left: Shipping and Payment Form -->
            <div>
                <!-- Shipping Address Card -->
                <div class="card" style="margin-bottom: 24px;">
                    <h3 style="font-size: 1.25rem; color: var(--primary); margin-bottom: 18px;">
                        <i class="fa-solid fa-location-dot" style="color: var(--accent); margin-right: 8px;"></i> Shipping Address
                    </h3>

                    <div class="form-group">
                        <label class="form-label">Recipient Full Name</label>
                        <asp:TextBox ID="txtName" runat="server" CssClass="form-control" placeholder="Full Name"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvName" runat="server" ControlToValidate="txtName" 
                            ErrorMessage="Name is required" ForeColor="#ef4444" Display="Dynamic" CssClass="error-text"></asp:RequiredFieldValidator>
                    </div>

                    <div class="form-group">
                        <label class="form-label">Delivery Street Address</label>
                        <asp:TextBox ID="txtAddress" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3" placeholder="House/Flat number, Building name, Street, Landmark"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvAddress" runat="server" ControlToValidate="txtAddress" 
                            ErrorMessage="Delivery address is required" ForeColor="#ef4444" Display="Dynamic" CssClass="error-text"></asp:RequiredFieldValidator>
                    </div>

                    <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 16px;">
                        <div class="form-group">
                            <label class="form-label">City / Town</label>
                            <asp:TextBox ID="txtCity" runat="server" CssClass="form-control" placeholder="City"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvCity" runat="server" ControlToValidate="txtCity" 
                                ErrorMessage="City is required" ForeColor="#ef4444" Display="Dynamic" CssClass="error-text"></asp:RequiredFieldValidator>
                        </div>
                        <div class="form-group">
                            <label class="form-label">Postal / ZIP Code</label>
                            <asp:TextBox ID="txtZip" runat="server" CssClass="form-control" placeholder="Postal Code"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvZip" runat="server" ControlToValidate="txtZip" 
                                ErrorMessage="Postal Code is required" ForeColor="#ef4444" Display="Dynamic" CssClass="error-text"></asp:RequiredFieldValidator>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="form-label">Contact Phone Number</label>
                        <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control" placeholder="Mobile Number"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvPhone" runat="server" ControlToValidate="txtPhone" 
                            ErrorMessage="Contact number is required" ForeColor="#ef4444" Display="Dynamic" CssClass="error-text"></asp:RequiredFieldValidator>
                    </div>
                </div>

                <!-- Payment Method Card -->
                <div class="card">
                    <h3 style="font-size: 1.25rem; color: var(--primary); margin-bottom: 18px;">
                        <i class="fa-solid fa-credit-card" style="color: var(--accent); margin-right: 8px;"></i> Payment Method
                    </h3>

                    <div class="form-group">
                        <asp:RadioButtonList ID="rblPayment" runat="server" CssClass="form-check" RepeatDirection="Vertical">
                            <asp:ListItem Value="Cash on Delivery" Selected="True"> &nbsp;Cash on Delivery (Pay when your order arrives)</asp:ListItem>
                            <asp:ListItem Value="Credit/Debit Card"> &nbsp;Credit / Debit Card (Online Demo Payment)</asp:ListItem>
                            <asp:ListItem Value="UPI / Net Banking"> &nbsp;UPI / Net Banking (Instant Confirmation)</asp:ListItem>
                        </asp:RadioButtonList>
                    </div>
                </div>
            </div>

            <!-- Right: Order Summary -->
            <div>
                <div class="cart-summary-card">
                    <h3 style="font-size: 1.25rem; color: var(--primary); margin-bottom: 20px;">Review Order</h3>

                    <!-- Order items list preview -->
                    <div style="max-height: 250px; overflow-y: auto; margin-bottom: 16px;">
                        <asp:Repeater ID="rptCheckoutItems" runat="server">
                            <ItemTemplate>
                                <div class="flex justify-between items-center" style="padding: 8px 0; border-bottom: 1px solid #f1f5f9; font-size: 0.9rem;">
                                    <div>
                                        <div style="font-weight: 600; color: var(--primary);"><%# Eval("ProductName") %></div>
                                        <div style="color: var(--text-muted); font-size: 0.8rem;">Qty: <%# Eval("Quantity") %> &times; $<%# Convert.ToDecimal(Eval("Price")).ToString("F2") %></div>
                                    </div>
                                    <div style="font-weight: 700; color: var(--primary);">
                                        $<%# (Convert.ToDecimal(Eval("Price")) * Convert.ToInt32(Eval("Quantity"))).ToString("F2") %>
                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>

                    <div class="summary-row">
                        <span>Items Subtotal</span>
                        <span>$<asp:Literal ID="litSubtotal" runat="server">0.00</asp:Literal></span>
                    </div>

                    <div class="summary-row">
                        <span>Shipping Fee</span>
                        <span style="color: var(--success); font-weight: 600;">FREE</span>
                    </div>

                    <div class="summary-row total">
                        <span>Total to Pay</span>
                        <span>$<asp:Literal ID="litGrandTotal" runat="server">0.00</asp:Literal></span>
                    </div>

                    <div style="margin-top: 24px;">
                        <asp:Button ID="btnPlaceOrder" runat="server" Text="Place Order Now" CssClass="btn btn-primary btn-lg" Width="100%" OnClick="btnPlaceOrder_Click" />
                    </div>

                    <div style="margin-top: 16px; text-align: center;">
                        <a href="Cart.aspx" style="font-size: 0.88rem; color: var(--text-muted);">
                            <i class="fa-solid fa-arrow-left"></i> Return to Cart
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

