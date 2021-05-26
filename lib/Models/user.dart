class User {
  int id;
  String username = '';
  String password = '';

  User({this.id, this.username, this.password});

  // CONVERT OBJECT INTO MAP
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{'username':username, 'password':password};

    if (id != null) {
      map['id'] = id;
    }

    return map;
  }

  // CONVERT MAP TO OBJECT
  User.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    username = map['username'];
    password = map['password'];
  }
}