# Core Logic

## Models

### General

Result<T, E>
- value : T?
- error: E?
- hasValue: bool
- hasError: bool

### Database Models

UserSnapshot
- id : int
- email : string
- firstName : string
- lastName : string

TransactionSnapshot
- id : int
- userId : int
- amount_cents : int
- category : string
- payment_method_int : int
- notes : string
- time : DateTime

PaymentMethodSnapshot
- id : int
- userId : int
- name : string

### SQL

SqlError
- message : string

## Interfaces

ISqlDatabase
- init() : Future<Result<void, SqlError>>
- execute(String, List<Object>) : Future<Result<void, SqlError>>
- dispose() : Future<Result<void, SqlError>>

IUserTable
- createUser(...)
- getUser(id)
- updateUser(id, ...)
- deleteUser(id)

ITransactionTable
- createTransaction(...) : Future<Result<Transaction, SqlError>>
- getTransaction(id) : Future<Result<Transaction, SqlError>>
- updateTransaction(id, ...) : Future<Result<Transaction, SqlError>>
- deleteTransaction(id) : Future<Result<void, SqlError>>

IPaymentMethodTable
...

ITransactionSchema
- IUserTable
- ITransactionTable
- IPaymentMethodTable