import 'package:flutter/material.dart';
import 'package:localizacionversion2/screens/check_auth_screen.dart';

import 'package:localizacionversion2/screens/sceens.dart';
import 'package:localizacionversion2/services/auth_service.dart';
import 'package:localizacionversion2/services/service.dart';
import 'package:provider/provider.dart';

void main() => runApp(const AppState());

class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => AuthService()),
    ], child: MyApp());
  }
}

// ignore: use_key_in_widget_constructors
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "GeoRuta",
      debugShowCheckedModeBanner: false,
      initialRoute: 'checking',
      routes: {
        'login': (BuildContext context) => const LoginPage(),
        'home': (BuildContext context) => const HomePage(),
        'checking': (_) => const CheckAuthScreen(),
      },
      scaffoldMessengerKey: NotificationService.messengerKey,
      theme:
          ThemeData.light().copyWith(scaffoldBackgroundColor: Colors.grey[300]),
    );
  }
}
