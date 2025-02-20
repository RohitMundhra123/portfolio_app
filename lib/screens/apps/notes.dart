import 'package:flutter/material.dart';
import 'package:my_portfolio/widgets/appbar_widget.dart';

class NoteApp extends StatefulWidget {
  const NoteApp({super.key});

  @override
  State<NoteApp> createState() => _NoteAppState();
}

class _NoteAppState extends State<NoteApp> {
  Widget _body() {
    return const Center(child: Text('Notes'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: appBar("Notes"), body: _body());
  }
}
