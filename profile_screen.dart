import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../theme/app_theme.dart';

/// "حسابي" — Profile & Settings tab.
class ProfileScreen extends StatefulWidget {
  final String userName;
  final String phoneNumber;
  final String userType;
  final ValueChanged<bool> onDarkModeChanged;
  final bool isDarkMode;

  const ProfileScreen({
    super.key,
    this.userName = 'أحمد الكربلائي',
    this.phoneNumber = '+964 770 123 4567',
    this.userType = 'مواطن',
    required this.onDarkModeChanged,
    required this.isDarkMode,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Future<void> _launch(String url) async {
    await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
  }

  void _confirmLogout() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('تسجيل الخروج'),
        content: const Text('هل أنت متأكد من رغبتك بتسجيل الخروج؟'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('إلغاء')),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // TODO: AuthService().signOut();
            },
            child: const Text('تسجيل الخروج', style: TextStyle(color: AppColors.danger)),
          ),
        ],
      ),
    );
  }

  void _confirmDeleteAccount() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('حذف الحساب'),
        content: const Text(
          'سيتم حذف حسابك وكافة بياناتك بشكل نهائي ولا يمكن التراجع عن هذا الإجراء. هل تريد الاستمرار؟',
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('إلغاء')),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // TODO: AuthService().deleteAccount(); FirestoreService().deleteUserData(uid);
            },
            child: const Text('حذف نهائياً', style: TextStyle(color: AppColors.danger)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('حسابي')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _ProfileCard(userName: widget.userName, phoneNumber: widget.phoneNumber, userType: widget.userType),
          const SizedBox(height: 20),

          _SectionTitle('إدارة الحساب'),
          _SettingsGroup(children: [
            _SettingsTile(
              icon: Icons.edit_outlined,
              title: 'تعديل البيانات الشخصية',
              onTap: () {
                // TODO: navigate to Edit Profile screen
              },
            ),
          ]),

          const SizedBox(height: 20),
          _SectionTitle('إعدادات التطبيق'),
          _SettingsGroup(children: [
            SwitchListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              secondary: const Icon(Icons.dark_mode_outlined),
              title: const Text('الوضع الليلي', textAlign: TextAlign.right),
              value: widget.isDarkMode,
              onChanged: widget.onDarkModeChanged,
              activeColor: AppColors.gold,
            ),
            const Divider(height: 1, indent: 16, endIndent: 16),
            _SettingsTile(
              icon: Icons.block_outlined,
              title: 'المستخدمون المحظورون',
              onTap: () {
                // TODO: navigate to Blocked Users list screen
              },
            ),
          ]),

          const SizedBox(height: 20),
          _SectionTitle('عن حقوقي'),
          _SettingsGroup(children: [
            _SettingsTile(
              icon: Icons.support_agent_outlined,
              title: 'الدعم الفني',
              onTap: () => _launch('mailto:support@huqouqi.app'),
            ),
            const Divider(height: 1, indent: 16, endIndent: 16),
            _SettingsTile(
              icon: Icons.description_outlined,
              title: 'الشروط والأحكام',
              onTap: () {
                // TODO: navigate to Terms & Conditions screen
              },
            ),
            const Divider(height: 1, indent: 16, endIndent: 16),
            _SettingsTile(
              icon: Icons.facebook_outlined,
              title: 'حسابات التواصل الاجتماعي',
              onTap: () => _launch('https://facebook.com'),
            ),
            const Divider(height: 1, indent: 16, endIndent: 16),
            _SettingsTile(
              icon: Icons.star_border_outlined,
              title: 'تقييم التطبيق',
              onTap: () {
                // TODO: launch Play Store review URL
              },
            ),
          ]),

          const SizedBox(height: 28),
          OutlinedButton.icon(
            onPressed: _confirmLogout,
            icon: const Icon(Icons.logout, color: AppColors.danger),
            label: const Text('تسجيل الخروج', style: TextStyle(color: AppColors.danger)),
            style: OutlinedButton.styleFrom(side: const BorderSide(color: AppColors.danger)),
          ),
          const SizedBox(height: 10),
          TextButton(
            onPressed: _confirmDeleteAccount,
            child: const Text('حذف الحساب', style: TextStyle(color: AppColors.danger, fontSize: 13)),
          ),
        ],
      ),
    );
  }
}

class _ProfileCard extends StatelessWidget {
  final String userName;
  final String phoneNumber;
  final String userType;

  const _ProfileCard({required this.userName, required this.phoneNumber, required this.userType});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Row(
          children: [
            CircleAvatar(
              radius: 32,
              backgroundColor: AppColors.navy.withOpacity(0.1),
              child: Icon(Icons.person, size: 34, color: AppColors.navy.withOpacity(0.6)),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(userName, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
                  const SizedBox(height: 4),
                  Text(phoneNumber, style: const TextStyle(color: AppColors.textSecondary, fontSize: 13)),
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                    decoration: BoxDecoration(
                      color: AppColors.navy.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(userType,
                        style: const TextStyle(fontSize: 11.5, fontWeight: FontWeight.w600)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, right: 4),
      child: Align(
        alignment: Alignment.centerRight,
        child: Text(
          text,
          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13.5, color: AppColors.textSecondary),
        ),
      ),
    );
  }
}

class _SettingsGroup extends StatelessWidget {
  final List<Widget> children;
  const _SettingsGroup({required this.children});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(children: children),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _SettingsTile({required this.icon, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      leading: Icon(icon, color: AppColors.navy),
      title: Text(title, textAlign: TextAlign.right),
      trailing: const Icon(Icons.chevron_left, color: AppColors.textSecondary),
      onTap: onTap,
    );
  }
}
