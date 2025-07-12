import 'package:contacts_d5/models/contact_model.dart';
import 'package:contacts_d5/services/contact_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({super.key});

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  final nameController = TextEditingController();
  final telController = TextEditingController();
  final nameFocus = FocusNode();
  final telFocus = FocusNode();
  bool isLoading = false;

  final telMask = MaskTextInputFormatter(
    mask: "(##) ###-##-##",
    filter: {
      "#": RegExp(r'[0-9]'),
    },
  );

  final key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Create | Update Contact"),
      ),
      body: Form(
        key: key,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                TextFormField(
                  controller: nameController,
                  focusNode: nameFocus,
                  onTapOutside: (value) => nameFocus.unfocus(),
                  textCapitalization: TextCapitalization.words,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Ism Kiriting";
                    }
                  },
                  decoration: InputDecoration(
                    labelText: "Ism",
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: telController,
                  focusNode: telFocus,
                  onTapOutside: (value) => telFocus.unfocus(),
                  inputFormatters: [telMask],
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (telMask.isFill() == false) {
                      return "Tefon raqam kiriting";
                    }
                  },
                  decoration: InputDecoration(
                    labelText: "Telefon Raqam",
                  ),
                ),
                Spacer(),
                isLoading
                    ? Center(child: CircularProgressIndicator())
                    : CupertinoButton(
                        color: Colors.yellow,
                        onPressed: () async {
                          if (key.currentState!.validate()) {
                            final model = ContactModel(
                              name: nameController.text.trim(),
                              tel: telController.text.trim(),
                              id: "",
                            );
                            isLoading = true;
                            setState(() {});
                            final res = await ContactService.create(model);
                            isLoading = false;
                            setState(() {});
                            if (res) {
                              Navigator.pop(context);
                            }
                          }
                        },
                        child: Center(child: Text("Save | Create")),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
