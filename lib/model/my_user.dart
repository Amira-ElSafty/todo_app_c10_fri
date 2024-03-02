class MyUser {
  // data class
  static const String collectionName = 'users';
  String? id;

  String? email;

  String? name;

  MyUser({required this.id, required this.email, required this.name});

  // json => object
  MyUser.fromFireStore(Map<String, dynamic>? data)
      : this(
            id: data?['id'] as String?,
            email: data?['email'],
            name: data?['name']);

  // object => json
  Map<String, dynamic> toFireStore() {
    return {'id': id, 'email': email, 'name': name};
  }
}
