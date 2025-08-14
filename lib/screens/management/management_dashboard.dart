import 'package:flutter/material.dart';
import 'package:katoapp/constants/app_constants.dart';
import 'package:katoapp/services/auth_service.dart';
import 'package:katoapp/utils/theme.dart';

class ManagementDashboard extends StatefulWidget {
  const ManagementDashboard({super.key});

  @override
  State<ManagementDashboard> createState() => _ManagementDashboardState();
}

class _ManagementDashboardState extends State<ManagementDashboard> {
  final AuthService _authService = AuthService();
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const ManagementHomePage(),
    const ManagementUsersPage(),
    const ManagementSupplyChainPage(),
    const ManagementReportsPage(),
    const ManagementProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    final user = _authService.currentUser;
    
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: Text('Dashboard ${user?.name ?? 'Management'}'),
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
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppTheme.primaryColor,
        unselectedItemColor: AppTheme.textSecondaryColor,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Users',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_tree),
            label: 'Supply Chain',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assessment),
            label: 'Laporan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}

// Management Home Page
class ManagementHomePage extends StatelessWidget {
  const ManagementHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Welcome Card
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.admin_panel_settings,
                        size: 40,
                        color: AppTheme.primaryColor,
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Dashboard Management',
                              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Monitor dan kelola seluruh sistem supply chain',
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: AppTheme.textSecondaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 24),
          
          // System Overview
          Text(
            'Overview Sistem',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          
          Row(
            children: [
              Expanded(
                child: _buildOverviewCard(
                  context,
                  icon: Icons.people,
                  title: 'Total Users',
                  value: '156',
                  subtitle: '+12 bulan ini',
                  color: Colors.blue,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildOverviewCard(
                  context,
                  icon: Icons.eco,
                  title: 'Active Suppliers',
                  value: '89',
                  subtitle: '+5 bulan ini',
                  color: Colors.green,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          Row(
            children: [
              Expanded(
                child: _buildOverviewCard(
                  context,
                  icon: Icons.warehouse,
                  title: 'Warehouse',
                  value: '3',
                  subtitle: 'Aktif',
                  color: Colors.orange,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildOverviewCard(
                  context,
                  icon: Icons.shopping_cart,
                  title: 'Total Orders',
                  value: '1,234',
                  subtitle: '+89 bulan ini',
                  color: Colors.purple,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 24),
          
          // Supply Chain Status
          Text(
            'Status Supply Chain',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          
          _buildStatusCard(
            context,
            title: 'Gudang Masuk',
            status: 'Normal',
            statusColor: Colors.green,
            description: 'Bahan baku masuk sesuai jadwal',
            icon: Icons.inbox,
          ),
          
          const SizedBox(height: 16),
          
          _buildStatusCard(
            context,
            title: 'Produksi',
            status: 'Sedang Berjalan',
            statusColor: Colors.orange,
            description: '3 batch sedang diproses',
            icon: Icons.build,
          ),
          
          const SizedBox(height: 16),
          
          _buildStatusCard(
            context,
            title: 'Gudang Keluar',
            status: 'Normal',
            statusColor: Colors.green,
            description: 'Pengiriman sesuai target',
            icon: Icons.outbox,
          ),
          
          const SizedBox(height: 24),
          
          // Quick Actions
          Text(
            'Aksi Cepat',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          
          Row(
            children: [
              Expanded(
                child: _buildQuickActionCard(
                  context,
                  icon: Icons.person_add,
                  title: 'Tambah User',
                  subtitle: 'Buat akun baru',
                  onTap: () {
                    // TODO: Navigate to add user
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildQuickActionCard(
                  context,
                  icon: Icons.settings,
                  title: 'Pengaturan',
                  subtitle: 'Konfigurasi sistem',
                  onTap: () {
                    // TODO: Navigate to settings
                  },
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          Row(
            children: [
              Expanded(
                child: _buildQuickActionCard(
                  context,
                  icon: Icons.notifications,
                  title: 'Notifikasi',
                  subtitle: 'Kelola notifikasi',
                  onTap: () {
                    // TODO: Navigate to notifications
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildQuickActionCard(
                  context,
                  icon: Icons.security,
                  title: 'Keamanan',
                  subtitle: 'Pengaturan keamanan',
                  onTap: () {
                    // TODO: Navigate to security
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String value,
    required String subtitle,
    required Color color,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  size: 32,
                  color: color,
                ),
                const Spacer(),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppTheme.textSecondaryColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              value,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusCard(
    BuildContext context, {
    required String title,
    required String status,
    required Color statusColor,
    required String description,
    required IconData icon,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: statusColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: statusColor,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        title,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: statusColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          status,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: statusColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppTheme.textSecondaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActionCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Icon(
                icon,
                size: 32,
                color: AppTheme.primaryColor,
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppTheme.textSecondaryColor,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Placeholder pages
class ManagementUsersPage extends StatelessWidget {
  const ManagementUsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Halaman Manajemen Users - Dalam Pengembangan'),
    );
  }
}

class ManagementSupplyChainPage extends StatelessWidget {
  const ManagementSupplyChainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Halaman Supply Chain - Dalam Pengembangan'),
    );
  }
}

class ManagementReportsPage extends StatelessWidget {
  const ManagementReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Halaman Laporan - Dalam Pengembangan'),
    );
  }
}

class ManagementProfilePage extends StatelessWidget {
  const ManagementProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Halaman Profil - Dalam Pengembangan'),
    );
  }
}
