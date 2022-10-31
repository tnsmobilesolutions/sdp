import 'dart:convert';

class userDetailsModel {
  String? name;
  String? email;
  String? phoneNumber;
  String? userId;
  String? bloodgroup;
  String? sangha;
  String? city;
  String? proffesion;
  String? uid;
  userDetailsModel({
    this.name,
    this.email,
    this.phoneNumber,
    this.userId,
    this.bloodgroup,
    this.sangha,
    this.city,
    this.proffesion,
    this.uid,
  });

  userDetailsModel copyWith({
    String? name,
    String? email,
    String? phoneNumber,
    String? userId,
    String? bloodgroup,
    String? sangha,
    String? city,
    String? proffesion,
    String? uid,
  }) {
    return userDetailsModel(
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      userId: userId ?? this.userId,
      bloodgroup: bloodgroup ?? this.bloodgroup,
      sangha: sangha ?? this.sangha,
      city: city ?? this.city,
      proffesion: proffesion ?? this.proffesion,
      uid: uid ?? this.uid,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (name != null) {
      result.addAll({'name': name});
    }
    if (email != null) {
      result.addAll({'email': email});
    }
    if (phoneNumber != null) {
      result.addAll({'phoneNumber': phoneNumber});
    }
    if (userId != null) {
      result.addAll({'userId': userId});
    }
    if (bloodgroup != null) {
      result.addAll({'bloodgroup': bloodgroup});
    }
    if (sangha != null) {
      result.addAll({'sangha': sangha});
    }
    if (city != null) {
      result.addAll({'city': city});
    }
    if (proffesion != null) {
      result.addAll({'proffesion': proffesion});
    }
    if (uid != null) {
      result.addAll({'uid': uid});
    }

    return result;
  }

  factory userDetailsModel.fromMap(Map<String, dynamic> map) {
    return userDetailsModel(
      name: map['name'],
      email: map['email'],
      phoneNumber: map['phoneNumber'],
      userId: map['userId'],
      bloodgroup: map['bloodgroup'],
      sangha: map['sangha'],
      city: map['city'],
      proffesion: map['proffesion'],
      uid: map['uid'],
    );
  }

  String toJson() => json.encode(toMap());

  factory userDetailsModel.fromJson(String source) =>
      userDetailsModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'userModel(name: $name, email: $email, phoneNumber: $phoneNumber, userId: $userId, bloodgroup: $bloodgroup, sangha: $sangha, city: $city, proffesion: $proffesion, uid: $uid)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is userDetailsModel &&
        other.name == name &&
        other.email == email &&
        other.phoneNumber == phoneNumber &&
        other.userId == userId &&
        other.bloodgroup == bloodgroup &&
        other.sangha == sangha &&
        other.city == city &&
        other.proffesion == proffesion &&
        other.uid == uid;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        email.hashCode ^
        phoneNumber.hashCode ^
        userId.hashCode ^
        bloodgroup.hashCode ^
        sangha.hashCode ^
        city.hashCode ^
        proffesion.hashCode ^
        uid.hashCode;
  }
}
