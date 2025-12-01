import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الرئيسية'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => Navigator.pushReplacementNamed(context, '/'),
          ),
        ],
      ),
      body: GridView.count(
        padding: const EdgeInsets.all(20),
        crossAxisCount: 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        children: [
          _buildMenuCard(
            context,
            'ادخال قيد رئيسي',
            Icons.add_circle_outline,
            Colors.blue,
            () => Navigator.pushNamed(context, '/entry'),
          ),
          _buildMenuCard(
            context,
            'بحث وقيود مرتبطة',
            Icons.search,
            Colors.green,
            () => Navigator.pushNamed(context, '/search'),
          ),
          _buildMenuCard(
            context,
            'التقارير',
            Icons.bar_chart,
            Colors.orange,
            () => Navigator.pushNamed(context, '/reports'),
          ),
          _buildMenuCard(
            context,
            'الاعدادات',
            Icons.settings,
            Colors.grey,
            () {},
          ),
        ],
      ),
    );
  }

  Widget _buildMenuCard(BuildContext context, String title, IconData icon, Color color, VoidCallback onTap) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 50, color: color),
            const SizedBox(height: 16),
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
