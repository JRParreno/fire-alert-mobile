// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Profile {
  final String pk;
  final String profilePk;
  final String username;
  final String firstName;
  final String lastName;
  final String email;
  final String address;
  final String contactNumber;
  final bool isVerified;
  final bool otpVerified;
  final String? profilePhoto;

  Profile({
    required this.pk,
    required this.profilePk,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.address,
    required this.contactNumber,
    required this.isVerified,
    required this.otpVerified,
    this.profilePhoto,
  });

  Profile copyWith({
    String? pk,
    String? profilePk,
    String? username,
    String? firstName,
    String? lastName,
    String? email,
    String? address,
    String? contactNumber,
    bool? isVerified,
    bool? otpVerified,
    String? profilePhoto,
  }) {
    return Profile(
      pk: pk ?? this.pk,
      profilePk: profilePk ?? this.profilePk,
      username: username ?? this.username,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      address: address ?? this.address,
      contactNumber: contactNumber ?? this.contactNumber,
      isVerified: isVerified ?? this.isVerified,
      otpVerified: otpVerified ?? this.otpVerified,
      profilePhoto: profilePhoto ?? this.profilePhoto,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'pk': pk,
      'profilePk': profilePk,
      'username': username,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'address': address,
      'contactNumber': contactNumber,
      'isVerified': isVerified,
      'otpVerified': otpVerified,
      'profilePhoto': profilePhoto,
    };
  }

  factory Profile.fromMap(Map<String, dynamic> map) {
    return Profile(
      pk: map['pk'] as String,
      profilePk: map['profilePk'] as String,
      username: map['username'] as String,
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      email: map['email'] as String,
      address: map['address'] as String,
      contactNumber: map['contactNumber'] as String,
      isVerified: map['isVerified'] as bool,
      otpVerified: map['otpVerified'] as bool,
      profilePhoto:
          map['profilePhoto'] != null ? map['profilePhoto'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Profile.fromJson(String source) =>
      Profile.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Profile(pk: $pk, profilePk: $profilePk, username: $username, firstName: $firstName, lastName: $lastName, email: $email, address: $address, contactNumber: $contactNumber, isVerified: $isVerified, otpVerified: $otpVerified, profilePhoto: $profilePhoto)';
  }

  @override
  bool operator ==(covariant Profile other) {
    if (identical(this, other)) return true;

    return other.pk == pk &&
        other.profilePk == profilePk &&
        other.username == username &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.email == email &&
        other.address == address &&
        other.contactNumber == contactNumber &&
        other.isVerified == isVerified &&
        other.otpVerified == otpVerified &&
        other.profilePhoto == profilePhoto;
  }

  @override
  int get hashCode {
    return pk.hashCode ^
        profilePk.hashCode ^
        username.hashCode ^
        firstName.hashCode ^
        lastName.hashCode ^
        email.hashCode ^
        address.hashCode ^
        contactNumber.hashCode ^
        isVerified.hashCode ^
        otpVerified.hashCode ^
        profilePhoto.hashCode;
  }
}
