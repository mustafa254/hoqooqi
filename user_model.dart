/// Represents an authenticated app user (citizen or lawyer).
/// Maps 1:1 to a Firestore document in the `users` collection.
class UserModel {
  final String uid;
  final String name;
  final String phoneNumber;
  final String userType; // 'مواطن' or 'محامي'
  final String? photoUrl;
  final DateTime createdAt;

  UserModel({
    required this.uid,
    required this.name,
    required this.phoneNumber,
    required this.userType,
    this.photoUrl,
    required this.createdAt,
  });

  factory UserModel.fromMap(String uid, Map<String, dynamic> map) {
    return UserModel(
      uid: uid,
      name: map['name'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      userType: map['userType'] ?? 'مواطن',
      photoUrl: map['photoUrl'],
      createdAt: map['createdAt'] != null
          ? DateTime.tryParse(map['createdAt'].toString()) ?? DateTime.now()
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phoneNumber': phoneNumber,
      'userType': userType,
      'photoUrl': photoUrl,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
