import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BooleanApp')
      ),
      body: _buildMenu(context)
    );
  }

  Widget _buildMenu(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: _buildListItems(context),
    );
  }

  List<Widget> _buildListItems(BuildContext context) {
    final List<Widget> options = [];

    final widgetTable = ListTile(
        title: const Text('Table'),
        leading: const Icon(Icons.border_all_rounded),
        trailing: const Icon(Icons.keyboard_arrow_right, color: Colors.blue,),
        onTap: () {
          Navigator.pushNamed(context, 'table');
        },
      );
      final widgetFunction = ListTile(
        title: const Text('Funciones'),
        leading: const Icon(Icons.functions),
        trailing: const Icon(Icons.keyboard_arrow_right, color: Colors.blue,),
        onTap: () {
          Navigator.pushNamed(context, 'functions');
        },
      );
      options..add(widgetTable)
            ..add(const Divider())
            ..add(widgetFunction)
            ..add(const Divider());

    return options;
  }
}