import 'package:baxi/auth/otp.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputPhoneNumberScreen extends StatelessWidget {
  const InputPhoneNumberScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
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
                      decoration: const InputDecoration(
                          suffix: Text('( +98 ) ', textDirection: TextDirection.ltr,),
                          hintText: "9123456789",
                          hintTextDirection: TextDirection.ltr,
                          contentPadding: EdgeInsets.only(left: 12, right: 12)),
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
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) {
                              return const OTPScreen();
                            },
                          ));
                        },
                        child: Text(
                          'تایید',
                          style: theme.textTheme.bodyMedium!
                              .copyWith(fontWeight: FontWeight.bold),
                        )),
                  ),
                  const SizedBox(
                    height: 12,
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
    );
  }
}
