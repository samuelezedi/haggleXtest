
class User {
  String id;
  String email;
  String phone;
  String username;
  bool active;
  bool isVerified;
  User({this.id, this.email,this.phone, this.username, this.active, this.isVerified});

  static User fromMap(Map<String, dynamic> data) =>
    User(email: data['email'], isVerified: data['emailVerified'], phone: data['phonenumber'], username: data['username'], active: data['active'],id: data['_id']);
}