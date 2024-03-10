import 'package:flutter/material.dart';

class DriverDisabilityScreen extends StatefulWidget {
  const DriverDisabilityScreen({super.key});

  @override
  State<DriverDisabilityScreen> createState() => _DriverDisabilityScreenState();
}

class _DriverDisabilityScreenState extends State<DriverDisabilityScreen> {
  bool deaf = false;
  bool paralyzed = false;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'در صورت داشتن هر یک از ناتوانایی های زیر هر آنرا تیک بزنید',
          style: theme.textTheme.bodySmall!.copyWith(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.onPrimary),
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          children: [
            Checkbox(
              value: deaf,
              onChanged: (value) {
                setState(() {
                  if (value != null) {
                    deaf = value;
                  }
                });
              },
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              'ناشنوایی',
              style: theme.textTheme.bodyMedium!
                  .copyWith(fontWeight: FontWeight.bold),
            )
          ],
        ),
        Row(
          children: [
            Checkbox(
              value: paralyzed,
              onChanged: (value) {
                setState(() {
                  if (value != null) {
                    paralyzed = value;
                  }
                });
              },
            ),
            const SizedBox(
              width: 8,
            ),
            Text('ناتوانایی حرکتی',
                style: theme.textTheme.bodyMedium!
                    .copyWith(fontWeight: FontWeight.bold))
          ],
        ),
      ],
    );
  }
}
