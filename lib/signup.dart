import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:requests_portal/requests_list_page.dart';

import 'login.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final roleController = TextEditingController();
  final codeController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool same = false;

  final _formKey = GlobalKey<FormState>();
  // regular expression to check if string
  // 0: No password
  // 1/4: Weak
  // 2/4: Medium
  // 3/4: Strong
  //   1:   Great
  RegExp passwordValid = RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)");
  double passwordStrength = 0;
  //A function that validate user entered password
  bool validatePassword(String pass) {
    String password = pass.trim();
    if (password.isEmpty) {
      setState(() {
        passwordStrength = 0;
      });
    } else if (password.length < 6) {
      setState(() {
        passwordStrength = 1 / 4;
      });
    } else if (password.length < 8) {
      setState(() {
        passwordStrength = 2 / 4;
      });
    } else {
      if (passwordValid.hasMatch(password)) {
        setState(() {
          passwordStrength = 4 / 4;
        });
        return true;
      } else {
        setState(() {
          passwordStrength = 3 / 4;
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
      appBar: AppBar(elevation: 0),
      body: Column(
        children: [
          Flexible(
            fit: FlexFit.loose,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 32),
                  const Text(
                    "REQUEST PORTAL",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    "Create Your Account",
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                            ),
                            child: Row(
                              children: [
                                Flexible(
                                  child: TextFormField(
                                    controller: nameController,
                                    textInputAction: TextInputAction.next,
                                    decoration: const InputDecoration(
                                      hintText: "Full Name",
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'enter your name';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                            ),
                            child: Row(
                              children: [
                                Flexible(
                                  child: TextFormField(
                                    controller: emailController,
                                    keyboardType: TextInputType.emailAddress,
                                    textInputAction: TextInputAction.next,
                                    decoration: const InputDecoration(
                                      hintText: "email",
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'enterYourEmail';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                            ),
                            child: Row(
                              children: [
                                Flexible(
                                  child: TextFormField(
                                    controller: roleController,
                                    textInputAction: TextInputAction.next,
                                    decoration: const InputDecoration(
                                      hintText: "role",
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'enterYourRole';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                            ),
                            child: Row(
                              children: [
                                Flexible(
                                  child: TextFormField(
                                    controller: codeController,
                                    keyboardType: TextInputType.number,
                                    textInputAction: TextInputAction.next,
                                    decoration: const InputDecoration(
                                      hintText: "Faculty Code",
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'enterYourFacultyCode';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              children: [
                                Flexible(
                                  child: Column(
                                    children: [
                                      TextFormField(
                                          controller: passwordController,
                                          obscureText: true,
                                          decoration: InputDecoration(
                                            hintText: "password",
                                            suffix: GestureDetector(
                                              onTap: () {},
                                              child: const Icon(
                                                Icons.remove_red_eye_outlined,
                                                size: 16,
                                              ),
                                            ),
                                          ),
                                          onChanged: (value) {
                                            _formKey.currentState!.validate();
                                          },
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return "Please enter password";
                                            } else {
                                              //call function to check password
                                              bool result =
                                                  validatePassword(value);
                                              if (result) {
                                                // create account event
                                                return null;
                                              } else {
                                                return "Should contain Capital,Small letter,Number & Special Character";
                                              }
                                            }
                                          }),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: LinearProgressIndicator(
                                          value: passwordStrength,
                                          backgroundColor: Colors.grey[300],
                                          minHeight: 5,
                                          color: passwordStrength <= 1 / 4
                                              ? Colors.red
                                              : passwordStrength == 2 / 4
                                                  ? Colors.yellow
                                                  : passwordStrength == 3 / 4
                                                      ? Colors.blue
                                                      : Colors.green,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              children: [
                                Flexible(
                                  child: Column(
                                    children: [
                                      TextFormField(
                                          controller: confirmPasswordController,
                                          obscureText: true,
                                          decoration: InputDecoration(
                                            hintText: "confirm password",
                                            suffix: GestureDetector(
                                              onTap: () {},
                                              child: const Icon(
                                                Icons.remove_red_eye_outlined,
                                                size: 16,
                                              ),
                                            ),
                                          ),
                                          onChanged: (value) {
                                            if (passwordController.text ==
                                                confirmPasswordController
                                                    .text) {
                                              same = true;
                                            }
                                          },
                                          validator: (value) {
                                            if (!same) {
                                              return "Enter the same password";
                                            } else {
                                              print(confirmPasswordController.text);

                                              return null;
                                            }
                                          }),
                                      // Padding(
                                      //   padding: const EdgeInsets.all(8.0),
                                      //   child: LinearProgressIndicator(
                                      //     value: passwordStrength,
                                      //     backgroundColor: Colors.grey[300],
                                      //     minHeight: 5,
                                      //     color: passwordStrength <= 1 / 4
                                      //         ? Colors.red
                                      //         : passwordStrength == 2 / 4
                                      //             ? Colors.yellow
                                      //             : passwordStrength == 3 / 4
                                      //                 ? Colors.blue
                                      //                 : Colors.green,
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 32),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: ElevatedButton(
                              onPressed: passwordStrength != 1
                                  ? null
                                  : () async {
                                      try {
                                        await FirebaseAuth.instance
                                            .createUserWithEmailAndPassword(
                                          email: emailController.text,
                                          password: passwordController.text,
                                        );
                                        // Successfully signed up
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const RequestsListPage(),
                                          ),
                                        );
                                      } on FirebaseAuthException catch (e) {
                                        if (e.code == 'weak-password') {
                                          // Inform the user about password requirements (e.g., a stronger password is needed).
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                  'The password is too weak. It should have at least 6 characters.'),
                                            ),
                                          );
                                        } else if (e.code ==
                                            'email-already-in-use') {
                                          // Inform the user that the email is already associated with an account.
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                  'An account already exists for this email.'),
                                            ),
                                          );
                                        }
                                      } catch (e) {
                                        // Handle other exceptions here
                                        print(e);
                                      }
                                    },
                              child: const Text('continue'),
                            ),
                          ),
                          const SizedBox(height: 32),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginPage()));
                            },
                            child: const Text('Login'),
                          ),
                        ]),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
