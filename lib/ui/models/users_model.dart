class UsersModel {
  String id;
  String foto;
  String correo;
  String contrasena;
  String nombre;
  String genero;
  String profesion;
  String ciudad;
  String direccion;
  String celular;

  UsersModel(
      {required this.id,
      required this.foto,
      required this.correo,
      required this.contrasena,
      required this.nombre,
      required this.genero,
      required this.profesion,
      required this.ciudad,
      required this.direccion,
      required this.celular});

  factory UsersModel.fromJson(Map<String, dynamic> json) {
    return UsersModel(
        id: json['id'],
        foto: json['foto'],
        correo: json['correo'],
        contrasena: json['contrasena'],
        nombre: json['nombre'],
        genero: json['genero'],
        profesion: json['profesion'],
        ciudad: json['ciudad'],
        direccion: json['created_at'],
        celular: json['updated_at']);
  }

  List<Map<String, dynamic>> toJson() {
    return [
      {
        'id': id,
        'foto': foto,
        'correo': correo,
        'contrasena': contrasena,
        'nombre': nombre,
        'profesion': profesion,
        'direccion': direccion,
        'celular': celular,
      }
    ];
  }
}
