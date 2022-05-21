import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:latihan_api/models/model.dart';

class Repository {
  final _baseUrl = 'https://6285d7de96bccbf32d694dc3.mockapi.io';

  Future getData() async {
    try {
      final response = await http.get(Uri.parse(_baseUrl + '/mahasiswa'));

      if (response.statusCode == 200) {
        // print(response.body);
        Iterable it = jsonDecode(response.body);
        List<Mahasiswa> mahasiswa =
            it.map((e) => Mahasiswa.fromJson(e)).toList();
        return mahasiswa;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future postData(String name, String nim) async {
    try {
      final response =
          await http.post(Uri.parse(_baseUrl + '/mahasiswa'), body: {
        "name": name,
        "nim": nim,
      });

      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future putData(int id, String name, String nim) async {
    try {
      final response = await http
          .put(Uri.parse(_baseUrl + '/mahasiswa/' + id.toString()), body: {
        'name': name,
        'nim': nim,
      });

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future deleteData(String id) async {
    try {
      final response =
          await http.delete(Uri.parse(_baseUrl + '/mahasiswa/' + id));

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
