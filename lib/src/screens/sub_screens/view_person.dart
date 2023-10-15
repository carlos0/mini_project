import 'package:mini_proyect/src/model/persona.dart';
import 'package:flutter/material.dart';

class ViewPerson extends StatefulWidget {
  final Persona persona;
  const ViewPerson({Key? key, required this.persona}) : super(key: key);

  @override
  State<ViewPerson> createState() => _ViewPersonState();
}

class _ViewPersonState extends State<ViewPerson> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Vista de Persona"),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              "Detalle de Persona",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.blueGrey, //Color(0xff17324f),
                  fontSize: 20),
            ),
            const SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  'Nombres:',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Color(0xff17324f),
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  width: 30,
                ),
                Text(
                  widget.persona.nombres ?? '',
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  'Apellidos:',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Color(0xff17324f),
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  width: 30,
                ),
                Text(
                  widget.persona.apellidos ?? '',
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  'Cédula de identidad:',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Color(0xff17324f),
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  width: 30,
                ),
                Text(
                  widget.persona.cedulaIdentidad ?? '',
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  'Celular:',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Color(0xff17324f),
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  width: 30,
                ),
                Text(
                  widget.persona.celular.toString(),
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  'Fecha de nacimiento:',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Color(0xff17324f),
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  width: 30,
                ),
                Text(
                  widget.persona.fechaNacimiento.toString(),
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  'Enviado al Servidor:',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Color(0xff17324f),
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  width: 30,
                ),
                Text(
                  widget.persona.enviado.toString() == "1"
                      ? "Enviado"
                      : "No enviado",
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
