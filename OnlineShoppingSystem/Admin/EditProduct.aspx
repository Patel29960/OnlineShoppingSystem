<%@ Page Title="Edit Product" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="EditProduct.aspx.cs" Inherits="OnlineShoppingSystem.Admin.EditProduct" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="AdminContent" runat="server">
    <div style="max-width: 800px; margin-bottom: 50px;">
        <div class="card" style="padding: 36px;">
            <div class="section-header" style="margin-bottom: 24px;">
                <div>
                    <h3 style="font-size: 1.5rem; color: var(--primary);">Update Product Information</h3>
                    <p style="color: var(--text-muted); font-size: 0.9rem;">Edit pricing, specifications, inventory quantity, or images</p>
                </div>
                <a href="ManageProducts.aspx" class="btn btn-outline btn-sm">
                    <i class="fa-solid fa-arrow-left"></i> Cancel &amp; Back
                </a>
            </div>

            <!-- Alert Notification -->
            <asp:Panel ID="pnlAlert" runat="server" Visible="false">
                <div class="alert alert-danger">
                    <i class="fa-solid fa-circle-exclamation"></i>
                    <asp:Literal ID="litAlertMsg" runat="server"></asp:Literal>
                </div>
            </asp:Panel>

            <!-- Product Name -->
            <div class="form-group">
                <label class="form-label" for="txtProductName">Product Name *</label>
                <asp:TextBox ID="txtProductName" runat="server" CssClass="form-control"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvName" runat="server" ControlToValidate="txtProductName" 
                    ErrorMessage="Product name is required" ForeColor="#ef4444" Display="Dynamic" CssClass="error-text"></asp:RequiredFieldValidator>
            </div>

            <!-- Category & Price in two columns -->
            <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 20px;">
                <div class="form-group">
                    <label class="form-label" for="ddlCategory">Category *</label>
                    <asp:DropDownList ID="ddlCategory" runat="server" CssClass="form-control">
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="rfvCategory" runat="server" ControlToValidate="ddlCategory" 
                        InitialValue="0" ErrorMessage="Please select a valid category" ForeColor="#ef4444" Display="Dynamic" CssClass="error-text"></asp:RequiredFieldValidator>
                </div>

                <div class="form-group">
                    <label class="form-label" for="txtPrice">Price ($ USD) *</label>
                    <asp:TextBox ID="txtPrice" runat="server" CssClass="form-control"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvPrice" runat="server" ControlToValidate="txtPrice" 
                        ErrorMessage="Price is required" ForeColor="#ef4444" Display="Dynamic" CssClass="error-text"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="revPrice" runat="server" ControlToValidate="txtPrice" 
                        ValidationExpression="^\d+(\.\d{1,2})?$" ErrorMessage="Enter a valid decimal price" ForeColor="#ef4444" Display="Dynamic" CssClass="error-text"></asp:RegularExpressionValidator>
                </div>
            </div>

            <!-- Stock Quantity & Is Featured -->
            <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 20px;">
                <div class="form-group">
                    <label class="form-label" for="txtStock">Stock Quantity *</label>
                    <asp:TextBox ID="txtStock" runat="server" CssClass="form-control" TextMode="Number" min="0"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvStock" runat="server" ControlToValidate="txtStock" 
                        ErrorMessage="Stock is required" ForeColor="#ef4444" Display="Dynamic" CssClass="error-text"></asp:RequiredFieldValidator>
                </div>

                <div class="form-group" style="padding-top: 30px;">
                    <label class="form-check">
                        <asp:CheckBox ID="chkFeatured" runat="server" />
                        <span style="font-weight: 600; color: var(--primary);">Mark as Featured Product</span>
                    </label>
                </div>
            </div>

            <!-- Current Image Preview -->
            <div class="form-group">
                <label class="form-label">Current Image Preview</label>
                <div style="margin-bottom: 10px;">
                    <asp:Image ID="imgCurrent" runat="server" style="max-height: 120px; border-radius: var(--radius-md); border: 1px solid var(--border-color);" />
                </div>
            </div>

            <!-- Image URL -->
            <div class="form-group">
                <label class="form-label" for="txtImageUrl">Image Web URL</label>
                <asp:TextBox ID="txtImageUrl" runat="server" CssClass="form-control"></asp:TextBox>
            </div>

            <!-- Or File Upload -->
            <div class="form-group">
                <label class="form-label" for="fuProductImage">Or Upload New Image</label>
                <asp:FileUpload ID="fuProductImage" runat="server" CssClass="form-control" />
            </div>

            <!-- Description -->
            <div class="form-group">
                <label class="form-label" for="txtDescription">Detailed Description</label>
                <asp:TextBox ID="txtDescription" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="4"></asp:TextBox>
            </div>

            <!-- Submit Buttons -->
            <div style="margin-top: 30px;" class="flex gap-3">
                <asp:Button ID="btnUpdateProduct" runat="server" Text="Update Product" CssClass="btn btn-primary btn-lg" OnClick="btnUpdateProduct_Click" />
                <a href="ManageProducts.aspx" class="btn btn-outline btn-lg">Cancel</a>
            </div>
        </div>
    </div>
</asp:Content>

