import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:localizacionversion2/widgets/widgets.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  bool _isHidden = true;
  bool controlcmail = false;
  bool controlcontrsena = false;
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  bool respuestahttp = false;

  void toggleVisibility() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  void dispose() {
    emailcontroller.dispose();
    passwordcontroller.dispose();
    super.dispose();
  }

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
                      'Acceder',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const _LoginForm()
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
    // Scaffold(
    //   backgroundColor: Colors.blue[100],
    //   body: Stack(
    //     children: [
    //       Container(
    //         padding: const EdgeInsets.only(top: 125, left: 25, right: 25),
    //         child: Container(
    //           decoration: BoxDecoration(
    //             borderRadius: BorderRadius.circular(5),
    //             color: const Color.fromRGBO(255, 255, 255, 0.6),
    //           ),
    //           padding: const EdgeInsets.only(top: 100, left: 10, right: 10),
    //           height: MediaQuery.of(context).size.height * 0.6,
    //           width: MediaQuery.of(context).size.width,
    //           child: SingleChildScrollView(
    //             child: Column(
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: [
    //                 const Text(
    //                   'Correo electrónico',
    //                 ),
    //                 const SizedBox(
    //                   height: 5,
    //                 ),
    //                 campoemail(),
    //                 const SizedBox(
    //                   height: 40,
    //                 ),
    //                 const Text(
    //                   'Contraseña',
    //                 ),
    //                 const SizedBox(
    //                   height: 5,
    //                 ),
    //                 campocontrasena(),
    //                 const SizedBox(
    //                   height: 40,
    //                 ),
    //                 MaterialButton(
    //                   child: const Text('Continuar'),
    //                   minWidth: MediaQuery.of(context).size.width,
    //                   height: 40,
    //                   onPressed: () {
    //                     comprobar(
    //                         emailcontroller.text, passwordcontroller.text);

    //                     // dispose();
    //                   },
    //                   color: Colors.blue[400],
    //                 )
    //               ],
    //             ),
    //           ),
    //         ),
    //       ),
    //       Container(
    //         child: logo(),
    //         padding: EdgeInsets.only(
    //           top: 80,
    //           left: MediaQuery.of(context).size.width * 0.35,
    //           right: MediaQuery.of(context).size.width * 0.35,
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }

  campoemail() {
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: TextFormField(
          controller: emailcontroller,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            hintText: "johnDo@gmail.com",
            hintStyle: const TextStyle(
              color: Colors.grey,
              fontSize: 16.0,
            ),
            prefixIcon: const Icon(Icons.email),
          ),
          validator: (value) {
            String pattern =
                r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
            RegExp regExp = RegExp(pattern);

            if (regExp.hasMatch(value ?? "")) {
              controlcmail = true;

              //emailText = myController.text;
              return null;
            } else {
              controlcmail = false;
              return 'Introduzca un correo electronico valido';
            }
          }),
    );
  }

  campocontrasena() {
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: TextFormField(
          controller: passwordcontroller,
          decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              hintText: "*******",
              hintStyle: const TextStyle(
                color: Colors.grey,
                fontSize: 16.0,
              ),
              prefixIcon: const Icon(Icons.lock),
              suffixIcon: IconButton(
                onPressed: toggleVisibility,
                icon: _isHidden
                    ? const Icon(Icons.visibility_off)
                    : const Icon(Icons.visibility),
              )),
          obscureText: _isHidden,
          validator: (value) {
            if ((value != null && value.length > 5)) {
              controlcontrsena = true;
              return null;
            } else {
              controlcontrsena = false;
              return "La contrasena debe tener 6 caracteres";
            }
          }),
    );
  }

  logo() {
    return const SizedBox(
        height: 100,
        width: 100,
        child: Image(image: AssetImage('assets/foto1.png')));
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

class _LoginForm extends StatelessWidget {
  const _LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
          child: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepPurple)),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepPurple, width: 2)),
                hintText: 'jhon.doe@gmail.com',
                labelText: 'Correo',
                labelStyle: TextStyle(color: Colors.grey),
                prefixIcon: Icon(
                  Icons.alternate_email_sharp,
                  color: Colors.deepPurple,
                )),
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            obscureText: true,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepPurple)),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepPurple, width: 2)),
                hintText: '******',
                labelText: 'Contraseña',
                labelStyle: TextStyle(color: Colors.grey),
                prefixIcon: Icon(
                  Icons.lock_outline,
                  color: Colors.deepPurple,
                )),
          ),
          const SizedBox(
            height: 20,
          ),
          MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              disabledColor: Colors.grey,
              elevation: 0,
              color: Colors.deepPurple,
              child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                  child: const Text(
                    'Ingresar',
                    style: TextStyle(color: Colors.white),
                  )),
              onPressed: () {})
        ],
      )),
    );
  }
}
