import 'package:equatable/equatable.dart';

class User extends Equatable {
  final bool success;
  final int id;
  final String username;
  final String contact;
  final String address;
  final String message;
  final String password;
  final String email;
  final String firstname;
  final String lastname;
  final String gender;
  final String image;
  final String token;
  const User({
    this.success = false,
    this.id = 0,
    this.username = '',
    this.contact = '',
    this.address = '',
    this.message = '',
    this.password = '',
    this.email = '',
    this.firstname = '',
    this.lastname = '',
    this.gender = '',
    this.image = '',
    this.token = '',
  });

  @override
  List<Object?> get props => [
        success,
        id,
        username,
        contact,
        address,
        message,
        password,
        email,
        firstname,
        lastname,
        gender,
        image,
        token,
      ];

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'success': success,
      'id': id,
      'username': username,
      'contact': contact,
      'address': address,
      'message': message,
      'password': password,
      'email': email,
      'firstname': firstname,
      'lastname': lastname,
      'gender': gender,
      'image': image,
      'token': token,
    };
  }

  factory User.fromJson(Map<String, dynamic> map) => User(
        success: map['success'] ?? false,
        id: map['id'] ?? 0,
        username: map['username'] ?? '',
        contact: map['mobile_no'] ?? '',
        address: map['address'] ?? '',
        message: map['message'] ?? '',
        password: map['password'] ?? '',
        email: map['email'] ?? '',
        firstname: map['firstname'] ?? '',
        lastname: map['lastname'] ?? '',
        gender: map['gender'] ?? '',
        image: map['image'] ?? '',
        token: map['token'] ?? '',
      );

  User copyWith({
    bool? success,
    int? id,
    String? username,
    String? contact,
    String? address,
    String? message,
    String? password,
    String? email,
    String? firstname,
    String? lastname,
    String? gender,
    String? image,
    String? token,
  }) {
    return User(
      success: success ?? this.success,
      id: id ?? this.id,
      username: username ?? this.username,
      contact: contact ?? this.contact,
      address: address ?? this.address,
      message: message ?? this.message,
      password: password ?? this.password,
      email: email ?? this.email,
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      gender: gender ?? this.gender,
      image: image ?? this.image,
      token: token ?? this.token,
    );
  }
}
