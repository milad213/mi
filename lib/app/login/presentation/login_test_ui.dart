import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'login.dart';
import 'package:mockito/mockito.dart';
import 'package:test1/app/login/cubit/login_cubit.dart';



///Test UI Rendering
class MockLoginCubit extends Mock implements LoginCubit {}
void main() {
  testWidgets('Login page UI elements are rendered', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: Login()));

    expect(find.text('Welcome\nBack !'), findsOneWidget);
    expect(find.text('sign in to accesses your data and manage your tasks effectively !'), findsOneWidget);
    expect(find.byIcon(Icons.email_outlined), findsOneWidget);
    expect(find.byIcon(Icons.lock_outline_rounded), findsOneWidget);
    expect(find.text('Login'), findsOneWidget);
    expect(find.text('Don’t have an account ? Sign up'), findsOneWidget);
  });
}



