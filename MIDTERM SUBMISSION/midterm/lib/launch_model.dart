class Launch {
  String missionName;
  String missionId;
  List<String> manufacturers;
  List<String> payloadIds;
  String wikipedia;
  String website;
  String twitter;
  String description;

  Launch(
      {required this.missionName,
      required this.missionId,
      required this.manufacturers,
      required this.payloadIds,
      required this.wikipedia,
      required this.website,
      required this.twitter,
      required this.description});

  factory Launch.fromJson(Map<String, dynamic> json) {
    return Launch(
      missionName: json['mission_name']?? 'null',
      missionId: json['mission_id']?? 'null',
      manufacturers: json['manufacturers'].cast<String>(),
      payloadIds: json['payload_ids'].cast<String>(),
      wikipedia: json['wikipedia']?? 'null',
      website: json['website']?? 'null',
      twitter: json['twitter'] ?? 'null' ,
      description: json['description']?? 'null',
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mission_name'] = missionName;
    data['mission_id'] = missionId;
    data['manufacturers'] = manufacturers;
    data['payload_ids'] = payloadIds;
    data['wikipedia'] = wikipedia;
    data['website'] = website;
    data['twitter'] = twitter;
    data['description'] = description;
    return data;
  }
}
