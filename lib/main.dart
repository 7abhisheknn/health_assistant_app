import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:health_assistant_app/pages/auth_page.dart';
import 'package:health_assistant_app/pages/home_page.dart';
import 'package:health_assistant_app/pages/tabs.dart';
import 'package:health_assistant_app/providers/theme_provider.dart';
import 'package:health_assistant_app/widgets/backgrounds/auth_background.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const Providers());
}

/// widget for all Providers
class Providers extends StatelessWidget {
  const Providers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const HAA(),
    );
  }
}

class HAA extends StatelessWidget {
  const HAA({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeProvider theme = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      title: 'Health Assistant',
      theme: theme.appTheme[theme.currentTheme], // user's default theme
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.idTokenChanges(),
        builder: (context, snapshot) {
          return snapshot.hasData ? const Tabs() : const AuthBackground();
        },
      ),
      routes: {
        '/home_page': (context) => const HomePage(),
        '/auth_page': (context) => const AuthPage(),
      },
    );
  }
}
