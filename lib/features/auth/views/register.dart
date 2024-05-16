import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:talnts_app/common/widgets/colors.dart';
import 'package:talnts_app/common/widgets/round_button.dart';
import 'package:talnts_app/features/auth/controller/auth_controller.dart';
import 'package:talnts_app/features/auth/views/login.dart';
import 'package:talnts_app/features/auth/views/register_with_google.dart';

import '../../../common/widgets/textform_field.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final introdata = GetStorage();

  final _authController = Get.find<AuthController>();

  String? selectedValue;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool obscurePassword = false;
  bool terms = false;

  final _formKey = GlobalKey<FormState>();
  RegExp pass_valid = RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)");
  double password_strength = 0;

  void _submitEmail() {
    final enteredEmail = _emailController.text;
    Navigator.pushNamed(
      context,
      '/VerifyLogin',
      arguments: enteredEmail,
    );
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
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Register',
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
                      children: [
                        const Text(
                          'Fill in your details below to register on Talnts App',
                          style: TextStyle(color: Colors.black),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: LabelTextFormField(
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
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              child: LabelTextFormField(
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
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        LabelTextFormField(
                          hintText: 'Email Address',
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
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
                          height: 10,
                        ),
                        LabelTextFormField(
                          hintText: 'Password',
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
                          hintText: 'Confirm Password',
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
                          height: 10,
                        ),
                        Row(
                          children: [
                            Checkbox(
                                activeColor: primaryColor,
                                value: terms,
                                onChanged: (bool? val) {
                                  setState(() {
                                    terms = val!;
                                  });
                                }),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  // Get.to(() => PrivacyScreen());
                                },
                                child: RichText(
                                  textAlign: TextAlign.justify,
                                  text: TextSpan(
                                    text:
                                        'By signing up on this platform, you agree to Techsemester\'s',
                                    style: TextStyle(color: grey, fontSize: 11),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: '  Terms & Conditions',
                                          style: TextStyle(
                                              color: primaryColor,
                                              fontSize: 12))
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        RoundedButtonWidget(
                            buttonText: 'Register',
                            loading: _authController.isLoading.value,
                            width: double.infinity,
                            onpressed: () {
                              if (_formKey.currentState!.validate() || terms) {
                                _authController.register(
                                    firstName: _firstNameController.text,
                                    lastName: _lastNameController.text,
                                    emailAddress: _emailController.text,
                                    username: _userNameController.text,
                                    password: _passwordController.text);
                              }
                            }),
                        const SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: TextButton(
                            onPressed: () {
                              Get.offAll(() => const Login());
                            },
                            child: RichText(
                              text: TextSpan(
                                text: 'Already have an account?',
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 14),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: '  Login',
                                      style: TextStyle(
                                          color: primaryColor, fontSize: 16))
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Container(
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(color: const Color(0xFF474747)),
                          ),
                          child: Center(
                            child: Align(
                              alignment: Alignment.center,
                              child: SizedBox(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/images/google_icon.png',
                                      height: 25,
                                      width: 25,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Get.to(
                                            () => const RegisterWithGoogle());
                                      },
                                      child: const Text(
                                        'Register with Google',
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0XFF263238)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
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
