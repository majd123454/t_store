

import 'package:first_project/app/features/chat/ui/chat_screen.dart';
import 'package:first_project/app/features/favorites/ui/favorite_screen.dart';
import 'package:first_project/app/features/home/ui/home_screen.dart';
import 'package:first_project/app/features/navigation_bar/logic/cubit/navigation_state.dart';
import 'package:first_project/app/features/profile/ui/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NavigationCubit extends Cubit<NavigationState>{
  NavigationCubit() : super(NavigationInitialState());

  final List<Widget> screens = [
    HomeScreen(),
    ChatScreen(),
    FavoriteScreen(),
    ProfileScreen(),
  ];

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