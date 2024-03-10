import 'package:baxi/auth/sign_up_driver/driver_disability.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class SignUpUploadDocsScreen extends StatefulWidget {
  const SignUpUploadDocsScreen({super.key});

  @override
  State<SignUpUploadDocsScreen> createState() => _SignUpUploadDocsScreenState();
}

class _SignUpUploadDocsScreenState extends State<SignUpUploadDocsScreen> {
  File? profileImage;
  File? idCardImage;
  File? drivingLicense;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _item(
          context,
          InkWell(
            onTap: () {
              pickImage(ImageSource.camera, 0);
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'اسکن کارت ملی',
                      style: theme.textTheme.bodyMedium!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Icon(Icons.document_scanner)
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  width: 150,
                  height: 4,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      color: idCardImage == null ? Colors.red : Colors.green),
                )
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        _item(
          context,
          InkWell(
            onTap: () async {
              pickImage(ImageSource.camera, 1);
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'عکس گواهینامه',
                      style: theme.textTheme.bodyMedium!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Icon(Icons.file_copy)
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  width: 150,
                  height: 4,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      color:
                          drivingLicense == null ? Colors.red : Colors.green),
                )
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        GestureDetector(
          onTap: () async {
            await _showSourceBottomSheet(context);
          },
          child: Container(
            width: double.infinity,
            height: 60,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(12)),
                border:
                    Border.all(color: theme.colorScheme.onPrimary, width: 1),
                boxShadow: [
                  BoxShadow(
                      color: theme.colorScheme.onPrimary.withOpacity(0.2),
                      blurRadius: 10)
                ]),
            child: Row(
              children: [
                Expanded(
                    child: Container(
                        alignment: Alignment.centerRight,
                        child: profileImage == null
                            ? Image.asset(
                                'assets/images/profile.png',
                              )
                            : Image.file(profileImage!))),
                Text(
                  'افزودن عکس پروفایل',
                  style: theme.textTheme.bodyMedium!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                    child: Container(
                        alignment: Alignment.centerRight,
                        child: const Icon(CupertinoIcons.add)))
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _item(BuildContext context, Widget child) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      height: 60,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: theme.colorScheme.onPrimary, width: 1),
          boxShadow: [
            BoxShadow(
                color: theme.colorScheme.onPrimary.withOpacity(0.2),
                blurRadius: 10)
          ]),
      child: child,
    );
  }

  Future pickImage(ImageSource source, int choosen) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      final permanentImage = await saveImagePermanently(image.path);
      setState(() {
        switch (choosen) {
          case 0:
            idCardImage = permanentImage;
            break;
          case 1:
            drivingLicense = permanentImage;
            break;
          case 2:
            profileImage = permanentImage;
            break;
        }
      });
    } on PlatformException catch (_) {
      debugPrint("ERROR in picking image");
    }
  }

  Future<File> saveImagePermanently(String imagePath) async {
    final directory = await getApplicationDocumentsDirectory();
    final name = basename(imagePath);
    final image = File("${directory.path}/$name");

    return File(imagePath).copy(image.path);
  }

  Future<void> _showSourceBottomSheet(BuildContext context) {
    final theme = Theme.of(context);
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
            alignment: Alignment.center,
            decoration: const BoxDecoration(
                color: Color.fromARGB(255, 231, 231, 231),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12))),
            height: 150,
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      pickImage(ImageSource.camera, 2);
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: theme.colorScheme.surface,
                          borderRadius: BorderRadius.circular(12)),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            CupertinoIcons.camera,
                            size: 20,
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text('دوربین')
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      pickImage(ImageSource.gallery, 2);
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: theme.colorScheme.surface,
                          borderRadius: BorderRadius.circular(12)),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            CupertinoIcons.photo,
                            size: 20,
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text('گالری')
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ));
      },
    );
  }
}
