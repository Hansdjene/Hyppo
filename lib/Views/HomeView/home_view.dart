import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hyppo/Views/HomeView/Tools/tools_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  // Liste des pages spécifiques
  static final List<Widget> _screens = [
    AppointmentPage(), // Page des rendez-vous
    ToolsPage(), // Page des rappels
    NotifPage(), // Page des notifications
    ProfilePage(), // Page du profil
    MapPage(), // Page de la carte, pour le bouton flottant
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var brightness = Theme.of(context).brightness;
    var isDarkMode = brightness == Brightness.dark;

    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            buildNavBarItem(
              CupertinoIcons.waveform_path_badge_plus,
              'Appointment',
              0,
              isDarkMode,
            ),
            buildNavBarItem(
                CupertinoIcons.rectangle_fill_on_rectangle_angled_fill,
                'Tools',
                1,
                isDarkMode),
            const SizedBox(
              width: 30,
            ),
            buildNavBarItem(
                CupertinoIcons.bell_fill, 'Notification', 2, isDarkMode),
            buildNavBarItem(
                CupertinoIcons.person_solid, 'Profile', 3, isDarkMode),
          ],
        ),
      ),
      floatingActionButton: ClipOval(
        child: Material(
          color: Colors.green,
          elevation: 10,
          child: InkWell(
            onTap: () => _onItemTapped(4), // Indice de la page de la carte
            child: SizedBox(
              width: 56,
              height: 56,
              child: Icon(
                CupertinoIcons.location_north_fill,
                size: 28,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget buildNavBarItem(
      IconData icon, String label, int index, bool isDarkMode) {
    return InkWell(
      onTap: () => _onItemTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: _selectedIndex == index
                ? Colors.green
                : (isDarkMode ? Colors.white : Colors.black),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: _selectedIndex == index
                  ? Colors.green
                  : (isDarkMode ? Colors.white : Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}

// Voici des exemples de pages spécifiques à utiliser dans l'application
class AppointmentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Appointment')),
      body: Center(child: Text('Appointment Page')),
    );
  }
}

class NotifPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Notifications')),
      body: Center(child: Text('Notification Page')),
    );
  }
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: Center(child: Text('Profile Page')),
    );
  }
}

class MapPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Map')),
      body: Center(child: Text('Map Page')),
    );
  }
}
