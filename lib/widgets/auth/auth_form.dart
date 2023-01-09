import 'dart:io';


import 'package:flutter/material.dart';

import 'package:flutter_chat/widgets/pickers/user_image_picker.dart';
import 'package:image_picker/image_picker.dart';

class AuthForm extends StatefulWidget {
  AuthForm(
    this.submitFn,
    this.isLoading,
  );
  final bool isLoading;
  final void Function(
    String email,
    String userName,
    File? image,
    String password,
    bool isLogin,
    BuildContext ctx,
  ) submitFn;

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  var _isLogin = true;
  var _userEmail = '';
  var _userPassword = '';
  var _userName = '';
  File? _userImageFile;

  Future<void> _pickedImage(File? image) async {
    _userImageFile = image;
  }

  final ImagePicker _picker = ImagePicker();
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void _trySubmit() {
    final isValid = _formKey.currentState?.validate() ?? false;
    FocusScope.of(context).unfocus();

    if (_userImageFile == null) {
      print('1');
      retrieveLostData();
      print('2');
    }

    if (_userImageFile == null && !_isLogin) {
      //  print(isValid);
      final snackBar = SnackBar(
        content: Text("please pick an image"),
        backgroundColor: Theme.of(context).errorColor,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }

    if (isValid && _userImageFile != null && !_isLogin) {
      _formKey.currentState?.save();
      widget.submitFn(
        emailController.text,
        nameController.text,
        _userImageFile!,
        passwordController.text,
        _isLogin,
        context,
      );
    }
    //print("Authfo submitted");
  }

  // void _trySubmit() {
  //   bool isValid = _formKey.currentState!.validate() ?? false;
  //
  //
  //
  //   FocusScope.of(context).unfocus();
  //
  //   if (_userImageFile == null && !_isLogin) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text('Please pick an image'),
  //         backgroundColor: Theme.of(context).errorColor,
  //       ),
  //     );
  //     return;
  //   }
  //
  //   if (isValid) {
  //     _formKey.currentState!.save();
  //     //print(emailController.text);
  //     //print(nameController.text);
  //     //print(passwordController.text);
  //
  //     widget.submitFn(
  //       /*_userEmail,
  //       _userName,
  //       _userPassword,
  //       _userImageFile,
  //       _isLogin,
  //       context,*/
  //
  //       emailController.text,
  //       nameController.text,
  //        _userImageFile,
  //       passwordController.text,
  //       _isLogin,
  //       context,
  //     );
  //   }
  // }

  Future<void> retrieveLostData() async {
    final LostDataResponse response = await _picker.retrieveLostData();
    if (response.isEmpty) {
      print('response is empty');
      return;
    }
    if (response.file != null) {
      if (response.type == RetrieveType.image) {
        print('imageRetrived');
        await _pickedImage(response.file as File);
      }
      // else
      // {
      //   setState(() {
      //     if (_userImageFile == null) {
      //       _pickedImage;
      //     } else {
      //       _userImageFile;
      //     }
      //   });
      // }

    } else {
      print(response.exception!.code);
    }
    // _retrieveDataError = response.exception!.code;
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  if (!_isLogin)
                    UserImagePicker((pickedImage) {
                      setState(() {
                        _userImageFile = pickedImage;
                      });
                    }),
                  TextFormField(
                    key: ValueKey('email'),
                    validator: (value) {
                      if (value!.isEmpty || !value.contains('@')) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(labelText: 'Email address'),
                    controller: emailController,
                  ),
                  if (!_isLogin)
                    TextFormField(
                      key: ValueKey('username'),
                      validator: (value) {
                        if (value!.isEmpty || value.length < 4) {
                          return 'Username should contain at least 4 characters';
                        }
                        return null;
                      },
                      decoration: InputDecoration(labelText: 'UserName'),
                      controller: nameController,
                    ),
                  TextFormField(
                    key: ValueKey('password'),
                    validator: (value) {
                      if (value!.isEmpty || value.length < 7) {
                        return 'Password must be at least 7 characters long';
                      }
                      return null;
                    },
                    decoration: InputDecoration(labelText: 'Password'),
                    obscureText: true,
                    controller: passwordController,
                  ),
                  SizedBox(height: 12),
                  if (widget.isLoading) CircularProgressIndicator(),
                  if (!widget.isLoading)
                    ElevatedButton(
                      onPressed: () {
                        _trySubmit();
                      },
                      child: Text(_isLogin ? 'LogIn' : 'Signup'),
                    ),
                  if (!widget.isLoading)
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _isLogin = !_isLogin;
                        });
                      },
                      child: Text(_isLogin
                          ? 'Create new account'
                          : 'I already have an account'),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
