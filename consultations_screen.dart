import 'package:flutter/material.dart';
import '../../models/consultation_model.dart';
import '../../theme/app_theme.dart';
import '../../widgets/empty_state.dart';

/// "المحادثات" — tracks ongoing consultations/chats with lawyers.
class ConsultationsScreen extends StatelessWidget {
  const ConsultationsScreen({super.key});

  // Replace with FirestoreService.streamConsultations(uid) via StreamBuilder.
  final List<ConsultationModel> _consultations = const [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('المحادثات')),
      body: _consultations.isEmpty
          ? const EmptyState(
              icon: Icons.chat_bubble_outline,
              title: 'لا توجد محادثات حتى الآن',
              message:
                  'عند تواصلك مع أحد المحامين من دليل المحامين، ستظهر محادثاتك واستشاراتك هنا.',
            )
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: _consultations.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final c = _consultations[index];
                return Card(
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                    leading: CircleAvatar(
                      backgroundColor: AppColors.navy.withOpacity(0.1),
                      backgroundImage:
                          c.lawyerPhotoUrl != null ? NetworkImage(c.lawyerPhotoUrl!) : null,
                      child: c.lawyerPhotoUrl == null
                          ? const Icon(Icons.person, color: AppColors.navy)
                          : null,
                    ),
                    title: Text(c.lawyerName, style: const TextStyle(fontWeight: FontWeight.w700)),
                    subtitle: Text(
                      c.lastMessage,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: AppColors.textSecondary),
                    ),
                    trailing: c.isUnread
                        ? Container(
                            width: 10,
                            height: 10,
                            decoration: const BoxDecoration(
                              color: AppColors.gold,
                              shape: BoxShape.circle,
                            ),
                          )
                        : null,
                    onTap: () {
                      // TODO: open chat thread screen for this consultation.
                    },
                  ),
                );
              },
            ),
    );
  }
}
