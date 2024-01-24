import 'package:advanced_mobile_project/common/error-dialog.dart';
import 'package:advanced_mobile_project/common/success-dialog.dart';
import 'package:advanced_mobile_project/services/tutor-service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReportDialog extends StatefulWidget {
  final String tutorId;

  const ReportDialog({super.key, required this.tutorId});

  @override
  State<ReportDialog> createState() => _ReportDialogState();
}

class _ReportDialogState extends State<ReportDialog> {
  List<String> titles = [];
  List<bool> values = [false, false, false];
  String description = "";
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  void onSubmit() async {
    if (description.isEmpty) {
      showDialog(
        context: context,
        builder: (context) =>
            ErrorDialog(errorMessage: "Something went wrong! Try again."),
      );
      return;
    }

    TutorService tutorService = TutorService.instance;
    Map res = await tutorService.reportTutor(widget.tutorId, description);
    if (res["status"] == "200") {
      Navigator.pop(context);
      showDialog(
        context: context,
        builder: (context) => BookingSuccessDialog(
          title: "Report",
          message:
              "Your report has been sent to admin. Thank you for your feedback!",
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => ErrorDialog(errorMessage: res["message"]),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    titles.add("This tutor is annoying me");
    titles.add("This profile is pretending to be someone or is fake");
    titles.add("Inappropriate profile photo");

    return Dialog(
      child: Container(
        height: 450,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(Icons.report, color: Colors.red),
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: Text(
                        "Report",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                ...List.generate(
                  3,
                  (index) => CheckboxListTile(
                    title: Text(titles[index]),
                    value: values[index],
                    onChanged: (bool? value) {
                      setState(() {
                        if (value! == true) {
                          _descriptionController.text += "${titles[index]}\n";
                          description += "${titles[index]}\n";
                        } else {
                          _descriptionController.text = _descriptionController
                              .text
                              .replaceAll("${titles[index]}\n", "");
                          description =
                              description.replaceAll("${titles[index]}\n", "");
                        }
                        values[index] = value;
                      });
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[300]!),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextField(
                    controller: _descriptionController,
                    maxLines: 5,
                    decoration: InputDecoration(
                      hintText:
                          'Please let us know the details about your problems',
                      border: InputBorder.none,
                    ),
                    onChanged: (String value) {
                      setState(() {
                        for (int i = 0; i < 3; i++) {
                          if (value.contains(titles[i])) {
                            values[i] = true;
                          } else {
                            values[i] = false;
                          }
                        }
                        description = value;
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: 16,
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
                    _descriptionController.text.isNotEmpty
                        ? TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: Color(0xFF0071f0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 16),
                            ),
                            onPressed: onSubmit,
                            child: Text(
                              'Submit',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          )
                        : TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.grey[400]!,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 16),
                            ),
                            onPressed: null,
                            child: Text(
                              'Submit',
                              style: TextStyle(
                                color: Colors.grey[800]!,
                              ),
                            ),
                          )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
