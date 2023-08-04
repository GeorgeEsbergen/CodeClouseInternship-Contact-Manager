import 'package:flutter/material.dart';

import '../add_contact/add_contact.dart';
import 'home_page_body.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff096552),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text("Contact Management"),
        centerTitle: true,
      ),
      body: const HomePageBody(),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white.withOpacity(0.5),
          onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const AddContact(),
                ),
              ),
          child: Icon(
            Icons.add,
            size: 30,
            color: Color(0xff096552),
          )),
    );
  }
}
