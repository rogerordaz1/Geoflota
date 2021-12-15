import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class AuthBackground extends StatelessWidget {
  final Widget child;

  const AuthBackground({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          const _CajaDeColor(),
          const _HeaderIcon(),
          child,
        ],
      ),
    );
  }
}

class _HeaderIcon extends StatelessWidget {
  const _HeaderIcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Padding(
        padding: EdgeInsets.only(top: 30),
        child: SizedBox(
            width: double.infinity,
            child: SizedBox(
                height: 100,
                width: 100,
                child:

                    //Image(image: AssetImage('assets/foto1.png'))
                    Icon(
                  Icons.person_pin,
                  color: Colors.white,
                  size: 80,
                ))),
      ),
    );
  }
}

class _CajaDeColor extends StatelessWidget {
  const _CajaDeColor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: size.height * 0.40,
      decoration: _buildBoxDecoration(),
      // color: Colors.indigo[400],
    );
  }

  BoxDecoration _buildBoxDecoration() {
    return const BoxDecoration(
        gradient: LinearGradient(colors: [
      Color.fromRGBO(63, 63, 156, 1),
      Color.fromRGBO(90, 70, 178, 1),
    ]));
  }
}
