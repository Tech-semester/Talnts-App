import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:talnts_app/common/widgets/colors.dart';
import 'package:talnts_app/common/widgets/round_button.dart';

import '../../../common/widgets/textform_field.dart';

class RegisterWithGoogle extends StatefulWidget {
  const RegisterWithGoogle({Key? key,}) : super(key: key);


  @override
  State<RegisterWithGoogle> createState() => _RegisterState();
}

class _RegisterState extends State<RegisterWithGoogle> {
  final introdata = GetStorage();

  String? selectedValue;
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
              child: Form(
                key: _formKey,
                child: Column(
                  children:  [
                    const SizedBox(
                      height: 20,
                    ),
                    Text('Register',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 24, color: primaryColor,
                        fontWeight: FontWeight.bold,),),
                    const SizedBox(
                      height: 3,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        width: 80,
                        color: primaryColor,
                        height: 3,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Column(
                      children: [
                        const Text('Fill in your details below to register on Talnts App',
                          style: TextStyle(color: Colors.black),
                          textAlign: TextAlign.center,),
                        const SizedBox(
                          height: 20,
                        ),
                        LabelTextFormField(
                          hintText: 'First Name',
                          controller: _firstNameController,
                          validator: (value) {
                            if (value != '') {
                              return null;
                            } else {
                              return "Field cannot be empty";
                            }
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        LabelTextFormField(
                          hintText: 'Last Name',
                          controller: _lastNameController,
                          validator: (value) {
                            if (value != '') {
                              return null;
                            } else {
                              return "Field cannot be empty";
                            }
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        LabelTextFormField(
                          hintText: 'Username',
                          controller: _userNameController,
                          validator: (value) {
                            if (value != '') {
                              return null;
                            } else {
                              return "Field cannot be empty";
                            }
                          },
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        RoundedButtonWidget(
                            buttonText: 'Register',
                            width: double.infinity,
                            onpressed: () {

                            }),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

