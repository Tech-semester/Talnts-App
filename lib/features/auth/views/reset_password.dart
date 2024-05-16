import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:talnts_app/common/widgets/colors.dart';
import 'package:talnts_app/common/widgets/round_button.dart';
import 'package:talnts_app/features/auth/controller/auth_controller.dart';

import '../../../common/widgets/textform_field.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword(
      {Key? key, required this.emailAddress, required this.otpCode})
      : super(key: key);

  final String emailAddress;
  final int otpCode;

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final introdata = GetStorage();

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  RegExp pass_valid = RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)");
  double password_strength = 0;
  bool obscurePassword = false;

  final _formKey = GlobalKey<FormState>();
  final AuthController _authController = Get.put(AuthController());

  @override
  void initState() {
    super.initState();
  }

  bool validatePassword(String pass) {
    String _password = pass.trim();
    if (_password.isEmpty) {
      setState(() {
        password_strength = 0;
      });
    } else if (_password.length < 6) {
      setState(() {
        password_strength = 1 / 4;
      });
    } else if (_password.length < 8) {
      setState(() {
        password_strength = 2 / 4;
      });
    } else {
      if (pass_valid.hasMatch(_password)) {
        setState(() {
          password_strength = 4 / 4;
        });
        return true;
      } else {
        setState(() {
          password_strength = 3 / 4;
        });
        return false;
      }
    }
    return false;
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
              padding: const EdgeInsets.symmetric(
                  horizontal: 20.0, vertical: 15),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    Text(
                      'Reset Password',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Enter your new password in the fields below',
                          style:
                          TextStyle(color: Colors.black, fontSize: 15),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 60,
                        ),
                        LabelTextFormField(
                          hintText: 'Enter New Password',
                          controller: _passwordController,
                          obscureText: !obscurePassword,
                          onChanged: (val) {
                            validatePassword(val);
                          },
                          validator: (value) {
                            if (value == '') {
                              return "Please enter password";
                            } else {
                              //call function to check password
                              bool result = validatePassword(value!);
                              if (result) {
                                return null;
                              } else {
                                return " Password should contain Capital, small letter & Number & Special";
                              }
                            }
                          },
                          suffixIcon: IconButton(
                            icon: Icon(
                                obscurePassword
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: grey),
                            onPressed: () {
                              setState(() {
                                obscurePassword = !obscurePassword;
                              });
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        LabelTextFormField(
                          hintText: 'Confirm New Password',
                          controller: _confirmPasswordController,
                          validator: (value) {
                            if (value == '') {
                              return "Please enter your password again";
                            } else {
                              if (_passwordController.text ==
                                  _confirmPasswordController.text) {
                                return null;
                              } else {
                                return 'Passwords do not match';
                              }
                            }
                          },
                          suffixIcon: IconButton(
                            icon: Icon(
                                obscurePassword
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: grey),
                            onPressed: () {
                              setState(() {
                                obscurePassword = !obscurePassword;
                              });
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Obx(() => RoundedButtonWidget(
                            loading: _authController.isLoading.value,
                            buttonText: 'Reset Password',
                            width: double.infinity,
                            onpressed: () {
                              if (_formKey.currentState!.validate()) {
                                _authController.resetPassword(
                                  widget.emailAddress,
                                  _passwordController.text,
                                  widget.otpCode,
                                );
                              }
                            }))
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
