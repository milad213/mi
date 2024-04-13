import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test1/app/login/cubit/login_states.dart';
import 'package:test1/http_manager/end_points.dart';
import 'package:test1/http_manager/http_manager.dart';
import '../model/login_model.dart';

class LoginCubit extends Cubit<LoginStates>{

  LoginCubit() : super(LoginInitialState());
  static LoginCubit get(context) => BlocProvider.of(context);

  late LoginModel loginModel;
  Future login({
    required String email,
    required String password,
}) async {
    emit(LoginLoadingState());
    Http.postData(
        path: loginPath,
        map: {
          "email":email,
          "password":password,
        }
    ).then((value) {
      var response = jsonDecode(value.body);
      loginModel = LoginModel.fromJson(response);
      var responseToken = response['token'];
      emit(LoginSuccessState(responseToken));
    }).catchError((error){
      var errorJson = jsonDecode(error.toString());
      var errorMessage = errorJson['error'];
      loginModel = LoginModel.fromJson(errorJson);
      emit(LoginErrorState(errorMessage));
    });
  }
}