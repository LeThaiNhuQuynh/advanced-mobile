import 'package:flutter/material.dart';

class MyTabBar extends StatefulWidget {
  final int quantity;
  final int? initialIndex;
  final List<Widget> tabs;
  final List<Widget> views;

  const MyTabBar(
      {super.key,
      required this.quantity,
      required this.tabs,
      required this.views,
      this.initialIndex = 0});

  @override
  State<MyTabBar> createState() => _MyTabBarState();
}

class _MyTabBarState extends State<MyTabBar> with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: widget.quantity, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: widget.quantity,
        child: Column(
          children: [
            TabBar(tabs: widget.tabs),
            Expanded(
                child: TabBarView(
              children: widget.views,
            ))
          ],
        ));
  }
}
