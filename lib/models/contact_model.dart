import '../core/utils/constants.dart';

class Contact {
  int userId;
  int contactId;
  String name;
  String email;
  String cellphone;
  String image;
  Contact({required this.userId, required this.contactId, required this.name, required this.email, required this.cellphone, required this.image});

  Contact.fromJson(Map<String, dynamic> json)
      : userId= json['UserId'],
        contactId = json['ContactId'],
        name = json['Name'],
        email = json['Email'],
        cellphone = json['CellPhone'],
        image = Constants.apiUrl + "/Imagens/" + json['Image'];

  Map<String, dynamic> toJson() => {'userId': userId, 'contactId' : contactId, 'name' : name, 'email' : email, 'cellphone' : cellphone, "image": image};
}