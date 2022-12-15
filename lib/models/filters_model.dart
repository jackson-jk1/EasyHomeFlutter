class Filters {
  int page;
  String polo;
  double valueMax;
  int rooms;
  Filters({required this.page, required this.polo, required this.valueMax, required this.rooms});

  Filters.fromJson(Map<String, dynamic> json)
      : page = json['Page'],
        polo = json['Polo'],
        valueMax = json['ValueMax'],
        rooms = json['Rooms'];

  Map<String, dynamic> toJson() => {'Page': page, 'Polo' : polo, 'ValueMax' : valueMax, 'Rooms': rooms};
}