import 'package:flutter/material.dart';
import 'package:latihan_api/addMahasiswa.dart';
import 'package:latihan_api/models/model.dart';
import 'package:latihan_api/repository.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/home': (context) => MyHomePage(title: 'Flutter Latihan API'),
        '/add-mahasiswa': (context) => AddMahasiswa(),
      },
      home: const MyHomePage(title: 'Flutter Latihan API'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Mahasiswa> listMahasiswa = [];
  Repository repository = Repository();

  Future<void> getData() async {
    listMahasiswa = await repository.getData();
    setState(() {});
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
              onPressed: () =>
                  Navigator.of(context).popAndPushNamed('/add-mahasiswa'),
              icon: Icon(Icons.add))
        ],
      ),
      body: ListView.separated(
          itemBuilder: (context, index) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => Navigator.of(context)
                      .popAndPushNamed('/add-mahasiswa', arguments: [
                    listMahasiswa[index].id,
                    listMahasiswa[index].name,
                    listMahasiswa[index].nim
                  ]),
                  child: Container(
                    margin: EdgeInsets.all(10),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            listMahasiswa[index].name,
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                          Text(listMahasiswa[index].nim),
                        ]),
                  ),
                ),
                IconButton(
                    onPressed: () async {
                      bool response =
                          await repository.deleteData(listMahasiswa[index].id);
                      if (response) {
                        print('Delete data berhasil!');
                      } else {
                        print('Delete data gagal!');
                      }
                      getData();
                    },
                    icon: Icon(Icons.delete))
              ],
            );
          },
          separatorBuilder: (context, index) {
            return Divider();
          },
          itemCount: listMahasiswa.length),
    );
  }
}
