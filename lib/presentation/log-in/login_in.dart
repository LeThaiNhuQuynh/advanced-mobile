import 'package:advanced_mobile_project/core/constants/validator.dart';
import 'package:advanced_mobile_project/core/dtos/login-dto.dart';
import 'package:advanced_mobile_project/core/states/user-state.dart';
import 'package:advanced_mobile_project/presentation/log-in/log-in-items/forgot_password.dart';
import 'package:advanced_mobile_project/presentation/tutor-list/tutor_list.dart';
import 'package:advanced_mobile_project/services/authencation-service.dart';
import 'package:advanced_mobile_project/services/user-service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  bool _isLogin = true;
  bool _isPasswordVisible = false;

  final LoginDTO _loginDTO = LoginDTO(email: '', password: '');
  String? _errorText = "";

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
                        child: SvgPicture.asset(
                          'assets/svgs/logo.svg',
                          width: 35,
                          height: 35,
                        ),
                      ),
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
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin:
                          const EdgeInsets.only(right: 20, top: 20, bottom: 30),
                      child: Image.asset(
                        'assets/images/log-in.png',
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 20.0),
                      child: const Text(
                        'Say hello to your English tutors',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 33,
                          height: 1.2,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w800,
                          color: Color.fromRGBO(0, 113, 240, 1),
                        ),
                      ),
                    ),
                    // Some Text
                    Container(
                      margin: const EdgeInsets.only(top: 5, bottom: 5),
                      child: const Text(
                        'Become fluent faster through one on one video chat lessons tailored to your goals.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          height: 1.3,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          color: Color.fromRGBO(0, 0, 0, .9),
                        ),
                      ),
                    ),
                    // Login Fields
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
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
                                  _loginDTO.email = value;
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 25),
                          Column(
                            children: <Widget>[
                              const Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'PASSWORD',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Color.fromRGBO(0, 0, 0, .6),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              TextFormField(
                                obscureText: !_isPasswordVisible,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 15.0, horizontal: 10.0),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _isPasswordVisible =
                                            !_isPasswordVisible;
                                      });
                                    },
                                    icon: SizedBox(
                                      width: 16,
                                      height: 16,
                                      child: _isPasswordVisible
                                          ? SvgPicture.asset(
                                              'assets/svgs/password.svg',
                                              semanticsLabel: 'Password Icon',
                                            )
                                          : Container(
                                              child: const Icon(
                                                Icons.visibility,
                                                size: 16,
                                              ),
                                            ),
                                    ),
                                  ),
                                ),
                                onChanged: (value) {
                                  _loginDTO.password = value;
                                },
                              )
                            ],
                          ),
                          const SizedBox(height: 25),
                          Column(
                            children: <Widget>[
                              if (_isLogin)
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const ForgotPasswordPage(),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      'Forgot Password?',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Color.fromRGBO(40, 106, 210, 1),
                                      ),
                                    ),
                                  ),
                                ),
                              const SizedBox(height: 10),
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
                                height: 50,
                                width: double.infinity,
                                child: TextButton(
                                    style: TextButton.styleFrom(
                                      backgroundColor:
                                          const Color.fromRGBO(0, 113, 240, 1),
                                    ),
                                    onPressed: () {
                                      _isLogin ? _onLogin() : _onSignUp();
                                    },
                                    child: _isLogin
                                        ? const Text(
                                            'LOG IN',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w800,
                                            ),
                                          )
                                        : const Text(
                                            'SIGN UP',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w800,
                                            ),
                                          )),
                              ),
                            ],
                          ),
                          const SizedBox(height: 30),
                          Column(
                            children: <Widget>[
                              const Text(
                                'Or continue with',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    'assets/svgs/fb.svg',
                                    width: 40,
                                    height: 40,
                                  ),
                                  const SizedBox(width: 25),
                                  SvgPicture.asset(
                                    'assets/svgs/google.svg',
                                    width: 40,
                                    height: 40,
                                  ),
                                  const SizedBox(width: 25),
                                  ClipOval(
                                    child: Container(
                                      padding: const EdgeInsets.all(5.0),
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: const Color.fromRGBO(
                                              40, 106, 210, 1),
                                          width: 1.0,
                                        ),
                                      ),
                                      child: SvgPicture.asset(
                                          'assets/svgs/mobile-phone-2642.svg'),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Not a member yet?',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  MouseRegion(
                                    cursor: SystemMouseCursors.click,
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _isLogin = !_isLogin;
                                        });
                                      },
                                      child: _isLogin
                                          ? Text(
                                              'Sign up',
                                              style: TextStyle(
                                                color: Color(0xFF1890FF),
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            )
                                          : Text(
                                              'Login',
                                              style: TextStyle(
                                                color: Color(0xFF1890FF),
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 30),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )));
  }

  void _onLogin() {
    // String? validateEmail = Validator.emailValidate(_loginDTO.email!);
    // if (validateEmail != null) {
    //   setState(() {
    //     _errorText = validateEmail;
    //   });
    //   return;
    // }

    AuthenticationService authApi = AuthenticationService.instance;
    UserService userService = UserService.instance;
    final userProvider = context.read<UserProvider>();

    LoginDTO _loginDTO1 = LoginDTO(
      email: "student@lettutor.com",
      password: "123456",
    );

    authApi.login(_loginDTO1).then((value) {
      if (value["status"] != "200") {
        print(value["message"]);
        setState(() {
          _errorText = "Invalid email or password";
        });
        return;
      } else {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => TutorList()));

        userService.getUser().then((user) {
          if (value["status"] == "200") {
            userProvider.setUserDTO(user["user"]);
          }
          ;
        });
      }
    });
  }

  _onSignUp() {
    String? validateEmail = Validator.emailValidate(_loginDTO.email!);
    if (validateEmail != null) {
      setState(() {
        _errorText = validateEmail;
      });
      return;
    }

    String? validatePassword = Validator.passwordValidate(_loginDTO.password!);
    if (validatePassword != null) {
      setState(() {
        _errorText = validatePassword;
      });
      return;
    }

    AuthenticationService authApi = AuthenticationService.instance;

    authApi.register(_loginDTO).then((value) {
      if (value["status"] != "201") {
        print(value["message"]);
        setState(() {
          _errorText = value["message"];
        });
        return;
      } else
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Success"),
              content: Text("Registration successful!"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LogIn()),
                    );
                  },
                  child: Text("OK"),
                ),
              ],
            );
          },
        );
    });
  }
}
