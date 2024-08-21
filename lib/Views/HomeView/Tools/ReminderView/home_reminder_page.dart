import 'package:flutter/material.dart';
import 'package:hyppo/Components/color.dart';
import 'package:hyppo/Views/HomeView/Tools/ReminderView/new_entry_page.dart';

class HomeReminderPage extends StatefulWidget {
  const HomeReminderPage({super.key});

  @override
  State<HomeReminderPage> createState() => _HomeReminderPageState();
}

class _HomeReminderPageState extends State<HomeReminderPage> {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TopContainer(),
            SizedBox(
              height: 100,
            ),
            Flexible(
              child: BottomContainer(),
            ),
          ],
        ),
      ),
      floatingActionButton: InkResponse(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => NewEntryPage()));
        },
        child: SizedBox(
          child: Card(
            color: Colors.green,
            child: Icon(
              Icons.add_outlined,
              size: 50,
            ),
          ),
        ),
      ),
    );
  }
}

class TopContainer extends StatelessWidget {
  const TopContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.topLeft,
          padding: EdgeInsets.only(
            bottom: 7,
          ),
          child: Text(
            'Worry less. \nLive healthier.',
            textAlign: TextAlign.start,
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          alignment: Alignment.topLeft,
          padding: EdgeInsets.only(
            bottom: 7,
          ),
          child: Text(
            'Welcome to Daily Dose.',
            style: TextStyle(),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(bottom: 1),
          child: Text(
            '0',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
        ),
      ],
    );
  }
}

class BottomContainer extends StatelessWidget {
  const BottomContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'No Medicine',
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 30, color: Colors.red),
    );
  }
}
