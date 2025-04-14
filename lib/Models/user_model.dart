import 'dart:convert';

class UserModel {
  String uid = "";
  String name = "";
  String image = "";
  String email = "";
  String createdOn = "";
  UserModel({
    required this.uid,
    required this.name,
    required this.image,
    required this.email,
    required this.createdOn,
  });

  UserModel copyWith({
    String? uid,
    String? name,
    String? image,
    String? email,
    String? createdOn,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      image: image ?? this.image,
      email: email ?? this.email,
      createdOn: createdOn ?? this.createdOn,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'image': image,
      'email': email,
      'createdOn': createdOn,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      name: map['name'] ?? '',
      image: map['image'] ?? '',
      email: map['email'] ?? '',
      createdOn: map['createdOn'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(uid: $uid, name: $name, image: $image, email: $email, createdOn: $createdOn)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.uid == uid &&
        other.name == name &&
        other.image == image &&
        other.email == email &&
        other.createdOn == createdOn;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        name.hashCode ^
        image.hashCode ^
        email.hashCode ^
        createdOn.hashCode;
  }
}
