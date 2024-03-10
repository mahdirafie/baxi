import 'dart:async';

import 'package:baxi/auth/bloc/phone_number_bloc.dart';
import 'package:baxi/auth/otp.dart';
import 'package:baxi/data/repository/phone_number_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InputPhoneNumberScreen extends StatefulWidget {
  const InputPhoneNumberScreen({super.key});

  @override
  State<InputPhoneNumberScreen> createState() => _InputPhoneNumberScreenState();
}

class _InputPhoneNumberScreenState extends State<InputPhoneNumberScreen> {
  bool isDriver = false;
  final TextEditingController textController = TextEditingController();
  StreamSubscription<PhoneNumberState>? subscription;

  @override
  void dispose() {
    textController.dispose();
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
          if (state is SendVerificationCodeSuccess || state is SendVerificatinoCodeFailure) {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) {
                return OTPScreen(
                  isDriver: isDriver,
                  phoneNumber: textController.text,
                );
              },
            ));
          }
        });
        return bloc;
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 25, right: 25),
            child: Container(
              height: MediaQuery.of(context).size.height,
              alignment: Alignment.center,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                        child: Image.asset(
                      'assets/images/baxi_text.png',
                      width: 200,
                      height: 200,
                    )),
                    const SizedBox(
                      height: 24,
                    ),
                    Text(
                      'شماره تلفن همراه خود را وارد کنید:',
                      style: theme.textTheme.headlineSmall!
                          .copyWith(fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: TextFormField(
                        controller: textController,
                        decoration: const InputDecoration(
                            suffix: Text(
                              '( +98 ) ',
                              textDirection: TextDirection.ltr,
                            ),
                            hintText: "9123456789",
                            hintTextDirection: TextDirection.ltr,
                            contentPadding:
                                EdgeInsets.only(left: 12, right: 12)),
                        keyboardType: TextInputType.number,
                        textDirection: TextDirection.ltr,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    BlocBuilder<PhoneNumberBloc, PhoneNumberState>(
                      builder: (context, state) {
                        return SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                              onPressed: () {
                                BlocProvider.of<PhoneNumberBloc>(context).add(
                                    SendVerificationButtonClicked(
                                        phoneNumber:
                                            "0${textController.text}"));
                              },
                              child: state is! SendVerificationCodeLoading
                                  ? Text(
                                      'تایید',
                                      style: theme.textTheme.bodyMedium!
                                          .copyWith(
                                              fontWeight: FontWeight.bold),
                                    )
                                  : Center(
                                      child: CircularProgressIndicator(
                                        color: theme.colorScheme.onPrimary,
                                      ),
                                    )),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: isDriver,
                          onChanged: (value) {
                            setState(() {
                              if (value != null) {
                                isDriver = value;
                              }
                            });
                          },
                        ),
                        const Text('راننده هستم'),
                        const SizedBox(
                          width: 4,
                        ),
                      ],
                    ),
                    Center(
                        child: Text(
                      'با زدن دکمه تایید با شرایط برنامه بکسی موافقت میکنم.',
                      style: theme.textTheme.bodySmall,
                    ))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
