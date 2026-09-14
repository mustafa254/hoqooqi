import 'package:flutter/material.dart';
import '../screens/lawyers/lawyer_profile_screen.dart';
import '../models/lawyer_model.dart';

/// Simple named-route registry. Extend as new full-screen pages are added
/// (e.g. Iraqi Laws viewer, My Posts, Edit Profile, Terms & Conditions).
class AppRoutes {
  AppRoutes._();

  static const String lawyerProfile = '/lawyer-profile';

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case lawyerProfile:
        final lawyer = settings.arguments as LawyerModel;
        return MaterialPageRoute(
          builder: (_) => LawyerProfileScreen(lawyer: lawyer),
        );
      default:
        return null;
    }
  }
}
