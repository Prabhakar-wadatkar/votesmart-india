class ElectionModel {
  final String id;
  final String name;
  final String nameHi;
  final String nameMr;
  final String type; // 'general', 'state', 'local'
  final String region;
  final String? state;
  final DateTime? nominationDate;
  final DateTime? pollingDate;
  final DateTime? resultDate;
  final String status; // 'upcoming', 'active', 'completed'
  final Map<String, dynamic> metadata;

  ElectionModel({
    required this.id,
    required this.name,
    this.nameHi = '',
    this.nameMr = '',
    required this.type,
    required this.region,
    this.state,
    this.nominationDate,
    this.pollingDate,
    this.resultDate,
    required this.status,
    this.metadata = const {},
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'nameHi': nameHi,
      'nameMr': nameMr,
      'type': type,
      'region': region,
      'state': state,
      'nominationDate': nominationDate?.toIso8601String(),
      'pollingDate': pollingDate?.toIso8601String(),
      'resultDate': resultDate?.toIso8601String(),
      'status': status,
      'metadata': metadata,
    };
  }

  factory ElectionModel.fromMap(Map<String, dynamic> map) {
    return ElectionModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      nameHi: map['nameHi'] ?? '',
      nameMr: map['nameMr'] ?? '',
      type: map['type'] ?? 'general',
      region: map['region'] ?? '',
      state: map['state'] as String?,
      nominationDate: map['nominationDate'] != null
          ? DateTime.tryParse(map['nominationDate'])
          : null,
      pollingDate: map['pollingDate'] != null
          ? DateTime.tryParse(map['pollingDate'])
          : null,
      resultDate: map['resultDate'] != null
          ? DateTime.tryParse(map['resultDate'])
          : null,
      status: map['status'] ?? 'upcoming',
      metadata: Map<String, dynamic>.from(map['metadata'] ?? {}),
    );
  }
}
