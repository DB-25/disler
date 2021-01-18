import 'package:flutter/material.dart';

FormFieldValidator<String> emptyValidator(String errorString) {
  return (val) {
    if (val.isEmpty) return errorString;
    return null;
  };
}

FormFieldValidator<String> emailValidator() {
  return (val) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(val)) return 'Enter a valid email';
    return null;
  };
}

class InputField extends StatelessWidget {
  final String hintText;
  final FormFieldValidator<String> validator;
  final ValueChanged<String> onSaved;
  final bool isLast;

  final TextInputType inputType;

  InputField({
    Key key,
    this.hintText,
    this.validator,
    this.onSaved,
    this.inputType,
    this.isLast = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xfff2f2f2),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        keyboardType: inputType,
        textAlignVertical: TextAlignVertical.top,
        cursorColor: Colors.black,
        autofocus: false,
        autocorrect: false,
        onSaved: onSaved,
        validator: validator,
        style: TextStyle(
            color: Colors.black, fontWeight: FontWeight.w400, fontSize: 18),
        decoration: InputDecoration(
          hintText: hintText,
//          prefixIcon: Padding(
//            padding: const EdgeInsets.symmetric(horizontal: 20),
//            child: Padding(
//              padding: const EdgeInsets.only(top: 12.0),
//              child: Text(
//                hintText,
//                style: TextStyle(
//                    fontSize: 18,
//                    fontWeight: FontWeight.w400,
//                    color: Colors.black.withOpacity(0.5)),
//              ),
//            ),
//          ),
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
            borderSide: BorderSide(
              color: Colors.white.withOpacity(0.2),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
