import 'package:flutter/material.dart';

class CourseDetailCard extends StatelessWidget {
  final VoidCallback? onTap;
  final String title;
  final String description;

  const CourseDetailCard(
      {super.key, this.onTap, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            width: double.infinity,
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image(
                  image: AssetImage(
                    'assets/images/course-card.png',
                  ),
                  fit: BoxFit.contain,
                ),
                SizedBox(
                  height: 12,
                ),
                Container(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Text(
                          description,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Container(
                          width: double.infinity,
                          child: TextButton(
                              onPressed: null,
                              style: TextButton.styleFrom(
                                backgroundColor: Color(0xFF0071f0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Text(
                                'Discover',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              )),
                        ),
                      ],
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
