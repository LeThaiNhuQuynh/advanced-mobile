import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:http/http.dart' as http;

class CardImage extends StatelessWidget {
  final String text;
  final String imageUrl;

  const CardImage({super.key, required this.text, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    if (imageUrl.isEmpty) {
      return Container(
        height: 100,
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            text.toUpperCase(), // Display the first letter of the username
            style: const TextStyle(
              color: Colors.white, // You can set the text color
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    } else {
      return Image.network(
        imageUrl,
        fit: BoxFit.cover,
        height: 100,
        width: double.infinity,
      );
    }
  }
}
