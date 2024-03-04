import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BaxiBoxBottomSheet extends StatefulWidget {
  const BaxiBoxBottomSheet({super.key});

  @override
  State<BaxiBoxBottomSheet> createState() => _BaxiBoxBottomSheetState();
}

class _BaxiBoxBottomSheetState extends State<BaxiBoxBottomSheet> {
  bool isBreakable = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(25),
      width: double.infinity,
      height: MediaQuery.of(context).size.height / 2,
      child: Column(
        children: [
          Row(
            children: [
              const Text('وزن کالا: '),
              const SizedBox(
                width: 12,
              ),
              SizedBox(
                width: 130,
                height: 50,
                child: TextField(
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      suffix: Text('kg'),
                      contentPadding: EdgeInsets.only(left: 12, right: 12)),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              const Text('ارزش مالی: '),
              const SizedBox(
                width: 12,
              ),
              Expanded(
                child: TextField(
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      contentPadding: EdgeInsets.only(left: 12, right: 12),
                      suffix: Text('تومان')),
                ),
              )
            ],
          ),
          const Expanded(child: SizedBox()),
          Row(
            children: [
              const Text('آیا کالای مورد نظر شکستنی است؟'),
              const SizedBox(
                width: 12,
              ),
              Checkbox(
                value: isBreakable,
                onChanged: (value) {
                  setState(() {
                    isBreakable = !isBreakable;
                  });
                },
              ),
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'تایید',
                  style: theme.textTheme.bodyMedium!
                      .copyWith(fontWeight: FontWeight.bold),
                )),
          )
        ],
      ),
    );
  }
}
