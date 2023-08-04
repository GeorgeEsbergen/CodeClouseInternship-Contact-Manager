import 'package:contact_manager/features/edit_contact/edit_contact.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:cloud_firestore/cloud_firestore.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_slidable/flutter_slidable.dart';

class HomePageBody extends StatefulWidget {
  const HomePageBody({super.key});

  @override
  State<HomePageBody> createState() => _HomePageBodyState();
}

class _HomePageBodyState extends State<HomePageBody> {
  final connectionState1 =
      FirebaseFirestore.instance.collection("contacts").snapshots();

  void deleteFun(String id) async {
    await FirebaseFirestore.instance.collection("contacts").doc(id).delete();
    if (mounted) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Contact Deleted")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: connectionState1,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final List<QueryDocumentSnapshot> document = snapshot.data!.docs;
          if (document.isEmpty) {
            return const Center(child: Text("No Contacts here"));
          } else {
            return ListView.builder(
                itemCount: document.length,
                itemBuilder: (context, index) {
                  final contact =
                      document[index].data() as Map<String, dynamic>;
                  // ignore: unused_local_variable
                  final contactId = document[index].id;
                  return Slidable(
                    startActionPane:
                        ActionPane(motion: const ScrollMotion(), children: [
                      SlidableAction(
                        backgroundColor: const Color(0xFFFE4A49),
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: 'Delete',
                        onPressed: (BuildContext context) {
                          deleteFun(contactId);
                        },
                      ),
                    ]),
                    child: ListTile(
                      title: Text("${contact["name"]}"),
                      subtitle: Text("${contact["phone"]} "),
                      trailing: IconButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => EditContact(
                                    emailController: contact["email"],
                                    nameController: contact["name"],
                                    phoneController: contact["phone"],
                                    id: contactId,
                                  )));
                        },
                        icon: const Icon(Icons.edit),
                      ),
                    ),
                  );
                });
          }
        } else if (snapshot.hasError) {
          return const Center(child: Text("has Error"));
        } else {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }
      },
    );
  }
}
