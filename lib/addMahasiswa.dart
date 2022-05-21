import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:latihan_api/repository.dart';

class AddMahasiswa extends StatefulWidget {
  const AddMahasiswa({Key? key}) : super(key: key);

  @override
  State<AddMahasiswa> createState() => _AddMahasiswaState();
}

class _AddMahasiswaState extends State<AddMahasiswa> {
  Repository repository = Repository();
  final _nameController = TextEditingController();
  final _nimController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as List<String>;
    if (args[1].isNotEmpty) {
      _nameController.text = args[1];
    }
    if (args[2].isNotEmpty) {
      _nimController.text = args[2];
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Mahasiswa'),
      ),
      body: Container(
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(hintText: 'Name'),
            ),
            TextField(
              controller: _nimController,
              decoration: InputDecoration(hintText: 'NIM'),
            ),
            ElevatedButton(
                onPressed: () async {
                  bool response = await repository.postData(
                      _nameController.text, _nimController.text);

                  if (response) {
                    Navigator.of(context).popAndPushNamed('/home');
                  } else {
                    print('Post Data Gagal!');
                  }
                },
                child: Text('Submit')),
            ElevatedButton(
                onPressed: () async {
                  bool response = await repository.putData(int.parse(args[0]),
                      _nameController.text, _nimController.text);

                  if (response) {
                    Navigator.of(context).popAndPushNamed('/home');
                  } else {
                    print('Update Data Gagal!');
                  }
                },
                child: Text('Update'))
          ],
        ),
      ),
    );
  }
}
