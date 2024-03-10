part of 'phone_number_bloc.dart';

@immutable
sealed class PhoneNumberState {}

final class SendVerificationCodeInitial extends PhoneNumberState {}

final class SendVerificationCodeLoading extends PhoneNumberState {}

final class SendVerificationCodeSuccess extends PhoneNumberState {}

final class SendVerificatinoCodeFailure extends PhoneNumberState {
  final Exception exception;

  SendVerificatinoCodeFailure({required this.exception});
}

final class ConfirmCodeLoading extends PhoneNumberState {}

final class ConfirmCodeSuccess extends PhoneNumberState {}

final class ConfirmCodeFailure extends PhoneNumberState {
  final Exception exception;

  ConfirmCodeFailure({required this.exception});
}
