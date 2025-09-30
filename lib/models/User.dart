class User {
  int? id;
  String lastname;
  int age;

  User({required this.lastname, required this.age, this.id});

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] ?? null,
      lastname: map['lastname'],
      age: map['age'],
    );
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{"lastname": lastname, "age": age};
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }
}
