import 'package:dio/dio.dart';

abstract class IPhoneNumberDataSource {
  Future<void> sendVerificationCode(String phoneNumber);
  Future<void> confirmCode(String phoneNumber, String code);
}

class PhoneNumberRemoteDataSource implements IPhoneNumberDataSource {
  final Dio httpClient = Dio();

  @override
  Future<void> sendVerificationCode(String phoneNumber) async {
    await httpClient.post('https://bverse.darkube.app/api/SendVerificationCode',
        data: {"phoneNumber": phoneNumber});
  }

  @override
  Future<void> confirmCode(String phoneNumber, String code) async {
    await httpClient.post(
        'https://bverse.darkube.app/api/authentication',
        data: {"phoneNumber": phoneNumber, "code": code});
  }
}
