<%@ Page Title="Edit Profile" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="EditProfile.aspx.cs" Inherits="OnlineShoppingSystem.EditProfile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container">
        <div style="max-width: 650px; margin: 40px auto 60px;">
            <div class="card" style="padding: 40px;">
                <div class="section-header" style="margin-bottom: 24px;">
                    <div>
                        <h2 style="font-size: 1.8rem; color: var(--primary);">Edit Your Profile</h2>
                        <p style="color: var(--text-muted); font-size: 0.95rem;">Update your account credentials and personal details</p>
                    </div>
                </div>

                <!-- Alert Messages -->
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

                <!-- Full Name -->
                <div class="form-group">
                    <label class="form-label" for="txtFullName">Full Name</label>
                    <asp:TextBox ID="txtFullName" runat="server" CssClass="form-control"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvName" runat="server" ControlToValidate="txtFullName" 
                        ErrorMessage="Full Name is required" ForeColor="#ef4444" Display="Dynamic" CssClass="error-text"></asp:RequiredFieldValidator>
                </div>

                <!-- Email Address -->
                <div class="form-group">
                    <label class="form-label" for="txtEmail">Email Address</label>
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" TextMode="Email"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail" 
                        ErrorMessage="Email is required" ForeColor="#ef4444" Display="Dynamic" CssClass="error-text"></asp:RequiredFieldValidator>
                </div>

                <!-- Change Password (Optional) -->
                <div style="margin: 28px 0 16px; border-top: 1px solid var(--border-color); padding-top: 20px;">
                    <h4 style="font-size: 1.1rem; color: var(--primary); margin-bottom: 6px;">Change Password (Optional)</h4>
                    <p style="color: var(--text-muted); font-size: 0.85rem; margin-bottom: 16px;">Leave blank if you do not wish to update your existing password.</p>
                </div>

                <div class="form-group">
                    <label class="form-label" for="txtNewPassword">New Password</label>
                    <asp:TextBox ID="txtNewPassword" runat="server" CssClass="form-control" TextMode="Password" placeholder="Enter new password"></asp:TextBox>
                </div>

                <div class="form-group">
                    <label class="form-label" for="txtConfirmNewPassword">Confirm New Password</label>
                    <asp:TextBox ID="txtConfirmNewPassword" runat="server" CssClass="form-control" TextMode="Password" placeholder="Confirm new password"></asp:TextBox>
                    <asp:CompareValidator ID="cvPass" runat="server" ControlToValidate="txtConfirmNewPassword" 
                        ControlToCompare="txtNewPassword" ErrorMessage="New passwords do not match" ForeColor="#ef4444" Display="Dynamic" CssClass="error-text"></asp:CompareValidator>
                </div>

                <!-- Action Buttons -->
                <div class="flex gap-3" style="margin-top: 30px;">
                    <asp:Button ID="btnSave" runat="server" Text="Save Changes" CssClass="btn btn-primary btn-lg" OnClick="btnSave_Click" />
                    <a href="Profile.aspx" class="btn btn-outline btn-lg">Cancel</a>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

