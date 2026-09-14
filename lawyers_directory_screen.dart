import 'package:flutter/material.dart';
import '../../core/constants.dart';
import '../../models/lawyer_model.dart';
import '../../theme/app_theme.dart';
import '../../widgets/lawyer_card.dart';

/// "دليل المحامين المعتمدين" — Lawyers Directory tab.
class LawyersDirectoryScreen extends StatefulWidget {
  const LawyersDirectoryScreen({super.key});

  @override
  State<LawyersDirectoryScreen> createState() => _LawyersDirectoryScreenState();
}

class _LawyersDirectoryScreenState extends State<LawyersDirectoryScreen> {
  final TextEditingController _searchController = TextEditingController();
  String? _selectedGovernorate;
  final Set<String> _selectedSpecialties = {};

  // Placeholder sample data — replace with FirestoreService.streamLawyers().
  final List<LawyerModel> _allLawyers = [
    LawyerModel(
      id: '1',
      name: 'المحامي علي حسين الكربلائي',
      rating: 4.8,
      reviewsCount: 132,
      specialties: const ['الأحوال الشخصية', 'القضايا المدنية'],
      governorate: 'كربلاء',
      phoneNumber: '+9647701234567',
      licenseNumber: 'IQ-LAW-4821',
      isPromoted: true,
      yearsOfExperience: 12,
    ),
    LawyerModel(
      id: '2',
      name: 'المحامية زينب عبد الرضا',
      rating: 4.6,
      reviewsCount: 89,
      specialties: const ['الجنائية والجنح'],
      governorate: 'بغداد',
      phoneNumber: '+9647709876543',
      licenseNumber: 'IQ-LAW-2290',
      yearsOfExperience: 8,
    ),
    LawyerModel(
      id: '3',
      name: 'المحامي مصطفى جبار',
      rating: 4.9,
      reviewsCount: 201,
      specialties: const ['تسجيل الشركات', 'التجارية والمصرفية'],
      governorate: 'النجف',
      phoneNumber: '+9647711223344',
      licenseNumber: 'IQ-LAW-1054',
      isPromoted: true,
      yearsOfExperience: 15,
    ),
  ];

  List<LawyerModel> get _filteredLawyers {
    final query = _searchController.text.trim().toLowerCase();
    return _allLawyers.where((lawyer) {
      final matchesQuery = query.isEmpty ||
          lawyer.name.toLowerCase().contains(query) ||
          lawyer.specialties.any((s) => s.toLowerCase().contains(query));
      final matchesGovernorate =
          _selectedGovernorate == null || lawyer.governorate == _selectedGovernorate;
      final matchesSpecialty = _selectedSpecialties.isEmpty ||
          lawyer.specialties.any(_selectedSpecialties.contains);
      return matchesQuery && matchesGovernorate && matchesSpecialty;
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('دليل المحامين المعتمدين')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Column(
              children: [
                TextField(
                  controller: _searchController,
                  textAlign: TextAlign.right,
                  onChanged: (_) => setState(() {}),
                  decoration: InputDecoration(
                    hintText: 'ابحث بالاسم أو التخصص...',
                    prefixIcon: const Icon(Icons.tune),
                    suffixIcon: const Icon(Icons.search),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: _selectedGovernorate,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        ),
                        hint: const Text('كل المحافظات', style: TextStyle(fontSize: 13)),
                        icon: const Icon(Icons.location_on_outlined, size: 18),
                        items: [
                          const DropdownMenuItem(value: null, child: Text('كل المحافظات')),
                          ...AppConstants.governorates.map(
                            (g) => DropdownMenuItem(value: g, child: Text(g)),
                          ),
                        ],
                        onChanged: (value) => setState(() => _selectedGovernorate = value),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 40,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: AppConstants.specialties.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final specialty = AppConstants.specialties[index];
                final selected = _selectedSpecialties.contains(specialty);
                return FilterChip(
                  label: Text(specialty),
                  selected: selected,
                  onSelected: (value) {
                    setState(() {
                      value
                          ? _selectedSpecialties.add(specialty)
                          : _selectedSpecialties.remove(specialty);
                    });
                  },
                  selectedColor: AppColors.navy,
                  labelStyle: TextStyle(
                    fontSize: 12.5,
                    color: selected ? Colors.white : AppColors.textPrimary,
                    fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: _filteredLawyers.isEmpty
                ? Center(
                    child: Text(
                      'لا توجد نتائج مطابقة',
                      style: TextStyle(color: AppColors.textSecondary),
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
                    itemCount: _filteredLawyers.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, index) => LawyerCard(lawyer: _filteredLawyers[index]),
                  ),
          ),
        ],
      ),
    );
  }
}
