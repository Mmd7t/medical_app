import 'package:flutter/material.dart';
import 'package:medical_app/constants.dart';

class GlobalTextField extends StatelessWidget {
  final bool isObscure;
  final String hint;
  final Widget suffixIcon;
  final IconData prefixIcon;
  final double borderRadius;
  final String label;
  final Function validator;
  final Function onSaved;
  final TextInputAction textInputAction;
  final TextInputType textInputType;

  const GlobalTextField({
    Key key,
    this.isObscure,
    this.hint,
    this.suffixIcon,
    this.validator,
    @required this.prefixIcon,
    this.borderRadius = 60,
    this.onSaved,
    this.label,
    this.textInputAction,
    this.textInputType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isObscure ?? false,
      textInputAction: textInputAction,
      keyboardType: textInputType,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 16),
        hintText: hint,
        labelText: label,
        filled: true,
        fillColor: Constants.textFieldColor,
        hintStyle: const TextStyle(color: Colors.grey),
        prefixIcon: Icon(prefixIcon, color: Theme.of(context).primaryColor),
        suffixIcon: suffixIcon ?? const SizedBox(),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide.none,
        ),
      ),
      validator: (value) {
        return validator(value);
      },
      onSaved: (newValue) => onSaved(newValue),
    );
  }
}
