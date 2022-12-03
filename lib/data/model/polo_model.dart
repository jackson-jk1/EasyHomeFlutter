class PoloModel {
  String id = "";
  String name = "";

  PoloModel(this.id, this.name);

  PoloModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'];

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
  };
}