import 'package:flutter/material.dart';

class UndefinedPage extends StatefulWidget {
  const UndefinedPage({super.key});

  @override
  State<UndefinedPage> createState() => _UndefinedPageState();
}

class _UndefinedPageState extends State<UndefinedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('UndefinedPage'),
      ),
    );
  }
}
