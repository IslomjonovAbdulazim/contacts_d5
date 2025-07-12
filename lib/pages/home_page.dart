import 'package:contacts_d5/models/contact_model.dart';
import 'package:contacts_d5/pages/create_page.dart';
import 'package:contacts_d5/services/contact_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ContactModel> contacts = [];
  bool isLoading = false;

  @override
  void initState() {
    load();
    super.initState();
  }

  void load() async {
    isLoading = true;
    setState(() {});
    contacts = await ContactService.getAll();
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Contacts"),
        leading: CupertinoButton(
          onPressed: () {
            load();
          },
          child: Icon(CupertinoIcons.refresh, size: 28),
        ),
        actions: [
          CupertinoButton(
            onPressed: () {
              Get.to(CreatePage());
            },
            child: Icon(CupertinoIcons.add, size: 28),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: isLoading
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: contacts.length,
                  itemBuilder: (context, index) {
                    final model = contacts[index];
                    return ListTile(
                      title: Text(model.tel),
                      subtitle: Text(model.name),
                    );
                  },
                ),
        ),
      ),
    );
  }
}
