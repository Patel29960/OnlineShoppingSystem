namespace OnlineShoppingSystem.Admin
{
    public partial class EditProduct
    {
        protected global::System.Web.UI.WebControls.Panel pnlAlert;
        protected global::System.Web.UI.WebControls.Literal litAlertMsg;
        protected global::System.Web.UI.WebControls.TextBox txtProductName;
        protected global::System.Web.UI.WebControls.RequiredFieldValidator rfvName;
        protected global::System.Web.UI.WebControls.DropDownList ddlCategory;
        protected global::System.Web.UI.WebControls.RequiredFieldValidator rfvCategory;
        protected global::System.Web.UI.WebControls.TextBox txtPrice;
        protected global::System.Web.UI.WebControls.RequiredFieldValidator rfvPrice;
        protected global::System.Web.UI.WebControls.RegularExpressionValidator revPrice;
        protected global::System.Web.UI.WebControls.TextBox txtStock;
        protected global::System.Web.UI.WebControls.RequiredFieldValidator rfvStock;
        protected global::System.Web.UI.WebControls.CheckBox chkFeatured;
        protected global::System.Web.UI.WebControls.Image imgCurrent;
        protected global::System.Web.UI.WebControls.TextBox txtImageUrl;
        protected global::System.Web.UI.WebControls.FileUpload fuProductImage;
        protected global::System.Web.UI.WebControls.TextBox txtDescription;
        protected global::System.Web.UI.WebControls.Button btnUpdateProduct;
    }
}
