import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hyppo/Components/my_button.dart';

class MedicineDetails extends StatefulWidget {
  const MedicineDetails({super.key});

  @override
  State<MedicineDetails> createState() => _MedicineDetailsState();
}

class _MedicineDetailsState extends State<MedicineDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.green),
        title: const Text(
          'Details',
          style: TextStyle(fontSize: 16),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          SizedBox(
            height: 20,
          ),
          MainSection(),
          ExtendedSection(),
          SizedBox(
            height: 90,
          ),
          MyButton(
              onTap: () {
                openAlertBox(context);
              },
              text: 'Delete')
        ]),
      ),
    );
  }

  openAlertBox(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            contentPadding: EdgeInsets.only(top: 8),
            title: Text(
              'Delete This Reminder?',
              style: TextStyle(fontSize: 18),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Cancel',
                  style: TextStyle(color: null),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'OK',
                  style: TextStyle(color: Colors.red),
                ),
              )
            ],
          );
        });
  }
}

class MainSection extends StatelessWidget {
  const MainSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SvgPicture.asset(
          'assets/icons/capsules.svg',
          height: 75,
          color: Colors.green,
        ),
        SizedBox(
          width: 10,
        ),
        Column(
          children: [
            MainInfoTab(fieldTitle: 'Medicine Name', fieldInfo: 'Catapol'),
            MainInfoTab(fieldTitle: 'Dosage', fieldInfo: '500 mg'),
          ],
        ),
      ],
    );
  }
}

class MainInfoTab extends StatelessWidget {
  const MainInfoTab(
      {super.key, required this.fieldTitle, required this.fieldInfo});
  final String fieldTitle;
  final String fieldInfo;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 110,
      height: 90,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              fieldTitle,
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(
              height: 2,
            ),
            Text(
              fieldInfo,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            )
          ],
        ),
      ),
    );
  }
}

class ExtendedSection extends StatelessWidget {
  const ExtendedSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: ListView(
        shrinkWrap: true,
        children: [
          ExtendedInfoTab(
            fieldTitle: 'Medicine Type',
            fieldInfo: 'Pill',
          ),
          ExtendedInfoTab(
            fieldTitle: 'Dose Interval',
            fieldInfo: 'Every 8 hours | 3 times a day',
          ),
          ExtendedInfoTab(
            fieldTitle: 'Start Time',
            fieldInfo: '01:19',
          )
        ],
      ),
    );
  }
}

class ExtendedInfoTab extends StatelessWidget {
  const ExtendedInfoTab(
      {super.key, required this.fieldTitle, required this.fieldInfo});
  final String fieldTitle;
  final String fieldInfo;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: Text(
              fieldTitle,
              style: TextStyle(fontSize: 17),
            ),
          ),
          Text(
            fieldInfo,
            style: TextStyle(color: Colors.green),
          )
        ],
      ),
    );
  }
}
