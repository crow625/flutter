/// Error codes that may be returned when creating an account.
enum CreateAccountError {
  invalidEmail,
  invalidPassword,
  accountExists,
  unknown;
}

/// Error codes that may be returned when signing in.
enum SignInError {
  noAccountFound,
  incorrectPassword,
  unknown;
}

/// Error codes that may be returned when signing out.
enum SignOutError {
  unknown;
}
