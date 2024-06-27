import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String hintText;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;

  const CustomTextField({
    required this.label,
    required this.hintText,
    required this.onChanged,
    this.validator,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 2.0),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
        ),
        TextFormField(
          textAlignVertical: TextAlignVertical.center,
          textAlign: TextAlign.left,
          obscuringCharacter: '*',
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(),
            contentPadding: const EdgeInsets.symmetric(
              vertical: 15.0,
              horizontal: 10.0,
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6.0),
              borderSide: const BorderSide(color: Colors.redAccent),
            ),
            filled: false,
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6.0),
              borderSide: const BorderSide(color: Colors.redAccent),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6.0),
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6.0),
              borderSide: const BorderSide(),
            ),
            labelStyle: TextStyle(fontSize: 18),
          ),
          validator: validator,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
