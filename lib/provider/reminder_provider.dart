import 'package:flutter/material.dart';
import 'package:workmanager/workmanager.dart';
import '../services/preferences_service.dart';
import '../services/notification_service.dart';

class ReminderProvider extends ChangeNotifier {
  bool _isReminderOn = false;

  bool get isReminderOn => _isReminderOn;

  final PreferencesService _preferencesService = PreferencesService();
  final NotificationService _notificationService = NotificationService();

  Future<void> loadReminder() async {
    _isReminderOn = await _preferencesService.getReminder();
    notifyListeners();
  }

  Future<void> toggleReminder(bool value) async {
    _isReminderOn = value;
    notifyListeners();

    await _preferencesService.setReminder(value);

    // if (value) {
    //   await _notificationService.scheduleDailyLunchReminder();
    // } else {
    //   await _notificationService.cancelReminder();
    // }
    if (value) {
      await scheduleDailyTask();
    } else {
      await Workmanager().cancelAll();
    }
  }

  Future<void> scheduleDailyTask() async {
    await Workmanager().registerPeriodicTask(
      "1",
      "dailyReminderTask",
      frequency: const Duration(hours: 24),
      initialDelay: _calculateInitialDelay(),
    );
  }

  Duration _calculateInitialDelay() {
    final now = DateTime.now();
    final scheduled = DateTime(now.year, now.month, now.day, 11);

    if (now.isAfter(scheduled)) {
      return scheduled.add(const Duration(days: 1)).difference(now);
    } else {
      return scheduled.difference(now);
    }
  }
}
