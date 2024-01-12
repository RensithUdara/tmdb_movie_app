class ActorModel {
  String? name;
  String? image;
  String? character;
  double? popularity;

  ActorModel({this.name, this.image, this.character, this.popularity});

  factory ActorModel.fromJson(Map<String, dynamic> json) {
    return ActorModel(
        name: json['name'],
        image: json['profile_path'] != null
            ? "https://image.tmdb.org/t/p/w500${json["profile_path"]}"
            : "https://cdn-icons-png.flaticon.com/512/475/475283.png",
        character: json['character'],
        popularity:
            json['popularity'] == null ? 0 : (json['popularity'].toDouble()));
  }
}
