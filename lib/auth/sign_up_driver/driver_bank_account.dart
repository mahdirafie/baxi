import 'package:flutter/material.dart';

class DriverBankAccount extends StatelessWidget {
  const DriverBankAccount({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'شماره شبا خود را وارد کنید:',
          style:
              theme.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
        ),
        Text('از این اطلاعات برای واریز حقوق شما استفاده میشود',
            style: theme.textTheme.bodyMedium!
                .copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(
          height: 16,
        ),
        const SizedBox(
          width: double.infinity,
          height: 50,
          child: TextField(
              textDirection: TextDirection.ltr,
              decoration: InputDecoration(
                  hintTextDirection: TextDirection.ltr,
                  hintText: 'IR-- --- - ------------------',
                  contentPadding: EdgeInsets.only(left: 12, right: 12))),
        ),
      ],
    );
  }
}
