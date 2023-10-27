import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class EntryFieldEmailWithValidateWidgets extends StatefulWidget {
  final bool isEmailWithValidate;
  final String label;
  final TextEditingController ctrl;
  final TextInputType type;
  final bool readOnly;
  final bool required;
  final bool autoFocus;
  final Widget? suffixIcon;
  final Function(String) onChanged;

  const EntryFieldEmailWithValidateWidgets({
    Key? key,
    this.isEmailWithValidate = false,
    required this.label,
    required this.ctrl,
    this.type = TextInputType.text,
    this.readOnly = false,
    this.required = false,
    this.autoFocus = false,
    required this.onChanged,
    this.suffixIcon,
  }) : super(key: key);

  @override
  _EntryFieldEmailWithValidateWidgetsState createState() =>
      _EntryFieldEmailWithValidateWidgetsState();
}

class _EntryFieldEmailWithValidateWidgetsState
    extends State<EntryFieldEmailWithValidateWidgets> {
  bool isFocused = false;
  bool isEmailValid = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: TextStyle(
            fontSize: 15,
          ),
        ),
        Container(
          padding: EdgeInsets.zero,
          width: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: 16),
          child: TextFormField(
            controller: widget.ctrl,
            keyboardType: widget.type,
            readOnly: widget.readOnly,
            autofocus: widget.autoFocus,
            onChanged: (value) {
              setState(() {
                isEmailValid = _validateEmail(value);
              });
              widget.onChanged(value);
            },
            onTap: () {
              setState(() {
                isFocused = false;
              });
            },
            decoration: InputDecoration(
              contentPadding:
              EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              border: _bordure(Colors.grey),
              fillColor: Colors.grey,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(color: Colors.orange),
              ),
              enabledBorder: _bordure(Colors.grey),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.red, width: 1.4),
              ),
              errorStyle: TextStyle(
                color: Colors.red,
              ),
              prefixIcon: Icon(
                Icons.email_outlined,
                color: isFocused ? Colors.orange : null,
              ),
              suffixIcon: widget.suffixIcon,
              hintText: 'Enter your email address',
              errorText: isEmailValid ? null : 'Invalid email',
            ),
            validator: (value) {
              if (value != null && widget.isEmailWithValidate && !_validateEmail(value)) {
                return 'Invalid email';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }

  bool _validateEmail(String value) {
    if (value.isEmpty) {
      return true; // Allow empty email field
    }
    return EmailValidator.validate(value);
  }
}

OutlineInputBorder _bordure(MaterialColor _color) {
  return OutlineInputBorder(
    borderSide: BorderSide(width: 1.5, color: _color),
  );
}