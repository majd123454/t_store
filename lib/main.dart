import 'package:first_project/shop.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'app/core/di/service_locator.dart';
import 'app/core/routing/app_routes.dart';
import 'app/core/services/supabase/supabase_service.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized(); 
  // Load environment variables
  await dotenv.load(fileName: '.env');

  // Initialize Supabase
  await SupabaseService.initialize();

  // Setup dependency injection (new Supabase-based services)
  await setupServiceLocator();

  runApp(ShopApp(appRoutes: AppRoutes()));
}
