<%@ Page Title="Order Confirmed" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="OrderSuccess.aspx.cs" Inherits="OnlineShoppingSystem.OrderSuccess" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <style>
        .success-card {
            max-width: 650px;
            margin: 40px auto 60px;
            background: #ffffff;
            border-radius: var(--radius-lg);
            border: 1px solid var(--border-color);
            padding: 48px;
            text-align: center;
            box-shadow: var(--shadow-md);
        }
        .success-icon-box {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            background-color: #ecfdf5;
            color: #10b981;
            font-size: 2.5rem;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 24px;
        }
        .order-meta-box {
            background-color: #f8fafc;
            border: 1px solid var(--border-color);
            border-radius: var(--radius-md);
            padding: 20px;
            margin: 28px 0;
            text-align: left;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container">
        <div class="success-card">
            <div class="success-icon-box">
                <i class="fa-solid fa-check"></i>
            </div>

            <h1 style="font-size: 2rem; color: var(--primary); margin-bottom: 8px;">Order Placed Successfully!</h1>
            <p style="color: var(--text-muted); font-size: 1.05rem;">Thank you for shopping with ShopEase. Your order has been registered and is being prepared.</p>

            <div class="order-meta-box">
                <div class="flex justify-between items-center" style="margin-bottom: 12px; padding-bottom: 10px; border-bottom: 1px solid var(--border-color);">
                    <span style="color: var(--text-muted);">Order Tracking ID:</span>
                    <strong style="color: var(--accent); font-size: 1.1rem;">#<asp:Literal ID="litOrderId" runat="server"></asp:Literal></strong>
                </div>
                <div class="flex justify-between items-center" style="margin-bottom: 12px;">
                    <span style="color: var(--text-muted);">Order Date:</span>
                    <strong style="color: var(--primary);"><asp:Literal ID="litOrderDate" runat="server"></asp:Literal></strong>
                </div>
                <div class="flex justify-between items-center" style="margin-bottom: 12px;">
                    <span style="color: var(--text-muted);">Payment Method:</span>
                    <strong style="color: var(--primary);"><asp:Literal ID="litPayment" runat="server"></asp:Literal></strong>
                </div>
                <div class="flex justify-between items-center" style="margin-bottom: 12px;">
                    <span style="color: var(--text-muted);">Total Amount Paid:</span>
                    <strong style="color: var(--primary); font-size: 1.15rem;">$<asp:Literal ID="litTotal" runat="server"></asp:Literal></strong>
                </div>
                <div>
                    <span style="color: var(--text-muted); display: block; margin-bottom: 4px;">Delivering To:</span>
                    <div style="font-size: 0.9rem; color: var(--primary); font-weight: 500;">
                        <asp:Literal ID="litShipping" runat="server"></asp:Literal>
                    </div>
                </div>
            </div>

            <div class="flex justify-center gap-3">
                <a href="Profile.aspx" class="btn btn-outline btn-lg">View Order History</a>
                <a href="Products.aspx" class="btn btn-primary btn-lg">Continue Shopping</a>
            </div>
        </div>
    </div>
</asp:Content>
