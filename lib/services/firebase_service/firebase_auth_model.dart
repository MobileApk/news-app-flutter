class FirebaseUser {
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? imageUrl;

  FirebaseUser(
      {this.id, this.firstName, this.lastName, this.email, this.imageUrl});

  FirebaseUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    imageUrl = json['imageUrl'];
  }
  
  FirebaseUser.empty() {
    id = "";
    firstName = "";
    lastName = "";
    email = "";
    imageUrl = "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['email'] = email;
    data['imageUrl'] = imageUrl;
    return data;
  }
}
