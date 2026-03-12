# KIRANA KONU - PROJECT ARCHITECTURE & RULES

## 1. Project Goal
Building a B2B Wholesale App (Flutter + Firebase) for a "Hub & Spoke" distribution model.
- **App Name:** Kirana Konu
- **Primary Color:** Royal Blue (#1565C0)
- **Tech Stack:** Flutter, Firebase Auth, Firestore.

## 2. Business Rules (DO NOT VIOLATE)
1.  **Hub-Centric Data:** Every document in Firestore (`products`, `orders`) MUST have a `hub_id` field.
    - *Current Dev Hub ID:* "brother_shop_01"
2.  **No Public Sign-up:** Retailers are "Invite Only". Creating a user requires Admin approval (`hub_access` collection).
3.  **Inventory UI:** Retailers see "In Stock" / "Out of Stock". They NEVER see exact quantity numbers.
4.  **Credit System:**
    - Green: Balance < Limit (Allow Order)
    - Red: Balance > Limit (Block Order)

## 3. Database Schema (Firestore)
- **hubs:** { id, owner_uid, shop_name }
- **products:** { id, hub_id, name, price, is_available, keywords[] }
- **hub_access:** { retailer_uid, hub_id, status, outstanding_balance }
- **orders:** { order_id, hub_id, retailer_uid, items[], status, timestamp }

## 4. UI Design System
- **Font:** Roboto / Poppins
- **Themes:**
  - Light: BG #F5F5F5, Cards #FFFFFF, Text #212121
  - Dark: BG #121212, Cards #1E1E1E, Text #E0E0E0
- **Logo:** Hexagon Icon with "KK" text.

<!-- ## 5. Current Task Focus
We are building the **Hub Owner (Admin)** side first.
- Feature 1: Login
- Feature 2: Product Management (CRUD)
- Feature 3: Retailer Approval List -->