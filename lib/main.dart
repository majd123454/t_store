import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:first_project/app/core/services/notifications/firebase_cloud_messaging.dart';
import 'package:first_project/shop.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'app/core/di/service_locator.dart';
import 'app/core/routing/app_routes.dart';
import 'app/core/services/supabase/supabase_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // env
  await dotenv.load(fileName: '.env');

  // Firebase
  await Firebase.initializeApp();

  // Supabase
  await SupabaseService.initialize();

  // DI
  await setupServiceLocator();

  // Notifications
  await NotificationService.instance.initializeNotifications();

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  runApp(ShopApp(appRoutes: AppRoutes()));
}