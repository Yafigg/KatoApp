import 'package:katoapp/models/user_model.dart';

class AuthService {
  // Singleton pattern
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  UserModel? _currentUser;
  bool _isAuthenticated = false;

  // Getters
  UserModel? get currentUser => _currentUser;
  bool get isAuthenticated => _isAuthenticated;

  // Login method
  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      // TODO: Implement actual API call
      // Simulate API delay
      await Future.delayed(const Duration(seconds: 2));

      // Mock response - replace with actual API call
      if (email == 'admin@katoapp.com' && password == '123456') {
        _currentUser = UserModel(
          id: '1',
          name: 'Admin Kato',
          email: email,
          phone: '081234567890',
          address: 'Jakarta, Indonesia',
          role: 'management',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );
        _isAuthenticated = true;

        return {
          'success': true,
          'message': 'Login berhasil',
          'user': _currentUser,
        };
      } else if (email == 'supplier@katoapp.com' && password == '123456') {
        _currentUser = UserModel(
          id: '2',
          name: 'Petani Sukses',
          email: email,
          phone: '081234567891',
          address: 'Bandung, Indonesia',
          role: 'supplier',
          companyName: 'Tani Makmur',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );
        _isAuthenticated = true;

        return {
          'success': true,
          'message': 'Login berhasil',
          'user': _currentUser,
        };
      } else if (email == 'warehouse@katoapp.com' && password == '123456') {
        _currentUser = UserModel(
          id: '3',
          name: 'Manager Gudang',
          email: email,
          phone: '081234567892',
          address: 'Surabaya, Indonesia',
          role: 'warehouse',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );
        _isAuthenticated = true;

        return {
          'success': true,
          'message': 'Login berhasil',
          'user': _currentUser,
        };
      } else {
        return {'success': false, 'message': 'Email atau password salah'};
      }
    } catch (e) {
      return {'success': false, 'message': 'Terjadi kesalahan: $e'};
    }
  }

  // Register method
  Future<Map<String, dynamic>> register({
    required String name,
    required String email,
    required String phone,
    required String address,
    required String password,
    required String role,
    String? companyName,
  }) async {
    try {
      // TODO: Implement actual API call
      // Simulate API delay
      await Future.delayed(const Duration(seconds: 2));

      // Mock response - replace with actual API call
      _currentUser = UserModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: name,
        email: email,
        phone: phone,
        address: address,
        role: role,
        companyName: companyName,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      _isAuthenticated = true;

      return {
        'success': true,
        'message': 'Registrasi berhasil',
        'user': _currentUser,
      };
    } catch (e) {
      return {'success': false, 'message': 'Terjadi kesalahan: $e'};
    }
  }

  // Logout method
  Future<void> logout() async {
    _currentUser = null;
    _isAuthenticated = false;
  }

  // Check if user has specific role
  bool hasRole(String role) {
    return _currentUser?.role == role;
  }

  // Check if user is supplier
  bool get isSupplier => hasRole('supplier');

  // Check if user is warehouse
  bool get isWarehouse => hasRole('warehouse');

  // Check if user is management
  bool get isManagement => hasRole('management');
}
