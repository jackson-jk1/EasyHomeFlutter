import 'package:flutter/material.dart';

Widget buildButton({
  required String title,
  required IconData icon,
  required VoidCallback onClicked,
}) =>
    ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: Size.fromHeight(46),
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        textStyle: TextStyle(fontSize: 20),
        padding: const EdgeInsets.all(16.0),
      ),
      onPressed: onClicked,
      child: Row(
        children: [
          Icon(icon, size: 28),
          const SizedBox(width: 16),
          Text(title),
        ],
      ),
    );