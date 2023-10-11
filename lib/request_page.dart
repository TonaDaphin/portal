import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:requests_portal/test.dart';

class RequestPage extends StatelessWidget {
  RequestPage({super.key, required this.requestId});

  final String requestId;
  final replyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(elevation: 0),
      body: FutureBuilder<DocumentSnapshot>(
        future: retrieveRequestById(requestId),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              // Retrieve the data
              Map<String, dynamic> data =
                  snapshot.data!.data() as Map<String, dynamic>;
              String category = data['category'];
              String faculty = data['faculty'];
              String title = data['title'];
              String description = data['description'];

              // Display the data in a Text widget
              return Padding(
                padding: const EdgeInsets.all(8.0),
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
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              // width: 50,
                              child: Text(
                                title,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  description,
                                  style: const TextStyle(
                                    fontSize: 17,
                                    // fontWeight: FontWeight.w600,
                                    color: Color(
                                      0xFF596065,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      category,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Color(
                                          0xFF596065,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 15),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Replies',
                          style: TextStyle(
                              color: Color.fromARGB(255, 166, 18, 31),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 15),
                      SizedBox(
                        height: 300,
                        child: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('request')
                              .doc(requestId)
                              .collection('replies')
                              .orderBy('timestamp', descending: false)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return CircularProgressIndicator();
                            }

                            final replies = snapshot.data!.docs;
                            if (replies.isEmpty) {
                              return const Text('No replies yet');
                            }
                            List<Widget> replyWidgets = [];

                            for (var reply in replies) {
                              final sender = reply['sender'] ?? '';
                              final replyText = reply['reply'] ?? '';

                              replyWidgets.add(
                                ListTile(
                                  title: Text(
                                    sender,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  subtitle: Text(
                                    replyText,
                                    style: const TextStyle(
                                      fontSize: 17,
                                      // fontWeight: FontWeight.w600,
                                      color: Color(
                                        0xFF596065,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }

                            return ListView(
                              children: replyWidgets,
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 100),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          children: [
                            Flexible(
                              child: TextFormField(
                                controller: replyController,
                                decoration: InputDecoration(
                                  hintText: "Reply...",
                                  suffix: GestureDetector(
                                    onTap: () {
                                      addReplyToRequest(
                                        requestId: requestId,
                                        sender: 'kankwanzi',
                                        reply: replyController.text,
                                        timestamp: Timestamp.now(),
                                      );
                                      replyController.text = '';
                                    },
                                    child: const Icon(
                                      Icons.send_sharp,
                                      size: 16,
                                      color: Color.fromARGB(255, 166, 18, 31),
                                    ),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'pleaseEnterYourRequest';
                                  }

                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return const Text('Request not found.');
            }
          } else {
            return const CircularProgressIndicator(); // Display a loading indicator
          }
        },
      ),
    );
  }
}
