import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:planner/modules/auth_module/bloc/register_bloc/bloc/register_bloc.dart';

import 'package:planner/theme/size_settings.dart';

import '../../../common_presentation/buttons.dart';
import '../../../common_presentation/loading_dialog.dart';
import '../../../common_presentation/messages_helper.dart';
import 'widgets/auth_widget_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool isValid = false;
  bool _obscureText = true;
  String? _email;
  String? _password;
  bool? _rememberMe = false;
  late GlobalKey<FormState> _registerKey;
  bool _validateEmail(String? v) {
    final bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(v!);

    return emailValid;
  }

  @override
  void initState() {
    _registerKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: BlocListener<RegisterBloc, RegisterState>(
        listener: (context, state) async {
          if (state is RegisterLoading) {
            MessageHelper.showLoading(context);
          }
          if (state is RegisterError) {
            MessageHelper.hideLoading(context);
            MessageHelper.showError(context, state.error);
          }
          if (state is RegisterSuccess) {
            MessageHelper.hideLoading(context);
            Navigator.of(context).pushNamedAndRemoveUntil(
              'login',
              (route) => false,
            );
            MessageHelper.showSuccess(context,
                "Your account was created \nWe have send you a link on your email to activate your account");
          }
        },
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: SizeSettings.screenHeight! * 0.4,
                child: const AuthScreenHeader(
                  subString: "Create your account",
                  title: "Register",
                ),
              ),
              Container(
                height: SizeSettings.screenHeight! * 0.6,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _registerKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Register with your email",
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                        ),
                        SizeSettings.smalPaddingHeightWidgetMulti(3),
                        EmailField(
                            validator: (v) {
                              if (!_validateEmail(v)) {
                                return "Enter a valid Email";
                              }
                            },
                            onSaved: (v) {
                              setState(() {
                                _email = v;
                              });
                            },
                            isValid: isValid,
                            onChanged: (v) {
                              if (_validateEmail(v)) {
                                setState(() {
                                  isValid = true;
                                });
                              } else {
                                setState(() {
                                  isValid = false;
                                });
                              }
                              return null;
                            }),
                        AuthTextFieldWidget(
                          obscureText: _obscureText,
                          prefix: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              IconlyLight.lock,
                              size: 30,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          hintText: "Password",
                          suffix: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                              child: Icon(
                                _obscureText == true
                                    ? FontAwesomeIcons.eyeSlash
                                    : FontAwesomeIcons.eye,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          onChanged: (v) {},
                          // key: Key("EmailRegister"),
                          validator: (v) {
                            if (v == null || v.isEmpty) {
                              return "Password is required";
                            }
                            return null;
                          },
                          onSaved: (v) {
                            setState(() {
                              _password = v;
                            });
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Checkbox(
                                        value: _rememberMe,
                                        onChanged: (v) {
                                          setState(() {
                                            _rememberMe = v;
                                          });
                                        }),
                                    const Text(
                                      "Remember me",
                                      style: TextStyle(color: Colors.black38),
                                    )
                                  ],
                                ),
                              ),
                              const Text(
                                "Forgot password?",
                                style: TextStyle(color: Colors.redAccent),
                              )
                            ],
                          ),
                        ),
                        SizeSettings.smalPaddingHeightWidgetMulti(3),
                        PrimaryButton(
                          buttonText: "Register",
                          onPressed: () {
                            if (_registerKey.currentState!.validate()) {
                              _registerKey.currentState!.save();
                              context.read<RegisterBloc>().add(EmailRegister(
                                  email: _email!, password: _password!));
                            }
                          },
                        ),
                        SizeSettings.smalPaddingHeightWidgetMulti(1),
                        const AuthFooterWidget(
                          cta: "Login",
                          push: "login",
                          title: "Do you have an account? ",
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class AuthFooterWidget extends StatelessWidget {
  final String title;
  final String cta;
  final String push;
  const AuthFooterWidget({
    super.key,
    required this.title,
    required this.cta,
    required this.push,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(title),
        GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(push);
          },
          child: Text(
            cta,
            style: const TextStyle(color: Colors.redAccent),
          ),
        ),
      ],
    );
  }
}

class EmailField extends StatelessWidget {
  final String? Function(String?)? onChanged;
  final String? Function(String?)? validator;
  final String? Function(String?)? onSaved;
  const EmailField({
    super.key,
    required this.isValid,
    this.onChanged,
    this.validator,
    this.onSaved,
  });

  final bool isValid;

  @override
  Widget build(BuildContext context) {
    return AuthTextFieldWidget(
        prefix: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            IconlyLight.message,
            size: 30,
            color: Theme.of(context).primaryColor,
          ),
        ),
        hintText: "Email Address",
        suffix: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            FontAwesomeIcons.check,
            color: isValid == true ? Colors.green : Colors.black12,
          ),
        ),
        onChanged: onChanged,
        // key: Key("EmailRegister"),
        validator: validator,
        onSaved: onSaved);
  }
}

class AuthScreenHeader extends StatelessWidget {
  final String title;
  final String subString;
  const AuthScreenHeader({
    Key? key,
    required this.title,
    required this.subString,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeSettings.screenHeight! * 0.4, width: SizeSettings.screenWidth,
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withOpacity(1),
          borderRadius: BorderRadius.circular(15)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
              height: SizeSettings.screenHeight! * 0.4,
              // width: SizeSettings.screenWidth,
              child: Image.asset('assets/pla.png')),
          // const Expanded(
          //   child: Text(
          //     "Planner",
          //     style: TextStyle(color: Colors.white, fontSize: 50),
          //   ),
          // )
        ],
      ), // Use primary color of the theme
    );
  }
}

class Circle extends StatelessWidget {
  final Color color;

  const Circle({Key? key, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 500,
      height: 500,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
    );
  }
}
