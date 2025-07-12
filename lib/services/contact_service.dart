import 'dart:convert';

import 'package:contacts_d5/models/contact_model.dart';
import 'package:http/http.dart' as http;

class ContactService {
  static const baseUrl = "https://6872628576a5723aacd48157.mockapi.io/contacts";

  static Future<List<ContactModel>> getAll() async {
    final uri = Uri.parse(baseUrl);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final jsonList = List.from(jsonDecode(response.body));
      return jsonList.map((j) => ContactModel.fromJson(j)).toList();
    }
    return [];
  }

  static Future<bool> create(ContactModel contact) async {
    final uri = Uri.parse(baseUrl);
    final response = await http.post(
      uri,
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode(contact.toJson()),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> update(ContactModel contact) async {
    final uri = Uri.parse("$baseUrl/${contact.id}");
    final response = await http.put(
      uri,
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode(contact.toJson()),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> delete(ContactModel contact) async {
    final uri = Uri.parse("$baseUrl/${contact.id}");
    final response = await http.delete(uri);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
