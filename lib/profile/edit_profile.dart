import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        shadowColor: Colors.grey,
        backgroundColor: theme.colorScheme.background,
        elevation: 1,
        title: Text(
          'ویرایش پروفایل',
          style:
              theme.textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(left: 12, right: 12, top: 25, bottom: 10),
        child: Column(
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: Image.asset('assets/images/profile.png', width: 80, height: 80,),
                ),
                const SizedBox(
                  width: 12,
                ),
                Column(
                  children: [
                    Text(
                      'مهدی رفیعی',
                      style: theme.textTheme.bodyMedium!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    const Text('۰۹۱۸۸۹۳۱۷۷۵')
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.4), blurRadius: 15)
                  ],
                  color: theme.colorScheme.surface),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                    child: Text(
                      'مشخصات من',
                      style: theme.textTheme.bodyMedium!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Divider(
                    indent: 12,
                    endIndent: 12,
                  ),
                  informationItem(context, 'نام'),
                  const Divider(
                    indent: 12,
                    endIndent: 12,
                  ),
                  informationItem(context, 'نام خانوادگی'),
                  const Divider(
                    indent: 12,
                    endIndent: 12,
                  ),
                  informationItem(context, 'ایمیل'),
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.4), blurRadius: 15)
                  ],
                  color: theme.colorScheme.surface),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                    child: Text(
                      'تنظیمات سفر',
                      style: theme.textTheme.bodyMedium!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Divider(
                    indent: 12,
                    endIndent: 12,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                    child: Row(
                      children: [
                        const Icon(Icons.wheelchair_pickup),
                        const SizedBox(
                          width: 8,
                        ),
                        const Text('ویلچر / عصا دارم'),
                        Expanded(
                            child: Container(
                          alignment: Alignment.centerLeft,
                          child: const Icon(
                            CupertinoIcons.forward,
                            size: 18,
                          ),
                        ))
                      ],
                    ),
                  ),
                  const Divider(
                    indent: 12,
                    endIndent: 12,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                      child: Row(
                        children: [
                          const Icon(CupertinoIcons.ear),
                          const SizedBox(
                            width: 8,
                          ),
                          const Text(
                            'ناشنوا / کم شنوا هستم',
                          ),
                          Expanded(
                              child: Container(
                            alignment: Alignment.centerLeft,
                            child: Switch(
                              onChanged: (value) {},
                              value: true,
                            ),
                          ))
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.4), blurRadius: 15)
                  ],
                  color: theme.colorScheme.surface),
              width: double.infinity,
              child: const Padding(
                padding: EdgeInsets.fromLTRB(16, 12, 16, 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('خروج از حساب کاربری'),
                    Icon(
                      CupertinoIcons.forward,
                      size: 18,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }

  Widget informationItem(BuildContext context, String title) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: theme.textTheme.bodySmall,
          ),
          Expanded(
              child: InkWell(
            onTap: () {},
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('تغییر'),
                Icon(
                  Icons.edit,
                  size: 18,
                )
              ],
            ),
          ))
        ],
      ),
    );
  }
}
