import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../models/lawyer_model.dart';
import '../../theme/app_theme.dart';

/// "الملف المهني" — full professional profile for a single lawyer.
class LawyerProfileScreen extends StatelessWidget {
  final LawyerModel lawyer;

  const LawyerProfileScreen({super.key, required this.lawyer});

  Future<void> _call() async {
    final uri = Uri(scheme: 'tel', path: lawyer.phoneNumber);
    await launchUrl(uri);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('الملف المهني')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Center(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 46,
                  backgroundColor: AppColors.navy.withOpacity(0.1),
                  backgroundImage: lawyer.photoUrl != null ? NetworkImage(lawyer.photoUrl!) : null,
                  child: lawyer.photoUrl == null
                      ? Icon(Icons.person, size: 46, color: AppColors.navy.withOpacity(0.5))
                      : null,
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      lawyer.name,
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(fontWeight: FontWeight.w700),
                    ),
                    if (lawyer.isVerified) ...[
                      const SizedBox(width: 6),
                      const Icon(Icons.verified, color: AppColors.verifiedBlue, size: 20),
                    ],
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.star, color: AppColors.gold, size: 18),
                    const SizedBox(width: 4),
                    Text('${lawyer.rating.toStringAsFixed(1)} (${lawyer.reviewsCount} تقييم)'),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _infoRow(Icons.badge_outlined, 'رقم الترخيص', lawyer.licenseNumber),
                  const Divider(height: 20),
                  _infoRow(Icons.location_on_outlined, 'المحافظة', lawyer.governorate),
                  const Divider(height: 20),
                  _infoRow(Icons.work_history_outlined, 'سنوات الخبرة',
                      '${lawyer.yearsOfExperience} سنة'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              'التخصصات',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
            ),
          ),
          const SizedBox(height: 10),
          Wrap(
            alignment: WrapAlignment.end,
            spacing: 8,
            runSpacing: 8,
            children: lawyer.specialties
                .map((s) => Chip(
                      label: Text(s),
                      backgroundColor: AppColors.navy.withOpacity(0.06),
                    ))
                .toList(),
          ),
          if (lawyer.bio != null) ...[
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                'نبذة',
                style:
                    Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              lawyer.bio!,
              textAlign: TextAlign.right,
              style: const TextStyle(color: AppColors.textSecondary, height: 1.6),
            ),
          ],
          const SizedBox(height: 28),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: _call,
                  icon: const Icon(Icons.call),
                  label: const Text('اتصال'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    // TODO: navigate into a new consultation/chat thread with this lawyer.
                  },
                  icon: const Icon(Icons.chat_bubble_outline),
                  label: const Text('بدء محادثة'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _infoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 20, color: AppColors.navy),
        const SizedBox(width: 10),
        Text(label, style: const TextStyle(color: AppColors.textSecondary, fontSize: 13.5)),
        const Spacer(),
        Text(value, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13.5)),
      ],
    );
  }
}
