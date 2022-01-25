import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyText extends StatelessWidget {
  final String hintText;
  final Function validator;
  final Function onSaved;
  final bool isPassword;
  final bool isEmail;
  final int linesize;
  final Key k;
  final TextEditingController Controller;
  final bool enable;
  final Function onChanged;


  MyText({
    this.hintText,
    this.validator,
    this.onSaved,
    this.Controller,
    this.onChanged,
    this.isPassword = false,
    this.isEmail = false,
    this.linesize = 1,
    this.k,
    this.enable,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: hintText,
          contentPadding: EdgeInsets.all(15.0),
          border: InputBorder.none,
          filled: true,
          fillColor: Colors.grey[200],
        ),
        obscureText: isPassword ? true : false,

        validator: validator,
        onSaved: onSaved,
        onChanged: onChanged,
        controller: Controller,
        keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.multiline,
        maxLines: linesize,
        minLines: null,
        key:k,
        enabled: enable,


      ),
    );
  }
}