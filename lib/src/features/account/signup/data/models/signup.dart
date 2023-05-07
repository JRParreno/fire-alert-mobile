// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Signup {
  final String firstName;
  final String lastName;
  final String email;
  final String mobileNumber;
  final String completeAddress;
  final String password;
  final String confirmPassword;

  Signup({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.mobileNumber,
    required this.completeAddress,
    required this.password,
    required this.confirmPassword,
  });

  Signup copyWith({
    String? firstName,
    String? lastName,
    String? email,
    String? mobileNumber,
    String? completeAddress,
    String? password,
    String? confirmPassword,
  }) {
    return Signup(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      completeAddress: completeAddress ?? this.completeAddress,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'mobileNumber': mobileNumber,
      'completeAddress': completeAddress,
      'password': password,
      'confirmPassword': confirmPassword,
    };
  }

  factory Signup.fromMap(Map<String, dynamic> map) {
    return Signup(
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      email: map['email'] as String,
      mobileNumber: map['mobileNumber'] as String,
      completeAddress: map['completeAddress'] as String,
      password: map['password'] as String,
      confirmPassword: map['confirmPassword'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Signup.fromJson(String source) =>
      Signup.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Signup(firstName: $firstName, lastName: $lastName, email: $email, mobileNumber: $mobileNumber, completeAddress: $completeAddress, password: $password, confirmPassword: $confirmPassword)';
  }

  @override
  bool operator ==(covariant Signup other) {
    if (identical(this, other)) return true;

    return other.firstName == firstName &&
        other.lastName == lastName &&
        other.email == email &&
        other.mobileNumber == mobileNumber &&
        other.completeAddress == completeAddress &&
        other.password == password &&
        other.confirmPassword == confirmPassword;
  }

  @override
  int get hashCode {
    return firstName.hashCode ^
        lastName.hashCode ^
        email.hashCode ^
        mobileNumber.hashCode ^
        completeAddress.hashCode ^
        password.hashCode ^
        confirmPassword.hashCode;
  }
}
