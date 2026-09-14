/// Represents a chat/consultation thread between a citizen and a lawyer
/// (`consultations` collection).
class ConsultationModel {
  final String id;
  final String lawyerId;
  final String lawyerName;
  final String? lawyerPhotoUrl;
  final String lastMessage;
  final DateTime lastMessageAt;
  final bool isUnread;
  final String status; // 'active' | 'closed'

  ConsultationModel({
    required this.id,
    required this.lawyerId,
    required this.lawyerName,
    this.lawyerPhotoUrl,
    required this.lastMessage,
    required this.lastMessageAt,
    this.isUnread = false,
    this.status = 'active',
  });

  factory ConsultationModel.fromMap(String id, Map<String, dynamic> map) {
    return ConsultationModel(
      id: id,
      lawyerId: map['lawyerId'] ?? '',
      lawyerName: map['lawyerName'] ?? '',
      lawyerPhotoUrl: map['lawyerPhotoUrl'],
      lastMessage: map['lastMessage'] ?? '',
      lastMessageAt: map['lastMessageAt'] != null
          ? DateTime.tryParse(map['lastMessageAt'].toString()) ?? DateTime.now()
          : DateTime.now(),
      isUnread: map['isUnread'] ?? false,
      status: map['status'] ?? 'active',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'lawyerId': lawyerId,
      'lawyerName': lawyerName,
      'lawyerPhotoUrl': lawyerPhotoUrl,
      'lastMessage': lastMessage,
      'lastMessageAt': lastMessageAt.toIso8601String(),
      'isUnread': isUnread,
      'status': status,
    };
  }
}
