class User {
  final String uid;
  final String? firstName;
  final String? lastName;
  final String? email;
  final Map<String, Object?>? extra;

  const User({
    required this.uid,
    this.firstName,
    this.lastName,
    this.email,
    this.extra,
  });
}
