import 'package:flutter/material.dart';

class DriverService extends StatefulWidget {
  const DriverService({super.key});

  @override
  State<DriverService> createState() => _DriverServiceState();
}

class _DriverServiceState extends State<DriverService> {
  int chosen = 0;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Text('سرویسی که قرار است اراعه بدهید را انتخاب کنید:'),
        SizedBox(
          height: 16,
        ),
        Table(
          border: TableBorder.all(
              color: theme.colorScheme.onPrimary,
              width: 2,
              borderRadius: BorderRadius.circular(12)),
          children: [
            TableRow(children: [
              InkWell(
                onTap: () {
                  setState(() {
                    chosen = 0;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: chosen == 0 ? theme.colorScheme.primary : null,
                    borderRadius: BorderRadius.only(topRight: Radius.circular(12))
                  ),
                    padding: EdgeInsets.fromLTRB(12, 8, 12, 8),
                    alignment: Alignment.center,
                    child: Text('بکسی')),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    chosen = 1;
                  });
                },
                child: Container(
                    decoration: BoxDecoration(
                    color: chosen == 1 ? theme.colorScheme.primary : null,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(12))
                  ),
                    padding: EdgeInsets.fromLTRB(12, 8, 12, 8),
                    alignment: Alignment.center,
                    child: Text('بکسی بانوان')),
              )
            ]),
            TableRow(children: [
              InkWell(
                onTap: () {
                  setState(() {
                    chosen = 2;
                  });
                },
                child: Container(
                    decoration: BoxDecoration(
                    color: chosen == 2 ? theme.colorScheme.primary : null,
                    borderRadius: BorderRadius.only(bottomRight: Radius.circular(12))
                  ),
                    padding: EdgeInsets.fromLTRB(12, 8, 12, 8),
                    alignment: Alignment.center,
                    child: Text('بکسی باکس')),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    chosen = 3;
                  });
                },
                child: Container(
                    decoration: BoxDecoration(
                    color: chosen == 3 ? theme.colorScheme.primary : null,
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12))
                  ),
                    padding: EdgeInsets.fromLTRB(12, 8, 12, 8),
                    alignment: Alignment.center,
                    child: Text('بکسی بار')),
              )
            ]),
          ],
        )
      ],
    );
  }
}
