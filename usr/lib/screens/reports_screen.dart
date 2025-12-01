import 'package:flutter/material.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('التقارير')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildReportTile(context, 'كشف صيانة الالية', Icons.build),
          _buildReportTile(context, 'كشف استلام الالية', Icons.vpn_key),
          _buildReportTile(context, 'كشف حسب نوع الالية', Icons.category),
          _buildReportTile(context, 'كشف حسب الموديل', Icons.directions_car),
          _buildReportTile(context, 'كشف حسب رقم الالية العسكري', Icons.numbers),
        ],
      ),
    );
  }

  Widget _buildReportTile(BuildContext context, String title, IconData icon) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(icon, color: Theme.of(context).primaryColor),
        title: Text(title),
        trailing: const Icon(Icons.print),
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('جاري طباعة $title...')),
          );
        },
      ),
    );
  }
}
