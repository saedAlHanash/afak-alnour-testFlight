class LevelResponse {
  LevelResponse({
    required this.data,
  });

  final List<LevelData> data;

  factory LevelResponse.fromJson(Map<String, dynamic> json, int catId) {
    return LevelResponse(
      data: json["data"] == null
          ? []
          : List<LevelData>.from(json["data"]!.map((x) => LevelData.fromJson(x, catId))),
    );
  }

  Map<String, dynamic> toJson() => {
        "data": data.map((x) => x.toJson()).toList(),
      };
}

class LevelData {
  LevelData({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.catId,
  });

  final int id;
  final int catId;
  final String name;
  final String description;
  final String imageUrl;

  factory LevelData.fromJson(Map<String, dynamic> json, int catId) {
    return LevelData(
      id: json["id"] ?? 0,
      catId: catId,
      name: json["name"] ?? "",
      description: json["description"] ?? "",
      imageUrl: json["image_url"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "image_url": imageUrl,
      };
}
