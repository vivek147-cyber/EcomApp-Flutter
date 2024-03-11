import 'package:flutter/material.dart';

import 'navbar.dart';

class CommonScreen extends StatefulWidget {
  final Widget body;

  CommonScreen({required this.body});

  @override
  State<CommonScreen> createState() => _CommonScreenState();
}

class _CommonScreenState extends State<CommonScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Navbar(),
        automaticallyImplyLeading: false,
      ),
      body: widget.body,
    );
  }
}
