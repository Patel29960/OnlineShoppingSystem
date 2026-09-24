<%@ Page Title="Add Product" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="AddProduct.aspx.cs" Inherits="OnlineShoppingSystem.Admin.AddProduct" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="AdminContent" runat="server">
    <div style="max-width: 800px; margin-bottom: 50px;">
        <div class="card" style="padding: 36px;">
            <div class="section-header" style="margin-bottom: 24px;">
                <div>
                    <h3 style="font-size: 1.5rem; color: var(--primary);">Add New Inventory Product</h3>
                    <p style="color: var(--text-muted); font-size: 0.9rem;">Fill in the product specifications to list it on the store catalog</p>
                </div>
                <a href="ManageProducts.aspx" class="btn btn-outline btn-sm">
                    <i class="fa-solid fa-arrow-left"></i> Back to Inventory
                </a>
            </div>

            <!-- Alert Notification -->
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

            <!-- Product Name -->
            <div class="form-group">
                <label class="form-label" for="txtProductName">Product Name *</label>
                <asp:TextBox ID="txtProductName" runat="server" CssClass="form-control" placeholder="e.g. Wireless Noise Cancelling Headphones"></asp:TextBox>
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
                    <asp:TextBox ID="txtPrice" runat="server" CssClass="form-control" placeholder="e.g. 79.99"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvPrice" runat="server" ControlToValidate="txtPrice" 
                        ErrorMessage="Price is required" ForeColor="#ef4444" Display="Dynamic" CssClass="error-text"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="revPrice" runat="server" ControlToValidate="txtPrice" 
                        ValidationExpression="^\d+(\.\d{1,2})?$" ErrorMessage="Enter a valid decimal price (e.g. 29.99)" ForeColor="#ef4444" Display="Dynamic" CssClass="error-text"></asp:RegularExpressionValidator>
                </div>
            </div>

            <!-- Stock Quantity & Is Featured -->
            <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 20px;">
                <div class="form-group">
                    <label class="form-label" for="txtStock">Stock Quantity *</label>
                    <asp:TextBox ID="txtStock" runat="server" CssClass="form-control" TextMode="Number" Text="15" min="0"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvStock" runat="server" ControlToValidate="txtStock" 
                        ErrorMessage="Stock is required" ForeColor="#ef4444" Display="Dynamic" CssClass="error-text"></asp:RequiredFieldValidator>
                </div>

                <div class="form-group" style="padding-top: 30px;">
                    <label class="form-check">
                        <asp:CheckBox ID="chkFeatured" runat="server" />
                        <span style="font-weight: 600; color: var(--primary);">Mark as Featured Product (Display on Home page)</span>
                    </label>
                </div>
            </div>

            <!-- Product Image URL / Upload -->
            <div class="form-group">
                <label class="form-label" for="txtImageUrl">Product Image Web URL</label>
                <asp:TextBox ID="txtImageUrl" runat="server" CssClass="form-control" placeholder="https://images.unsplash.com/... or paste image web link"></asp:TextBox>
                <small style="color: var(--text-muted); font-size: 0.8rem; display: block; margin-top: 4px;">
                    Recommended: Use direct image links from Unsplash, or upload an image file below.
                </small>
            </div>

            <div class="form-group">
                <label class="form-label" for="fuProductImage">Or Upload Product Image File</label>
                <asp:FileUpload ID="fuProductImage" runat="server" CssClass="form-control" />
            </div>

            <!-- Description -->
            <div class="form-group">
                <label class="form-label" for="txtDescription">Detailed Description</label>
                <asp:TextBox ID="txtDescription" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="4" placeholder="Enter key features, material, technical specifications, and warranty details..."></asp:TextBox>
            </div>

            <!-- Submit Button -->
            <div style="margin-top: 30px;" class="flex gap-3">
                <asp:Button ID="btnAddProduct" runat="server" Text="Add Product to Store" CssClass="btn btn-primary btn-lg" OnClick="btnAddProduct_Click" />
                <asp:Button ID="btnReset" runat="server" Text="Clear Form" CssClass="btn btn-outline btn-lg" OnClick="btnReset_Click" CausesValidation="false" />
            </div>
        </div>
    </div>
</asp:Content>

