import 'package:flutter/material.dart';
import 'package:katoapp/constants/app_constants.dart';
import 'package:katoapp/services/auth_service.dart';
import 'package:katoapp/screens/supplier/supplier_dashboard.dart';
import 'package:katoapp/screens/warehouse/warehouse_dashboard.dart';
import 'package:katoapp/screens/management/management_dashboard.dart';
import 'package:katoapp/utils/theme.dart';

class MainDashboard extends StatefulWidget {
  const MainDashboard({super.key});

  @override
  State<MainDashboard> createState() => _MainDashboardState();
}

class _MainDashboardState extends State<MainDashboard> {
  final AuthService _authService = AuthService();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final user = _authService.currentUser;
    
    if (user == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    // Return appropriate dashboard based on user role
    if (_authService.isSupplier) {
      return const SupplierDashboard();
    } else if (_authService.isWarehouse) {
      return const WarehouseDashboard();
    } else if (_authService.isManagement) {
      return const ManagementDashboard();
    }

    // Fallback dashboard for unknown roles
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: Text('Dashboard - ${user.name}'),
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await _authService.logout();
              if (mounted) {
                Navigator.pushReplacementNamed(context, AppConstants.loginRoute);
              }
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.person,
              size: 100,
              color: AppTheme.primaryColor,
            ),
            const SizedBox(height: 24),
            Text(
              'Selamat Datang, ${user.name}!',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: AppTheme.textPrimaryColor,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              'Role: ${user.role}',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppTheme.textSecondaryColor,
              ),
            ),
            const SizedBox(height: 32),
            Text(
              'Dashboard untuk role ini sedang dalam pengembangan',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppTheme.textSecondaryColor,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
