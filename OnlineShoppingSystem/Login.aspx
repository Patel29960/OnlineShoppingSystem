<%@ Page Title="Sign In" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="OnlineShoppingSystem.Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <style>
        .demo-box {
            background-color: #f1f5f9;
            border: 1px dashed #cbd5e1;
            border-radius: var(--radius-md);
            padding: 12px;
            margin-top: 20px;
            font-size: 0.85rem;
        }
        .demo-btn {
            background: #ffffff;
            border: 1px solid #cbd5e1;
            border-radius: var(--radius-sm);
            padding: 4px 8px;
            font-size: 0.78rem;
            cursor: pointer;
            margin-top: 6px;
            display: inline-block;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container">
        <div class="auth-wrapper">
            <div class="auth-card">
                <!-- Left Visual Graphic Banner -->
                <div class="auth-sidebar">
                    <div>
                        <div class="brand-logo" style="color: #ffffff; margin-bottom: 24px;">
                            <div class="brand-icon">
                                <i class="fa-solid fa-bag-shopping"></i>
                            </div>
                            <span>Shop<span class="highlight">Ease</span></span>
                        </div>
                        <h2>Welcome Back!</h2>
                        <p>Sign in to access your curated shopping bag, track active orders, and discover new trending collections.</p>
                    </div>

                    <div style="margin-top: 40px;">
                        <div class="flex items-center gap-2" style="color: #cbd5e1; font-size: 0.9rem; margin-bottom: 8px;">
                            <i class="fa-solid fa-shield-halved" style="color: #60a5fa;"></i> 100% Secure Checkout Guarantee
                        </div>
                        <div class="flex items-center gap-2" style="color: #cbd5e1; font-size: 0.9rem;">
                            <i class="fa-solid fa-truck-fast" style="color: #60a5fa;"></i> Express Nationwide Delivery
                        </div>
                    </div>
                </div>

                <!-- Right Login Form -->
                <div class="auth-form-container">
                    <div class="auth-header">
                        <h3>Member Login</h3>
                        <p>Enter your email and password to continue</p>
                    </div>

                    <!-- Notification Alert Message -->
                    <asp:Panel ID="pnlAlert" runat="server" Visible="false">
                        <div class="alert alert-danger">
                            <i class="fa-solid fa-circle-exclamation"></i>
                            <asp:Literal ID="litAlertMsg" runat="server"></asp:Literal>
                        </div>
                    </asp:Panel>

                    <asp:Panel ID="pnlSuccess" runat="server" Visible="false">
                        <div class="alert alert-success">
                            <i class="fa-solid fa-circle-check"></i>
                            <asp:Literal ID="litSuccessMsg" runat="server"></asp:Literal>
                        </div>
                    </asp:Panel>

                    <!-- Email Field -->
                    <div class="form-group">
                        <label class="form-label" for="txtEmail">Email Address</label>
                        <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" placeholder="name@example.com" TextMode="Email"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail" 
                            ErrorMessage="Email is required" ForeColor="#ef4444" Display="Dynamic" CssClass="error-text"></asp:RequiredFieldValidator>
                    </div>

                    <!-- Password Field -->
                    <div class="form-group">
                        <div class="flex justify-between items-center" style="margin-bottom: 6px;">
                            <label class="form-label" for="txtPassword" style="margin-bottom: 0;">Password</label>
                            <a href="javascript:alert('For demo purposes, please use the test passwords or contact admin.');" style="font-size: 0.85rem; color: var(--accent);">Forgot password?</a>
                        </div>
                        <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password" placeholder="••••••••"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvPassword" runat="server" ControlToValidate="txtPassword" 
                            ErrorMessage="Password is required" ForeColor="#ef4444" Display="Dynamic" CssClass="error-text"></asp:RequiredFieldValidator>
                    </div>

                    <!-- Remember Me Checkbox -->
                    <div class="form-group">
                        <label class="form-check">
                            <asp:CheckBox ID="chkRemember" runat="server" />
                            <span>Remember my login</span>
                        </label>
                    </div>

                    <!-- Login Button -->
                    <div style="margin-top: 10px;">
                        <asp:Button ID="btnLogin" runat="server" Text="Sign In to ShopEase" CssClass="btn btn-primary" Width="100%" OnClick="btnLogin_Click" />
                    </div>

                    <!-- Quick Demo Credentials for presentation -->
                    <div class="demo-box">
                        <strong>Demo Accounts (Click to test):</strong><br />
                        <a href="javascript:void(0);" onclick="fillDemo('admin@shopease.com', 'admin123')" class="demo-btn">
                            <i class="fa-solid fa-lock"></i> Admin: admin@shopease.com
                        </a>
                        <a href="javascript:void(0);" onclick="fillDemo('prachi@example.com', 'user123')" class="demo-btn">
                            <i class="fa-solid fa-user"></i> Customer: prachi@example.com
                        </a>
                    </div>

                    <div class="auth-footer">
                        Don't have an account? <a href="Register.aspx" style="font-weight: 700; color: var(--accent);">Create an Account</a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script type="text/javascript">
        function fillDemo(email, pass) {
            document.getElementById('<%= txtEmail.ClientID %>').value = email;
            document.getElementById('<%= txtPassword.ClientID %>').value = pass;
        }
    </script>
</asp:Content>

