import 'dart:async';

import 'package:baxi/auth/bloc/phone_number_bloc.dart';
import 'package:baxi/auth/sign_up_customer/sing_up_customer.dart';
import 'package:baxi/auth/sign_up_driver/driver_sign_up_process.dart';
import 'package:baxi/data/repository/phone_number_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OTPScreen extends StatefulWidget {
  final bool isDriver;
  final String phoneNumber;
  const OTPScreen({super.key, required this.phoneNumber, required this.isDriver});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final TextEditingController controller1 = TextEditingController();
  final TextEditingController controller2 = TextEditingController();
  final TextEditingController controller3 = TextEditingController();
  final TextEditingController controller4 = TextEditingController();
  StreamSubscription<PhoneNumberState>? subscription;

  @override
  void dispose() {
    controller1.dispose();
    controller2.dispose();
    controller3.dispose();
    controller4.dispose();
    subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocProvider(
      create: (context) {
        final bloc = PhoneNumberBloc(phoneNumberRepository);
        subscription = bloc.stream.listen((state) {
          if (state is ConfirmCodeSuccess || state is ConfirmCodeFailure) {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) {
                return widget.isDriver? const DriverSignUpProcess(): const SignUpCustomerScreen();
              },
            ));
          }
        });
        return bloc;
      },
      child: SafeArea(
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.only(left: 25, right: 25),
            child: Container(
              width: double.infinity,
              height: double.infinity,
              alignment: Alignment.center,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/baxi_text.png',
                      width: 200,
                      height: 200,
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Text(
                      'کد ارسال شده به شماره زیر را وارد کنید: ',
                      style: theme.textTheme.bodyMedium!
                          .copyWith(fontWeight: FontWeight.w500, fontSize: 16),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      '+98 ${widget.phoneNumber}',
                      textDirection: TextDirection.ltr,
                      style: theme.textTheme.bodyLarge!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Directionality(
                        textDirection: TextDirection.ltr,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 25, right: 25),
                          child: otp(context),
                        )),
                    const SizedBox(
                      height: 24,
                    ),
                    BlocBuilder<PhoneNumberBloc, PhoneNumberState>(
                      builder: (BuildContext context, PhoneNumberState state) {
                        return SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                              onPressed: () {
                                BlocProvider.of<PhoneNumberBloc>(context).add(
                                    ConfirmVerificationButtonClicked(
                                        phoneNumber: "0${widget.phoneNumber}",
                                        code: controller1.text +
                                            controller2.text +
                                            controller3.text +
                                            controller4.text));
                              },
                              child: state is! ConfirmCodeLoading
                                  ? Text(
                                      'تایید',
                                      style: theme.textTheme.bodyLarge!
                                          .copyWith(
                                              fontWeight: FontWeight.bold),
                                    )
                                  : Center(
                                      child: CircularProgressIndicator(color: theme.colorScheme.onPrimary,),
                                    )),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      'کدی دریافت نکردید؟',
                      style: theme.textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.primary.withGreen(200)),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget otp(BuildContext context) {
    return Row(
        textDirection: TextDirection.ltr,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _textFieldOTP(true, false, context, controller1),
          _textFieldOTP(false, false, context, controller2),
          _textFieldOTP(false, false, context, controller3),
          _textFieldOTP(false, true, context, controller4),
        ]);
  }

  _textFieldOTP(bool first, bool last, BuildContext context,
      TextEditingController controller) {
    final theme = Theme.of(context);
    return SizedBox(
      height: 60,
      child: AspectRatio(
        aspectRatio: 0.7,
        child: TextField(
          controller: controller,
          autocorrect: true,
          onChanged: (value) {
            if (value.length == 1 && last == false) {
              FocusScope.of(context).nextFocus();
            }
            if (value.isEmpty && first == false) {
              FocusScope.of(context).previousFocus();
            }
          },
          showCursor: true,
          readOnly: false,
          textAlign: TextAlign.center,
          style:
              theme.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
          keyboardType: TextInputType.number,
          maxLength: 1,
          decoration: InputDecoration(
              counter: const Offstage(),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide:
                      BorderSide(color: theme.colorScheme.onPrimary, width: 2)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide:
                      BorderSide(color: theme.colorScheme.primary, width: 2))),
        ),
      ),
    );
  }
}
