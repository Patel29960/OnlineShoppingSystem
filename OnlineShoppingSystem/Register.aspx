<%@ Page Title="Create Account" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="OnlineShoppingSystem.Register" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container">
        <div class="auth-wrapper">
            <div class="auth-card">
                <!-- Left Banner Graphic -->
                <div class="auth-sidebar">
                    <div>
                        <div class="brand-logo" style="color: #ffffff; margin-bottom: 24px;">
                            <div class="brand-icon">
                                <i class="fa-solid fa-bag-shopping"></i>
                            </div>
                            <span>Shop<span class="highlight">Ease</span></span>
                        </div>
                        <h2>Join ShopEase Today</h2>
                        <p>Create an account to start shopping our curated catalogue, save favorites, and enjoy express delivery.</p>
                    </div>

                    <div>
                        <ul style="list-style: none; color: #cbd5e1; font-size: 0.9rem;">
                            <li style="margin-bottom: 12px;"><i class="fa-solid fa-check" style="color: #34d399; margin-right: 8px;"></i> Fast, 1-click checkout</li>
                            <li style="margin-bottom: 12px;"><i class="fa-solid fa-check" style="color: #34d399; margin-right: 8px;"></i> Real-time package tracking</li>
                            <li><i class="fa-solid fa-check" style="color: #34d399; margin-right: 8px;"></i> Exclusive subscriber offers</li>
                        </ul>
                    </div>
                </div>

                <!-- Registration Form -->
                <div class="auth-form-container">
                    <div class="auth-header">
                        <h3>Create Account</h3>
                        <p>Fill in your details below to register your account</p>
                    </div>

                    <!-- Alert message -->
                    <asp:Panel ID="pnlAlert" runat="server" Visible="false">
                        <div class="alert alert-danger">
                            <i class="fa-solid fa-circle-exclamation"></i>
                            <asp:Literal ID="litAlertMsg" runat="server"></asp:Literal>
                        </div>
                    </asp:Panel>

                    <!-- Full Name -->
                    <div class="form-group">
                        <label class="form-label" for="txtFullName">Full Name</label>
                        <asp:TextBox ID="txtFullName" runat="server" CssClass="form-control" placeholder="John Doe"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvName" runat="server" ControlToValidate="txtFullName" 
                            ErrorMessage="Full Name is required" ForeColor="#ef4444" Display="Dynamic" CssClass="error-text"></asp:RequiredFieldValidator>
                    </div>

                    <!-- Email Address -->
                    <div class="form-group">
                        <label class="form-label" for="txtEmail">Email Address</label>
                        <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" TextMode="Email" placeholder="john@example.com"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail" 
                            ErrorMessage="Email is required" ForeColor="#ef4444" Display="Dynamic" CssClass="error-text"></asp:RequiredFieldValidator>
                    </div>

                    <!-- Password -->
                    <div class="form-group">
                        <label class="form-label" for="txtPassword">Password</label>
                        <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password" placeholder="Minimum 6 characters"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvPassword" runat="server" ControlToValidate="txtPassword" 
                            ErrorMessage="Password is required" ForeColor="#ef4444" Display="Dynamic" CssClass="error-text"></asp:RequiredFieldValidator>
                    </div>

                    <!-- Confirm Password -->
                    <div class="form-group">
                        <label class="form-label" for="txtConfirmPassword">Confirm Password</label>
                        <asp:TextBox ID="txtConfirmPassword" runat="server" CssClass="form-control" TextMode="Password" placeholder="Re-enter password"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvConfirmPassword" runat="server" ControlToValidate="txtConfirmPassword" 
                            ErrorMessage="Please confirm your password" ForeColor="#ef4444" Display="Dynamic" CssClass="error-text"></asp:RequiredFieldValidator>
                        <asp:CompareValidator ID="cvPassword" runat="server" ControlToValidate="txtConfirmPassword" 
                            ControlToCompare="txtPassword" ErrorMessage="Passwords do not match" ForeColor="#ef4444" Display="Dynamic" CssClass="error-text"></asp:CompareValidator>
                    </div>

                    <!-- Register Button -->
                    <div style="margin-top: 24px;">
                        <asp:Button ID="btnRegister" runat="server" Text="Create Account" CssClass="btn btn-primary" Width="100%" OnClick="btnRegister_Click" />
                    </div>

                    <div class="auth-footer">
                        Already have an account? <a href="Login.aspx" style="font-weight: 700; color: var(--accent);">Sign In here</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

