class UserInformationModel {
  final int id;
  final String username;
  final String email;
  final String password;
  final String phone;
  final NameModel name;
  final AddressModel address;

  UserInformationModel({
    required this.id,
    required this.username,
    required this.email,
    required this.password,
    required this.phone,
    required this.name,
    required this.address,
  });

  factory UserInformationModel.fromJson(Map<String, dynamic> json) {
    return UserInformationModel(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      password: json['password'],
      phone: json['phone'],
      name: NameModel.fromJson(json['name']),
      address: AddressModel.fromJson(json['address']),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'password': password,
      'phone': phone,
      'name': name.toJson(),
      'address': address.toJson(),
    };
  }
}

class NameModel {
  final String firstname;
  final String lastname;
  NameModel({required this.firstname, required this.lastname});

  factory NameModel.fromJson(Map<String, dynamic> json) {
    return NameModel(
      firstname: json['firstname'],
      lastname: json['lastname'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'firstname': firstname,
      'lastname': lastname,
    };
  }
}

// كلاس للعنوان
class AddressModel {
  final String city;
  final String street;
  final int number;
  final String zipcode;

  AddressModel({required this.city, required this.street, required this.number, required this.zipcode});

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      city: json['city'],
      street: json['street'],
      number: json['number'],
      zipcode: json['zipcode'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'city': city,
      'street': street,
      'number': number,
      'zipcode': zipcode,
    };
  }
}