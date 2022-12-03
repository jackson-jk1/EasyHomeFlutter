import 'package:easy_home/data/model/polo_model.dart';
import 'package:flutter/material.dart';
import '../../../data/repository/real_estate_repository.dart';

RealEstateRepository realEstateRepository = new RealEstateRepository(Http: null);
const List<String> list = ['UFPR', 'PUC','UTFPR', 'Mackenzie'];
String? selectedItem = 'UFPR';

class DropdownButtonList extends StatefulWidget {
  const DropdownButtonList({super.key});

  @override
  State<DropdownButtonList> createState() => _DropdownButtonState();
}

class _DropdownButtonState extends State<DropdownButtonList> {
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
        });
      },
      items: list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
