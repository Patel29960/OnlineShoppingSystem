-- =======================================================
-- ONLINE SHOPPING SYSTEM (ShopEase) - DATABASE SCRIPT
-- Technology: Microsoft SQL Server / LocalDB
-- ADO.NET compatible relational schema with sample data
-- =======================================================

-- Step 1: Create Database if it does not exist
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = 'OnlineShoppingDB')
BEGIN
    CREATE DATABASE OnlineShoppingDB;
END
GO

USE OnlineShoppingDB;
GO

-- Step 2: Drop Existing Tables in Reverse Dependency Order (For clean re-runs)
IF OBJECT_ID('OrderDetails', 'U') IS NOT NULL DROP TABLE OrderDetails;
IF OBJECT_ID('Orders', 'U') IS NOT NULL DROP TABLE Orders;
IF OBJECT_ID('Cart', 'U') IS NOT NULL DROP TABLE Cart;
IF OBJECT_ID('Products', 'U') IS NOT NULL DROP TABLE Products;
IF OBJECT_ID('Categories', 'U') IS NOT NULL DROP TABLE Categories;
IF OBJECT_ID('Users', 'U') IS NOT NULL DROP TABLE Users;
GO

-- =======================================================
-- Table 1: Users
-- Stores Customer and Administrator accounts
-- =======================================================
CREATE TABLE Users (
    UserId INT IDENTITY(1,1) PRIMARY KEY,
    FullName NVARCHAR(100) NOT NULL,
    Email NVARCHAR(100) NOT NULL UNIQUE,
    Password NVARCHAR(100) NOT NULL,
    Role NVARCHAR(20) NOT NULL DEFAULT 'Customer', -- 'Customer' or 'Admin'
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE()
);
GO

-- =======================================================
-- Table 2: Categories
-- Product categories (Electronics, Fashion, etc.)
-- =======================================================
CREATE TABLE Categories (
    CategoryId INT IDENTITY(1,1) PRIMARY KEY,
    CategoryName NVARCHAR(100) NOT NULL,
    Description NVARCHAR(255) NULL,
    ImageUrl NVARCHAR(500) NULL
);
GO

-- =======================================================
-- Table 3: Products
-- Product catalog items
-- =======================================================
CREATE TABLE Products (
    ProductId INT IDENTITY(1,1) PRIMARY KEY,
    ProductName NVARCHAR(150) NOT NULL,
    CategoryId INT NOT NULL,
    Price DECIMAL(10, 2) NOT NULL,
    Description NVARCHAR(MAX) NULL,
    ImageUrl NVARCHAR(500) NULL,
    StockQuantity INT NOT NULL DEFAULT 10,
    IsFeatured BIT NOT NULL DEFAULT 0,
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT FK_Products_Categories FOREIGN KEY (CategoryId) 
        REFERENCES Categories(CategoryId) ON DELETE CASCADE
);
GO

-- =======================================================
-- Table 4: Cart
-- Active shopping cart items per user
-- =======================================================
CREATE TABLE Cart (
    CartId INT IDENTITY(1,1) PRIMARY KEY,
    UserId INT NOT NULL,
    ProductId INT NOT NULL,
    Quantity INT NOT NULL DEFAULT 1,
    AddedAt DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT FK_Cart_Users FOREIGN KEY (UserId) 
        REFERENCES Users(UserId) ON DELETE CASCADE,
    CONSTRAINT FK_Cart_Products FOREIGN KEY (ProductId) 
        REFERENCES Products(ProductId) ON DELETE CASCADE
);
GO

-- =======================================================
-- Table 5: Orders
-- Master order records
-- =======================================================
CREATE TABLE Orders (
    OrderId INT IDENTITY(1001,1) PRIMARY KEY,
    UserId INT NOT NULL,
    OrderDate DATETIME NOT NULL DEFAULT GETDATE(),
    TotalAmount DECIMAL(10, 2) NOT NULL,
    ShippingAddress NVARCHAR(500) NOT NULL,
    PaymentMethod NVARCHAR(50) NOT NULL DEFAULT 'Cash on Delivery',
    OrderStatus NVARCHAR(50) NOT NULL DEFAULT 'Pending', -- 'Pending', 'Processing', 'Shipped', 'Delivered', 'Cancelled'
    CONSTRAINT FK_Orders_Users FOREIGN KEY (UserId) 
        REFERENCES Users(UserId) ON DELETE CASCADE
);
GO

-- =======================================================
-- Table 6: OrderDetails
-- Individual line items in an order
-- =======================================================
CREATE TABLE OrderDetails (
    OrderDetailId INT IDENTITY(1,1) PRIMARY KEY,
    OrderId INT NOT NULL,
    ProductId INT NOT NULL,
    Quantity INT NOT NULL,
    UnitPrice DECIMAL(10, 2) NOT NULL,
    CONSTRAINT FK_OrderDetails_Orders FOREIGN KEY (OrderId) 
        REFERENCES Orders(OrderId) ON DELETE CASCADE,
    CONSTRAINT FK_OrderDetails_Products FOREIGN KEY (ProductId) 
        REFERENCES Products(ProductId)
);
GO

-- =======================================================
-- SAMPLE SEED DATA
-- =======================================================

-- 1. Insert Initial Users (Admin & Customer)
INSERT INTO Users (FullName, Email, Password, Role, CreatedAt)
VALUES 
('System Admin', 'admin@shopease.com', 'admin123', 'Admin', GETDATE()),
('Prachi Patel', 'prachi@example.com', 'user123', 'Customer', GETDATE()),
('Rahul Sharma', 'rahul@example.com', 'user123', 'Customer', GETDATE());
GO

-- 2. Insert Categories
INSERT INTO Categories (CategoryName, Description, ImageUrl)
VALUES 
('Electronics', 'Premium gadgets, audio, laptops & accessories', 'https://images.unsplash.com/photo-1498049794561-7780e7231661?w=500&auto=format&fit=crop&q=80'),
('Fashion', 'Modern apparel, timeless watches & smart accessories', 'https://images.unsplash.com/photo-1445205170230-053b83016050?w=500&auto=format&fit=crop&q=80'),
('Home & Living', 'Aesthetic home decor, modern lighting & furnishings', 'https://images.unsplash.com/photo-1513694203232-719a280e022f?w=500&auto=format&fit=crop&q=80'),
('Footwear', 'Performance running shoes, sneakers & formal footwear', 'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=500&auto=format&fit=crop&q=80'),
('Books & Stationery', 'Bestsellers, premium hardcover journals & office supplies', 'https://images.unsplash.com/photo-1512820790803-83ca734da794?w=500&auto=format&fit=crop&q=80');
GO

-- 3. Insert Products
INSERT INTO Products (ProductName, CategoryId, Price, Description, ImageUrl, StockQuantity, IsFeatured, CreatedAt)
VALUES 
-- Category 1: Electronics
('Sony WH-1000XM5 Wireless Headphones', 1, 349.99, 'Industry-leading noise cancellation with two processors and 8 microphones. Exceptional sound quality and ultra-comfortable lightweight design.', 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=600&auto=format&fit=crop&q=80', 25, 1, GETDATE()),
('Apple MacBook Air M2 - 13.6-inch', 1, 999.00, 'Strikingly thin design with the powerful Apple M2 chip. Up to 18 hours of battery life and a stunning Liquid Retina display.', 'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=600&auto=format&fit=crop&q=80', 12, 1, GETDATE()),
('Mechanical RGB Gaming Keyboard', 1, 89.50, 'Custom mechanical switches for ultra-fast response, aircraft-grade aluminum frame, and vibrant per-key dynamic RGB backlighting.', 'https://images.unsplash.com/photo-1587829741301-dc798b83add3?w=600&auto=format&fit=crop&q=80', 35, 0, GETDATE()),
('Wireless Noise Cancelling Earbuds Pro', 1, 149.00, 'Active noise cancellation with transparency mode, water resistance, and crystal-clear audio with custom high-excursion driver.', 'https://images.unsplash.com/photo-1590658268037-6bf12165a8df?w=600&auto=format&fit=crop&q=80', 40, 1, GETDATE()),

-- Category 2: Fashion
('Minimalist Chronograph Men''s Watch', 2, 129.00, 'Precision quartz movement with sapphire-coated crystal, water-resistant stainless steel casing, and genuine Italian leather strap.', 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=600&auto=format&fit=crop&q=80', 20, 1, GETDATE()),
('Classic Denim Trucker Jacket', 2, 69.99, 'Timeless rugged denim jacket made from 100% premium cotton with dual chest pockets and durable brass button hardware.', 'https://images.unsplash.com/photo-1576995853123-5a10305d93c0?w=600&auto=format&fit=crop&q=80', 18, 0, GETDATE()),
('Premium Leather Laptop Messenger Bag', 2, 85.00, 'Handcrafted from full-grain leather with padded compartment for up to 15.6-inch laptops, secure zippers, and adjustable shoulder strap.', 'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=600&auto=format&fit=crop&q=80', 15, 1, GETDATE()),

-- Category 3: Home & Living
('Ceramic Pour-Over Coffee Maker Set', 3, 38.50, 'Artisan handcrafted ceramic dripper with heat-resistant borosilicate glass carafe. Brews the cleanest, richest cup of coffee every morning.', 'https://images.unsplash.com/photo-1514432324607-a09d9b4aefdd?w=600&auto=format&fit=crop&q=80', 30, 1, GETDATE()),
('Smart Ergonomic LED Desk Lamp', 3, 45.00, 'Dimmable touch-control desk lamp with 5 color temperatures, built-in USB charging port, and eye-friendly flicker-free illumination.', 'https://images.unsplash.com/photo-1507473885765-e6ed057f782c?w=600&auto=format&fit=crop&q=80', 22, 0, GETDATE()),

-- Category 4: Footwear
('Nike Air Zoom Performance Running Shoes', 4, 119.99, 'Engineered mesh upper for breathability, responsive Zoom Air cushioning, and durable rubber waffle outsole for superior grip.', 'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=600&auto=format&fit=crop&q=80', 28, 1, GETDATE()),
('Classic Canvas Low-Top Sneakers', 4, 49.99, 'Versatile and comfortable everyday sneakers with breathable canvas upper, vulcanized rubber sole, and cushioned insole.', 'https://images.unsplash.com/photo-1525966222134-fcfa99b8ae77?w=600&auto=format&fit=crop&q=80', 45, 0, GETDATE()),

-- Category 5: Books & Stationery
('Hardcover Minimalist Daily Planner', 5, 22.50, 'Thick 120gsm ink-proof bleed-resistant paper with undated monthly and weekly layouts, ribbon bookmark, and elastic closure band.', 'https://images.unsplash.com/photo-1544716278-ca5e3f4abd8c?w=600&auto=format&fit=crop&q=80', 50, 0, GETDATE());
GO

-- 4. Insert Initial Sample Orders for Demonstration
INSERT INTO Orders (UserId, OrderDate, TotalAmount, ShippingAddress, PaymentMethod, OrderStatus)
VALUES 
(2, DATEADD(DAY, -3, GETDATE()), 349.99, '204 Green Valley, Sector 12, Gandhinagar, Gujarat', 'Cash on Delivery', 'Delivered'),
(2, DATEADD(DAY, -1, GETDATE()), 129.00, '204 Green Valley, Sector 12, Gandhinagar, Gujarat', 'Credit Card', 'Processing'),
(3, GETDATE(), 89.50, 'Flat 5B, Skyline Towers, Ahmedabad, Gujarat', 'UPI / Online', 'Pending');
GO

-- 5. Insert Sample Order Details
INSERT INTO OrderDetails (OrderId, ProductId, Quantity, UnitPrice)
VALUES 
(1001, 1, 1, 349.99),
(1002, 5, 1, 129.00),
(1003, 3, 1, 89.50);
GO

-- Display confirmation summary
SELECT 'Database OnlineShoppingDB created successfully with all tables and sample seed data!' AS Status;
SELECT COUNT(*) AS TotalUsers FROM Users;
SELECT COUNT(*) AS TotalCategories FROM Categories;
SELECT COUNT(*) AS TotalProducts FROM Products;
SELECT COUNT(*) AS TotalOrders FROM Orders;
GO
