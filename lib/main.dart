import 'package:flutter/material.dart';
import 'package:flutter_pekmi/providers/auth.dart';
import 'package:provider/provider.dart';

import './screens/login_screen.dart';
import './screens/home_screen.dart';
import './screens/loading_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(
          create: (_) => AuthProvider(),
        )
      ],
      child: Consumer<AuthProvider>(builder: (context, auth, _) {
        return MaterialApp(
          key: Key('auth_${auth.isAuthenticated}'),
          title: 'Silat Club',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: auth.isAuthenticated
              ? HomeScreen()
              : FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder: (context, snapshot) =>
                      snapshot.connectionState == ConnectionState.waiting
                          ? LoadingScreen()
                          : LoginScreen(),
                ),
          routes: {
            '/home': (context) => null,
            '/shop': (context) => null,
            '/event': (context) => null,
          },
        );
      }),
    );
  }
}
