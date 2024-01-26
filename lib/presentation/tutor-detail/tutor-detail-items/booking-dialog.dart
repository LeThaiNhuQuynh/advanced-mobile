import 'dart:convert';

import 'package:advanced_mobile_project/core/constants/share-preference.dart';
import 'package:advanced_mobile_project/common/error-dialog.dart';
import 'package:advanced_mobile_project/common/success-dialog.dart';
import 'package:advanced_mobile_project/services/tutor-service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

class BookingDialog extends StatefulWidget {
  final DateTime time;
  final String bookingDetailId;
  final int walletAmount;
  late DateTime endTime;
  late DateFormat dateFormat;
  TutorService tutorService = TutorService.instance;
  final void Function() reloadSchedule;

  BookingDialog(
      {super.key,
      required this.time,
      required this.bookingDetailId,
      required this.walletAmount,
      required this.reloadSchedule}) {
    endTime = time.add(const Duration(minutes: 25));
    dateFormat = DateFormat(
        'HH:mm-${endTime.hour}:${endTime.minute} EEEE, MMMM dd, yyyy');
  }

  @override
  State<BookingDialog> createState() => _BookingDialogState();
}

class _BookingDialogState extends State<BookingDialog> {
  String _note = "";

  void onSubmit() async {
    bool success = await widget.tutorService
        .bookingSchedule(widget.bookingDetailId, _note);

    if (success == true) {
      Navigator.pop(context);

      showDialog(
        context: context,
        builder: (context) => SuccessDialog(
          title: "Booking",
          message: "Check you mail's inbox to see detail order",
        ),
      );

      widget.reloadSchedule();
    } else {
      showDialog(
        context: context,
        builder: (context) =>
            ErrorDialog(errorMessage: "Something went wrong! Try again."),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: 600,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    'Booking details',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  color: Colors.grey[200],
                  child: Text(
                    'Booking time',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  )),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[200]!),
                ),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                margin: EdgeInsets.symmetric(vertical: 12),
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.purple[100],
                  ),
                  child: Text(
                    widget.dateFormat.format(widget.time),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[200]!),
                    color: Colors.grey[200],
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Balance',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            'You have ${widget.walletAmount} lessons left',
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Price',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            '1 lesson',
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          )
                        ],
                      )
                    ],
                  )),
              SizedBox(
                height: 20,
              ),
              Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  color: Colors.grey[200],
                  child: Text(
                    'Notes',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  )),
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
                        hintText: 'Enter your notes here',
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
                          color: Color(
                              0xFF0071f0), // Set your desired border color here
                          width: 2.0, // Set the border width
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
                    width: 12,
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
                    onPressed: onSubmit,
                    child: Text(
                      '>> Book',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
