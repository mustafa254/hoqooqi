/// Represents a licensed lawyer listed in the directory (`lawyers` collection).
class LawyerModel {
  final String id;
  final String name;
  final String? photoUrl;
  final double rating;
  final int reviewsCount;
  final List<String> specialties;
  final String governorate;
  final String phoneNumber;
  final String licenseNumber;
  final bool isVerified;
  final bool isPromoted;
  final String? bio;
  final int yearsOfExperience;

  LawyerModel({
    required this.id,
    required this.name,
    this.photoUrl,
    this.rating = 0.0,
    this.reviewsCount = 0,
    this.specialties = const [],
    required this.governorate,
    required this.phoneNumber,
    required this.licenseNumber,
    this.isVerified = true,
    this.isPromoted = false,
    this.bio,
    this.yearsOfExperience = 0,
  });

  factory LawyerModel.fromMap(String id, Map<String, dynamic> map) {
    return LawyerModel(
      id: id,
      name: map['name'] ?? '',
      photoUrl: map['photoUrl'],
      rating: (map['rating'] ?? 0).toDouble(),
      reviewsCount: map['reviewsCount'] ?? 0,
      specialties: List<String>.from(map['specialties'] ?? const []),
      governorate: map['governorate'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      licenseNumber: map['licenseNumber'] ?? '',
      isVerified: map['isVerified'] ?? true,
      isPromoted: map['isPromoted'] ?? false,
      bio: map['bio'],
      yearsOfExperience: map['yearsOfExperience'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'photoUrl': photoUrl,
      'rating': rating,
      'reviewsCount': reviewsCount,
      'specialties': specialties,
      'governorate': governorate,
      'phoneNumber': phoneNumber,
      'licenseNumber': licenseNumber,
      'isVerified': isVerified,
      'isPromoted': isPromoted,
      'bio': bio,
      'yearsOfExperience': yearsOfExperience,
    };
  }
}
