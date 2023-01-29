class Contact {
  int userId;
  int contactId;
  String name;
  String email;
  String cellphone;
  Contact({required this.userId, required this.contactId, required this.name, required this.email, required this.cellphone});

  Contact.fromJson(Map<String, dynamic> json)
      : userId= json['UserId'],
        contactId = json['ContactId'],
        name = json['Name'],
        email = json['Email'],
        cellphone = json['CellPhone'];

  Map<String, dynamic> toJson() => {'userId': userId, 'contactId' : contactId, 'name' : name, 'email' : email, 'cellphone' : cellphone};
}