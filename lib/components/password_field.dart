import 'package:flutter/material.dart';

FormFieldValidator<String> passwordValidator(String errorString) {
  return (val) {
    if (val.length == 0) return errorString;
    return null;
  };
}

class PasswordField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final FormFieldValidator<String> validator;
  final ValueChanged<String> onSaved;
  final bool isLast;

  PasswordField({
    Key key,
    this.hintText,
    this.icon,
    this.validator,
    this.onSaved,
    this.isLast = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xfff6f6f6),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        cursorColor: Colors.black,
        autofocus: false,
        autocorrect: false,
        onSaved: onSaved,
        validator: validator,
        style: TextStyle(
            color: Colors.black, fontWeight: FontWeight.w400, fontSize: 18),
        obscureText: true,
        decoration: InputDecoration(
          hintText: hintText,
          // prefixIcon: Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 20),
          //   child: Padding(
          //     padding: const EdgeInsets.only(top: 12.0),
          //     child: Text(
          //       hintText,
          //       style: TextStyle(
          //           fontSize: 18,
          //           fontWeight: FontWeight.w400,
          //           color: Colors.black.withOpacity(0.5)),
          //     ),
          //   ),
          // ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Colors.white.withOpacity(0.2),
              width: 1,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Colors.white.withOpacity(0.2),
              width: 1,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
