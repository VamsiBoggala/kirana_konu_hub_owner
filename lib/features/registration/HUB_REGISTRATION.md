# MODULE: HUB OWNER REGISTRATION (KYB)

## 1. Objective
To build a secure Onboarding Flow for **Hub Owners** (Distributors). This process must verify the legal legitimacy of the business before allowing them to sell on the platform.

## 2. The "KYB" (Know Your Business) Requirements
We must collect the following 6 verifications to comply with Indian B2B & Food Safety laws:
1.  **GSTIN Certificate** (Mandatory for Tax)
2.  **FSSAI License** (Mandatory for Food Safety)
3.  **PAN Card** (Identity Proof)
4.  **Shop & Establishment License** (Address/Labor Proof)
5.  **Bank Proof** (Cancelled Cheque/Passbook for payouts)
6.  **Physical Location** (Captured via GPS)

## 3. UI Flow (4 Screens)

### Screen 1: Personal & Location Details
- **Inputs:**
  - Owner Full Name
  - Mobile Number (OTP Verified)
  - Hub/Shop Name (e.g., "Raju Traders")
  - **Action:** "Detect My Location" button (Capture Lat/Lng) -> Show Map Pin.

### Screen 2: Business Documents (KYB)
- **GSTIN:**
  - Input Field: Enter Number (Regex validation: `^\d{2}[A-Z]{5}\d{4}[A-Z]{1}[1-9A-Z]{1}Z[0-9A-Z]{1}$`)
  - Upload: Image/PDF
- **FSSAI:**
  - Input Field: Enter License Number
  - Upload: Image/PDF

### Screen 3: Financial Settlement
- **Inputs:**
  - Bank Account Holder Name
  - Account Number (Double entry for confirmation)
  - IFSC Code (Auto-fetch Branch Name if possible)
- **Upload:** Cancelled Cheque Image.

### Screen 4: Legal & Submit
- **Display:** "Terms of Service" & "Commission Policy".
- **Checkbox:** "I agree to the terms."
- **Button:** [Submit Application] -> Redirect to "Verification Pending" Screen.

## 4. Backend Logic (Firebase)

### Database Structure (`hubs_pending` collection)
Store temporary data here until approved.
```json
{
  "temp_id": "application_xyz",
  "owner_uid": "auth_uid",
  "status": "pending_verification", // pending -> approved -> rejected
  "submitted_at": "timestamp",
  "documents": {
    "gst_url": "gs://...",
    "fssai_url": "gs://..."
  },
  "business_details": { ... }
}