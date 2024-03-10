import 'package:animations/animations.dart';
import 'package:baxi/auth/sign_up_driver/driver_bank_account.dart';
import 'package:baxi/auth/sign_up_driver/driver_disability.dart';
import 'package:baxi/auth/sign_up_driver/driver_service.dart';
import 'package:baxi/auth/sign_up_driver/sign_up_driver.dart';
import 'package:baxi/auth/sign_up_driver/sign_up_driver_pics.dart';
import 'package:baxi/auth/sign_up_driver/vehicle_information.dart';
import 'package:baxi/home/driver_home.dart';
import 'package:baxi/home/home.dart';
import 'package:baxi/theme.dart';
import 'package:flutter/material.dart';

class DriverSignUpProcess extends StatefulWidget {
  const DriverSignUpProcess({super.key});

  @override
  State<DriverSignUpProcess> createState() => _DriverSignUpProcessState();
}

class _DriverSignUpProcessState extends State<DriverSignUpProcess> {
  int currentStep = 0;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('ثبت نام رانندگان'),
        ),
        body: Stepper(
          connectorColor: MaterialStatePropertyAll(theme.colorScheme.onPrimary),
          type: StepperType.vertical,
          steps: getSteps(),
          currentStep: currentStep,
          onStepContinue: () {
            bool isLastStep = getSteps().length - 1 == currentStep;
            if (isLastStep) {
              debugPrint('completed');
            } else {
              setState(() {
                currentStep += 1;
              });
            }
          },
          onStepCancel: () {
            if (currentStep != 0) {
              setState(() {
                currentStep -= 1;
              });
            }
          },
          onStepTapped: (value) {
            setState(() {
              currentStep = value;
            });
          },
          controlsBuilder: (context, details) {
            bool isLastStep = getSteps().length - 1 == currentStep;
            return Padding(
              padding: const EdgeInsets.only(top: 24),
              child: Row(
                children: [
                  Expanded(
                      child: ElevatedButton(
                          onPressed: () {
                            if (isLastStep) {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) {
                                  return const DriverHomeScreen();
                                },
                              ));
                            } else {
                              details.onStepContinue!();
                            }
                          },
                          child: Text(
                            !isLastStep ? 'بعدی' : 'تایید',
                            style: theme.textTheme.bodyMedium!
                                .copyWith(fontWeight: FontWeight.bold),
                          ))),
                  SizedBox(
                    width: 12,
                  ),
                  if (currentStep != 0)
                    Expanded(
                        child: ElevatedButtonTheme(
                      data: LightTheme.elevatedButton1,
                      child: ElevatedButton(
                          onPressed: () {
                            details.onStepCancel!();
                          },
                          child: Text(
                            'بازگشت',
                            style: theme.textTheme.bodyMedium!.copyWith(
                                fontWeight: FontWeight.bold,
                                color: theme.colorScheme.primary),
                          )),
                    ))
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  List<Step> getSteps() {
    final theme = Theme.of(context);
    return [
      Step(
          state: currentStep > 0 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 0,
          title: Text(
            'اطلاعات',
            style: theme.textTheme.bodySmall!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          content: SignUpDriverScreen()),
      Step(
          state: currentStep > 1 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 1,
          title: Text('مدارک',
              style: theme.textTheme.bodySmall!
                  .copyWith(fontWeight: FontWeight.bold)),
          content: const SignUpUploadDocsScreen()),
      Step(
          state: currentStep > 2 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 2,
          title: Text('سلامت',
              style: theme.textTheme.bodySmall!
                  .copyWith(fontWeight: FontWeight.bold)),
          content: DriverDisabilityScreen()),
      Step(
          state: currentStep > 3 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 3,
          title: Text('اطلاعات بانکی',
              style: theme.textTheme.bodySmall!
                  .copyWith(fontWeight: FontWeight.bold)),
          content: const DriverBankAccount()),
      Step(
        state: currentStep > 4 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 4,
        title: Text('سرویس',
            style: theme.textTheme.bodySmall!
                .copyWith(fontWeight: FontWeight.bold)),
        content: DriverService(),
      ),
      Step(
        state: currentStep > 5 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 5,
        title: Text('وسیله',
            style: theme.textTheme.bodySmall!
                .copyWith(fontWeight: FontWeight.bold)),
        content: VehicleInformation(),
      )
    ];
  }
}
