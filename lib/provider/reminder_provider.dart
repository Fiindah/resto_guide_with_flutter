import 'package:flutter/material.dart';
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

    if (value) {
      await _notificationService.scheduleDailyLunchReminder();
    } else {
      await _notificationService.cancelReminder();
    }
  }
}