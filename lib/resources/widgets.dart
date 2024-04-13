import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:test1/app/home/cubit/home_cubit.dart';
import 'package:test1/resources/app_theme.dart';
import 'package:test1/resources/color_manager.dart';

Widget myBar({
  required Widget prefixIcon,
  required String hint,
  required TextStyle? hintStyle,
  required TextEditingController controller,
  Widget? suffixIcon,
}) {
  return myContainer(
    child: TextFormField(
      style: textTheme.titleLarge,
      controller: controller,
      decoration: InputDecoration(
        border: InputBorder.none,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        hintText: hint,
        hintStyle: hintStyle,
      ),
    ),
  );
}

Widget myContainer({
  required Widget child,
  double horizontalPadding = 10,
  double verticalPadding = 5,
}) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(35),
      color: ColorManager.white,
    ),
    padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding, vertical: verticalPadding),
    child: child,
  );
}

Widget button(function, String text) {
  return GestureDetector(
    onTap: function,
    child: myContainer(
      verticalPadding: 10,
      child: Center(
        child: Text(
          text,
          style: textTheme.displayMedium!.copyWith(color: ColorManager.primary),
        ),
      ),
    ),
  );
}

void showToast(String message, ToastStates state) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 3,
      webBgColor: chooseWebToastColor(state),
      webPosition: 'center',
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0);
}

Color chooseToastColor(ToastStates state) {
  switch (state) {
    case ToastStates.Success:
      return Colors.green;
    case ToastStates.Warning:
      return Colors.yellow;
    case ToastStates.Error:
      return Colors.red;
  }
}

String chooseWebToastColor(ToastStates state) {
  switch (state) {
    case ToastStates.Success:
      return 'green';
    case ToastStates.Warning:
      return 'yellow';
    case ToastStates.Error:
      return 'red';
  }
}

enum ToastStates { Success, Error, Warning }

Widget userCard({
  required String imageUrl,
  required String firstName,
  required String lastName,
  required String email,
  required Cubit homeCubit,
  required int userId,
  required BuildContext context,
  required TextEditingController newNameController,
  required TextEditingController newJobController,
}) {
  return Container(
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25), color: ColorManager.lightBlue),
    child: Row(
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    imageUrl,
                  ))),
        ),
        const SizedBox(width: 5),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              firstName,
              style: textTheme.labelLarge!.copyWith(color: ColorManager.grey),
            ),
            Text(
              lastName,
              style: textTheme.labelLarge!.copyWith(color: ColorManager.grey),
            ),
            Text(
              email,
              style: textTheme.labelLarge,
            ),
          ],
        ),
        const Spacer(),
        Column(
          children: [
            IconButton(
                onPressed: () {
                  (homeCubit as HomeCubit).deleteUser(userId);
                },
                icon: const Icon(Icons.delete)),
            IconButton(
                onPressed: () {
                  myAlertDialog(
                      context: context,
                      newNameController: newNameController,
                      newJobController: newJobController,
                      homeCubit: homeCubit,
                      userId: userId);
                },
                icon: const Icon(Icons.edit)),
          ],
        )
      ],
    ),
  );
}

myAlertDialog({
  required BuildContext context,
  required TextEditingController newNameController,
  required TextEditingController newJobController,
  required Cubit homeCubit,
  required int userId,
}) {
  showDialog(
    context: context,
    builder: (context) {
      return Material(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Container(
            padding: const EdgeInsets.all(20),
            color: ColorManager.grey,
            child: Column(
              children: [
                Text(
                  'Enter new data',
                  style: textTheme.displayMedium,
                ),
                const SizedBox(
                  height: 10,
                ),
                myBar(
                    prefixIcon: const Icon(Icons.person),
                    hint: 'new name',
                    hintStyle: textTheme.bodySmall,
                    controller: newNameController),
                const SizedBox(
                  height: 10,
                ),
                myBar(
                    prefixIcon: const Icon(Icons.work_history_outlined),
                    hint: 'new work',
                    hintStyle: textTheme.bodySmall,
                    controller: newJobController),
                const SizedBox(
                  height: 10,
                ),
                button(() {
                  (homeCubit as HomeCubit).editUser(
                      userId: userId,
                      name: newNameController.text,
                      job: newJobController.text);
                }, 'edit')
              ],
            ),
          ),
        ),
      );
    },
  );
}
