class UserModel {
  String? name;
  String? email;
  String? phone;
  String? savelifeid;
  double? latitude;
  double? longitude;

  UserModel({this.name, this.email, this.phone, this.savelifeid,this.latitude,this.longitude});

  // receiving data from server
    factory UserModel.fromMap(map) {
      return UserModel(
        name: map['name'],
        email: map['email'],
        phone: map['phone'],
        savelifeid: map['savelifeid'],
        latitude: map['latitude'],
        longitude: map['longitude'],

      );
    }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'savelifeid': savelifeid,
      'latitude': latitude,
      'longitude': longitude,

    };
  }
}
