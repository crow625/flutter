# Transaction App

This app allows the user to record their transactions in as few clicks as possible.
It supports creation of transactions, including amount, category, and the payment method.
You can also browse past transactions.

## User Experience

### Sign-in

1. Open the app. If no previous user session has been saved, the sign-in screen will be shown.
2. If the user has no account, they can navigate to the create account screen.
3. On the create account screen, user will enter their name, email, and password.
4. After creating an account, user will be authenticated, and navigate to the home screen.

### Log Transaction

1. From the home screen, click "Log Transaction".
2. Enter the amount, category, and payment method.
3. Click "Create".
4. User navigates to the transactions list page.

### View Transactions

1. From the home screen, click "View Transactions".
2. A scrollable list will appear of the last X transactions, with the most recent at the top.
3. (Optionally) user can set a time window, or filter by specific categories or payment methods.

### Add payment method

1. From the home screen, click "Add Payment Method".
2. Name the payment method and choose a category (credit, debit, ?)
3. The "Cash" payment method is always available by default and cannot be removed.
