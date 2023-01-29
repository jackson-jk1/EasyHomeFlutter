class Notification {
  int id;
  int userId;
  int status;
  String name;
  bool read;
  Notification({required this.id, required this.userId, required this.status, required this.name, required this.read});

  Notification.fromJson(Map<String, dynamic> json)
      : id = json['Id'],
        userId= json['UserId'],
        status = json['Status'],
        name = json['Name'],
        read = json['Read'];

  Map<String, dynamic> toJson() => {'id': id, 'userId': userId, 'status' : status, 'name' : name, 'read' : read};
}