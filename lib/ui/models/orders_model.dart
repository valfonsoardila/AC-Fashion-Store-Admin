class OrdersModel {
  String id;
  String idUser;
  String nombre;
  String correo;
  String telefono;
  String foto;
  String direccion;
  int cantidad;
  int total;
  String metodoPago;
  String fechaDeCompra;
  String horaDeCompra;
  String estado;
  String tiempoDeEntrega;
  OrdersModel(
      this.id,
      this.idUser,
      this.nombre,
      this.correo,
      this.telefono,
      this.foto,
      this.direccion,
      this.cantidad,
      this.total,
      this.metodoPago,
      this.fechaDeCompra,
      this.horaDeCompra,
      this.estado,
      this.tiempoDeEntrega);
}
