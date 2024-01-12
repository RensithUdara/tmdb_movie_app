class CompanyModel {
  String? logo;
  String? name;

  CompanyModel({this.logo, this.name});

  factory CompanyModel.fromJson(Map<String, dynamic> json) {
    return CompanyModel(
      logo: json['logo_path'] != null
          ? "https://image.tmdb.org/t/p/w500${json['logo_path']}"
          : "https://cdn-icons-png.flaticon.com/512/2399/2399925.png",
      name: json['name'],
    );
  }
}
