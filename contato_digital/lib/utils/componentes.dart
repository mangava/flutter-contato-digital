import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final TextInputType keyboardType;  
  final bool obscureText;  
  final int maxLength;
  final isVisible;
  final showCounterCharacters;
  final bool readOnly;
  

  CustomTextFormField(
      {Key key,
      @required this.hintText,
      @required this.controller,
      this.keyboardType,      
      this.obscureText:false,
      this.maxLength,
      this.isVisible:true,      
      this.showCounterCharacters:false,
      this.readOnly:false
      })
      : super(key: key);

Widget counter(
  BuildContext context,
  {
    int currentLength,
    int maxLength,
    bool isFocused,
  }
) {
  return Text(
    this.showCounterCharacters ? 
    '$currentLength/$maxLength characters' : ""
  );
}

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      buildCounter: counter,      
      keyboardType: keyboardType, 
      readOnly: readOnly,
      decoration: InputDecoration(
        border: OutlineInputBorder(),       
        labelText:hintText,      
      ),     
      controller: controller,
      obscureText: obscureText,
      showCursor: true,
      maxLength: maxLength,
      
      validator: (value) {
        if (this.isVisible && value.trim().isEmpty) return 'Campo ${this.hintText} obrigatório';
        return null;
      },
    );
  }
}