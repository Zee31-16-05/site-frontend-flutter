import '../models/user_model.dart';

class AuthException implements Exception {
  const AuthException(this.message);

  final String message;

  @override
  String toString() => message;
}

/// In-memory auth for local development. Accounts are lost when the app
/// restarts. Replace the method bodies with real API / Firebase calls later.
class AuthService {
  AuthService._();
  static final AuthService instance = AuthService._();

  final Map<String, ({UserModel user, String password})> _accounts = {};

  Future<UserModel> signUp({
    required String name,
    required String email,
    required String password,
    String role = 'user',
  }) async {
    await Future.delayed(const Duration(milliseconds: 600));
    final key = email.trim().toLowerCase();
    if (_accounts.containsKey(key)) {
      throw const AuthException('An account with this email already exists.');
    }
    final user = UserModel(name: name.trim(), email: key, role: role.trim());
    _accounts[key] = (user: user, password: password);
    return user;
  }

  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    await Future.delayed(const Duration(milliseconds: 600));
    final account = _accounts[email.trim().toLowerCase()];
    if (account == null || account.password != password) {
      throw const AuthException('Incorrect email or password.');
    }
    return account.user;
  }
}
