import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hedieaty/View/login_page.dart';
import 'package:hedieaty/main.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group("end_to_end", () {
    testWidgets("login", (tester) async{
      await fireBaseInit();
      //await dataBaseInit();
      await tester.pumpWidget(MaterialApp(home: LoginScreen()));
      await tester.enterText(find.byType(TextFormField).at(0), "seif@gmail.com");
      await tester.enterText(find.byType(TextFormField).at(1), "123456789");
      await tester.pump();
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle(Duration(seconds: 2));
      expect(find.byIcon(Icons.person_add_alt_1), findsOneWidget);
      await tester.enterText(find.byType(TextField), "a");
      await tester.pump(Duration(seconds: 5));
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump(Duration(seconds: 5));
      expect(find.byType(Card), findsOneWidget);
      // await tester.tap(find.byIcon(Icons.person_add_alt_1));
      // await tester.pumpAndSettle(Duration(seconds: 2));
      // await tester.enterText(find.byType(TextFormField), "d@gmail.com");
      // await tester.pump(Duration(seconds: 2));
      // await tester.tap(find.text("ADD"));
      // await tester.pumpAndSettle();
      // await tester.pumpAndSettle();
      // await tester.pumpAndSettle();
      // expect(find.byType(Card), findsNWidgets(4));
    });
  });

}
