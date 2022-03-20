class Login {
  final String name;
  final String email;
  final String password;

  Login({required this.name, required this.email, required this.password});

  // Convert a Dog into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {'name': name, 'email': email, 'password': password};
  }

  // Implement toString to make it easier to see information about
  // each dog when using the print statement.
  @override
  String toString() {
    return 'Login{name: $name, email: $email, password: $password}';
  }
}
