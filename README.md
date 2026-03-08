# Sales-Domain-SQL-Analytics
SQL sales analytics project for a hardware maker selling via retailers (Croma, Flipkart, etc) to consumers. Built finance &amp; supply chain insights plus top-customer/customer performance reporting using stored procedures, CTEs, and temp tables—following SQL best practices.

## Business Scenario

Consider a company that manufactures and sells **hardware peripherals** to various retail partners. These partners operate across multiple sales platforms, including both **offline (brick-and-mortar)** and **online (e-commerce)** channels.

### Retail Platforms

- **Offline Retailers (Brick & Mortar):**  
  Physical retail stores where customers purchase products in person.  
  Examples: Croma, Reliance Digital.

- **Online Retailers (E-Commerce):**  
  Digital marketplaces where products are sold online.  
  Examples: Flipkart, Amazon.

### Sales Channels

The company distributes its products through multiple operational channels:

- **Retail Channel:**  
  Supplying products directly to large retail chains.

- **Distributor Channel:**  
  Selling products to distributors who further supply them to smaller retailers.

- **Direct Channel:**  
  Selling products directly to customers or businesses without intermediaries.

### Key Stakeholders

- **Retailers / Platforms:** Intermediaries that sell the company’s products through online or physical stores.
- **Consumers:** End users who purchase hardware peripherals from these platforms.

This multi-channel distribution model enables the company to reach a wider customer base and efficiently serve both online and offline markets.

# Business Terms (Based on Profit & Loss Statement)

The following terms are used in the project to calculate key financial metrics derived from the **Profit and Loss (P&L) statement**.

---

## 1. Gross Price
- The **initial listed price** of a product before applying any discounts or deductions.
- It represents the base price offered by the company to retailers or distributors.

**Example:**  
If a keyboard is listed at **₹2,000** for retailers, ₹2,000 is the **Gross Price**.

---

## 2. Pre-Invoice Deductions
- Discounts applied **before the invoice is generated**.
- These typically include **trade discounts, bulk discounts, or channel discounts** offered to retailers or distributors.

**Example:**  
A retailer receives a **10% trade discount** on a product priced at ₹2,000.  
Deduction = **₹200**.

---

## 3. Net Invoice Sales
- The **amount billed to the retailer after pre-invoice deductions**.
- This is the value that appears on the invoice.

**Formula**
Net Invoice Sales = Gross Price - Pre-Invoice Deductions

**Example**
₹2,000 - ₹200 = ₹1,800

---

## 4. Post-Invoice Deductions
Adjustments applied **after the invoice has been issued**.

Common components include:

- **Promotional Offers:** Discounts during marketing campaigns or sales events.
- **Placement Fees:** Fees paid for premium product placement in retail stores or online platforms.
- **Performance Rebates:** Incentives provided to retailers for achieving sales targets.

**Example:**  
A retailer receives a **₹100 promotional rebate** after meeting a sales target.

---

## 5. Net Sales / Revenue
- The **actual revenue earned by the company after all deductions**.

**Formula**
Net Sales = Net Invoice Sales - Post-Invoice Deductions

₹1,800 - ₹100 = ₹1,700

---

## 6. Cost of Goods Sold (COGS)
- The **direct cost incurred to manufacture or procure the product**.
- Includes costs such as raw materials, manufacturing, and logistics.

**Example:**  
If producing the keyboard costs **₹1,100**, that amount is the **COGS**.

---

## 7. Gross Margin
- The **profit earned after subtracting the cost of goods sold from net sales**.

**Formula**
Gross Margin = Net Sales - COGS

**Example**
₹1,700 - ₹1,100 = ₹600

---

## 8. Gross Margin % of Net Sales
- Represents **profitability as a percentage of total revenue**.

**Formula**
Gross Margin % = (Gross Margin / Net Sales) × 100

**Example**
(600 / 1700) × 100 = 35.29%

-- Data Model

-- Dataset
Due to terms and conditions of the dataset provider, it cannot be publically accessible, but I can show the preview of each like what type of data was present with placeholder data.
