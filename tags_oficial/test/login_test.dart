// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:tags_oficial/pages/login.dart';

// void main() {
//   // Define a test. The TestWidgets function also provides a WidgetTester
//   // to work with. The WidgetTester allows you to build and interact
//   // with widgets in the test environment.
//   testWidgets('Login test ', (WidgetTester tester) async {
//     await tester.pumpWidget(Login());

//     final pass = 123;
//     final user = 'Eduardo';
//     final form1 = find.text('Usuario');
//     final form2 = find.text('Contraseña');
//     final EditableText formfield =
//         tester.widget<EditableText>(find.text('Usuario'));
//     final EditableText formfield2 =
//         tester.widget<EditableText>(find.text('Usuario'));
//     final buttonFinder = find.text('INICIAR SESION');
//     await tester.tap(find.byWidget(Text('INICIAR SESION')));
//     await tester.pump();
//     // Verify the counter starts at 0.
//     expect(find.text('0'), findsOneWidget);

//     // // Emulate a tap on the floating action button.
//     // await tester.tap(fab);

//     // // Trigger a frame.
//     // await tester.pumpAndSettle();

//     // expect(find.text('1'), findsOneWidget);

//     expect(pass, findsOneWidget);
//     expect(user, findsOneWidget);
//     expect(formfield.maxLines, 2);
//     expect(formfield2.maxLines, 2);
//   });
// }


// /*
// void main() {
//   IntegrationTestWidgetsFlutterBinding.ensureInitialized();

//   group('end-to-end test', () {
//     testWidgets('tap on the floating action button, verify counter',
//         (WidgetTester tester) async {
//       app.main();
//       await tester.pumpAndSettle();

//       // Verify the counter starts at 0.
//       expect(find.text('0'), findsOneWidget);

//       // Finds the floating action button to tap on.
//       final Finder fab = find.byTooltip('Increment');

//       // Emulate a tap on the floating action button.
//       await tester.tap(fab);

//       // Trigger a frame.
//       await tester.pumpAndSettle();

//       // Verify the counter increments by 1.
//       expect(find.text('1'), findsOneWidget);
//     });
//   });
// }

// */