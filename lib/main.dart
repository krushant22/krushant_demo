import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krushant_demo/routes/routes.dart';
import 'package:krushant_demo/theme/get_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyAwDnn7hrQBoKSILRydj0MQp5LN2aZR5t4",
            authDomain: "myprofiledemo-66571.firebaseapp.com",
            projectId: "myprofiledemo-66571",
            storageBucket: "myprofiledemo-66571.appspot.com",
            messagingSenderId: "578654838537",
            appId: "1:578654838537:web:4a2126f44934245b8d7dd8",
            measurementId: "G-54EFTYBDPT"));
  } else {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyAwDnn7hrQBoKSILRydj0MQp5LN2aZR5t4",
            authDomain: "myprofiledemo-66571.firebaseapp.com",
            projectId: "myprofiledemo-66571",
            storageBucket: "myprofiledemo-66571.appspot.com",
            messagingSenderId: "578654838537",
            appId: "1:578654838537:web:4a2126f44934245b8d7dd8",
            measurementId: "G-54EFTYBDPT"));
  }
  CustomGetXTheme.systemChromeStyle;
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: CustomGetXTheme.lightTheme,
      darkTheme: CustomGetXTheme.lightTheme,
      getPages: ApplicationRoutes.generateRoutes,
      initialRoute: ApplicationRoutes.initialRoutes,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
    );
  }
}
