import 'package:advanced_mobile_project/common/avatar.dart';
import 'package:advanced_mobile_project/common/error-dialog.dart';
import 'package:advanced_mobile_project/common/success-dialog.dart';
import 'package:advanced_mobile_project/core/dtos/upcoming-class-dto.dart';
import 'package:advanced_mobile_project/services/tutor-service.dart';
import 'package:advanced_mobile_project/services/user-service.dart';
import 'package:flutter/material.dart';

class CancelDialog extends StatefulWidget {
  UpcomingClassDTO classDTO;
  final void Function() reloadList;

  CancelDialog({required this.classDTO, required this.reloadList});

  @override
  _CancelDialogState createState() => _CancelDialogState();
}

class _CancelDialogState extends State<CancelDialog> {
  String selectedValue = '';
  String _note = '';
  List<String> _reasons = [
    'Reschedule at another time',
    'Busy at that time',
    'Asked by the tutor',
    'Other',
    ''
  ];

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: 650,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.close, color: Colors.grey),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                  child: Column(
                children: [
                  Avatar(
                      radius: 50,
                      avatarText: widget.classDTO.tutorName ?? "",
                      imageUrl: widget.classDTO.tutorAvatar ?? ""),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    widget.classDTO.tutorName ?? "Unknown",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Lesson time',
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    widget.classDTO.date ?? "Unknown",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ],
              )),
              SizedBox(
                height: 20,
              ),
              Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Text(
                    'What was the reason you cancel this booking?',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                  )),
              SizedBox(
                height: 20,
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[200]!),
                ),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: DropdownButton<String>(
                  hint: Text('Select an option'),
                  value: selectedValue,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedValue = newValue!;
                    });
                  },
                  items: _reasons.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[200]!),
                ),
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: Container(
                    alignment: Alignment.center,
                    child: TextField(
                      maxLines: 5,
                      decoration: InputDecoration(
                        hintText: 'Addition notes',
                      ),
                      onChanged: (String value) {
                        setState(() {
                          _note = value;
                        });
                      },
                    )),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                        side: const BorderSide(
                          color: Color(0xFF0071f0),
                          width: 2.0,
                        ),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    ),
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        color: Color(0xFF0071f0),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Color(0xFF0071f0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    ),
                    onPressed: _onSubmit,
                    child: Text(
                      'Submit',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onSubmit() async {
    int selectedIndex = 0;
    for (int i = 0; i < _reasons.length; i++) {
      if (_reasons[i] == selectedValue) {
        selectedIndex = i + 1;
        break;
      }
    }

    UserService userService = UserService.instance;
    Map res = await userService.cancelClass(
        widget.classDTO.scheduleId ?? "", selectedIndex, _note);
    if (res["status"] == "200") {
      widget.reloadList();
      
      Navigator.pop(context);
      showDialog(
        context: context,
        builder: (context) => BookingSuccessDialog(
          title: "Cancel",
          message: "Your cancelation request has been sent to the tutor.",
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => ErrorDialog(errorMessage: res["message"]),
      );
    }
  }
}
