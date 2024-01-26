import 'package:advanced_mobile_project/core/constants/validator.dart';
import 'package:advanced_mobile_project/core/dtos/login-dto.dart';
import 'package:advanced_mobile_project/presentation/log-in/login_in.dart';
import 'package:advanced_mobile_project/presentation/tutor-list/tutor_list.dart';
import 'package:advanced_mobile_project/services/authencation-service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  String? _email;
  String? _errorText = "";
  bool _isSuccess = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(65.0),
          child: Container(
            decoration: BoxDecoration(
              border: const Border(
                bottom: BorderSide(
                  color: Colors.grey,
                  width: 0.3,
                ),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.4),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: AppBar(
              backgroundColor: Colors.white,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      margin: const EdgeInsets.only(right: 10),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LogIn()),
                          );
                        },
                        child: SvgPicture.asset(
                          'assets/svgs/logo.svg',
                          width: 35,
                          height: 35,
                        ),
                      )),
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50.0),
                      child: SvgPicture.asset(
                        'assets/svgs/nation.svg',
                        width: 25,
                        height: 25,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        body: _isSuccess
            ? Center(
                child: Column(children: [
                Text(
                  AppLocalizations.of(context)!.forgotPassword_resetPassword,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 32,
                  ),
                ),
                Text(
                  AppLocalizations.of(context)!.forgotPassword_checkYourInbox,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                  ),
                ),
              ]))
            : SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Center(
                  child: Column(
                    children: [
                      Text(
                        AppLocalizations.of(context)!
                            .forgotPassword_resetPassword,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 32,
                        ),
                      ),
                      Text(
                        AppLocalizations.of(context)!
                            .forgotPassword_pleaseEnterYourEmail,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                        ),
                      ),
                      Column(
                        children: <Widget>[
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'EMAIL',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Color.fromRGBO(0, 0, 0, .6),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: 'mail@example.com',
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 15.0, horizontal: 10.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                            onChanged: (value) {
                              _email = value;
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      if (_errorText != "")
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            _errorText!,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor:
                                  const Color.fromRGBO(0, 113, 240, 1),
                            ),
                            onPressed: () {
                              setState(() {
                                _errorText = "";
                              });
                              onSendResetLink(_email!);
                            },
                            child: const Text(
                              'Send Reset Link',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  void onSendResetLink(String value) {
    String? validateEmail = Validator.emailValidate(value!);
    if (validateEmail != null) {
      setState(() {
        _errorText = validateEmail;
      });
      return;
    }

    AuthenticationService resetPassApi = AuthenticationService.instance;

    resetPassApi.forgotPassword(value).then((value) {
      if (value["status"] != "200") {
        print(value["message"]);
        setState(() {
          _errorText = value["message"];
        });
        return;
      } else
        setState(() {
          _isSuccess = true;
        });
    });
  }
}
