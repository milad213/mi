import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test1/app/login/cubit/login_cubit.dart';
import 'package:test1/app/login/cubit/login_states.dart';
import 'package:test1/http_manager/http_manager.dart';

import 'login_test_ui.dart';






///Test Login Functionality
void main() {
  // ...

  testWidgets('Login functionality', (WidgetTester tester) async {
    final mockLoginCubit = MockLoginCubit();
    when(mockLoginCubit.state).thenReturn(LoginInitialState());

    await tester.pumpWidget(MaterialApp(
      home: BlocProvider<LoginCubit>(
        create: (context) => mockLoginCubit,
        child: Login(),
      ),
    ));

    // Simulate user input
    await tester.enterText(find.byType(TextField).first, 'test@example.com');
    await tester.enterText(find.byType(TextField).last, 'password123');

    // Simulate login button press
    await tester.tap(find.text('Login'));
    await tester.pumpAndSettle();

    // Verify login method is called with correct parameters
    verify(mockLoginCubit.login(email: 'test@example.com', password: 'password123')).called(1);
  });
}


