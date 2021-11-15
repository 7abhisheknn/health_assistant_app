import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:health_assistant_app/helper/search_tap.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  CollectionReference collectionRef =
      FirebaseFirestore.instance.collection('user');
  List<Map<String, dynamic>> _allUsers = [];
  List<Map<String, dynamic>> _foundUsers = [];

  Future<void> getData() async {
    QuerySnapshot querySnapshot = await collectionRef.get();
    print(querySnapshot);
    // ignore: unnecessary_cast
    List<Map<String, dynamic>> allData = querySnapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList() as List<Map<String, dynamic>>;
    allData = allData.where((element) => element['is_doctor'] == true).toList();
    setState(() {
      _allUsers = allData;
      _foundUsers = allData;
    });
    print(allData);
  }

  @override
  initState() {
    getData();
    super.initState();
  }

  void _runFilter(String enteredKeyword) {
    List<Map<String, dynamic>> results = [];
    if (enteredKeyword.isEmpty) {
      results = _allUsers;
    } else {
      for (int i = 0; i < _allUsers.length; i++) {
        if (_allUsers[i]["username"]
            .toLowerCase()
            .contains(enteredKeyword.toLowerCase())) {
          results.add(_allUsers[i]);
          break;
        } else if (_allUsers[i]["email"]
            .toLowerCase()
            .contains(enteredKeyword.toLowerCase())) {
          results.add(_allUsers[i]);
          break;
        } else {
          bool contains = false;
          for (int j = 0; j < _allUsers[i]['specialist'].length; j++) {
            if (_allUsers[i]['specialist'][j]
                .toLowerCase()
                .contains(enteredKeyword.toLowerCase())) {
              results.add(_allUsers[i]);
              contains = true;
              break;
            }
          }
          if (contains == true) break;
          for (int j = 0; j < _allUsers[i]['degree'].length; j++) {
            if (_allUsers[i]['degree'][j]
                .toLowerCase()
                .contains(enteredKeyword.toLowerCase())) {
              results.add(_allUsers[i]);
              break;
            }
          }
        }
      }
    }
    setState(() {
      _foundUsers = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Doctors/Consultants'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const SizedBox(height: 20),
            TextField(
              onChanged: (value) => _runFilter(value),
              decoration: const InputDecoration(
                  labelText: 'Search', suffixIcon: Icon(Icons.search)),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: _foundUsers.isNotEmpty
                  ? ListView.builder(
                      itemCount: _foundUsers.length,
                      itemBuilder: (context, index) => Card(
                        key: UniqueKey(),
                        color: Colors.lightBlue[100],
                        elevation: 4,
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: ListTile(
                          onTap: () async {
                            await searchOnTap(_foundUsers[index]);
                            Navigator.of(context).pop();
                          },
                          leading: CircleAvatar(
                            backgroundImage:
                                NetworkImage(_foundUsers[index]['image_url']),
                          ),
                          title: Text(_foundUsers[index]['username']),
                          subtitle: Text(
                              '${_foundUsers[index]["email"]}\n${_foundUsers[index]["degree"]} | ${_foundUsers[index]["specialist"]}'),
                        ),
                      ),
                    )
                  : const Text(
                      'No results found',
                      style: TextStyle(fontSize: 24),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
