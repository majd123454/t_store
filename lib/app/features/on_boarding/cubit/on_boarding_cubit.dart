// ignore_for_file: depend_on_referenced_packages

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/helper/extensions.dart';
import '../../../core/routing/routes.dart';

part 'on_boarding_state.dart';

class OnBoardingCubit extends Cubit<OnBoardingState> {
  OnBoardingCubit() : super(OnBoardingInitial());
  final PageController pageController = PageController();
  int currentIndex = 0;
  void dotNavigationClicked(int index) {
    currentIndex = index;
    pageController.jumpToPage(index);
    emit(OnBoardingUpdateIndicator());
  }

  void goToNextPage(BuildContext context) {
    if (currentIndex != 2) {
      currentIndex++;

      pageController.jumpToPage(currentIndex);
      emit(OnBoardingUpdateIndicator());
    } else {
      context.pushNamed(Routes.login);
    }
  }

  void updatePageIndicator(int index) {
    currentIndex = index;
    emit(OnBoardingUpdateIndicator());
  }

  void skipPage() {
    currentIndex = 2;
    pageController.jumpToPage(currentIndex);
    emit(OnBoardingUpdateIndicator());
  }
}
