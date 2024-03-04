import 'package:flutter/material.dart';

class OTPScreen extends StatelessWidget {
  const OTPScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // final pinTheme = PinTheme(
    //     width: 55,
    //     height: 60,
    //     padding: EdgeInsets.fromLTRB(8, 4, 8, 4),
    //     decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: theme.colorScheme.primary));

    return SafeArea(
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
                    '+98 9188931775',
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
                    )
                  ),
                  const SizedBox(height: 24,),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(onPressed: () {
                      
                    }, child: Text('تایید', style: theme.textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),)),
                  ),
                  const SizedBox(height: 12,),
                  Text('کدی دریافت نکردید؟', style: theme.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold, color: theme.colorScheme.primary.withGreen(200)),)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget otp(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
      _textFieldOTP(true, false, context),
      _textFieldOTP(false, false, context),
      _textFieldOTP(false, false, context),
      _textFieldOTP(false, true, context),
    ]);
  }

  _textFieldOTP(bool first, bool last, BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      height: 60,
      child: AspectRatio(
        aspectRatio: 0.7,
        child: TextField(
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
