import 'package:cloud_firestore/cloud_firestore.dart';

class SessionModel {
  final String sessionId;
  final int? age;
  final DateTime? dateOfBirth;
  final String? location;
  final String? region;
  final Map<String, bool> progress;
  final String language;
  final DateTime createdAt;
  final DateTime lastActive;

  SessionModel({
    required this.sessionId,
    this.age,
    this.dateOfBirth,
    this.location,
    this.region,
    required this.progress,
    this.language = 'en',
    required this.createdAt,
    required this.lastActive,
  });

  factory SessionModel.create(String sessionId) {
    final now = DateTime.now();
    return SessionModel(
      sessionId: sessionId,
      progress: {
        'eligibility': false,
        'registration': false,
        'verification': false,
        'timeline': false,
        'votingDay': false,
        'results': false,
      },
      createdAt: now,
      lastActive: now,
    );
  }

  int get completedSteps => progress.values.where((v) => v).length;
  int get totalSteps => progress.length;
  double get progressPercent =>
      totalSteps > 0 ? completedSteps / totalSteps : 0;

  bool get isEligible => age != null && age! >= 18;

  int? get daysUntilEligible {
    if (dateOfBirth == null || isEligible) return null;
    final eighteenthBirthday = DateTime(
      dateOfBirth!.year + 18,
      dateOfBirth!.month,
      dateOfBirth!.day,
    );
    return eighteenthBirthday.difference(DateTime.now()).inDays;
  }

  SessionModel copyWith({
    int? age,
    DateTime? dateOfBirth,
    String? location,
    String? region,
    Map<String, bool>? progress,
    String? language,
    DateTime? lastActive,
  }) {
    return SessionModel(
      sessionId: sessionId,
      age: age ?? this.age,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      location: location ?? this.location,
      region: region ?? this.region,
      progress: progress ?? Map.from(this.progress),
      language: language ?? this.language,
      createdAt: createdAt,
      lastActive: lastActive ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'sessionId': sessionId,
      'age': age,
      'dateOfBirth': dateOfBirth?.toIso8601String(),
      'location': location,
      'region': region,
      'progress': progress,
      'language': language,
      'createdAt': Timestamp.fromDate(createdAt),
      'lastActive': Timestamp.fromDate(lastActive),
    };
  }

  factory SessionModel.fromMap(Map<String, dynamic> map) {
    final progressMap = <String, bool>{};
    if (map['progress'] != null) {
      (map['progress'] as Map<String, dynamic>).forEach((key, value) {
        progressMap[key] = value as bool;
      });
    }

    return SessionModel(
      sessionId: map['sessionId'] ?? '',
      age: map['age'] as int?,
      dateOfBirth: map['dateOfBirth'] != null
          ? DateTime.tryParse(map['dateOfBirth'])
          : null,
      location: map['location'] as String?,
      region: map['region'] as String?,
      progress: progressMap.isNotEmpty
          ? progressMap
          : {
              'eligibility': false,
              'registration': false,
              'verification': false,
              'timeline': false,
              'votingDay': false,
              'results': false,
            },
      language: map['language'] ?? 'en',
      createdAt: map['createdAt'] is Timestamp
          ? (map['createdAt'] as Timestamp).toDate()
          : DateTime.now(),
      lastActive: map['lastActive'] is Timestamp
          ? (map['lastActive'] as Timestamp).toDate()
          : DateTime.now(),
    );
  }
}
