import 'package:flutter/material.dart';

class Carousel extends StatefulWidget {
  const Carousel({super.key});

  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  late PageController _pageController;
  int activePage = 1;

  List<String> images = [
    'assets/images/log-in.png',
    'assets/images/avatar1.jpeg',
    'assets/images/course-card.png',
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.8);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 700,
      width: MediaQuery.of(context).size.width - 100,
      child: PageView.builder(
          itemCount: images.length,
          pageSnapping: true,
          controller: _pageController,
          allowImplicitScrolling: true,
          onPageChanged: (page) {
            setState(() {
              activePage = page;
            });
          },
          itemBuilder: (context, pagePosition) {
            return Container(
              margin: EdgeInsets.all(10),
              child: Image.asset(images[pagePosition]),
            );
          }),
    );
  }
}
