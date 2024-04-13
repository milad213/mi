import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test1/app/login/cubit/login_cubit.dart';
import 'package:test1/app/login/cubit/login_states.dart';
import 'package:test1/resources/app_theme.dart';
import 'package:test1/resources/color_manager.dart';
import 'package:test1/resources/widgets.dart';
import '../../../http_manager/end_points.dart';
import '../../../prefrences_manager/prefrences_manager.dart';
import '../../../resources/routes_manager.dart';

class Login extends StatelessWidget {
   Login({super.key});
  final TextEditingController emailController=TextEditingController();
  final TextEditingController passwordController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
                ColorManager.primary,
                ColorManager.lightBlue,
              ]
          ),
        ),
        child: _loginUi() ,
      ),
    );
  }

  Widget _loginUi(){
    return Padding(
      padding: const EdgeInsets.all(50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome\nBack !',
            style: textTheme.displayLarge!.copyWith(height: 1.1.sp),
          ),
           SizedBox(
            height: 20.h,
          ),
          Text(
            'sign in to accesses your data and manage your tasks effectively !',
            style: textTheme.titleLarge,
          ),
           SizedBox(
            height: 70.h,
          ),
          myBar(
              prefixIcon: Icon(
                Icons.email_outlined,
                color: ColorManager.grey,
              ),
              hint: 'email',
              hintStyle: textTheme.titleLarge!.copyWith(color: ColorManager.lightGrey),
            controller: emailController
          ),
           SizedBox(height: 20.h,),
          myBar(
            prefixIcon: Icon(
              Icons.lock_outline_rounded,
              color: ColorManager.grey,
            ),
            hint: 'password',
            hintStyle: textTheme.titleLarge!.copyWith(color: ColorManager.lightGrey),
            suffixIcon: Icon(
              Icons.visibility_off,
              color: ColorManager.black,
            ),
            controller: passwordController,
          ),
           SizedBox(height: 50.h,),
          BlocConsumer<LoginCubit,LoginStates>(
              listener: (context, state) {
                if(state is LoginSuccessState){
                  showToast(
                      'you logged in successfully',
                      ToastStates.Success
                  );
                  PreferencesManager.setData(
                    key: 'api_token',
                    value:state.token,
                  ).then((value) {
                    token = state.token;
                      Navigator.pushReplacementNamed(context, Routes.homeRoute);
                  }).catchError((error){
                    if (kDebugMode) {
                      print(error.toString());
                    }
                  });
                }else if(state is LoginErrorState){
                  showToast(
                      state.message,
                      ToastStates.Error,
                  );
                }
              },
            builder: (context, state) {
                var loginCubit = LoginCubit.get(context);
              return button((){
                state is !LoginLoadingState ? loginCubit.login(
                    email: emailController.text,
                    password: passwordController.text
                ): const Center(child: CircularProgressIndicator(),);
              },
                'Login'
              );
            },
          ),
           SizedBox(height: 10.h,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RichText(
                text: TextSpan(
                    text: 'Don’t have an account ? ',
                    style: textTheme.bodyLarge,
                    children: [
                      TextSpan(
                        text: 'Sign up',
                        style: textTheme.bodyLarge!.copyWith(
                            color: ColorManager.primary,
                          fontWeight: FontWeight.w900
                        ),
                      )
                   ]
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
