class UserInformationEntity {
  final int id;
  final String username;
  final String email;
  final String phone;
  final NameEntity name;
  final AddressEntity address;

  UserInformationEntity({
    required this.id,
    required this.username,
    required this.email,
    required this.phone,
    required this.name,
    required this.address,
  });
}

class NameEntity {
  final String firstname;
  final String lastname;

  NameEntity({required this.firstname, required this.lastname});
}

class AddressEntity {
  final String city;
  final String street;
  final int number;
  final String zipcode;

  AddressEntity({
    required this.city,
    required this.street,
    required this.number,
    required this.zipcode
  });
}