class Polo {
  int id;
  String name;
  Polo({required this.id, required this.name});

  Polo.fromJson(Map<String, dynamic> json)
      : id = json['Id'],
        name = json['Name'];

  Map<String, dynamic> toJson() => {'id': id, 'name' : name};
}