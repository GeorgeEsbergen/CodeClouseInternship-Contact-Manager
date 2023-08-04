import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../core/constant/buttons.dart';
import '../../core/constant/text_field.dart';

class AddContactBody extends StatefulWidget {
  const AddContactBody({super.key});

  @override
  State<AddContactBody> createState() => _AddContactBodyState();
}

class _AddContactBodyState extends State<AddContactBody> {
  TextEditingController name = TextEditingController();

  TextEditingController phone = TextEditingController();

  TextEditingController email = TextEditingController();

  final globalKey1 = GlobalKey<FormState>();

  @override
  void dispose() {
    email.dispose();
    phone.dispose();
    name.dispose();
    super.dispose();
  }

  void addContact() async {
    if (globalKey1.currentState!.validate()) {
      try {
        await FirebaseFirestore.instance.collection("contacts").add({
          "name": name.text.trim(),
          "phone": phone.text.trim(),
          "email": email.text.trim(),
        });

        // ignore: use_build_context_synchronously
        Navigator.pop(context);
      } on FirebaseException {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Can't connect to firebase")));
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("All Should be full")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SizedBox(height: 50),
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
                const SizedBox(height: 5),
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
                const SizedBox(height: 5),
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
          fn: addContact,
          text: 'Add Contact',
        )
      ],
    );
  }
}
