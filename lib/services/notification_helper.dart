import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationHelper {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    const AndroidInitializationSettings androidInit =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initSettings =
        InitializationSettings(android: androidInit);

    await flutterLocalNotificationsPlugin.initialize(initSettings);
  }

  static Future<void> showRandomRestaurantNotification() async {
    await init(); // WAJIB untuk background isolate

    final response = await http.get(
      Uri.parse('https://restaurant-api.dicoding.dev/list'),
    );

    final data = jsonDecode(response.body);
    final List restaurants = data['restaurants'];

    final randomRestaurant =
        restaurants[Random().nextInt(restaurants.length)];

    final String name = randomRestaurant['name'];
    final String city = randomRestaurant['city'];
    final double rating = (randomRestaurant['rating'] as num).toDouble();

    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'channel_01',
      'Restaurant Recommendation',
      channelDescription: 'Daily restaurant recommendation',
      importance: Importance.high,
      priority: Priority.high,
    );

    const NotificationDetails details =
        NotificationDetails(android: androidDetails);

    await flutterLocalNotificationsPlugin.show(
      1,
      '🍽️ Rekomendasi Makan Siang',
      '$name ⭐ $rating - $city',
      details,
    );
  }
}