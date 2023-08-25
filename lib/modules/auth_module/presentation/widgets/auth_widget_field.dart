import 'package:flutter/material.dart';
import 'package:planner/theme/size_settings.dart';

class AuthTextFieldWidget extends StatelessWidget {
  final String? Function(String?)? validator;
  final String? Function(String?)? onSaved;
  final String? hintText;
  final String? Function(String?)? onChanged;
  final Widget? suffix;
  final Widget? prefix;
  bool? obscureText = false;
  AuthTextFieldWidget(
      {Key? key,
      this.obscureText,
      this.hintText,
      this.prefix,
      this.validator,
      this.onSaved,
      this.onChanged,
      required this.suffix})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 0.5, color: Colors.black12),
        ),
        child: Row(
          children: [
            prefix ?? SizedBox(),
            Expanded(
              child: TextFormField(
                  obscureText: obscureText ?? false,
                  onChanged: onChanged,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.all(SizeSettings.heightMultiplier),
                      hintText: hintText,
                      hintStyle: const TextStyle(color: Colors.black38)),
                  validator: validator,
                  onSaved: onSaved),
            ),
            suffix ?? SizedBox()
          ],
        ),
      ),
    );
  }
}
