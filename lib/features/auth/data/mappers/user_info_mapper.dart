import 'package:e_commerce/features/auth/data/models/user_info_model.dart';
import 'package:e_commerce/features/auth/domain/entities/user_info_entity.dart';

extension UserMapper on UserInformationModel {
  UserInformationEntity toEntity() {
    return UserInformationEntity(
      id: id,
      username: username,
      email: email,
      phone: phone,
      name: NameEntity(
        firstname: name.firstname,
        lastname: name.lastname,
      ),
      address: AddressEntity(
        city: address.city,
        street: address.street,
        number: address.number,
        zipcode: address.zipcode,
      ),
    );
  }
}