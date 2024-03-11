import 'package:flutter/material.dart';

class NavItem extends StatelessWidget {
  final String title;
  final String route;

  const NavItem({
    Key? key,
    required this.title,
    required this.route,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, route);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 18.0,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}
