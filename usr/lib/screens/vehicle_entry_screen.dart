import 'package:flutter/material.dart';

class VehicleEntryScreen extends StatefulWidget {
  const VehicleEntryScreen({super.key});

  @override
  State<VehicleEntryScreen> createState() => _VehicleEntryScreenState();
}

class _VehicleEntryScreenState extends State<VehicleEntryScreen> {
  final _formKey = GlobalKey<FormState>();
  
  // Controllers
  final _militaryIdController = TextEditingController();
  final _civilIdController = TextEditingController();
  final _colorController = TextEditingController();
  
  // Dropdown Values (Mock Data)
  String? _selectedType;
  String? _selectedModel;
  String? _selectedDriver;

  final List<String> _types = ['سيارة سيدان', 'شاحنة', 'جيب عسكري', 'حافلة'];
  final List<String> _models = ['تويوتا 2022', 'نيسان 2020', 'مرسيدس 2019', 'فورد 2023'];
  final List<String> _drivers = ['أحمد محمد', 'خالد علي', 'سعيد عمر'];

  void _saveVehicle() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تم حفظ القيد الرئيسي بنجاح')),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ادخال قيد رئيسي (آلية)')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('بيانات الالية الاساسية', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              
              // Primary Key
              TextFormField(
                controller: _militaryIdController,
                decoration: const InputDecoration(labelText: 'رقم الالية العسكري (PK)'),
                validator: (v) => v!.isEmpty ? 'مطلوب' : null,
              ),
              const SizedBox(height: 16),
              
              TextFormField(
                controller: _civilIdController,
                decoration: const InputDecoration(labelText: 'رقم الالية المدني'),
              ),
              const SizedBox(height: 16),
              
              DropdownButtonFormField<String>(
                value: _selectedType,
                decoration: const InputDecoration(labelText: 'النوع'),
                items: _types.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                onChanged: (v) => setState(() => _selectedType = v),
                validator: (v) => v == null ? 'مطلوب' : null,
              ),
              const SizedBox(height: 16),
              
              DropdownButtonFormField<String>(
                value: _selectedModel,
                decoration: const InputDecoration(labelText: 'الموديل'),
                items: _models.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                onChanged: (v) => setState(() => _selectedModel = v),
                validator: (v) => v == null ? 'مطلوب' : null,
              ),
              const SizedBox(height: 16),
              
              TextFormField(
                controller: _colorController,
                decoration: const InputDecoration(labelText: 'اللون'),
              ),
              const SizedBox(height: 16),
              
              DropdownButtonFormField<String>(
                value: _selectedDriver,
                decoration: const InputDecoration(labelText: 'اسم السائق الحالي'),
                items: _drivers.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                onChanged: (v) => setState(() => _selectedDriver = v),
              ),
              
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: _saveVehicle,
                  icon: const Icon(Icons.save),
                  label: const Text('حفظ البيانات'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
