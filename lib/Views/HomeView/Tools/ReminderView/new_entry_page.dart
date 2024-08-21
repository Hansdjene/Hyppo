import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hyppo/Components/color.dart';
import 'package:hyppo/Components/my_button.dart';
import 'package:hyppo/Components/my_textfield.dart';
import 'package:hyppo/Views/HomeView/Tools/ReminderView/convert_time.dart';
import 'package:hyppo/Views/HomeView/Tools/ReminderView/medicine_type.dart';

class NewEntryPage extends StatefulWidget {
  const NewEntryPage({super.key});

  @override
  State<NewEntryPage> createState() => _NewEntryPageState();
}

class _NewEntryPageState extends State<NewEntryPage> {
  // Text editing controllers
  late TextEditingController mednameController;
  late TextEditingController dosageController;

  late GlobalKey<ScaffoldState> _scaffoldKey;

  @override
  void dispose() {
    mednameController.dispose();
    dosageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    mednameController = TextEditingController();
    dosageController = TextEditingController();
    _scaffoldKey = GlobalKey<ScaffoldState>();
  }

  @override
  Widget build(BuildContext context) {
    // Obtenir les couleurs du thème actuel
    final primaryColor = Colors.green;
    final onPrimaryColor = Theme.of(context).colorScheme.onPrimary;
    final backgroundColor = Theme.of(context).colorScheme.background;

    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        iconTheme: IconThemeData(color: primaryColor),
        title: const Text(
          'Add New',
          style: TextStyle(fontSize: 16),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            MyTextField(
              controller: mednameController,
              hintText: 'Medicine Name',
              obscureText: false,
            ),
            const SizedBox(height: 15),
            MyTextField(
              controller: dosageController,
              hintText: 'Dosage in mg',
              obscureText: false,
            ),
            const SizedBox(height: 25),
            const PanelTitle(title: 'Medicine Type', isRequired: false),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: StreamBuilder(
                stream:
                    null, // Vous devez remplacer `null` par le flux réel si nécessaire.
                builder: (context, snapshot) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MedicineTypeColumn(
                        name: 'Capsule',
                        iconValue: 'assets/icons/capsules.svg',
                        isSelected: snapshot.data == MedicineType.capsules,
                        primaryColor: primaryColor,
                        onPrimaryColor: onPrimaryColor,
                        backgroundColor: backgroundColor,
                        medicineType: MedicineType.capsules,
                      ),
                      MedicineTypeColumn(
                        name: 'Medicine',
                        iconValue: 'assets/icons/medicine.svg',
                        isSelected: snapshot.data == MedicineType.medicine,
                        primaryColor: primaryColor,
                        onPrimaryColor: onPrimaryColor,
                        backgroundColor: backgroundColor,
                        medicineType: MedicineType.medicine,
                      ),
                      MedicineTypeColumn(
                        name: 'Ointment',
                        iconValue: 'assets/icons/ointment.svg',
                        isSelected: snapshot.data == MedicineType.ointment,
                        primaryColor: primaryColor,
                        onPrimaryColor: onPrimaryColor,
                        backgroundColor: backgroundColor,
                        medicineType: MedicineType.ointment,
                      ),
                      MedicineTypeColumn(
                        name: 'Syringe',
                        iconValue: 'assets/icons/syringe.svg',
                        isSelected: snapshot.data == MedicineType.syringe,
                        primaryColor: primaryColor,
                        onPrimaryColor: onPrimaryColor,
                        backgroundColor: backgroundColor,
                        medicineType: MedicineType.syringe,
                      ),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: 25),
            const PanelTitle(title: 'Interval Selection', isRequired: true),
            const IntervalSelection(),
            const SizedBox(height: 25),
            const PanelTitle(title: 'Starting Time', isRequired: true),
            SelectTime(),
            const SizedBox(height: 15),
            MyButton(onTap: () {}, text: 'Confirm')
          ],
        ),
      ),
    );
  }
}

class SelectTime extends StatefulWidget {
  const SelectTime({super.key});

  @override
  State<SelectTime> createState() => _SelectTimeState();
}

class _SelectTimeState extends State<SelectTime> {
  final TimeOfDay _time = const TimeOfDay(hour: 0, minute: 00);
  final bool _cliked = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          child: MyButton(
              onTap: () {},
              text
        ),
      ],
    );
  }
}

class IntervalSelection extends StatefulWidget {
  const IntervalSelection({super.key});

  @override
  State<IntervalSelection> createState() => _IntervalSelectionState();
}

class _IntervalSelectionState extends State<IntervalSelection> {
  final _intervals = [6, 8, 12, 24];
  var _selected = 0; // Variable pour stocker l'intervalle sélectionné

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Remind me every',
            style: TextStyle(fontSize: 16),
          ),
          // Espacement entre le texte et le menu déroulant
          DropdownButton(
            iconEnabledColor: Colors.green,
            hint: _selected == 0
                ? Text('Select an interval',
                    style: TextStyle(color: Colors.green))
                : null,
            elevation: 4,
            value: _selected == 0 ? null : _selected,
            items: _intervals.map((int value) {
              return DropdownMenuItem<int>(
                value: value,
                child: Text(
                  value.toString(),
                  style: const TextStyle(
                      fontSize: 16,
                      color: Colors.green), // Style du texte du menu
                ),
              );
            }).toList(),
            onChanged: (newVal) {
              setState(() {
                _selected = newVal!;
              });
            },
          ),
          Text(
            _selected == 1 ? "hour" : "hours",
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}

class MedicineTypeColumn extends StatelessWidget {
  const MedicineTypeColumn({
    super.key,
    required this.name,
    required this.iconValue,
    required this.isSelected,
    required this.primaryColor,
    required this.onPrimaryColor,
    required this.backgroundColor,
    required this.medicineType,
  });

  final MedicineType medicineType;
  final String name;
  final String iconValue;
  final bool isSelected;
  final Color primaryColor;
  final Color onPrimaryColor;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Column(
        children: [
          Container(
            width: 80,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: isSelected ? primaryColor : backgroundColor,
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 13, bottom: 13),
                child: SvgPicture.asset(
                  iconValue,
                  height: 50,
                  color: isSelected ? onPrimaryColor : primaryColor,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 9),
            child: Container(
              width: 60,
              height: 30,
              decoration: BoxDecoration(
                color: isSelected ? primaryColor : Colors.transparent,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text(
                  name,
                  style: TextStyle(
                    color: isSelected ? onPrimaryColor : primaryColor,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PanelTitle extends StatelessWidget {
  const PanelTitle({super.key, required this.title, required this.isRequired});
  final String title;
  final bool isRequired;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 5),
      child: Text.rich(
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        TextSpan(
          children: <TextSpan>[
            TextSpan(
              text: title,
            ),
            TextSpan(
              text: isRequired ? " *" : "",
            ),
          ],
        ),
      ),
    );
  }
}


//: _cliked == false? "Select Time""${convertTime(_time.hour.toString())}:${convertTime(_time.minute.toString())}"),