class Notes {
  String? id;
  String? userid;
  int? totalamt;
  int? title;
  String? content;
  DateTime? dateadded;

  Notes({
    this.id,
    this.userid,
    this.totalamt,
    this.title,
    this.content,
    this.dateadded,
  });

  factory Notes.fromMap(Map<String, dynamic> map) {
    return Notes(
      id: map["id"],
      userid: map["userid"],
      totalamt: map["totalamt"] is String ? int.tryParse(map["totalamt"]) : map["totalamt"],
      title: map["title"] is String ? int.tryParse(map["title"]) : map["title"],
      content: map["content"],
      dateadded: map["dateadded"] is String ? DateTime.tryParse(map["dateadded"]) : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "userid": userid,
      "totalamt": totalamt?.toString(), // Convert int to String
      "title": title?.toString(), // Convert int to String
      "content": content,
      "dateadded": dateadded?.toIso8601String(),
    };
  }
}
