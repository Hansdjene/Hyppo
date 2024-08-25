import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hyppo/Components/color.dart';
import 'package:hyppo/Views/HomeView/Tools/ReminderView/Models/global_bloc.dart';
import 'package:hyppo/Views/HomeView/Tools/ReminderView/medicine.dart';
import 'package:hyppo/Views/HomeView/Tools/ReminderView/medicine_details.dart';
import 'package:hyppo/Views/HomeView/Tools/ReminderView/new_entry_page.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

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
              height: 25,
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
    final GlobalBloc globalBloc = Provider.of<GlobalBloc>(context);
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
            style: TextStyle(color: Colors.grey),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        StreamBuilder<List<Medicine>>(
          builder: (context, snapshot) {
            return Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(bottom: 1),
              child: Text(
                snapshot.hasData ? '0' : snapshot.data.length.toString(),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
            );
          },
          stream: null,
        ),
      ],
    );
  }
}

class BottomContainer extends StatelessWidget {
  const BottomContainer({super.key});

  @override
  Widget build(BuildContext context) {
    // return Text(
    //   'No Medicine',
    //   textAlign: TextAlign.center,
    //   style: TextStyle(fontSize: 30, color: Colors.red),
    //);
    return GridView.builder(
      padding: EdgeInsets.only(top: 1),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: 5, // Nombre d'éléments à afficher dans la grille
      itemBuilder: (context, index) {
        return MedicineCard();
      },
    );
  }
}

class MedicineCard extends StatelessWidget {
  const MedicineCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      highlightColor: Colors.white,
      splashColor: Color.fromARGB(80, 76, 175, 79),
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => MedicineDetails()));
      },
      child: Container(
        padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 15),
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            SvgPicture.asset(
              'assets/icons/capsules.svg',
              height: 55,
              color: Colors.green,
            ),
            Spacer(),
            Text(
              'Calpol',
              textAlign: TextAlign.start,
              overflow: TextOverflow.fade,
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge!
                  .copyWith(fontSize: 20),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              'Every 8 hours',
              textAlign: TextAlign.start,
              overflow: TextOverflow.fade,
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge!
                  .copyWith(fontSize: 12, color: Colors.grey),
            )
          ],
        ),
      ),
    );
  }
}
