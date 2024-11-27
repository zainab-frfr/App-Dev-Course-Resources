import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_demo/authentication/services/auth_gate.dart';
import 'package:firebase_demo/firebase_options.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions
          .currentPlatform); 
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {

    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/authGate',
      routes: {
        '/authGate': (context) => const AuthGate(), //in lib>authentication>services
      },
    );
  }
}
