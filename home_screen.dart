import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/legal_disclaimer_banner.dart';
import '../../widgets/request_consultation_sheet.dart';

/// The main landing tab ("الرئيسية").
class HomeScreen extends StatelessWidget {
  final String userName;
  final String userType;

  const HomeScreen({
    super.key,
    this.userName = 'أحمد الكربلائي',
    this.userType = 'مواطن',
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.balance, color: AppColors.gold, size: 22),
            const SizedBox(width: 8),
            const Text('حقوقي'),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {
              // TODO: navigate to notifications screen
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  _GreetingCard(userName: userName, userType: userType),
                  const SizedBox(height: 20),
                  Text(
                    'خدمات سريعة',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.w700),
                    textAlign: TextAlign.right,
                  ),
                  const SizedBox(height: 12),
                  _QuickServiceTile(
                    icon: Icons.edit_note,
                    iconColor: AppColors.gold,
                    title: 'طلب استشارة',
                    subtitle: 'اكتب استفسارك القانوني وانشره ليصلك ردّ محامٍ',
                    onTap: () {
                      RequestConsultationSheet.show(
                        context,
                        onPublish: (text) async {
                          // TODO: wire to FirestoreService.publishInquiry(uid, name, text)
                          await Future.delayed(const Duration(milliseconds: 400));
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('تم نشر استشارتك بنجاح')),
                            );
                          }
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 12),
                  _QuickServiceTile(
                    icon: Icons.menu_book_outlined,
                    iconColor: AppColors.navy,
                    title: 'القوانين العراقية',
                    subtitle: 'تصفح النصوص القانونية والتشريعات النافذة',
                    onTap: () {
                      // TODO: navigate to Iraqi Laws screen
                    },
                  ),
                  const SizedBox(height: 12),
                  _QuickServiceTile(
                    icon: Icons.article_outlined,
                    iconColor: AppColors.navy,
                    title: 'منشوراتي',
                    subtitle: 'استعرض استشاراتك المنشورة وردود المحامين عليها',
                    onTap: () {
                      // TODO: navigate to My Posts screen
                    },
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
            const LegalDisclaimerBanner(),
          ],
        ),
      ),
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.background,
    );
  }
}

class _GreetingCard extends StatelessWidget {
  final String userName;
  final String userType;

  const _GreetingCard({required this.userName, required this.userType});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.navy, AppColors.navyLight],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.gold.withOpacity(0.2),
            ),
            child: const Icon(Icons.person, color: AppColors.gold, size: 28),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'مرحباً، $userName',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.right,
                ),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                  decoration: BoxDecoration(
                    color: AppColors.gold.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    userType,
                    style: const TextStyle(
                      color: AppColors.goldLight,
                      fontSize: 11.5,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _QuickServiceTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _QuickServiceTile({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: iconColor.withOpacity(0.1),
                ),
                child: Icon(icon, color: iconColor),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14.5),
                      textAlign: TextAlign.right,
                    ),
                    const SizedBox(height: 3),
                    Text(
                      subtitle,
                      style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
                      textAlign: TextAlign.right,
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_left, color: AppColors.textSecondary),
            ],
          ),
        ),
      ),
    );
  }
}
