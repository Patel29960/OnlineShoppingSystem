# ShopEase - Modern Online Shopping System

An elegant, modern, and professional **Online Shopping System** built using **ASP.NET Web Forms**, **C#**, **ADO.NET**, and **Microsoft SQL Server**.

Designed with a clean e-commerce interface, clear separation of `.aspx` markups and `.aspx.cs` code-behind logic, and transparent relational database operations ideal for student submissions, viva evaluations, and real-world e-commerce demonstrations.

---

## 🚀 Key Features

### 🛍️ Customer Storefront
* **Fixed Responsive Navigation**: Brand logo, quick catalog links, search, interactive cart badge counter, and authenticated user dropdown.
* **Modern Home Page (`Default.aspx`)**: High-impact hero section, category discovery cards, featured products grid, promotional banners, and trust badges.
* **Product Catalog (`Products.aspx`)**: Clean responsive grid, real-time keyword search, category filters, and price/alphabetical sorting.
* **Product Details (`ProductDetails.aspx`)**: High-resolution image preview, stock inventory availability indicator, quantity selector, and instant add-to-cart.
* **Interactive Cart (`Cart.aspx`)**: Tabular cart overview, inline quantity increment/decrement (`+` and `-`), line item subtotal calculation, single-item deletion, and clear cart functionality.
* **Multi-Step Checkout (`Checkout.aspx`)**: Complete shipping address collection, payment method selection (Cash on Delivery, Credit/Debit, UPI), and order placement.
* **Order Confirmation Receipt (`OrderSuccess.aspx`)**: Clean receipt presentation with Order Tracking ID, order total, delivery destination, and payment confirmation.
* **User Profile & History (`Profile.aspx`)**: User avatar, registered email, total orders placed, membership duration, and interactive past order history table with status badges.
* **Profile Management (`EditProfile.aspx`)**: Form allowing customers to update their full name, email, and password.

### 🛡️ Administrator Panel (`/Admin`)
* **Role-Based Access Control (RBAC)**: Master page security verification ensuring only accounts with the `Admin` role can view management routes.
* **Admin Dashboard (`Admin/Dashboard.aspx`)**: Real-time KPI statistic cards tracking **Total Users**, **Total Products**, **Total Orders**, and **Total Categories**, plus recent customer orders.
* **Product Inventory Management (`Admin/ManageProducts.aspx`)**: ASP.NET `GridView` with thumbnail previews, live search, stock indicators, and direct edit/delete controls.
* **Add New Product (`Admin/AddProduct.aspx`)**: Form supporting product name, dynamic category dropdown, price validation, stock count, featured flag, and image URL / file upload.
* **Edit Product (`Admin/EditProduct.aspx`)**: Pre-populated editing screen to update pricing, description, stock, and imagery.
* **Order Fulfillment Center (`Admin/ManageOrders.aspx`)**: GridView tracking all customer orders with filterable status dropdown and inline order status updates (`Pending`, `Processing`, `Shipped`, `Delivered`, `Cancelled`).
* **User Account Management (`Admin/ManageUsers.aspx`)**: View all registered shoppers, toggle administrative privileges, or remove accounts.

---

## 🛠️ Technology Stack

| Layer | Technology |
|---|---|
| **Presentation (Frontend)** | ASP.NET Web Forms (`.aspx`), HTML5, CSS3, Font Awesome 6.5 |
| **Backend & Business Logic** | C# (`.aspx.cs`), .NET Framework 4.7.2 / 4.8 |
| **Data Access Layer** | ADO.NET (`SqlConnection`, `SqlCommand`, `SqlDataAdapter`, `SqlDataReader`) |
| **Database** | Microsoft SQL Server / SQL Server LocalDB |
| **Development Environment** | Visual Studio 2019 / 2022 / 2026 Community |

---

## 📂 Project Architecture

```
OnlineShoppingSystem/
│
├── OnlineShoppingSystem.sln              # Visual Studio Solution File (Double-click to open)
│
└── OnlineShoppingSystem/                  # ASP.NET Web Application Project
    │
    ├── Web.config                        # Database connection strings & validation configuration
    ├── Global.asax / Global.asax.cs      # Application & Session lifecycle management
    ├── OnlineShoppingDB.sql              # Complete database creation & sample data script
    │
    ├── Site.Master / Site.Master.cs      # Customer storefront layout & navigation
    ├── Default.aspx / Default.aspx.cs    # Home page with hero, categories & featured items
    ├── Products.aspx / Products.aspx.cs  # Product catalog with search, filter & sorting
    ├── ProductDetails.aspx / .cs         # Product detail view with quantity selector
    ├── Cart.aspx / Cart.aspx.cs          # Shopping cart with quantity modification
    ├── Checkout.aspx / Checkout.aspx.cs  # Order checkout & payment selection
    ├── OrderSuccess.aspx / .cs           # Order confirmation receipt
    ├── Login.aspx / Login.aspx.cs        # Member authentication with demo buttons
    ├── Register.aspx / Register.aspx.cs  # Customer account registration
    ├── Profile.aspx / Profile.aspx.cs    # Customer profile & past order history
    ├── EditProfile.aspx / .cs            # Profile credentials update
    ├── Logout.aspx / Logout.aspx.cs      # Session termination
    │
    ├── Admin/                            # Administrator Management Area
    │   ├── Admin.Master / .cs            # Admin panel sidebar layout & RBAC guard
    │   ├── Dashboard.aspx / .cs          # KPI stats & recent orders GridView
    │   ├── ManageProducts.aspx / .cs     # Product inventory GridView (Edit/Delete)
    │   ├── AddProduct.aspx / .cs         # Add product form (URL / Upload)
    │   ├── EditProduct.aspx / .cs        # Edit existing product form
    │   ├── ManageOrders.aspx / .cs       # Order tracking & status update
    │   └── ManageUsers.aspx / .cs        # User account management & role toggle
    │
    ├── App_Code/
    │   └── DBHelper.cs                   # Reusable ADO.NET helper (GetData, ExecuteNonQuery, ExecuteScalar)
    │
    └── css/
        └── style.css                     # Modern CSS design system (Navy, Slate, Royal Blue)
```

---

## 🗄️ Database Tables (`OnlineShoppingDB`)

The system uses 6 relational tables with primary keys, foreign keys, and cascading delete rules:

1. **`Users`**: `UserId` (PK), `FullName`, `Email` (Unique), `Password`, `Role` ('Customer' or 'Admin'), `CreatedAt`.
2. **`Categories`**: `CategoryId` (PK), `CategoryName`, `Description`, `ImageUrl`.
3. **`Products`**: `ProductId` (PK), `ProductName`, `CategoryId` (FK), `Price`, `Description`, `ImageUrl`, `StockQuantity`, `IsFeatured`, `CreatedAt`.
4. **`Cart`**: `CartId` (PK), `UserId` (FK), `ProductId` (FK), `Quantity`, `AddedAt`.
5. **`Orders`**: `OrderId` (PK), `UserId` (FK), `OrderDate`, `TotalAmount`, `ShippingAddress`, `PaymentMethod`, `OrderStatus`.
6. **`OrderDetails`**: `OrderDetailId` (PK), `OrderId` (FK), `ProductId` (FK), `Quantity`, `UnitPrice`.

---

## 🔑 Pre-Configured Demo Accounts

For instant testing and presentation demonstrations:

| Role | Email | Password | Access Level |
|---|---|---|---|
| **Administrator** | `admin@shopease.com` | `admin123` | Full access to Admin Panel (`/Admin/Dashboard.aspx`), inventory, orders & users |
| **Customer 1** | `prachi@example.com` | `user123` | Browsing, shopping cart, checkout, profile & order history |
| **Customer 2** | `rahul@example.com` | `user123` | Customer shopping account |

*(Tip: The Login page contains 1-click helper buttons that auto-fill demo credentials during project presentations!)*

---

## 💻 How to Run in Visual Studio

### Step 1: Set Up the Database
1. Open **SQL Server Management Studio (SSMS)** or Visual Studio's **SQL Server Object Explorer** (`Ctrl+\`, `Ctrl+S`).
2. Connect to your SQL Server instance (e.g., `(localdb)\MSSQLLocalDB` or `.\SQLEXPRESS`).
3. Open and execute `OnlineShoppingDB.sql`.
   *(Note: The database has already been pre-executed and seeded on this machine!)*

### Step 2: Open Solution in Visual Studio
1. Navigate to `c:\Users\Prachi\OneDrive\Desktop\OnlineShoppingSystem\`.
2. Double-click `OnlineShoppingSystem.sln` to open the project in **Visual Studio**.

### Step 3: Run the Project
1. In Solution Explorer, right-click `Default.aspx` and select **Set As Start Page**.
2. Press **F5** (or click the green **IIS Express** play button in the toolbar).
3. The browser will open displaying the **ShopEase** e-commerce home page!

---

## 🎓 BCA Viva & Presentation Highlights

When demonstrating this project to professors or examiners:
1. **Explain the 3-Tier Architecture**:
   - **Presentation Layer**: `.aspx` files with clean HTML5 semantic markup and CSS styling.
   - **Business Logic Layer**: `.aspx.cs` code-behind handling events, validations, and session state.
   - **Data Access Layer**: `DBHelper.cs` utilizing standard ADO.NET with parameterized queries to prevent SQL Injection.
2. **Session State Management**: Explain how `Session["UserId"]` and `Session["UserRole"]` control user state, cart item badges, and role-based access control.
3. **Data Binding**: Demonstrate how ASP.NET `Repeater` controls render responsive product cards, and how `GridView` controls display administrative tables.
4. **Relational Order Transactions**: Demonstrate placing an order in `Checkout.aspx` and show how it populates both master `Orders` and detail line items `OrderDetails`, then empties `Cart`.
