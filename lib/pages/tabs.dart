import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:health_assistant_app/pages/chat_page.dart';
import 'package:health_assistant_app/pages/form_page.dart';
import 'package:health_assistant_app/pages/home_page.dart';
import 'package:health_assistant_app/pages/search_page.dart';

class Tabs extends StatefulWidget {
  const Tabs({Key? key}) : super(key: key);

  @override
  State<Tabs> createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  void selectedItem(BuildContext context, item) {
    switch (item) {
      case 0:
        FirebaseAuth.instance.signOut();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SearchPage()),
                  );
                },
                child: const Icon(Icons.search),
              ),
              PopupMenuButton<int>(
                onSelected: (item) => selectedItem(context, item),
                itemBuilder: (context) => [
                  const PopupMenuItem<int>(
                      value: 0,
                      child: Text(
                        'Logout',
                        style: TextStyle(color: Colors.red),
                      )),
                ],
              ),
            ],
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.home)),
                Tab(icon: Icon(Icons.auto_graph)),
                Tab(icon: Icon(Icons.list_alt)),
              ],
            ),
            title: const Text('Health Assistant App'),
          ),
          body: TabBarView(
            children: [
              const HomePage(),
              const FormPage(),
              ChatPage(id: FirebaseAuth.instance.currentUser!.uid),
            ],
          ),
        ),
      ),
    );
  }
}
