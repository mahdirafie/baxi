import 'package:baxi/auth/sign_up_driver/sign_up_driver_pics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

class SignUpDriverScreen extends StatefulWidget {
  const SignUpDriverScreen({super.key});

  @override
  State<SignUpDriverScreen> createState() => _SignUpDriverScreenState();
}

class _SignUpDriverScreenState extends State<SignUpDriverScreen> {
  bool sex = true;
  Jalali? birthDate;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Row(
          children: [
            Expanded(
                child: SizedBox(
                    height: 50,
                    child: TextField(
                      decoration: InputDecoration(
                          hintText: 'نام',
                          contentPadding:
                              EdgeInsets.only(left: 12, right: 12)),
                    ))),
            SizedBox(
              width: 12,
            ),
            Expanded(
                child: SizedBox(
                    height: 50,
                    child: TextField(
                      decoration: InputDecoration(
                          hintText: 'نام خانوادگی',
                          contentPadding:
                              EdgeInsets.only(left: 12, right: 12)),
                    ))),
          ],
        ),
        const SizedBox(
          height: 12,
        ),
        Row(
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'جنسیت:',
                    style: theme.textTheme.bodyMedium!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  
                  sexSelection(context)
                ],
              ),
            ),
            const SizedBox(
              width: 12,
            ),
            Expanded(
                child: SizedBox(
              height: 50,
              child: TextField(
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: const InputDecoration(
                      hintText: 'شماره ملی',
                      contentPadding: EdgeInsets.only(left: 12, right: 12))),
            ))
          ],
        ),
        const SizedBox(
          height: 12,
        ),
        Row(
          children: [
            Text(
              'تاریخ تولد:',
              style: theme.textTheme.bodyMedium!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 8),
            if (birthDate == null)
              GestureDetector(
                onTap: () async {
                  birthDate = await showPersianDatePicker(
                      context: context,
                      initialDate: Jalali.now(),
                      firstDate: Jalali(1340),
                      lastDate: Jalali(1405));
                  setState(() {});
                },
                child: Container(
                  padding: const EdgeInsets.all(12),
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                          color: theme.colorScheme.onPrimary, width: 1)),
                  child: Text(
                    'تقویم',
                    style: theme.textTheme.bodyMedium!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
              )
            else
              GestureDetector(
                onTap: () async {
                  birthDate = await showPersianDatePicker(
                      context: context,
                      initialDate: Jalali.now(),
                      firstDate: Jalali(1340),
                      lastDate: Jalali(1405));
                  setState(() {});
                },
                child: Container(
                  padding: const EdgeInsets.all(12),
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                          color: theme.colorScheme.onPrimary, width: 1)),
                  child: Text(
                    birthDate!.formatFullDate().toString(),
                    style: theme.textTheme.bodyMedium!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }

  Widget sexSelection(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: 100,
      height: 50,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: theme.colorScheme.onPrimary)),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                if (!sex) {
                  setState(() {
                    sex = true;
                  });
                }
              },
              child: Icon(Icons.man,
                  size: 35,
                  color: sex
                      ? theme.colorScheme.primary
                      : theme.colorScheme.onPrimary),
            ),
          ),
          Container(
            color: theme.colorScheme.onPrimary,
            width: 1,
            height: double.infinity,
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                if (sex) {
                  setState(() {
                    sex = false;
                  });
                }
              },
              child: Icon(
                Icons.woman,
                size: 35,
                color: sex
                    ? theme.colorScheme.onPrimary
                    : theme.colorScheme.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
