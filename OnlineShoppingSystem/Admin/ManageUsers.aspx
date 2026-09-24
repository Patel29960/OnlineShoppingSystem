<%@ Page Title="Manage Users" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="ManageUsers.aspx.cs" Inherits="OnlineShoppingSystem.Admin.ManageUsers" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="AdminContent" runat="server">
    <div style="margin-bottom: 40px;">
        <div class="card" style="padding: 28px;">
            <div class="section-header" style="margin-bottom: 20px;">
                <div>
                    <h3 style="font-size: 1.4rem; color: var(--primary);">Registered User Accounts</h3>
                    <p style="color: var(--text-muted); font-size: 0.88rem;">Review customer registrations, administrators, and manage user access</p>
                </div>
                <div style="color: var(--text-muted); font-size: 0.9rem;">
                    Total Accounts: <strong style="color: var(--primary);"><asp:Literal ID="litUserCount" runat="server">0</asp:Literal></strong>
                </div>
            </div>

            <!-- Alert Notification -->
            <asp:Panel ID="pnlAlert" runat="server" Visible="false">
                <div class="alert alert-success">
                    <i class="fa-solid fa-circle-check"></i>
                    <asp:Literal ID="litAlertMsg" runat="server"></asp:Literal>
                </div>
            </asp:Panel>

            <!-- ASP.NET GridView -->
            <div class="table-responsive">
                <asp:GridView ID="gvUsers" runat="server" AutoGenerateColumns="False" 
                    DataKeyNames="UserId" CssClass="gridview-modern" GridLines="None"
                    OnRowCommand="gvUsers_RowCommand" EmptyDataText="No users found.">
                    <Columns>
                        <asp:TemplateField HeaderText="User ID" ItemStyle-Width="80px">
                            <ItemTemplate>
                                <span style="font-weight: 700; color: var(--text-muted);">#<%# Eval("UserId") %></span>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Full Name">
                            <ItemTemplate>
                                <strong><%# Eval("FullName") %></strong>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Email Address">
                            <ItemTemplate>
                                <span><%# Eval("Email") %></span>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Role Privilege">
                            <ItemTemplate>
                                <span class='<%# Eval("Role").ToString() == "Admin" ? "badge-status badge-processing" : "badge-status badge-delivered" %>'>
                                    <i class='<%# Eval("Role").ToString() == "Admin" ? "fa-solid fa-shield-halved" : "fa-solid fa-user" %>'></i>
                                    <%# Eval("Role") %>
                                </span>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Registered On">
                            <ItemTemplate>
                                <%# Convert.ToDateTime(Eval("CreatedAt")).ToString("MMM dd, yyyy") %>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Actions" ItemStyle-HorizontalAlign="Right" ItemStyle-Width="180px">
                            <ItemTemplate>
                                <asp:LinkButton ID="btnToggleRole" runat="server" 
                                    CommandName="ToggleRole" 
                                    CommandArgument='<%# Eval("UserId") %>' 
                                    CssClass="btn btn-outline btn-sm" 
                                    Visible='<%# Eval("Email").ToString() != "admin@shopease.com" %>'
                                    title="Toggle Admin / Customer Role">
                                    <i class="fa-solid fa-arrows-rotate"></i> Change Role
                                </asp:LinkButton>
                                
                                <asp:LinkButton ID="btnDeleteUser" runat="server" 
                                    CommandName="DeleteUser" 
                                    CommandArgument='<%# Eval("UserId") %>' 
                                    CssClass="btn btn-danger btn-sm"
                                    Visible='<%# Eval("Email").ToString() != "admin@shopease.com" %>'
                                    OnClientClick="return confirm('Are you sure you want to delete this user? All their carts and orders will be removed.');"
                                    title="Delete User">
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
