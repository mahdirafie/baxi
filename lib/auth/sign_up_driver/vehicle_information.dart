import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VehicleInformation extends StatefulWidget {
  const VehicleInformation({super.key});

  @override
  State<VehicleInformation> createState() => _VehicleInformationState();
}

class _VehicleInformationState extends State<VehicleInformation> {
  List<String> fuelType = ['گاز سوز', 'بنزین سوز', 'دوگانه'];
  late String chosenFuelType;

  @override
  void initState() {
    chosenFuelType = fuelType[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Expanded(
                flex: 2,
                child: SizedBox(
                  height: 50,
                  child: TextField(
                    decoration: InputDecoration(
                        hintText: 'نام',
                        contentPadding: EdgeInsets.only(left: 12, right: 12)),
                  ),
                )),
            SizedBox(
              width: 12,
            ),
            Expanded(
                flex: 2,
                child: SizedBox(
                  height: 50,
                  child: TextField(
                    decoration: InputDecoration(
                        hintText: 'رنگ',
                        contentPadding: EdgeInsets.only(left: 12, right: 12)),
                  ),
                )),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        const Row(
          children: [
            Expanded(
                flex: 2,
                child: SizedBox(
                  height: 50,
                  child: TextField(
                    decoration: InputDecoration(
                        hintText: 'سال تولید',
                        contentPadding: EdgeInsets.only(left: 12, right: 12)),
                  ),
                )),
            SizedBox(
              width: 12,
            ),
            Expanded(
                flex: 2,
                child: SizedBox(
                  height: 50,
                  child: TextField(
                    decoration: InputDecoration(
                        hintText: 'پلاک',
                        contentPadding: EdgeInsets.only(left: 12, right: 12)),
                  ),
                )),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          children: [
            const Expanded(
              child: SizedBox(
                height: 50,
                child: TextField(
                  decoration: InputDecoration(
                      hintText: 'ظرفیت',
                      contentPadding: EdgeInsets.only(left: 12, right: 12)),
                ),
              ),
            ),
            const SizedBox(width: 12,),
            Expanded(child: dropDown())
          ],
        ),

      ],
    );
  }

  Widget dropDown() {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        hint: const Text('select'),
        value: chosenFuelType,
        items: fuelType
            .map((e) => DropdownMenuItem<String>(value: e,child: Row(
              textDirection: TextDirection.rtl,
              children: [
                Text(e),
              ],
            )))
            .toList(),
        onChanged: (value) {
          if (value != null) {
            chosenFuelType = value;
            setState(() {});
          }
        },
        buttonStyleData: ButtonStyleData(
          height: 50,
          width: 160,
          padding: const EdgeInsets.only(left: 14, right: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: Colors.black26,
            ),
            color: Colors.grey,
          ),
          elevation: 2,
        ),
        iconStyleData: const IconStyleData(
          icon: Icon(
            Icons.arrow_downward_outlined,
          ),
          iconSize: 15,
          iconEnabledColor: Colors.black,
          iconDisabledColor: Colors.black,
        ),
        dropdownStyleData: DropdownStyleData(
          maxHeight: 250,
          width: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.grey,
          ),
          offset: const Offset(0, -5),
          padding: const EdgeInsets.fromLTRB(10, 5, 5, 5),
          scrollbarTheme: ScrollbarThemeData(
            interactive: true,
            radius: const Radius.circular(40),
            thickness: MaterialStateProperty.all<double>(8),
            thumbVisibility: MaterialStateProperty.all<bool>(true),
          ),
        ),
        menuItemStyleData: MenuItemStyleData(
          height: 50,
          selectedMenuItemBuilder: (context, child) {
            return Container(
              decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.black, width: 2)),
              child: child,
            );
          },
          padding: const EdgeInsets.only(left: 14, right: 14),
        ),
      ),
    );
  }
}
