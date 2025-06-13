import 'package:flutter/material.dart';
import 'package:presensi/login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Pegawai Rajin",
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 20),
              Container(
                width: 400,
                decoration: BoxDecoration(color: Colors.blue[800]),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text("3 Juni 2025",
                          style: TextStyle(color: Colors.white, fontSize: 16)),
                      SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              Text("07.00",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 24)),
                              Text("Masuk",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16)),
                            ],
                          ),
                          Column(
                            children: [
                              Text("17.00",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 24)),
                              Text("Pulang",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16)),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text("Riwayat Presensi"),
              Card(
                child: ListTile(
                  leading: Text("2 Juni 2025"),
                  title: Row(children: [
                    Column(
                      children: [
                        Text("07.00", style: TextStyle(fontSize: 18)),
                        Text("Masuk", style: TextStyle(fontSize: 14)),
                      ],
                    ),
                    SizedBox(width: 20),
                    Column(
                      children: [
                        Text("17.00", style: TextStyle(fontSize: 18)),
                        Text("Pulang", style: TextStyle(fontSize: 14)),
                      ],
                    ),
                  ]),
                ),
              ),
              Card(
                child: ListTile(
                  leading: Text("2 Juni 2025"),
                  title: Row(children: [
                    Column(
                      children: [
                        Text("07.00", style: TextStyle(fontSize: 18)),
                        Text("Masuk", style: TextStyle(fontSize: 14)),
                      ],
                    ),
                    SizedBox(width: 20),
                    Column(
                      children: [
                        Text("17.00", style: TextStyle(fontSize: 18)),
                        Text("Pulang", style: TextStyle(fontSize: 14)),
                      ],
                    ),
                  ]),
                ),
              ),
              Card(
                child: ListTile(
                  leading: Text("2 Juni 2025"),
                  title: Row(children: [
                    Column(
                      children: [
                        Text("07.00", style: TextStyle(fontSize: 18)),
                        Text("Masuk", style: TextStyle(fontSize: 14)),
                      ],
                    ),
                    SizedBox(width: 20),
                    Column(
                      children: [
                        Text("17.00", style: TextStyle(fontSize: 18)),
                        Text("Pulang", style: TextStyle(fontSize: 14)),
                      ],
                    ),
                  ]),
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }
}
