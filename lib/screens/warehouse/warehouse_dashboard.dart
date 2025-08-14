import 'package:flutter/material.dart';
import 'package:katoapp/constants/app_constants.dart';
import 'package:katoapp/services/auth_service.dart';
import 'package:katoapp/utils/theme.dart';

class WarehouseDashboard extends StatefulWidget {
  const WarehouseDashboard({super.key});

  @override
  State<WarehouseDashboard> createState() => _WarehouseDashboardState();
}

class _WarehouseDashboardState extends State<WarehouseDashboard> {
  final AuthService _authService = AuthService();
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const WarehouseHomePage(),
    const WarehouseIncomingPage(),
    const WarehouseProductionPage(),
    const WarehouseOutgoingPage(),
    const WarehouseProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    final user = _authService.currentUser;
    
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: Text('Dashboard ${user?.name ?? 'Warehouse'}'),
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
            icon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.inbox),
            label: 'Masuk',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.build),
            label: 'Produksi',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.outbox),
            label: 'Keluar',
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

// Warehouse Home Page
class WarehouseHomePage extends StatelessWidget {
  const WarehouseHomePage({super.key});

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
                        Icons.warehouse,
                        size: 40,
                        color: AppTheme.primaryColor,
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Dashboard Warehouse',
                              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Kelola gudang masuk, produksi, dan keluar',
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
          
          // Statistics Cards
          Text(
            'Statistik Hari Ini',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  context,
                  icon: Icons.inbox,
                  title: 'Gudang Masuk',
                  value: '150kg',
                  color: Colors.blue,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildStatCard(
                  context,
                  icon: Icons.build,
                  title: 'Produksi',
                  value: '80kg',
                  color: Colors.orange,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  context,
                  icon: Icons.outbox,
                  title: 'Gudang Keluar',
                  value: '120kg',
                  color: Colors.green,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildStatCard(
                  context,
                  icon: Icons.inventory,
                  title: 'Stok Tersedia',
                  value: '200kg',
                  color: Colors.purple,
                ),
              ),
            ],
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
                  icon: Icons.add_circle,
                  title: 'Terima Bahan',
                  subtitle: 'Input bahan masuk',
                  onTap: () {
                    // TODO: Navigate to receive materials
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildQuickActionCard(
                  context,
                  icon: Icons.play_circle,
                  title: 'Mulai Produksi',
                  subtitle: 'Proses bahan baku',
                  onTap: () {
                    // TODO: Navigate to start production
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
                  icon: Icons.local_shipping,
                  title: 'Kirim Produk',
                  subtitle: 'Kirim ke pembeli',
                  onTap: () {
                    // TODO: Navigate to send products
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildQuickActionCard(
                  context,
                  icon: Icons.assessment,
                  title: 'Laporan',
                  subtitle: 'Lihat laporan',
                  onTap: () {
                    // TODO: Navigate to reports
                  },
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 24),
          
          // Recent Activities
          Text(
            'Aktivitas Terbaru',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          
          _buildActivityCard(
            context,
            icon: Icons.inbox,
            title: 'Bahan baku diterima',
            subtitle: '100kg bayam dari Petani Sukses',
            time: '1 jam yang lalu',
            color: Colors.blue,
          ),
          
          const SizedBox(height: 16),
          
          _buildActivityCard(
            context,
            icon: Icons.build,
            title: 'Produksi selesai',
            subtitle: '50kg tepung bayam siap',
            time: '3 jam yang lalu',
            color: Colors.orange,
          ),
          
          const SizedBox(height: 16),
          
          _buildActivityCard(
            context,
            icon: Icons.outbox,
            title: 'Produk dikirim',
            subtitle: '30kg tepung bayam ke Pembeli A',
            time: '5 jam yang lalu',
            color: Colors.green,
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(
              icon,
              size: 40,
              color: color,
            ),
            const SizedBox(height: 12),
            Text(
              value,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppTheme.textSecondaryColor,
              ),
              textAlign: TextAlign.center,
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

  Widget _buildActivityCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required String time,
    required Color color,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: color,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppTheme.textSecondaryColor,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              time,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppTheme.textSecondaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Placeholder pages
class WarehouseIncomingPage extends StatelessWidget {
  const WarehouseIncomingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Halaman Gudang Masuk - Dalam Pengembangan'),
    );
  }
}

class WarehouseProductionPage extends StatelessWidget {
  const WarehouseProductionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Halaman Produksi - Dalam Pengembangan'),
    );
  }
}

class WarehouseOutgoingPage extends StatelessWidget {
  const WarehouseOutgoingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Halaman Gudang Keluar - Dalam Pengembangan'),
    );
  }
}

class WarehouseProfilePage extends StatelessWidget {
  const WarehouseProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Halaman Profil - Dalam Pengembangan'),
    );
  }
}
