import 'package:flutter/material.dart';

import 'add_contact_body.dart';

class AddContact extends StatelessWidget {
  const AddContact({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff096552),
      appBar: AppBar(
        title: const Text("Add New Contact"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: const AddContactBody(),
    );
  }
}
