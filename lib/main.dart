import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:news_app/app/core/di/service_locator.dart';
import 'package:news_app/app/core/routing/app_routes.dart';
import 'package:news_app/app/core/services/supabase/supabase_service.dart';
import 'package:news_app/shop.dart';

void main() async {
  // Load environment variables
  await dotenv.load(fileName: '.env');

  // Initialize Supabase
  await SupabaseService.initialize();

  // Setup dependency injection (new Supabase-based services)
  await setupServiceLocator();

  runApp(ShopApp(appRoutes: AppRoutes()));
}
