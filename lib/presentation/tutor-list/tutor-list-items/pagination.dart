import 'package:flutter/material.dart';

class Pagination extends StatefulWidget {
  final void Function(int) onPageChange;
  final int totalPage;

  const Pagination(
      {super.key, required this.onPageChange, required this.totalPage});

  @override
  State<Pagination> createState() => _PaginationState();
}

class _PaginationState extends State<Pagination> {
  int currentPage = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Wrap(
        // mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(
            child: Text(
              '<',
              style: TextStyle(
                color: Color(0xFF0071f0),
              ),
            ),
            onPressed: () {
              if (currentPage > 1) {
                setState(() {
                  currentPage--;
                  widget.onPageChange(currentPage);
                });
              }
            },
            style: TextButton.styleFrom(
              backgroundColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              side: const BorderSide(
                color: Color(0xFF0071f0),
                width: 0.5, // Set the border width
              ),
            ),
          ),
          for (int i = 1; i <= widget.totalPage; i++)
            TextButton(
              child: Text(
                i.toString(),
                style: TextStyle(
                  color: i == currentPage ? Colors.white : Color(0xFF0071f0),
                ),
              ),
              onPressed: () {
                setState(() {
                  currentPage = i;
                  widget.onPageChange(currentPage);
                });
              },
              style: TextButton.styleFrom(
                backgroundColor:
                    i == currentPage ? Color(0xFF0071f0) : Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                side: const BorderSide(
                  color: Color(0xFF0071f0),
                  width: 0.5, // Set the border width
                ),
              ),
            ),
          TextButton(
            child: Text(
              '>',
              style: TextStyle(
                color: Color(0xFF0071f0),
              ),
            ),
            onPressed: () {
              if (currentPage < widget.totalPage) {
                setState(() {
                  currentPage++;
                  widget.onPageChange(currentPage);
                });
              }
            },
            style: TextButton.styleFrom(
              backgroundColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              side: const BorderSide(
                color: Color(0xFF0071f0),
                width: 0.5, // Set the border width
              ),
            ),
          ),
        ],
      ),
    );
  }
}
