import 'package:flutter/material.dart';
import '../../models/case_model.dart';
import '../../theme/app_theme.dart';
import '../../widgets/empty_state.dart';

/// "قضاياي" — Active vs. Resolved case tracking.
class MyCasesScreen extends StatefulWidget {
  const MyCasesScreen({super.key});

  @override
  State<MyCasesScreen> createState() => _MyCasesScreenState();
}

class _MyCasesScreenState extends State<MyCasesScreen> with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  // Replace with FirestoreService.streamCases(uid, status: ...) via StreamBuilder.
  final List<CaseModel> _activeCases = const [];
  final List<CaseModel> _resolvedCases = const [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('قضاياي'),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppColors.gold,
          indicatorWeight: 3,
          labelStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13.5),
          tabs: const [
            Tab(text: 'القضايا الجارية'),
            Tab(text: 'القضايا الحاسمة'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildCaseList(_activeCases, isActiveTab: true),
          _buildCaseList(_resolvedCases, isActiveTab: false),
        ],
      ),
    );
  }

  Widget _buildCaseList(List<CaseModel> cases, {required bool isActiveTab}) {
    if (cases.isEmpty) {
      return EmptyState(
        icon: isActiveTab ? Icons.folder_open_outlined : Icons.task_alt_outlined,
        title: isActiveTab ? 'لا توجد قضايا جارية' : 'لا توجد قضايا محسومة',
        message:
            'اطلب من محاميك ربط رقم هاتفك بملف القضية الخاص بك حتى تظهر تفاصيلها هنا تلقائياً.',
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: cases.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        final c = cases[index];
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        c.title,
                        style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14.5),
                        textAlign: TextAlign.right,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: (isActiveTab ? AppColors.warning : AppColors.success)
                            .withOpacity(0.12),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        isActiveTab ? 'جارية' : 'محسومة',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: isActiveTab ? AppColors.warning : AppColors.success,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text('رقم القضية: ${c.caseNumber}',
                    style: const TextStyle(fontSize: 12.5, color: AppColors.textSecondary),
                    textAlign: TextAlign.right),
                const SizedBox(height: 2),
                Text('المحامي المسؤول: ${c.lawyerName}',
                    style: const TextStyle(fontSize: 12.5, color: AppColors.textSecondary),
                    textAlign: TextAlign.right),
              ],
            ),
          ),
        );
      },
    );
  }
}
