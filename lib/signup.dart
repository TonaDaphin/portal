import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:requests_portal/requests_list_page.dart';

import 'login.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final roleController = TextEditingController();
  final codeController = TextEditingController();
  final passwordController = TextEditingController();

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
                    // key: controller.form0Key,
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
                                  child: TextFormField(
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
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'please Enter YourPassword';
                                      }
                                      if (value.length < 6) {
                                        return 'password Should Have Atleast 6 Characters';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 32),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: ElevatedButton(
                              onPressed: () async {
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
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                            'The password is too weak. It should have at least 6 characters.'),
                                      ),
                                    );
                                  } else if (e.code == 'email-already-in-use') {
                                    // Inform the user that the email is already associated with an account.
                                    ScaffoldMessenger.of(context).showSnackBar(
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
