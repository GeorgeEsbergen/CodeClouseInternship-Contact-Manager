import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../core/constant/buttons.dart';
import '../../core/constant/text_field.dart';

class EditContact extends StatefulWidget {
  final String emailController;
  final String phoneController;
  final String nameController;
  final String id;
  const EditContact(
      {super.key,
      required this.emailController,
      required this.nameController,
      required this.phoneController,
      required this.id});

  @override
  State<EditContact> createState() => _EditContactState();
}

class _EditContactState extends State<EditContact> {
  late final TextEditingController name;
  late final TextEditingController phone;
  late final TextEditingController email;

  @override
  void initState() {
    name = TextEditingController(text: widget.nameController);
    phone = TextEditingController(text: widget.phoneController);
    email = TextEditingController(text: widget.emailController);
    super.initState();
  }

  final globalKey1 = GlobalKey<FormState>();

  @override
  void dispose() {
    email.dispose();
    phone.dispose();
    name.dispose();
    super.dispose();
  }

  void editContact() async {
    if (globalKey1.currentState!.validate()) {
      try {
        await FirebaseFirestore.instance
            .collection("contacts")
            .doc(widget.id)
            .update({
          "name": name.text.trim(),
          "phone": phone.text.trim(),
          "email": email.text.trim(),
        });

        // ignore: use_build_context_synchronously
        Navigator.pop(context);
      } on FirebaseException {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Can't Edit")));
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("All Should be full")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff096552),
      appBar: AppBar(
        title: const Text("Edit Contact"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: ListView(
        children: [
          SizedBox(height: 30),
          Form(
              key: globalKey1,
              child: Column(
                children: [
                  MainTextFormField(
                    fn: (value) {
                      if (value!.isEmpty) {
                        return "please Enter The Name";
                      } else {
                        return null;
                      }
                    },
                    controller: name,
                    hint: 'Enter The Name',
                    name: 'Name',
                    inputType: TextInputType.text,
                  ),
                  const SizedBox(height: 20),
                  MainTextFormField(
                    fn: (value) {
                      if (value!.isEmpty) {
                        return "please Enter phone";
                      } else if (value.length < 12) {
                        return "phone should be 12 digit";
                      } else {
                        return null;
                      }
                    },
                    controller: phone,
                    hint: 'Enter The phone',
                    name: 'phone',
                    inputType: TextInputType.phone,
                  ),
                  const SizedBox(height: 20),
                  MainTextFormField(
                    fn: (value) {
                      if (value!.isEmpty) {
                        return "please Enter The email";
                      } else if (!value.contains("@")) {
                        return "email should have @";
                      } else {
                        return null;
                      }
                    },
                    controller: email,
                    hint: 'Enter The email',
                    name: 'email',
                    inputType: TextInputType.emailAddress,
                  )
                ],
              )),
          const SizedBox(height: 150),
          MainButton(
            fn: editContact,
            text: 'Edit Contact',
          )
        ],
      ),
    );
  }
}
