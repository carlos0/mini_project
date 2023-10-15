import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _loading = false;
  bool _isObscure = true;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? usuario;
  String? contrasena;

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: body());
  }

  Widget body() {
    return Form(
        key: _formKey,
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 60),
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                colors: [Color(0xff4E6C86), Color(0xff17324f)],
              )),
              child: Image.asset(
                "assets/images/logo_login.png",
                height: 300,
                width: 600,
              ),
            ),
            Transform.translate(
                offset: const Offset(0, -60),
                child: Center(
                  child: SingleChildScrollView(
                    child: Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      margin: const EdgeInsets.only(
                          left: 20, right: 20, top: 260, bottom: 20),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 35, vertical: 20),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextFormField(
                              decoration: const InputDecoration(
                                labelText: "Usuario",
                                icon: Icon(Icons.people),
                              ),
                              onSaved: (String? value) {
                                usuario = value;
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Este campo es obligatorio";
                                }
                              },
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            TextFormField(
                              obscureText: _isObscure,
                              onSaved: (String? value) {
                                contrasena = value;
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Este campo es obligatorio";
                                }
                              },
                              decoration: InputDecoration(
                                  labelText: 'Contraseña',
                                  icon: const Icon(Icons.lock),
                                  // this button is used to toggle the password visibility
                                  suffixIcon: IconButton(
                                      icon: Icon(_isObscure
                                          ? Icons.visibility
                                          : Icons.visibility_off),
                                      onPressed: () {
                                        setState(() {
                                          _isObscure = !_isObscure;
                                        });
                                      })),
                            ),
                            const SizedBox(height: 40),
                            ElevatedButton(
                                onPressed: () {
                                  _login(context); //AQUI EL NAVIGATOR
                                },
                                style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text("Iniciar Sesión"),
                                    if (_loading)
                                      Container(
                                        height: 20,
                                        width: 20,
                                        margin: const EdgeInsets.only(left: 20),
                                        child: const CircularProgressIndicator(
                                          valueColor: AlwaysStoppedAnimation(
                                              Colors.white),
                                        ),
                                      )
                                  ],
                                )),
                          ],
                        ),
                      ),
                    ),
                  ),
                )),
          ],
        ));
  }

  void _login(BuildContext context) {
    if (!_loading) {
      setState(() {
        _loading = true;
      });
    }
    //if (usuario != null && contrasena != null) {
    Navigator.of(context).pushReplacementNamed("/home");
    //}
  }
}
