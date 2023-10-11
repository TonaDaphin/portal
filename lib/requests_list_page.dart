import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:requests_portal/file_request_page.dart';
import 'package:requests_portal/request_page.dart';
import 'package:requests_portal/test.dart';

class RequestsListPage extends StatefulWidget {
  const RequestsListPage({super.key});

  @override
  State<RequestsListPage> createState() => _RequestsListPageState();
}

class _RequestsListPageState extends State<RequestsListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(elevation: 0),
      body: Column(children: [
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
                      color: Color.fromARGB(255, 166, 18, 31),
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                      height: 600,
                      child: StreamBuilder<QuerySnapshot>(
                          stream: requests.snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            }

                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const CircularProgressIndicator(
                                color: Color.fromARGB(255, 166, 18, 31),
                              );
                            }

                            return ListView.separated(
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                final DocumentSnapshot request =
                                    snapshot.data!.docs[index];
                                return Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => RequestPage(
                                                    requestId:
                                                        request.id.toString(),
                                                  )));
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 8,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            child: Text(
                                              request['title']
                                                      .toString()
                                                      .isEmpty
                                                  ? 'title'
                                                  : request['title'].toString(),
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
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                request['description']
                                                        .toString()
                                                        .isEmpty
                                                    ? 'description'
                                                    : request['description']
                                                        .toString(),
                                                style: const TextStyle(
                                                  fontSize: 17,
                                                  // fontWeight: FontWeight.w600,
                                                  color: Color(
                                                    0xFF596065,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 8),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    request['faculty']
                                                            .toString()
                                                            .isEmpty
                                                        ? 'faculty'
                                                        : 'Faculty: ${request['faculty']}',
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                      fontStyle:
                                                          FontStyle.italic,
                                                      color: Color(
                                                        0xFF596065,
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    request['category']
                                                            .toString()
                                                            .isEmpty
                                                        ? 'category'
                                                        : request['category']
                                                            .toString(),
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500,
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
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) {
                                return const Divider(height: 0);
                              },
                            );
                          }),),
                ]),
          ),
        )
      ]),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        backgroundColor: Colors.transparent,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_outlined,
              color: Colors.white,
            ),
            label: 'Home',
            backgroundColor: Colors.transparent,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.ondemand_video_rounded,
              color: Color.fromARGB(255, 203, 59, 59),
            ),
            label: 'Vid',
            backgroundColor: Colors.transparent,
          ),
        ],
        currentIndex: _selectedIndex,
        // selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (_selectedIndex == 1) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FileRequestPage(),
          ),
        );
      }
    });
  }
}
