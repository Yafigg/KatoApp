import 'package:flutter/material.dart';
import 'package:katoapp/screens/auth/login_screen.dart';
import 'package:katoapp/screens/auth/register_screen.dart';
import 'package:katoapp/screens/splash_screen.dart';
import 'package:katoapp/screens/dashboard/main_dashboard.dart';
import 'package:katoapp/screens/supplier/supplier_dashboard.dart';
import 'package:katoapp/utils/theme.dart';

void main() {
  runApp(const KatoApp());
}

class KatoApp extends StatelessWidget {
  const KatoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kato Apps',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const SplashScreen(),
      routes: {
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/dashboard': (context) => const MainDashboard(),
        '/supplier-dashboard': (context) => const SupplierDashboard(),
      },
    );
  }
}
