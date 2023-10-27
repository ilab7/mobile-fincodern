import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_fincopay/widgets/ChargementWidget.dart';
import 'package:mobile_fincopay/widgets/EntryFieldEmailWidgets.dart';
import 'package:mobile_fincopay/widgets/EntryFieldMobileNumberWidgets.dart';
import 'package:mobile_fincopay/widgets/ReusableEntryFieldWidgets.dart';

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

  Future<void> _saveChanges() async {
    setState(() {
      _isSaving = true;
    });

    // Simulate saving changes
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      _isSaving = false;
    });

    // Show a success message or navigate back to the previous screen
    // ...
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
                                    title: Text('Choose from galerie'),
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
                      backgroundImage: _selectedImage != null ? FileImage(_selectedImage!) : AssetImage('assets/avatard.jfif') as ImageProvider,
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}