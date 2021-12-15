import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class AuthBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: const [
          _PurpleBox(),
        ],
      ),
    );
  }
}

class _PurpleBox extends StatelessWidget {
  const _PurpleBox({Key? key}) : super(key: key);

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
