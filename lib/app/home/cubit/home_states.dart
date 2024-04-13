import '../model/home_model.dart';

abstract class HomeStates{}

class HomeInitialState extends HomeStates{}
class HomeLoadingState extends HomeStates{}
class HomeSuccessState extends HomeStates{
  final HomeModel homeModel;

  HomeSuccessState({required this.homeModel});
}
class HomeErrorState extends HomeStates{}


class DeleteUserLoadingState extends HomeStates{}
class DeleteUserSuccessState extends HomeStates{}
class DeleteUserErrorState extends HomeStates{}


class EditUserLoadingState extends HomeStates{}
class EditUserSuccessState extends HomeStates{}
class EditUserErrorState extends HomeStates{}