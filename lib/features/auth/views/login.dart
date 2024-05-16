import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:talnts_app/common/widgets/colors.dart';
import 'package:talnts_app/common/widgets/round_button.dart';
import 'package:talnts_app/features/auth/controller/auth_controller.dart';
import 'package:talnts_app/features/auth/views/forgot_password.dart';
import 'package:talnts_app/features/auth/views/register.dart';

import '../../../common/widgets/textform_field.dart';

class Login extends StatefulWidget {
  const Login({
    Key? key,
  }) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final introdata = GetStorage();

  String? selectedValue;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool obscurePassword = false;
  final AuthController _authController = Get.put(AuthController());

  final _formKey = GlobalKey<FormState>();

  bool validateEmail(String email) {
    final valid_email = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return valid_email.hasMatch(email);
  }

  @override
  void initState() {
    _emailController.text = introdata.read('lastLoginEmail') ?? '';
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
                      height: 30,
                    ),
                    Text(
                      'Welcome',
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
                      height: 70,
                    ),
                    Column(
                      children: [
                        LabelTextFormField(
                          hintText: 'Email Address',
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (val) {
                            validateEmail(val);
                          },
                          validator: (value) {
                            if (value == '') {
                              return "Field cannot be empty";
                            } else {
                              bool result = validateEmail(value!);
                              if (result) {
                                return null;
                              } else {
                                return "Email format not correct";
                              }
                            }
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        LabelTextFormField(
                          hintText: 'Password',
                          controller: _passwordController,
                          obscureText: !obscurePassword,
                          validator: (value) {
                            if (value != '') {
                              return null;
                            } else {
                              return "Field cannot be empty";
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(''),
                            GestureDetector(
                              onTap: () {
                                Get.offAll(() => const ForgotPassword());
                              },
                              child: Text(
                                'Forgot Password?',
                                style: TextStyle(
                                    color: primaryColor, fontSize: 15),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Obx(() => RoundedButtonWidget(
                            loading: _authController.isLoading.value,
                            buttonText: 'Login',
                            width: double.infinity,
                            onpressed: () {
                              if (_formKey.currentState!.validate()) {
                                _authController.login(
                                    email: _emailController.text.trim(),
                                    password: _passwordController.text);
                              }
                            })),
                        const SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: TextButton(
                            onPressed: () {
                              Get.offAll(() => const Register());
                            },
                            child: RichText(
                              text: TextSpan(
                                text: 'Don\'t have an account?',
                                style: TextStyle(color: grey, fontSize: 15),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: '  Sign up',
                                      style: TextStyle(
                                          color: primaryColor, fontSize: 15))
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
                                    const Text(
                                      'Login with Google',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0XFF263238)),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        )
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
