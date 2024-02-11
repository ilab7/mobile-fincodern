import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

Widget EntryFieldMobileNumberWidgets({
  bool isMobileNumber = false,
  String label = "",
  required TextEditingController ctrl,
  TextInputType type = TextInputType.number,
  Function(String)? onChanged,
  bool required = false,
}) {
  return Container(
    padding: EdgeInsets.zero,
    width: double.infinity,
    margin: EdgeInsets.symmetric(horizontal: 16),
    child: IntlPhoneField(
      decoration: InputDecoration(
        labelText: 'Phone Number',
        border: _bordure(Colors.grey),
        fillColor: Colors.grey,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.orange, width: 1.4),
        ),
        enabledBorder: _bordure(Colors.grey),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.red, width: 1.4),
        ),
        errorStyle: TextStyle(
          color: Colors.red,
        ),
      ),
      initialCountryCode: 'CD',
      onChanged: (phone) {
        ctrl.text = phone.completeNumber; // Update the value of the controller
        if (onChanged != null) {
          onChanged(phone.completeNumber); // Calling of the callback function
        }
      },
    )
  );
}

OutlineInputBorder _bordure(MaterialColor _color) {
  return OutlineInputBorder(
    borderSide: BorderSide(width: 1.5, color: _color),
  );
}

bool _isValidPhoneNumber(String value) {
  // Implement your phone number validation logic here
  // You can use regular expressions or any other custom validation logic
  // For example, checking if the value is a 10-digit number
  return value.length == 10 && int.tryParse(value) != null;
}