class Mahasiswa {
  final String nim;
  // final String noTelp;
  final String id;
  final String name;

  const Mahasiswa({
    required this.nim,
    // required this.noTelp,
    required this.id,
    required this.name,
  });

  factory Mahasiswa.fromJson(Map<String, dynamic> json) {
    return Mahasiswa(
      nim: json['nim'],
      // noTelp: json['noTelp'],
      id: json['id'],
      name: json['name'],
    );
  }
}
