# Database Schema

PostgreSQL database

## Users
- *id (int)
- email (text)
- first name (text)
- last name (text)

## Transactions
- *id (int)
- *user_id (int)
- amount_cents (int)
- category (text)
- payment_method_id (int)
- notes (text)
- datetime (int8)

## Payment Methods
- *id (int)
- *user_id (int)
- name (text)
