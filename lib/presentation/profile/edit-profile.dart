import 'dart:convert';
import 'dart:io';

import 'package:advanced_mobile_project/common/avatar.dart';
import 'package:advanced_mobile_project/common/error-dialog.dart';
import 'package:advanced_mobile_project/common/header.dart';
import 'package:advanced_mobile_project/common/menu.dart';
import 'package:advanced_mobile_project/common/success-dialog.dart';
import 'package:advanced_mobile_project/core/dtos/filter-item-dto.dart';
import 'package:advanced_mobile_project/core/states/user-state.dart';
import 'package:advanced_mobile_project/presentation/profile/profile-items/date-picker.dart';
import 'package:advanced_mobile_project/presentation/profile/profile-items/file-dialog.dart';
import 'package:advanced_mobile_project/services/user-service.dart';
import 'package:country_picker/country_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:multi_dropdown/models/value_item.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../core/dtos/user-dto.dart';

class EditProfile extends StatefulWidget {
  final UserDTO user;

  const EditProfile({super.key, required this.user});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  late UserDTO _user;
  bool _isError = false;
  late String _name;
  late String _nationality;
  late String _birthday;
  late String _studySchedule;
  File? _selectedAvatar;

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _studyScheduleController = TextEditingController();
  TextEditingController _countryController = TextEditingController();
  TextEditingController _birthdayController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _user = widget.user;

    _nameController.text = _user.name;
    _emailController.text = _user.email;
    _phoneController.text = _user.phone;
    _studyScheduleController.text = _user.studySchedule;
    _countryController.text = _user.country;
    _birthdayController.text = _user.birthday;

    _name = _user.name;
    _nationality = _user.country;
    _birthday = _user.birthday;
    _studySchedule = _user.studySchedule;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _countryController.dispose();
    _birthdayController.dispose();
    _studyScheduleController.dispose();
    super.dispose();
  }

  void onSubmit() async {
    if (_isError) {
      return;
    }

    UserService userService = UserService.instance;
    Map res = await userService.editProfile(
        _name, _nationality, _birthday, _studySchedule);

    if (res["status"] == "200") {
      UserDTO userDTO = UserDTO.fromJson(res["user"]);
      context.read<UserProvider>().setUserDTO(userDTO);

      setState(() {
        _user = userDTO;

        _emailController = TextEditingController(text: userDTO.email);
        _studyScheduleController =
            TextEditingController(text: userDTO.studySchedule);
        _countryController = TextEditingController(text: userDTO.country);
        _birthdayController = TextEditingController(text: userDTO.birthday);

        // Store values in state variables
        _name = userDTO.name;
        _nationality = userDTO.country;
        _birthday = userDTO.birthday;
        _studySchedule = userDTO.studySchedule;
      });
    }
    if (context.mounted) {
      showDialog(
          context: context,
          builder: (context) => SuccessDialog(
                title: 'Edit profile',
                message: 'You have edit your profile successfully',
              ));
    } else if (context.mounted) {
      showDialog(
          context: context,
          builder: (context) => ErrorDialog(
                errorMessage: res["message"],
              ));
    }
  }

  Future<File?> _selectAvatar() async {
    FilePickerResult? pickedFile = await FilePicker.platform.pickFiles(
        // allowedExtensions: ['jpg', 'png', 'jpeg'],
        );

    if (pickedFile != null) {
      setState(() {
        _selectedAvatar = File(pickedFile.files.single.path!);
      });
    }
    return _selectedAvatar;
  }

  Future<void> _uploadAvatar() async {
    if (_selectedAvatar == null) {
      return;
    }
    Map res = await UserService.instance.uploadAvatar(_selectedAvatar!);
    if (res["status"] == "200") {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final userProvider = context.read<UserProvider>();

        setState(() {
          _user.avatar = res["avatar"];
        });
        userProvider.setUserDTO(_user);
      });
    }
  }

  GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            key: _key,
            appBar: Header(scaffoldKey: _key),
            endDrawer: Menu(),
            body: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return FileDialog(
                                    onSubmit: () {
                                      _uploadAvatar();
                                      Navigator.pop(context);
                                    },
                                    onChooseFile: _selectAvatar,
                                  );
                                });
                          },
                          child: _user.avatar == null
                              ? Avatar(
                                  radius: 40,
                                  avatarText: _user.name,
                                  imageUrl: _user.avatar,
                                )
                              : CircleAvatar(
                                  radius: 50,
                                  backgroundImage: Image.network(
                                    _user.avatar!,
                                    fit: BoxFit.cover,
                                  ).image,
                                ),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _user.name,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                'Account ID: ${_user.id}',
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    Divider(
                      color: Colors.grey,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text('Name: '),
                    SizedBox(
                      height: 8,
                    ),
                    TextField(
                      controller: _nameController,
                      onChanged: (value) {
                        setState(() {
                          _name = value;
                          _nameController.text = value;
                        });
                      },
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text('Email: '),
                    SizedBox(
                      height: 8,
                    ),
                    TextField(
                      enabled: false,
                      controller: _emailController,
                      onChanged: (value) {},
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text('Country: '),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          flex: 3,
                          child: TextField(
                            controller: _countryController,
                            enabled: false,
                            onChanged: (String value) {},
                          ),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        TextButton(
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.grey)),
                          onPressed: () {
                            showCountryPicker(
                                context: context,
                                onSelect: (Country value) {
                                  setState(() {
                                    _nationality = value.countryCode;
                                    _countryController.text = value.countryCode;
                                  });
                                });
                          },
                          child: Text(
                            '...',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text('Phone: '),
                    SizedBox(
                      height: 8,
                    ),
                    TextField(
                        controller: _phoneController,
                        enabled: false,
                        onChanged: (value) {}),
                    SizedBox(
                      height: 16,
                    ),
                    Text('Birthday: '),
                    SizedBox(
                      height: 8,
                    ),
                    DatePicker(
                      label: 'Birthday',
                      isRequired: true,
                      controller: _birthdayController,
                      onChanged: (value) {
                        setState(() {
                          _birthday = value;
                          _birthdayController.text = value;
                        });
                      },
                      onError: (error) {
                        setState(() {
                          _isError = true;
                        });
                      },
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text('Study Schedule: '),
                    SizedBox(
                      height: 8,
                    ),
                    TextField(
                        controller: _studyScheduleController,
                        maxLines: 5,
                        onChanged: (value) {
                          setState(() {
                            _studySchedule = value;
                            _studyScheduleController.text = value;
                          });
                        }),
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
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              backgroundColor:
                                  MaterialStateProperty.all(Color(0xFF0071f0)),
                            ),
                            child: Text('Submit',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                )),
                            onPressed: onSubmit)
                      ],
                    )
                  ]),
            )));
  }
}
