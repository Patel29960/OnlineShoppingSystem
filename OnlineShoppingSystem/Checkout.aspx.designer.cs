namespace OnlineShoppingSystem
{
    public partial class Checkout
    {
        protected global::System.Web.UI.WebControls.Panel pnlAlert;
        protected global::System.Web.UI.WebControls.Literal litAlertMsg;
        protected global::System.Web.UI.WebControls.TextBox txtName;
        protected global::System.Web.UI.WebControls.RequiredFieldValidator rfvName;
        protected global::System.Web.UI.WebControls.TextBox txtAddress;
        protected global::System.Web.UI.WebControls.RequiredFieldValidator rfvAddress;
        protected global::System.Web.UI.WebControls.TextBox txtCity;
        protected global::System.Web.UI.WebControls.RequiredFieldValidator rfvCity;
        protected global::System.Web.UI.WebControls.TextBox txtZip;
        protected global::System.Web.UI.WebControls.RequiredFieldValidator rfvZip;
        protected global::System.Web.UI.WebControls.TextBox txtPhone;
        protected global::System.Web.UI.WebControls.RequiredFieldValidator rfvPhone;
        protected global::System.Web.UI.WebControls.RadioButtonList rblPayment;
        protected global::System.Web.UI.WebControls.Repeater rptCheckoutItems;
        protected global::System.Web.UI.WebControls.Literal litSubtotal;
        protected global::System.Web.UI.WebControls.Literal litGrandTotal;
        protected global::System.Web.UI.WebControls.Button btnPlaceOrder;
    }
}
