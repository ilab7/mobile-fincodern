import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_fincopay/controllers/UserController.dart';
import 'package:mobile_fincopay/widgets/ChargementWidget.dart';
import 'package:mobile_fincopay/widgets/EntryFieldEmailWidgets.dart';
import 'package:mobile_fincopay/widgets/EntryFieldMobileNumberWidgets.dart';
import 'package:mobile_fincopay/widgets/GenderWidget.dart';
import 'package:gender_picker/source/enums.dart';
import 'package:mobile_fincopay/widgets/MessageWidgets.dart';
import 'package:mobile_fincopay/widgets/ReusableEntryFieldWidgets.dart';
import 'package:provider/provider.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  File? _selectedImage;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  bool _isSaving = false;

  var email = TextEditingController();
  var phone = TextEditingController();
  var fullname = TextEditingController();
  var address = TextEditingController();

  bool isVisible = false;
  var formKey = GlobalKey<FormState>();

  Gender? selectedGender;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedImage = await ImagePicker().pickImage(source: source);
    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: _isSaving ? null : _saveChanges,
          ),
        ],
        backgroundColor: Color(0xFF040034),
      ),
      body: Stack(
        children: [
          _body(context),
          ChargementWidget(isVisible)
        ],
      ),
    );
  }

  Widget _body(BuildContext context) {
    return Form(
      key: formKey,
      child: ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(06.0),
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.015),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Select a picture'),
                            content: SingleChildScrollView(
                              child: ListBody(
                                children: <Widget>[
                                  ListTile(
                                    leading: Icon(Icons.camera),
                                    title: Text('Take a picture'),
                                    onTap: () {
                                      _pickImage(ImageSource.camera);
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  ListTile(
                                    leading: Icon(Icons.photo_library),
                                    title: Text('Choose from gallery'),
                                    onTap: () {
                                      _pickImage(ImageSource.gallery);
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: CircleAvatar(
                      radius: 80.0,
                      backgroundImage: _selectedImage != null ? FileImage(_selectedImage!) : AssetImage('assets/avatard.png') as ImageProvider,
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                ReusableEntryFieldWidgets(
                  ctrl: fullname,
                  label: "Full name",
                  required: true,
                  isName: false,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.015),
                EntryFieldEmailWidgets(
                  ctrl: email,
                  required: true,
                  label: "Email",
                  isEmail: false,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.015),
                EntryFieldMobileNumberWidgets(
                  ctrl: phone,
                  label: "Phone",
                  required: true,
                  isMobileNumber: false,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.015),
                ReusableEntryFieldWidgets(
                  ctrl: address,
                  label: "Address",
                  required: true,
                  isName: false,
                ),
                GenderSelectionWidget(
                  showOtherGender: true,
                  alignVertical: false,
                  onChanged: (Gender? gender) {
                    print(gender);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _saveChanges() async {
    FocusScope.of(context).requestFocus(new FocusNode());
    if (!formKey.currentState!.validate()) {
      return;
    }

    isVisible = true;
    setState(() {
      _isSaving = true;
    });

    var ctrl = context.read<UserController>();
    // Create the request payload
    Map data = {
      'fullName': fullname.text,
      'email': email.text,
      'phone': phone.text,
      'address': address.text,
      'gender': selectedGender.toString(),
      // Add any other fields as needed
    };

    var response = await ctrl.updateProfil(data);
    await Future.delayed(Duration(seconds: 1));

    isVisible = false;
    setState(() {});

    if (response.status) {
      await Future.delayed(Duration(seconds: 1));
      setState(() {});
      } else {
      var msg =
      response.isException == true ? response.errorMsg : (response.data?['message']);
      MessageWidgets.showSnack(context, msg);
    }

    setState(() {
      _isSaving = false;
    });
  }
}