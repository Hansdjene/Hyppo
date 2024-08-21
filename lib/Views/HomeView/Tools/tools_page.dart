import 'package:flutter/material.dart';
import 'package:hyppo/Views/HomeView/Tools/ReminderView/home_reminder_page.dart';
import 'package:hyppo/Views/HomeView/Tools/tab_item.dart';

class ToolsPage extends StatefulWidget {
  const ToolsPage({super.key});

  @override
  State<ToolsPage> createState() => _ToolsPageState();
}

class _ToolsPageState extends State<ToolsPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Remplacé par 2 car vous avez deux onglets
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Tools',
            style: TextStyle(fontSize: 16),
          ),
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(20),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: Container(
                height: 40,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  color: Colors.green.shade100,
                ),
                child: const TabBar(
                  indicatorSize: TabBarIndicatorSize.tab,
                  dividerColor: Colors.transparent,
                  indicator: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.black54,
                  tabs: [
                    TabItem(title: 'Reminder', count: 6),
                    TabItem(title: 'Cycle', count: 3),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: const TabBarView(
          children: [
            HomeReminderPage(), // Page spécifique pour "Reminder"
            CyclePage(), // Page spécifique pour "Cycle"
          ],
        ),
      ),
    );
  }
}

// Exemple de page pour "Reminder"

// Exemple de page pour "Cycle"
class CyclePage extends StatelessWidget {
  const CyclePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cycle Page')),
      body: const Center(child: Text('Content of Cycle Page')),
    );
  }
}
