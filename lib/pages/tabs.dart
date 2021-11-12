import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:health_assistant_app/pages/home_page.dart';
import 'package:health_assistant_app/pages/search_page.dart';

class Tabs extends StatelessWidget {
  const Tabs({Key? key}) : super(key: key);
  void selectedItem(BuildContext context, item) {
    switch (item) {
      case 0:
        FirebaseAuth.instance.signOut();
        break;
      // case 1:
      //   print("Privacy Clicked");
      //   break;
      // case 2:
      //   print("User Logged out");
      //   Navigator.of(context).pushAndRemoveUntil(
      //       MaterialPageRoute(builder: (context) => LoginPage()),
      //       (route) => false);
      //   break;
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
            title: const Text('Tabs Demo'),
          ),
          body: const TabBarView(
            children: [
              HomePage(),
              Icon(Icons.auto_graph),
              Icon(Icons.list_alt),
            ],
          ),
        ),
      ),
    );
  }
}
