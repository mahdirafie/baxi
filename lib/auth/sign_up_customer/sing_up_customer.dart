import 'package:baxi/home/home.dart';
import 'package:flutter/material.dart';

class SignUpCustomerScreen extends StatefulWidget {
  const SignUpCustomerScreen({super.key});

  @override
  State<SignUpCustomerScreen> createState() => _SignUpCustomerScreenState();
}

class _SignUpCustomerScreenState extends State<SignUpCustomerScreen> {
  bool sex = true;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('ثبت نام مشتریان'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 25, right: 25),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/baxi_text.png', width: 200, height: 200,),
              const SizedBox(
                height: 24,
              ),
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
              const SizedBox(height: 12,),
              Row(mainAxisAlignment: MainAxisAlignment.center,children: [
                Text('جنسیت:', style: theme.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),),
                const SizedBox(width: 12),
                sexSelection(context)
              ],),
              const SizedBox(height: 16,),
              SizedBox(width: double.infinity, height: 50, child: ElevatedButton(onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                    return const HomeScreen();
                  },));
              }, child: Text('ثبت نام', style: theme.textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),)),)
            ],
          ),
        ),
      ),
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
