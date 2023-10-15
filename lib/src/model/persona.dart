class Persona {
  int? idPersona;
  String? cedulaIdentidad;
  String? nombres;
  String? apellidos;
  int? celular;
  String? fechaNacimiento;
  int? enviado;

  Persona(
      {this.idPersona,
      this.cedulaIdentidad,
      this.nombres,
      this.apellidos,
      this.celular,
      this.fechaNacimiento,
      this.enviado});

  Map<String, dynamic> toMap() {
    return {
      'idPersona': idPersona,
      'cedulaIdentidad': cedulaIdentidad,
      'nombres': nombres,
      'apellidos': apellidos,
      'celular': celular,
      'fechaNacimiento': fechaNacimiento,
      'enviado': enviado
    };
  }
}
