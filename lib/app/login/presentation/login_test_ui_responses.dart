import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'login.dart';

import 'package:mockito/mockito.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test1/app/login/cubit/login_cubit.dart';
import 'package:test1/app/login/cubit/login_states.dart';

import 'login_test_ui.dart';





///Test UI Responses to Login States
void main() {
  // ...

  testWidgets('UI responds to LoginSuccessState', (WidgetTester tester) async {
    final mockLoginCubit = MockLoginCubit();
    when(mockLoginCubit.state).thenReturn(LoginSuccessState( 'test_token'));

    await tester.pumpWidget(MaterialApp(
      home: BlocProvider<LoginCubit>(
        create: (context) => mockLoginCubit,
        child: Login(),
      ),
    ));

    // Check for success message
    expect(find.text('you logged in successfully'), findsOneWidget);
  });

  testWidgets('UI responds to LoginErrorState', (WidgetTester tester) async {
    final mockLoginCubit = MockLoginCubit();
    when(mockLoginCubit.state).thenReturn(LoginErrorState( 'Invalid credentials'));

    await tester.pumpWidget(MaterialApp(
      home: BlocProvider<LoginCubit>(
        create: (context) => mockLoginCubit,
        child: Login(),
      ),
    ));

    // Check for error message
    expect(find.text('Invalid credentials'), findsOneWidget);
  });
}

