import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hyppo/Components/my_button.dart';
import 'package:hyppo/Components/my_textfield.dart';
import 'package:hyppo/Views/HomeView/Tools/ReminderView/Models/errors.dart';
import 'package:hyppo/Views/HomeView/Tools/ReminderView/Models/global_bloc.dart';
import 'package:hyppo/Views/HomeView/Tools/ReminderView/Models/medicine_type.dart';
import 'package:hyppo/Views/HomeView/Tools/ReminderView/Models/number_page.dart';
import 'package:hyppo/Views/HomeView/Tools/ReminderView/Models/new_entry_bloc.dart';
import 'package:hyppo/Views/HomeView/Tools/ReminderView/medicine.dart';
import 'package:provider/provider.dart';

class NewEntryPage extends StatefulWidget {
  const NewEntryPage({super.key});

  @override
  State<NewEntryPage> createState() => _NewEntryPageState();
}

class _NewEntryPageState extends State<NewEntryPage> {
  late TextEditingController mednameController;
  late TextEditingController dosageController;
  late GlobalKey<ScaffoldState> _scaffoldKey;
  late NewEntryBloc _newEntryBloc;

  bool _isLoading = false;

  void _showLoadingAndGoBack() {
    setState(() {
      _isLoading = true;
    });

    // Attendre 2 secondes puis revenir à la page précédente
    Timer(const Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });
      Navigator.of(context).pop();
    });
  }

  @override
  void dispose() {
    super.dispose();
    mednameController.dispose();
    dosageController.dispose();
    _newEntryBloc.dispose();
  }

  @override
  void initState() {
    super.initState();
    mednameController = TextEditingController();
    dosageController = TextEditingController();
    _newEntryBloc = NewEntryBloc();
    _scaffoldKey = GlobalKey<ScaffoldState>();
    initializeErrorListen();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const primaryColor = Colors.green;
    final onPrimaryColor = Theme.of(context).colorScheme.onPrimary;
    final backgroundColor = Theme.of(context).colorScheme.background;

    final GlobalBloc globalBloc = Provider.of(context);

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
      body: Stack(
        children: [
          Provider<NewEntryBloc>.value(
            value: _newEntryBloc,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 15),
                    Text('Complete These Fields',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(height: 10),
                    MyTextField(
                      controller: mednameController,
                      hintText: 'Medicine Name',
                      obscureText: false,
                    ),
                    const SizedBox(height: 15),
                    TextField(
                      controller: dosageController,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      decoration: InputDecoration(
                        labelText: 'Dosage in mg',
                        border: OutlineInputBorder(),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green.shade400),
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),
                    Text('Medicine Type',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(height: 10),
                    StreamBuilder<MedicineType>(
                      stream: _newEntryBloc.selectedMedicineType,
                      builder: (context, snapshot) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MedicineTypeColumn(
                              name: 'Capsule',
                              iconValue: 'assets/icons/capsules.svg',
                              isSelected: snapshot.data == MedicineType.capsules
                                  ? true
                                  : false,
                              primaryColor: primaryColor,
                              onPrimaryColor: onPrimaryColor,
                              backgroundColor: backgroundColor,
                              medicineType: MedicineType.capsules,
                            ),
                            MedicineTypeColumn(
                              name: 'Medicine',
                              iconValue: 'assets/icons/medicine.svg',
                              isSelected: snapshot.data == MedicineType.medicine
                                  ? true
                                  : false,
                              primaryColor: primaryColor,
                              onPrimaryColor: onPrimaryColor,
                              backgroundColor: backgroundColor,
                              medicineType: MedicineType.medicine,
                            ),
                            MedicineTypeColumn(
                              name: 'Ointment',
                              iconValue: 'assets/icons/ointment.svg',
                              isSelected: snapshot.data == MedicineType.ointment
                                  ? true
                                  : false,
                              primaryColor: primaryColor,
                              onPrimaryColor: onPrimaryColor,
                              backgroundColor: backgroundColor,
                              medicineType: MedicineType.ointment,
                            ),
                            MedicineTypeColumn(
                              name: 'Syringe',
                              iconValue: 'assets/icons/syringe.svg',
                              isSelected: snapshot.data == MedicineType.syringe
                                  ? true
                                  : false,
                              primaryColor: primaryColor,
                              onPrimaryColor: onPrimaryColor,
                              backgroundColor: backgroundColor,
                              medicineType: MedicineType.syringe,
                            ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 10),
                    const IntervalSelection(),
                    const SizedBox(height: 10),
                    NumberPage(),
                    const SizedBox(height: 30),
                    Center(
                      child: MyButton(
                        onTap: () {
                          String? medicineName;
                          int? dosage;
                          if (mednameController.text == "") {
                            _newEntryBloc.SubmitError(EntryError.nameNull);
                            return;
                          }
                          if (mednameController.text != "") {
                            medicineName = mednameController.text;
                          }

                          if (dosageController.text == "") {
                            dosage = 0;
                          }
                          if (dosageController.text != "") {
                            dosage = int.parse(dosageController.text);
                          }

                          for (var medicine
                              in globalBloc.medicineList$!.value) {
                            if (medicineName == medicine.medicineName) {
                              _newEntryBloc.SubmitError(
                                  EntryError.nameDuplicate);
                              return;
                            }
                          }
                          if (_newEntryBloc.selectIntervals!.value == 0) {
                            _newEntryBloc.SubmitError(EntryError.interval);
                            return;
                          }
                          if (_newEntryBloc.selectedTimeOfDay$!.value ==
                              'None') {
                            _newEntryBloc.SubmitError(EntryError.startTime);
                            return;
                          }

                          String medicineType = _newEntryBloc
                              .selectedMedicineType!.value
                              .toString()
                              .substring(13);

                          int interval = _newEntryBloc.selectIntervals!.value;

                          String startTime =
                              _newEntryBloc.selectedTimeOfDay$!.value;

                          List<int> intIDs = makeIDs(
                              24 / _newEntryBloc.selectIntervals!.value);
                          List<String> notificationIDs =
                              intIDs.map((i) => i.toString()).toList();

                          Medicine newEntryMedicine = Medicine(
                              notificationIDs: notificationIDs,
                              medicineName: medicineName,
                              dosage: dosage,
                              medicineType: medicineName,
                              interval: interval,
                              startTime: startTime);

                          globalBloc.updateMedicineList(newEntryMedicine);

                          _showLoadingAndGoBack(); // Afficher l'image de chargement puis revenir
                        },
                        text: 'Confirm',
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
          // Affiche l'image de chargement au centre de l'écran si _isLoading est vrai
          if (_isLoading)
            Container(
              color: theme.colorScheme.surface.withOpacity(0.9),
              child: Center(
                child: Image.asset(
                  'assets/animations/check-mark.png', // Remplace par le chemin de ton image
                  width: 100,
                  height: 100,
                ),
              ),
            ),
        ],
      ),
    );
  }

  void initializeErrorListen() {
    _newEntryBloc.errorState$!.listen((EntryError error) {
      switch (error) {
        case EntryError.nameNull:
          displayError("Please enter the medicine's name");

        case EntryError.nameDuplicate:
          displayError("Medicine name already exits");

        case EntryError.dosage:
          displayError("Please enter the dosage required");

        case EntryError.interval:
          displayError("Please select the reminder's interval");

        case EntryError.startTime:
          displayError("Please select the reminder's starting time");

          break;
        default:
      }
    });
  }

  void displayError(String error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Color.fromARGB(147, 244, 67, 54),
        content: Text(error),
        duration: const Duration(milliseconds: 2000),
      ),
    );
  }

  List<int> makeIDs(double n) {
    var rng = Random();
    List<int> ids = [];
    for (int i = 0; i < n; i++) {
      ids.add(rng.nextInt(1000000000));
    }
    return ids;
  }
}

class IntervalSelection extends StatefulWidget {
  const IntervalSelection({super.key});

  @override
  State<IntervalSelection> createState() => _IntervalSelectionState();
}

class _IntervalSelectionState extends State<IntervalSelection> {
  final _intervals = [6, 8, 12, 24];
  var _selected = 0;

  @override
  Widget build(BuildContext context) {
    final NewEntryBloc newEntryBloc = Provider.of<NewEntryBloc>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Remind Me Every',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        DropdownButton(
          iconEnabledColor: Colors.green,
          hint: _selected == 0
              ? const Text('Select an interval',
                  style: TextStyle(
                    color: Colors.green,
                  ))
              : null,
          elevation: 4,
          value: _selected == 0 ? null : _selected,
          items: _intervals.map((int value) {
            return DropdownMenuItem<int>(
              value: value,
              child: Text(
                value.toString(),
                style: const TextStyle(fontSize: 16, color: Colors.green),
              ),
            );
          }).toList(),
          onChanged: (newVal) {
            setState(() {
              _selected = newVal!;
              newEntryBloc.UpdateInterval(newVal);
            });
          },
        ),
        Text(
          _selected == 1 ? "Hour" : "Hours",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
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
    final NewEntryBloc newEntryBloc = Provider.of<NewEntryBloc>(context);
    return GestureDetector(
      onTap: () {
        newEntryBloc.updateSelectedMedicine(medicineType);
      },
      child: Column(
        children: [
          Container(
            width: 70,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: isSelected ? primaryColor : backgroundColor,
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
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
              width: 72,
              height: 30,
              decoration: BoxDecoration(
                color: isSelected ? primaryColor : Colors.transparent,
                borderRadius: BorderRadius.circular(10),
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
