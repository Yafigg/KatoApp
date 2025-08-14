class AppConstants {
  // App Info
  static const String appName = 'Kato Apps';
  static const String appVersion = '1.0.0';

  // User Roles
  static const String roleSupplier = 'supplier'; // Pengepul/Petani
  static const String roleWarehouse = 'warehouse'; // Gudang
  static const String roleManagement = 'management'; // Management

  // Route Names
  static const String splashRoute = '/';
  static const String loginRoute = '/login';
  static const String registerRoute = '/register';
  static const String dashboardRoute = '/dashboard';
  static const String supplierDashboardRoute = '/supplier-dashboard';
  static const String warehouseDashboardRoute = '/warehouse-dashboard';
  static const String managementDashboardRoute = '/management-dashboard';

  // Asset Paths
  static const String logoPath = 'assets/images/logo.png';
  static const String backgroundPath = 'assets/images/background.jpg';

  // Validation Messages
  static const String requiredField = 'Field ini wajib diisi';
  static const String invalidEmail = 'Email tidak valid';
  static const String invalidPhone = 'Nomor telepon tidak valid';
  static const String passwordTooShort = 'Password minimal 6 karakter';
  static const String passwordNotMatch = 'Password tidak cocok';

  // Success Messages
  static const String loginSuccess = 'Login berhasil';
  static const String registerSuccess = 'Registrasi berhasil';
  static const String logoutSuccess = 'Logout berhasil';

  // Error Messages
  static const String loginFailed = 'Login gagal';
  static const String registerFailed = 'Registrasi gagal';
  static const String networkError = 'Kesalahan jaringan';
  static const String unknownError = 'Terjadi kesalahan yang tidak diketahui';
}
