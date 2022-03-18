import 'package:change_theme/home_page.dart';
import 'package:change_theme/login_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class ThemeService with ChangeNotifier {
  bool isDarkTheme = false;
  static final ThemeData themeA =
      ThemeData.light(); //.copyWith(scaffoldBackgroundColor: Colors.white);
  static final ThemeData themeB =
      ThemeData.dark(); //.copyWith(scaffoldBackgroundColor: Colors.black);

  ThemeData _currentTheme = themeA;

  get currentTheme => _currentTheme;

  switchToLightTheme() {
    _currentTheme = themeA;
    notifyListeners();
  }

  switchToDarkTheme() {
    _currentTheme = themeB;
    notifyListeners();
  }

  changeTheme() {
    isDarkTheme = !isDarkTheme;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // @override
  // Widget build(BuildContext context) {
  //   return MaterialApp(
  //     theme: Theme.of(context),
  //     debugShowCheckedModeBanner: false,
  //     home: const LoginPage(),
  //     // initialRoute: '/',
  //     // routes: {
  //     //   '/': (context) => const LoginPage(),
  //     //   '/home': (context) => const HomePage(),
  //     // },
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => ThemeService(),
        child: Builder(builder: (BuildContext context) {
          ThemeService themeService = Provider.of<ThemeService>(context);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: themeService._currentTheme,
            home: LoginPage(),
          );
        }));
  }
}

// class MyApp extends StatelessWidget {
//   static const String _title = 'Flutter Code Sample';

//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//         create: (_) => ThemeService(),
//         child: Builder(builder: (BuildContext context) {
//           ThemeService themeService = Provider.of<ThemeService>(context);
//           return MaterialApp(
//             theme: themeService._currentTheme,
//             title: _title,
//             home: const HomePage(),
//           );
//         }));
//   }
// }


