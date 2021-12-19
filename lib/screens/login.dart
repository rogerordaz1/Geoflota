import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:localizacionversion2/providers/login_form_provider.dart';
import 'package:localizacionversion2/services/auth_service.dart';
import 'package:localizacionversion2/services/service.dart';
import 'package:localizacionversion2/widgets/widgets.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  bool isHidden = true;
  bool controlcmail = false;
  bool controlcontrsena = false;
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  bool respuestahttp = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: AuthBackground(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.30,
              ),
              CardContainer(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Login',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    ChangeNotifierProvider(
                      create: (_) => LoginFormProvider(),
                      child: const _LoginForm(),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void comprobar(String email, String contrsena) async {
    var url = Uri.parse('http://152.206.177.70:1337/auth/local');
    final respuesta = await http
        .post(url, body: {'identifier': email, 'password': contrsena});

    if (respuesta.statusCode == 200) {
      Navigator.pushReplacementNamed(
        context,
        'home',
      );
      //  dispose();
      print(respuesta.body);
    } else {
      emailcontroller.clear();
      passwordcontroller.clear();
    }
  }
}

class _LoginForm extends StatefulWidget {
  const _LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  State<_LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<_LoginForm> {
  bool isHidden = true;

  void toggleVisibility() {
    setState(() {
      isHidden = !isHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginFormProvider>(context);

    return Form(
        key: loginForm.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            TextFormField(
              onChanged: (value) => loginForm.email = value,
              validator: (value) {
                String pattern =
                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                RegExp regExp = RegExp(pattern);
                return regExp.hasMatch(value ?? '')
                    ? null
                    : 'el valor no luce como un correo valido';
              },
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue)),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 2)),
                  hintText: 'jhon.doe@gmail.com',
                  labelText: 'Correo',
                  labelStyle: TextStyle(color: Colors.grey),
                  prefixIcon: Icon(
                    Icons.alternate_email_sharp,
                    color: Colors.blue,
                  )),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              onChanged: (value) => loginForm.password = value,
              validator: (value) {
                if ((value != null && value.length > 5)) {
                  // controlcontrsena = true;
                  return null;
                } else {
                  // controlcontrsena = false;
                  return "La contrasena debe tener 6 caracteres";
                }
              },
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                  border: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue)),
                  enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue)),
                  focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 2)),
                  hintText: '******',
                  labelText: 'Contraseña',
                  labelStyle: const TextStyle(color: Colors.grey),
                  prefixIcon: const Icon(
                    Icons.lock_outline,
                    color: Colors.blue,
                  ),
                  suffixIcon: IconButton(
                    onPressed: toggleVisibility,
                    icon: isHidden
                        ? const Icon(Icons.visibility_off)
                        : const Icon(Icons.visibility),
                  )),
              obscureText: isHidden,
            ),
            const SizedBox(
              height: 20,
            ),
            MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                disabledColor: Colors.grey,
                elevation: 0,
                color: Colors.blue,
                child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 80, vertical: 15),
                    child: const Text(
                      'Ingresar',
                      style: TextStyle(color: Colors.white),
                    )),
                onPressed: () async {
                  final authService =
                      Provider.of<AuthService>(context, listen: false);

                  if (!loginForm.isValidForm()) {
                    return;
                  } else {
                    final String? errorMesage = await authService.loginUser(
                        loginForm.email, loginForm.password);
                    if (errorMesage == null) {
                    } else {
                      if (authService.navegar == true) {
                        Navigator.pushReplacementNamed(context, 'home');
                      } else {
                        NotificationService.ShowSnackBar(errorMesage);
                      }
                    }
                  }
                }),
            const SizedBox(
              height: 20,
            ),
          ],
        ));
  }
}
