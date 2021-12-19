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
        children: [const _CajaDeColor(), const _HeaderIcon(), child],
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
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 1),
        child: Column(
          children: [
            const SizedBox(
                width: double.infinity,
                child: Image(
                    image: AssetImage(
                        'assets/260px-Logotipo-pequeño-Etecsa.png'))),
            Text(
              'GeoRuta',
              style: Theme.of(context).textTheme.headline6,
            )
          ],
        ),
        //  height: 100,
        //   width: 100,
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
      height: size.height,
      decoration: _buildBoxDecoration(),
      // color: Colors.indigo[400],
    );
  }

  BoxDecoration _buildBoxDecoration() {
    return const BoxDecoration(
        gradient: LinearGradient(colors: [
      Colors.blue,
      Colors.white,
    ]));
  }
}
