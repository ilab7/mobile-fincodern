import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class EntryFieldMobileNumberWithValidateWidgets extends StatefulWidget {
  final bool isMobileNumberWithValidate;
  final String label;
  final TextEditingController ctrl;
  final TextInputType type;
  final bool readOnly;
  final bool required;
  final bool autoFocus;
  final Widget? suffixIcon;
  final Function(String) onChanged;

  const EntryFieldMobileNumberWithValidateWidgets({
    Key? key,
    this.isMobileNumberWithValidate = false,
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
  _EntryFieldMobileNumberWithValidateWidgetsState createState() =>
      _EntryFieldMobileNumberWithValidateWidgetsState();
}

class _EntryFieldMobileNumberWithValidateWidgetsState
    extends State<EntryFieldMobileNumberWithValidateWidgets> {
  bool isFocused = false;
  bool isPhoneNumberValid = true;

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
        //SizedBox(height: 7),
        Container(
            padding: EdgeInsets.zero,
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 16),
            child: IntlPhoneField(
              controller: widget.ctrl,
              keyboardType: widget.type,
              readOnly: widget.readOnly,
              autofocus: widget.autoFocus,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              onChanged: (value) {
                final phoneNumber = value.completeNumber; // Extract the phone number string
                setState(() {
                  if (phoneNumber == null || phoneNumber.isEmpty) {
                    return; // Allow empty phone number field
                  }
                });
                widget.onChanged(phoneNumber); // Pass the phone number string to the onChanged callback
              },
              onTap: () {
                setState(() {
                  isFocused = false;
                });
              },
              decoration: InputDecoration(
                hintText: 'Enter your phone number',
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
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(color: Colors.red),
                ),
                errorStyle: TextStyle(
                  color: Colors.red,
                ),
                prefixIcon: Icon(
                  Icons.phone_android,
                  color: isFocused ? Colors.orange : null,
                ),
                suffixIcon: widget.suffixIcon,
              ),
              validator: (value) {
                if (value != null && widget.isMobileNumberWithValidate) {
                  return 'Invalid Phone number';
                }
                return null;
              },
              initialCountryCode: 'CD',
            )),
      ],
    );
  }
}

OutlineInputBorder _bordure(MaterialColor _color) {
  return OutlineInputBorder(
    borderSide: BorderSide(width: 1.5, color: _color),
  );
}
