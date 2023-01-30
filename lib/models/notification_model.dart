class Notify {
  int id;
  int userId;
  int status;
  String name;
  bool read;
  Notify({required this.id, required this.userId, required this.status, required this.name, required this.read});

  Notify.fromJson(Map<String, dynamic> json)
      : id = json['Id'],
        userId= json['UserId'],
        status = json['Status'],
        name = json['Name'],
        read = json['Read'] as bool;

  Map<String, dynamic> toJson() => {'id': id, 'UserId': userId, 'Status' : status, 'Name' : name, 'Read' : read};
}