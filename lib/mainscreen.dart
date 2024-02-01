import 'package:bloobak/dbmanager.dart';
import 'package:bloobak/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int index = 0;
  DbManager dbManager = DbManager();

  String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((MapEntry<String, String> e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }
  void Call(String no) {
    final Uri callLaunchUri = Uri.parse("tel:${no}");
    launchUrl(callLaunchUri);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Donors',
          style: TextStyle(
              fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.redAccent,
      ),
      body: FutureBuilder(
        future: dbManager.getDonorList(),
        builder: (BuildContext context, AsyncSnapshot<List<Donor>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(child: Icon(Icons.person)),
                  title: Text("${snapshot.data![index].name}",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                  trailing: Text("${snapshot.data![index].bgroup}"),
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Details"),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Name : ${snapshot.data![index].name}"),
                                Text("Age : ${snapshot.data![index].age}"),
                                Text(
                                    "Blood Group : ${snapshot.data![index].bgroup}"),
                                Text(
                                    "Mobile Phone : ${snapshot.data![index].phone}"),
                              ],
                            ),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Call("${snapshot.data![index].phone}");
                                  },
                                  child: Icon(Icons.phone)),
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('OK')),

                            ],
                          );
                        });
                  },
                );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => login()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
