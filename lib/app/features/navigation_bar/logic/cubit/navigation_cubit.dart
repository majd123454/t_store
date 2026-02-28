

import 'package:dio/dio.dart';
import 'package:first_project/app/core/services/network/dio_client.dart';
import 'package:first_project/app/features/chat/ui/chat_screen.dart';
import 'package:first_project/app/features/favorites/ui/favorite_screen.dart';
import 'package:first_project/app/features/home/data/data_source_remote/product_remote_data_source.dart';
import 'package:first_project/app/features/home/data/repositories/product_repository_impl.dart';
import 'package:first_project/app/features/home/logic/cubit/product_cubit.dart';
import 'package:first_project/app/features/home/logic/use_cases/get_products_list_usecase.dart';
import 'package:first_project/app/features/home/ui/home_screen.dart';
import 'package:first_project/app/features/navigation_bar/logic/cubit/navigation_state.dart';
import 'package:first_project/app/features/profile/ui/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NavigationCubit extends Cubit<NavigationState>{
  NavigationCubit() : super(NavigationInitialState());

  final List<Widget> screens = [
    BlocProvider(create: (BuildContext context) 
      => ProductCubit(getProductsListUsecase: GetProductsListUsecase(productRepository: ProductRepositoryImpl(remoteDataSource: ProductRemoteDataSourceImpl(dio: DioClient()))))..getProducts(),
    
    child: HomeView()),
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