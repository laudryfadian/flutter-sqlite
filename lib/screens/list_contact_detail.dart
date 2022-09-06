import 'package:flutter/material.dart';
import 'package:sqlite/models/contact.dart';

class ListContactDetail extends StatelessWidget {
  final Contact detailCon;
  const ListContactDetail({Key? key, required this.detailCon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Kontak"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Container(
                  alignment: Alignment.center,
                  // color: Colors.grey,
                  child: const Icon(
                    Icons.person,
                    color: Colors.blueAccent,
                    size: 250,
                  )),
              Text(
                detailCon.name.toString(),
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 24),
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Nomor Hp",
                    style: TextStyle(fontSize: 17),
                  ),
                  Text(
                    detailCon.phone.toString(),
                    style: const TextStyle(fontSize: 17),
                  )
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Email",
                    style: TextStyle(fontSize: 17),
                  ),
                  Text(
                    detailCon.email.toString(),
                    style: const TextStyle(fontSize: 17),
                  )
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Perusahaan",
                    style: TextStyle(fontSize: 17),
                  ),
                  Text(
                    detailCon.company.toString(),
                    style: const TextStyle(fontSize: 17),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
