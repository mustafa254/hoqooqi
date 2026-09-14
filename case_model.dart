/// Represents a legal case file linked by a lawyer to a citizen's account
/// (`cases` collection).
class CaseModel {
  final String id;
  final String title;
  final String caseNumber;
  final String lawyerName;
  final String courtName;
  final String status; // 'active' | 'resolved'
  final DateTime openedAt;
  final DateTime? nextSessionAt;
  final String? notes;

  CaseModel({
    required this.id,
    required this.title,
    required this.caseNumber,
    required this.lawyerName,
    required this.courtName,
    required this.status,
    required this.openedAt,
    this.nextSessionAt,
    this.notes,
  });

  factory CaseModel.fromMap(String id, Map<String, dynamic> map) {
    return CaseModel(
      id: id,
      title: map['title'] ?? '',
      caseNumber: map['caseNumber'] ?? '',
      lawyerName: map['lawyerName'] ?? '',
      courtName: map['courtName'] ?? '',
      status: map['status'] ?? 'active',
      openedAt: map['openedAt'] != null
          ? DateTime.tryParse(map['openedAt'].toString()) ?? DateTime.now()
          : DateTime.now(),
      nextSessionAt: map['nextSessionAt'] != null
          ? DateTime.tryParse(map['nextSessionAt'].toString())
          : null,
      notes: map['notes'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'caseNumber': caseNumber,
      'lawyerName': lawyerName,
      'courtName': courtName,
      'status': status,
      'openedAt': openedAt.toIso8601String(),
      'nextSessionAt': nextSessionAt?.toIso8601String(),
      'notes': notes,
    };
  }
}
