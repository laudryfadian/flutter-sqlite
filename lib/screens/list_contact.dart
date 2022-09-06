import 'package:flutter/material.dart';
import 'package:sqlite/helpers/database.dart';
import 'package:sqlite/models/contact.dart';
import 'package:sqlite/screens/form_contact.dart';
import 'package:sqlite/screens/list_contact_detail.dart';

class ListContactScreen extends StatefulWidget {
  const ListContactScreen({Key? key}) : super(key: key);

  @override
  State<ListContactScreen> createState() => _ListContactScreenState();
}

class _ListContactScreenState extends State<ListContactScreen> {
  List<Contact> listContact = [];
  DbHelper db = DbHelper();

  @override
  void initState() {
    _getAllContact();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kontak APP"),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: listContact.length,
        itemBuilder: (context, index) {
          Contact contact = listContact[index];
          return Padding(
            padding: const EdgeInsets.only(top: 20),
            child: ListTile(
              leading: const Icon(
                Icons.person,
                size: 50,
              ),
              title: InkWell(
                child: Text(contact.name.toString()),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ListContactDetail(detailCon: contact)));
                },
              ),
              // subtitle: Column(
              //   mainAxisAlignment: MainAxisAlignment.start,
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: [
              //     Padding(
              //       padding: const EdgeInsets.only(top: 8),
              //       child: Text(contact.email.toString()),
              //     ),
              //     Padding(
              //       padding: const EdgeInsets.only(top: 8),
              //       child: Text(contact.phone.toString()),
              //     ),
              //     Padding(
              //       padding: const EdgeInsets.only(top: 8),
              //       child: Text(contact.company.toString()),
              //     ),
              //   ],
              // ),
              trailing: FittedBox(
                fit: BoxFit.fill,
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          _openFormEdit(contact);
                        },
                        icon: const Icon(Icons.edit)),
                    IconButton(
                        onPressed: () {
                          AlertDialog hapus = AlertDialog(
                            title: const Text("Hapus?"),
                            content: Container(
                                height: 100,
                                child: Text(
                                    'Yakin ingin menghapus ${contact.name}')),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    _deteleContact(contact, index);
                                    Navigator.pop(context);
                                  },
                                  child: const Text("Ya")),
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text("Tidak"))
                            ],
                          );
                          showDialog(
                              context: context, builder: (context) => hapus);
                        },
                        icon: const Icon(Icons.delete)),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          _openFormCreate();
        },
      ),
    );
  }

  Future<void> _getAllContact() async {
    var list = await db.getAllContact();

    setState(() {
      listContact.clear();
      list!.forEach((data) {
        listContact.add(Contact.fromMap(data));
      });
    });
  }

  Future<void> _deteleContact(Contact contact, int position) async {
    await db.deleteContact(contact.id!);

    setState(() {
      listContact.removeAt(position);
    });
  }

  Future<void> _openFormCreate() async {
    var result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => FormContactScreen()));

    if (result == 'save') {
      await _getAllContact();
    }
  }

  Future<void> _openFormEdit(Contact contact) async {
    var result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => FormContactScreen(
                  contact: contact,
                )));

    if (result == 'update') {
      await _getAllContact();
    }
  }
}
