import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:http/http.dart' as http;

class Avatar extends StatelessWidget {
  final String avatarText;
  final String imageUrl;
  final double radius;
  const Avatar(
      {super.key,
      required this.radius,
      required this.avatarText,
      required this.imageUrl});

  Future<Uint8List?> loadImage() async {
    try {
      final response = await http.get(Uri.parse(imageUrl));
      if (response.statusCode == 200) {
        return response.bodyBytes;
      } else {
        print("Failed to load image with status code: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Error loading image: $e");
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Uint8List?>(
      future: loadImage(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError || snapshot.data == null) {
            // Handle error, show default image, or other fallback
            print("Error loading image: ${snapshot.error}");
            return CircleAvatar(
              backgroundColor: Colors.blue,
              radius: radius,
              child: Text(
                avatarText
                    .toUpperCase(), // Display the first letter of the username
                style: TextStyle(
                  color: Colors.white, // You can set the text color
                  fontWeight: FontWeight.bold,
                ),
              ), // You can adjust the size of the avatar
            );
            ; // Replace with your default image asset
          } else {
            // Display the loaded image
            return CircleAvatar(
                radius: 40,
                backgroundImage: Image.memory(snapshot.data!).image);
          }
        } else {
          // Show a loading indicator or placeholder
          return CircularProgressIndicator();
        }
      },
    );
  }
}
