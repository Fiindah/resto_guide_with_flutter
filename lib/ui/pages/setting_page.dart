import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resto_app/provider/reminder_provider.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final reminderProvider = Provider.of<ReminderProvider>(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        elevation: 0,
      ),
      body: ListView(
        children: [
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Notifications",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.indigo,
                      ),
                ),
                const SizedBox(height: 12),
                Consumer<ReminderProvider>(
                  builder: (context, reminderProvider, _) {
                    return Material(
                      elevation: 2,
                      shadowColor: Colors.black12,
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.white,
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          leading: CircleAvatar(
                            backgroundColor: Colors.indigo.shade50,
                            child: const Icon(
                              Icons.notifications_active,
                              color: Colors.indigo,
                            ),
                          ),
                          title: const Text(
                            "Daily Lunch Reminder",
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          subtitle: const Text(
                            "Rekomendasi restoran setiap jam 11:00",
                            style: TextStyle(fontSize: 13),
                          ),
                          trailing: Switch.adaptive( // Mengikuti gaya iOS/Android
                            activeColor: Colors.indigo,
                            value: reminderProvider.isReminderOn,
                            onChanged: (value) {
                              reminderProvider.toggleReminder(value);
                            },
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}