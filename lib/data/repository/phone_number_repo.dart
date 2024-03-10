import 'package:baxi/data/data_source/phone_number_data_source.dart';

abstract class IPhoneNumberRepository {
  Future<void> sendVerificationCode(String phoneNumber);
  Future<void> confirmCode(String phoneNumber, String code);
}

final PhoneNumberRemoteRepository phoneNumberRepository =
    PhoneNumberRemoteRepository(dataSource: PhoneNumberRemoteDataSource());

class PhoneNumberRemoteRepository implements IPhoneNumberRepository {
  final IPhoneNumberDataSource dataSource;

  PhoneNumberRemoteRepository({required this.dataSource});
  @override
  Future<void> confirmCode(String phoneNumber, String code) {
    return dataSource.confirmCode(phoneNumber, code);
  }

  @override
  Future<void> sendVerificationCode(String phoneNumber) {
    return dataSource.sendVerificationCode(phoneNumber);
  }
}
