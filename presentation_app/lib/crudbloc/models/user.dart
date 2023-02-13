class AuthUser{
  final String userId;
  final String email;
  final String password;

  AuthUser({ required this.userId,  required this.email,  required this.password});

  AuthUser copyWith({required String userId, required String email, required String password}) => AuthUser(
    userId: userId ?? this.userId,
    email: email ?? this.email,
    password: password ?? this.password,
  );
}