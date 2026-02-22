import 'package:flutter_app/src/auth/auth_errors.dart';
import 'package:flutter_app/src/auth/auth_models.dart';
import 'package:flutter_app/src/generic/result.dart';

abstract interface class IAuthProvider<T extends User> {
  /// Create an account.
  Future<Result<T, CreateAccountError>> createAccount({
    required String email,
    required String password,
  });

  /// Sign in to an existing account.
  Future<Result<T, SignInError>> signIn({
    required String email,
    required String password,
  });

  /// Sign out from the current session.
  Future<Result<void, SignOutError>> signOut();
}
