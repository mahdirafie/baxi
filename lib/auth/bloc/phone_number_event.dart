part of 'phone_number_bloc.dart';

@immutable
sealed class PhoneNumberEvent {}

class SendVerificationButtonClicked extends PhoneNumberEvent {
  final String phoneNumber;

  SendVerificationButtonClicked({required this.phoneNumber});
}

class ConfirmVerificationButtonClicked extends PhoneNumberEvent {
  final String phoneNumber;
  final String code;

  ConfirmVerificationButtonClicked({required this.phoneNumber, required this.code});
}