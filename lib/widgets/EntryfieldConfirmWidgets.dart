import 'package:flutter/material.dart';

class EntryFieldConfirmWidgets extends StatefulWidget {
  final bool isConfirm;
  final String label;
  final TextEditingController ctrl;
  final TextInputType type;
  final bool required;
  final TextEditingController password;

  EntryFieldConfirmWidgets({
    Key? key,
    this.isConfirm = false,
    this.label = "",
    required this.ctrl,
    this.type = TextInputType.text,
    this.required = false,
    required this.password,
  }) : super(key: key);

  @override
  _EntryFieldConfirmWidgetsState createState() => _EntryFieldConfirmWidgetsState();
}

class _EntryFieldConfirmWidgetsState extends State<EntryFieldConfirmWidgets> {
  bool isConfirmVisible = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: TextFormField(
        obscureText: !isConfirmVisible,
        controller: widget.ctrl,
        keyboardType: widget.type,
        validator: (String? value) {
          if (!widget.required) return null;

          if (value == null || value.isEmpty) {
            return "${widget.label} is required";
          }

          if (value != widget.password.text) {
            return "Password does not match";
          }

          return null;
        },
        decoration: InputDecoration(
          labelText: widget.label,
          hintText: "Enter your ${widget.label}",
          border: _bordure(Colors.grey),
          fillColor: Colors.grey,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.orange),
          ),
          enabledBorder: _bordure(Colors.grey),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.red),
          ),
          errorStyle: TextStyle(
            color: Colors.red,
          ),
          suffixIcon: IconButton(
            icon: Icon(
              isConfirmVisible ? Icons.visibility_off : Icons.visibility,
              color: Colors.grey,
            ),
            onPressed: () {
              setState(() {
                isConfirmVisible = !isConfirmVisible;
              });
            },
          ),
        ),
      ),
    );
  }

  OutlineInputBorder _bordure(Color color) {
    return OutlineInputBorder(
      borderSide: BorderSide(width: 1.5, color: color),
    );
  }
}