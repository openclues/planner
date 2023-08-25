import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:planner/common_presentation/buttons.dart';
import 'package:planner/modules/auth_module/bloc/login_bloc/bloc/login_bloc_bloc.dart';
import 'package:planner/modules/auth_module/presentation/register_screen.dart';
import 'package:planner/modules/auth_module/presentation/widgets/auth_widget_field.dart';

import '../../../common_presentation/messages_helper.dart';
import '../../../theme/size_settings.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isValid = false;

  String? _email;

  late GlobalKey<FormState> _loginKey;

  bool _obscureText = true;

  String? _password;
  @override
  void initState() {
    _loginKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SingleChildScrollView(
        child: BlocListener<LoginBlocBloc, LoginBlocState>(
          listener: (context, state) {
            if (state is LoginBlocLoading) {
              MessageHelper.showLoading(context);
            }
            if (state is LoginBlocError) {
              MessageHelper.hideLoading(context);
              MessageHelper.showError(context, state.error);
            }
            if (state is LoginBlocSuccess) {
              MessageHelper.hideLoading(context);
              Navigator.of(context)
                  .pushNamedAndRemoveUntil('/', (route) => false);
              MessageHelper.showSuccess(context, "Logged in");
            }
          },
          child: Column(
            children: [
              const AuthScreenHeader(title: "", subString: ""),
              Container(
                height: SizeSettings.screenHeight! * 0.6,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Form(
                    key: _loginKey,
                    child: Column(
                      children: [
                        SizeSettings.smalPaddingHeightWidgetMulti(1),
                        Text(
                          "Login with your email",
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                        ),
                        SizeSettings.smalPaddingHeightWidgetMulti(1),
                        EmailField(
                            isValid: isValid,
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
                        PrimaryButton(
                          buttonText: "Login your account",
                          onPressed: () {
                            if (_loginKey.currentState!.validate()) {
                              _loginKey.currentState!.save();

                              context.read<LoginBlocBloc>().add(EmailLoginEvent(
                                  email: _email!, password: _password!));
                            }
                          },
                        ),
                        SizeSettings.smalPaddingHeightWidgetMulti(1),
                        const AuthFooterWidget(
                          cta: "Sign up",
                          push: "register",
                          title: "You do not have an account? ",
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool _validateEmail(String? v) {
    final bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(v!);

    return emailValid;
  }
}
