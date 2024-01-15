import 'package:flutter/material.dart';

class VideoCall extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Call'),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(height: 150),
            Column(
              children: [
                CircleAvatar(
                  radius: 80,
                  backgroundImage: AssetImage('assets/images/avatar1.jpeg'),
                ),
                SizedBox(height: 16),
                Text(
                  'Keegan',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Connecting...',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            SizedBox(height: 32),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      icon: Icon(Icons.volume_up),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Icon(Icons.mic),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Icon(Icons.videocam),
                      onPressed: () {},
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      icon: Icon(Icons.screen_share),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Icon(Icons.chat),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Icon(Icons.pan_tool),
                      onPressed: () {},
                    ),
                  ],
                ),
                SizedBox(height: 32),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                  ),
                  onPressed: () {},
                  child: Text(
                    'End Call',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12)
          ],
        ),
      ),
    );
  }
}
