import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  static const String _reminderKey = 'DAILY_REMINDER';

  Future<void> setReminder(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_reminderKey, value);
  }

  Future<bool> getReminder() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_reminderKey) ?? false;
  }
}