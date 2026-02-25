import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resto_app/provider/reminder_provider.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

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
                  style: theme.textTheme.titleMedium,
                ),
                const SizedBox(height: 12),
                Consumer<ReminderProvider>(
                  builder: (context, reminderProvider, _) {
                    return Material(
                      elevation: 2,
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: theme.cardColor,
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          leading: CircleAvatar(
                            backgroundColor:
                                colorScheme.primary.withOpacity(0.1),
                            child: Icon(
                              Icons.notifications_active,
                              color: colorScheme.primary,
                            ),
                          ),
                          title: Text(
                            "Daily Lunch Reminder",
                            style: theme.textTheme.titleMedium,
                          ),
                          subtitle: Text(
                            "Rekomendasi restoran setiap jam 11:00",
                            style: theme.textTheme.bodyMedium,
                          ),
                          trailing: Switch.adaptive(
                            activeColor: colorScheme.primary,
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