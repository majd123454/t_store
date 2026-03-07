import 'package:first_project/app/core/di/service_locator.dart';
import 'package:first_project/app/features/chat/logic/cubit/chat_cubit.dart';
import 'package:first_project/app/features/chat/ui/chat_screen.dart';
import 'package:first_project/app/features/favorites/ui/favorite_screen.dart';
import 'package:first_project/app/features/home/logic/cubit/product_cubit.dart';
import 'package:first_project/app/features/home/ui/home_screen.dart';
import 'package:first_project/app/features/navigation_bar/logic/cubit/navigation_state.dart';
import 'package:first_project/app/features/settings/ui/settings_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class NavigationCubit extends Cubit<NavigationState>{
  NavigationCubit() : super(NavigationInitialState());

    late final List<Widget> screens;


  void initializeScreensList() {
    final currentUser = Supabase.instance.client.auth.currentUser;
    final currentUserId = currentUser!.id;

    screens = [
      BlocProvider(create: (BuildContext context) => sl<ProductCubit>()..getProducts(),
      child: const HomeView()),
      BlocProvider(
        create: (_) => ChatCubit(repository: sl())
          ..startListening()
          ..getMessages(currentUserId),
        child: const ChatScreen(),
      ),
      const WishlistView(),
      const SettingsView(),
    ];
  }

  int selectedIndex = 0;

  void updateSelectedIndex(int index) 
  {
      selectedIndex = index;
      emit(ChangeSelectedIndex(selectedIndex));
  }

  Widget getScreen(int index) {
    return screens[index];
  }
}