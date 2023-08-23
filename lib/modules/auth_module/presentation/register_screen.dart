import 'package:flutter/material.dart';
import 'package:planner/theme/size_settings.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              Container(
                height: SizeSettings.topPadding! * 5,
                width: SizeSettings.screenWidth,
                color: Theme.of(context).primaryColor.withOpacity(1),
                child: Stack(
                  children: [
                    // Positioned(
                    //   bottom: 100,
                    //   left: 100,
                    //   child: Circle(
                    //       color:
                    //           Theme.of(context).primaryColor.withOpacity(0.9)),
                    // ),
                    Positioned(
                      bottom: 100,
                      left: 50,
                      child: Circle(
                          color: Color.fromARGB(255, 10, 68, 148)
                              .withOpacity(0.3)),
                    ),
                    Positioned(
                      bottom: 110,
                      left: 40,
                      child: Circle(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: const Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Register",
                              style: TextStyle(
                                  fontSize: 50,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            Text(
                              "Create your account",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white54),
                            ),
                          ]),
                    ),
                  ],
                ), // Use primary color of the theme
              ),
            ],
          )
        ],
      ),
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
