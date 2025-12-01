import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class VehicleSearchScreen extends StatefulWidget {
  const VehicleSearchScreen({super.key});

  @override
  State<VehicleSearchScreen> createState() => _VehicleSearchScreenState();
}

class _VehicleSearchScreenState extends State<VehicleSearchScreen> with SingleTickerProviderStateMixin {
  final _searchController = TextEditingController();
  bool _isFound = false;
  late TabController _tabController;

  // Mock Data for Display
  final Map<String, dynamic> _vehicleData = {
    'military_id': '998877',
    'civil_id': 'DXB-1234',
    'type': 'سيارة سيدان',
    'model': 'تويوتا 2022',
    'color': 'أبيض',
    'driver': 'أحمد محمد',
    'rank': 'رقيب',
  };

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  void _search() {
    // Mock Search Logic
    if (_searchController.text.isNotEmpty) {
      setState(() {
        _isFound = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('بحث وقيود مرتبطة')),
      body: Column(
        children: [
          // Search Area
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                      labelText: 'بحث برقم الالية العسكري',
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _search,
                  child: const Text('بحث'),
                ),
              ],
            ),
          ),

          if (_isFound) ...[
            // Basic Info Card
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              color: Colors.blue.shade50,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    _infoRow('الرقم العسكري', _vehicleData['military_id']),
                    _infoRow('النوع', _vehicleData['type']),
                    _infoRow('الموديل', _vehicleData['model']),
                    _infoRow('السائق الحالي', '${_vehicleData['driver']} (${_vehicleData['rank']})'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),

            // Tabs
            TabBar(
              controller: _tabController,
              labelColor: Theme.of(context).primaryColor,
              unselectedLabelColor: Colors.grey,
              tabs: const [
                Tab(text: 'الصيانة', icon: Icon(Icons.build)),
                Tab(text: 'الاستلام', icon: Icon(Icons.key)),
                Tab(text: 'الحوادث', icon: Icon(Icons.warning)),
              ],
            ),

            // Tab Views
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildMaintenanceTab(),
                  _buildHandoverTab(),
                  _buildAccidentTab(),
                ],
              ),
            ),
          ] else
            const Expanded(
              child: Center(child: Text('الرجاء البحث عن الالية لعرض التفاصيل')),
            ),
        ],
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(value),
        ],
      ),
    );
  }

  // --- Tab Contents ---

  Widget _buildMaintenanceTab() {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddMaintenanceDialog(),
        mini: true,
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: 2,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(Icons.build_circle, color: Colors.orange),
            title: Text('صيانة دورية #${index + 1}'),
            subtitle: Text('المسافة: ${10000 * (index + 1)} كم - التاريخ: 2023/10/${index + 10}'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          );
        },
      ),
    );
  }

  Widget _buildHandoverTab() {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddHandoverDialog(),
        mini: true,
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(Icons.vpn_key, color: Colors.green),
            title: const Text('استلام: أحمد محمد'),
            subtitle: const Text('تاريخ الاستلام: 2023/01/01 - التسليم: --'),
          );
        },
      ),
    );
  }

  Widget _buildAccidentTab() {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddAccidentDialog(),
        mini: true,
        child: const Icon(Icons.add),
      ),
      body: const Center(child: Text('لا توجد حوادث مسجلة')),
    );
  }

  // --- Dialogs for Adding Related Records ---

  void _showAddMaintenanceDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('اضافة قيد صيانة'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(decoration: const InputDecoration(labelText: 'اخر مسافة مقطوعة')),
            const SizedBox(height: 10),
            TextFormField(decoration: const InputDecoration(labelText: 'الوصف')),
            const SizedBox(height: 10),
            TextFormField(
              decoration: const InputDecoration(labelText: 'تاريخ الصيانة'),
              onTap: () async {
                // Date picker logic here
              },
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('الغاء')),
          ElevatedButton(onPressed: () => Navigator.pop(context), child: const Text('حفظ')),
        ],
      ),
    );
  }

  void _showAddHandoverDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('اضافة قيد استلام'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButtonFormField(
              items: ['أحمد محمد', 'خالد علي'].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
              onChanged: (v) {},
              decoration: const InputDecoration(labelText: 'اسم السائق'),
            ),
            const SizedBox(height: 10),
            TextFormField(decoration: const InputDecoration(labelText: 'تاريخ الاستلام')),
            const SizedBox(height: 10),
            TextFormField(decoration: const InputDecoration(labelText: 'تاريخ التسليم (اختياري)')),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('الغاء')),
          ElevatedButton(onPressed: () => Navigator.pop(context), child: const Text('حفظ')),
        ],
      ),
    );
  }

  void _showAddAccidentDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('اضافة قيد حادث'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(decoration: const InputDecoration(labelText: 'وصف الحادث')),
            const SizedBox(height: 10),
            TextFormField(decoration: const InputDecoration(labelText: 'مكان الحادث')),
            const SizedBox(height: 10),
            TextFormField(decoration: const InputDecoration(labelText: 'تاريخ الحادث')),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('الغاء')),
          ElevatedButton(onPressed: () => Navigator.pop(context), child: const Text('حفظ')),
        ],
      ),
    );
  }
}
