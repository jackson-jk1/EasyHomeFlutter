class Notification {
  int idContactor;
  int idContacted;
  int status;
  Notification({required this.idContactor, required this.idContacted, required this.status});

  Notification.fromJson(Map<String, dynamic> json)
      : idContactor = json['IdContactor'],
        idContacted = json['IdContacted'],
        status = json['Status'];

  Map<String, dynamic> toJson() => {'idContactor': idContactor, 'idContacted': idContacted, 'status' : status};
}