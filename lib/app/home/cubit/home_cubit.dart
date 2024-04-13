import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test1/app/home/model/home_model.dart';
import 'package:test1/http_manager/http_manager.dart';
import '../../../http_manager/end_points.dart';
import 'home_states.dart';

class HomeCubit extends Cubit<HomeStates>{

  HomeCubit() : super(HomeInitialState());
  static HomeCubit get(context) => BlocProvider.of(context);


  int currentPage = 1;
  int totalPages = 1;

  Future<void> getUsers() async {
    emit(HomeLoadingState());
    try {
      final response = await Http.getData(
        path: getUsersPath,
        token: token,
        params: {'page': currentPage.toString()},
      );
      final data = jsonDecode(response.body);
      final newHomeModel = HomeModel.fromJson(data);
      if (homeModel == null) {
        homeModel = newHomeModel;
      } else {
        homeModel!.data!.addAll(newHomeModel.data!);
      }
      currentPage = newHomeModel.page!;
      totalPages = newHomeModel.totalPages!;
      emit(HomeSuccessState(homeModel: homeModel!));
    } catch (error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(HomeErrorState());
    }
  }


  Future<void> loadMoreUsers() async {
    if (currentPage < totalPages) {
      currentPage++;
      await getUsers();
    }
  }


  Future deleteUser(int userId) async{
    emit(DeleteUserLoadingState());
    Http.deleteData(
        path:'$deleteUsersPath$userId',
      token: token
    ).then((value) {
      emit(DeleteUserSuccessState());
      getUsers();
    }).catchError((error){
      emit(DeleteUserErrorState());
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }


  Future editUser({
    required int userId,
    required String name,
    required String job,
  }) async{
    emit(EditUserLoadingState());
    Http.editData(
        map: {
          "name":name,
          "job":job
        },
        path:'$editUsersPath$userId',
        token: token
    ).then((value) {
      emit(EditUserSuccessState());
    }).catchError((error){
      emit(EditUserErrorState());
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }

}