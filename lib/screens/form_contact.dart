import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sqlite/helpers/database.dart';
import 'package:sqlite/models/contact.dart';

class FormContactScreen extends StatefulWidget {
  final Contact? contact;
  const FormContactScreen({Key? key, this.contact}) : super(key: key);

  @override
  State<FormContactScreen> createState() => _FormContactScreenState();
}

class _FormContactScreenState extends State<FormContactScreen> {
  DbHelper db = DbHelper();

  TextEditingController? nameController;
  TextEditingController? phoneController;
  TextEditingController? emailController;
  TextEditingController? companyController;

  @override
  void initState() {
    nameController = TextEditingController(
        text: widget.contact == null ? '' : widget.contact!.name);

    phoneController = TextEditingController(
        text: widget.contact == null ? '' : widget.contact!.phone);

    emailController = TextEditingController(
        text: widget.contact == null ? '' : widget.contact!.email);

    companyController = TextEditingController(
        text: widget.contact == null ? '' : widget.contact!.company);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Form Kontak")),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Padding(
              padding: EdgeInsets.only(top: 20),
              child: TextField(
                controller: nameController,
                decoration: InputDecoration(
                    labelText: 'Nama',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8))),
              )),
          Padding(
            padding: EdgeInsets.only(top: 20),
            child: TextField(
              controller: phoneController,
              decoration: InputDecoration(
                  labelText: 'Nomor Hp',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8))),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20),
            child: TextField(
              controller: emailController,
              decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8))),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20),
            child: TextField(
              controller: companyController,
              decoration: InputDecoration(
                  labelText: 'Perusahaan',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: ElevatedButton(
              child: widget.contact == null
                  ? const Text(
                      'Tambah',
                      style: TextStyle(color: Colors.white),
                    )
                  : const Text(
                      'Update',
                      style: TextStyle(color: Colors.white),
                    ),
              onPressed: () {
                upsertContact();
              },
            ),
          )
        ],
      ),
    );
  }

  Future<void> upsertContact() async {
    if (widget.contact != null) {
      await db.updateContact(Contact(
          id: widget.contact!.id,
          name: nameController!.text,
          phone: phoneController!.text,
          email: emailController!.text,
          company: companyController!.text));
      Navigator.pop(context, 'update');
    } else {
      await db.saveContact(Contact(
          name: nameController!.text,
          phone: phoneController!.text,
          email: emailController!.text,
          company: companyController!.text));
      Navigator.pop(context, 'save');
    }
  }
}
