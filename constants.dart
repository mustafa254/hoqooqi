/// Static reference data used across the app.
class AppConstants {
  AppConstants._();

  static const String appName = 'حقوقي';
  static const String appTagline = 'منصة ربط المواطنين بالمحامين المرخصين';

  /// The legal disclaimer shown on the Home screen (fixed banner) and
  /// referenced in Terms & Conditions.
  static const String legalDisclaimer =
      'تنويه: تطبيق "حقوقي" هو منصة معلوماتية وتوجيهية تهدف لتسهيل التواصل بين '
      'المواطنين والمحامين المرخصين، ولا يقدم التطبيق استشارات قانونية بشكل '
      'مباشر ولا يتحمل أي مسؤولية عن المحتوى المتبادل بين الطرفين.';

  static const List<String> governorates = [
    'بغداد',
    'البصرة',
    'كربلاء',
    'النجف',
    'أربيل',
    'نينوى (الموصل)',
    'الأنبار',
    'ديالى',
    'ذي قار',
    'بابل',
    'واسط',
    'صلاح الدين',
    'كركوك',
    'ميسان',
    'القادسية (الديوانية)',
    'المثنى',
    'دهوك',
    'السليمانية',
  ];

  static const List<String> specialties = [
    'الأحوال الشخصية',
    'القضايا المدنية',
    'الجنائية والجنح',
    'تسجيل الشركات',
    'القضاء الإداري',
    'العمل والعمال',
    'العقارات',
    'التجارية والمصرفية',
    'الملكية الفكرية',
    'الأحداث',
  ];

  static const List<String> userTypes = [
    'مواطن',
    'محامي',
  ];
}
