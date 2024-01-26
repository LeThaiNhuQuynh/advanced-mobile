import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FileDialog extends StatefulWidget {
  final void Function() onSubmit;
  final Future<File?> Function() onChooseFile;

  const FileDialog({
    super.key,
    required this.onSubmit,
    required this.onChooseFile,
  });

  @override
  State<FileDialog> createState() => _FileDialogState();
}

class _FileDialogState extends State<FileDialog> {
  File? _file;

  @override
  Widget build(BuildContext context) {
    return Dialog(
        child: Container(
      height: 600,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    _file == null ? 'No file' : _file!.path,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                TextButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      backgroundColor:
                          MaterialStateProperty.all(Color(0xFF0071f0)),
                    ),
                    onPressed: () {
                      widget.onChooseFile().then((value) {
                        setState(() {
                          _file = value;
                        });
                      });
                    },
                    child: const Icon(
                      Icons.upload_file,
                      color: Colors.white,
                    ))
              ],
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    side: MaterialStateProperty.all(
                      BorderSide(color: Color(0xFF0071f0)),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Cancel",
                    style: TextStyle(
                      color: Color(0xFF0071f0),
                    ),
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                TextButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    backgroundColor:
                        MaterialStateProperty.all(Color(0xFF0071f0)),
                  ),
                  onPressed: widget.onSubmit,
                  child: Text(
                    'Submit',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    ));
  }
}
