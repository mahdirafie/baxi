import 'package:baxi/data/repository/phone_number_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'phone_number_event.dart';
part 'phone_number_state.dart';

class PhoneNumberBloc extends Bloc<PhoneNumberEvent, PhoneNumberState> {
  final IPhoneNumberRepository repository;
  PhoneNumberBloc(this.repository) : super(SendVerificationCodeInitial()) {
    on<PhoneNumberEvent>((event, emit) async {
      if (event is SendVerificationButtonClicked) {
        try {
          emit(SendVerificationCodeLoading());
          await repository.sendVerificationCode(event.phoneNumber);
          emit(SendVerificationCodeSuccess());
        } catch (e) {
          emit(SendVerificatinoCodeFailure(
              exception: Exception('Error in sending verification code')));
        }
      } else if(event is ConfirmVerificationButtonClicked) {
        try {
          emit(ConfirmCodeLoading());
          await repository.confirmCode(event.phoneNumber, event.code);
          emit(ConfirmCodeSuccess());
        }catch(e) {
          emit(ConfirmCodeFailure(exception:Exception('Error in confirming the code')));
        }
      }
    });
  }
}
