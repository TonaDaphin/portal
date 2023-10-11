import 'package:flutter/material.dart';
import 'package:requests_portal/test.dart';

import 'requests_list_page.dart';

class FileRequestPage extends StatelessWidget {
  FileRequestPage({super.key});

  final categoryController = TextEditingController();
  final facultyController = TextEditingController();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

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
                        color: Color.fromARGB(255, 166, 18, 31)),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    "File a request",
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
                                    controller: categoryController,
                                    textInputAction: TextInputAction.next,
                                    decoration: const InputDecoration(
                                      hintText: "Category",
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'enter category';
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
                                    controller: facultyController,
                                    textInputAction: TextInputAction.next,
                                    decoration: const InputDecoration(
                                      hintText: "faculty",
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'enter faculty member';
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
                                    controller: titleController,
                                    textInputAction: TextInputAction.next,
                                    decoration: const InputDecoration(
                                      hintText: "title",
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'enter title';
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
                                    controller: descriptionController,
                                    maxLines: 4,
                                    textInputAction: TextInputAction.next,
                                    decoration: const InputDecoration(
                                      hintText: "Description",
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'description';
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
                              onPressed: () {
                                addRequest(
                                    category: categoryController.text,
                                    faculty: facultyController.text,
                                    title: titleController.text,
                                    description: descriptionController.text,
                                    sender: "manyobwa");
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const RequestsListPage()));
                              },
                              child: const Text('Submit'),
                            ),
                          ),
                          const SizedBox(height: 32),
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
