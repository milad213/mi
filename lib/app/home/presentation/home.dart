import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test1/app/home/cubit/home_cubit.dart';
import 'package:test1/app/home/cubit/home_states.dart';
import 'package:test1/prefrences_manager/prefrences_manager.dart';
import 'package:test1/resources/app_theme.dart';
import 'package:test1/resources/color_manager.dart';
import 'package:test1/resources/widgets.dart';
import '../../../http_manager/end_points.dart';
import '../../../resources/assets_manager.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: ColorManager.lightBlue,
      body: Column(
        children: [
          _homeAppBar(),
          _homeBody(),
        ],
      ),
    );
  }

  Widget _homeAppBar(){
    return Padding(
      padding: const EdgeInsets.only(bottom:25 ,left:10 ,top:20 ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Image.asset(
                      ImageAssets.wavingHand,
                      width: 25.w,
                      height: 20.h,
                    ),
                    Text(
                      'Hi there !',
                      style: textTheme.bodySmall,
                    )
                  ],
                ),
                Text(
                  'Have a nice day',
                  style: textTheme.bodySmall!.copyWith(color: ColorManager.black),
                )
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              'Home',
              style: textTheme.displaySmall,
            ),
          ),
        ],
      ),
    );
  }

  Widget _homeBody(){
    return Expanded(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(45),
              topRight: Radius.circular(45),
            ),
            color: ColorManager.primary,
          ),
          child: BlocConsumer<HomeCubit,HomeStates>(
            listener: (context, state) {
              if(state is DeleteUserSuccessState){
                showToast("user deleted successfully", ToastStates.Success);
              }else if(state is DeleteUserErrorState){
                showToast("error while deleting user", ToastStates.Error);
              }
              if(state is EditUserSuccessState){
                showToast("user edited successfully", ToastStates.Success);
                Navigator.pop(context);
              }
              else if(state is EditUserErrorState){
                showToast("error while editing user", ToastStates.Error);
              }
            },
            builder: (context, state) {
              TextEditingController newNameController = TextEditingController();
              TextEditingController newJobController = TextEditingController();
              var homeCubit = HomeCubit.get(context);

              if( state is HomeLoadingState) {
                return Center(child: CircularProgressIndicator(color: ColorManager.white,),);
              }else if(state is HomeSuccessState){
                PreferencesManager.setData(
                    value: homeModel!.toJson(),
                    key: 'home_model'
                );
                final ScrollController _scrollController = ScrollController();
                _scrollController.addListener(() {
                  if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
                    BlocProvider.of<HomeCubit>(context).loadMoreUsers();
                  }
                });
                return Padding(
                  padding:  EdgeInsets.all(30.dg),
                  child: ListView.separated(
                    controller: _scrollController,
                    itemBuilder: (context, index) => userCard(
                      imageUrl: '${homeModel!.data![index].avatar}',
                      firstName: '${homeModel!.data![index].firstName}',
                      lastName: '${homeModel!.data![index].lastName}',
                      email: '${homeModel!.data![index].email}',
                      homeCubit: homeCubit,
                      userId: homeModel!.data![index].id??1,
                      context: context,
                      newNameController: newNameController,
                      newJobController: newJobController,
                    ),
                    separatorBuilder: (context, index) =>  SizedBox(height: 10.h),
                    itemCount: homeModel!.data!.length,
                  ),
                );
              }
              else{
                return Container();
              }
            },
          ),
        )
    );
  }
}
