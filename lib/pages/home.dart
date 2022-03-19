import 'dart:io';

import 'package:band_names/models/band.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Band> _bands = [
    Band(id: '1', name: 'Soda Stereo', votes: '6'),
    Band(id: '2', name: 'Mana', votes: '10'),
    Band(id: '3', name: 'Queen', votes: '1'),
    Band(id: '4', name: 'Bohemia Rapshody', votes: '2'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.title,
          style: const TextStyle(color: Colors.black87),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: Center(
        child: ListView.builder(
          itemCount: _bands.length,
          itemBuilder: (BuildContext context, int index) =>
              _bandTile(_bands[index]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewBand,
        child: const Icon(Icons.add),
        elevation: 1,
      ),
    );
  }

  Widget _bandTile(Band band) {
    return Dismissible(
      key:  Key(band.id),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction) {
        print('Direction: $direction');
        print('Band: ${band.id}');
      },
      background: Container(
        padding: const EdgeInsets.only(left: 10.00),
        color: Colors.red,
        child: const Align(
          alignment: Alignment.centerLeft,
          child: Text('Delete band',style: TextStyle(color: Colors.white),)),
      ),
      child: ListTile(
        leading: CircleAvatar(
          child: Text(band.name.substring(0, 2)),
          backgroundColor: Colors.blue[100],
        ),
        title: Text(band.name),
        trailing: Text(
          '${band.votes}',
          style: const TextStyle(fontSize: 20),
        ),
        onTap: () => print(band.name),
      ),
    );
  }

  void _addNewBand() {
    final textEditinController = new TextEditingController();

    !Platform.isAndroid
        ? showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text('New band name:'),
                content: TextField(controller: textEditinController),
                actions: [
                  MaterialButton(
                    onPressed: () =>
                        _addBandToListTile(textEditinController.text),
                    child: const Text('Add'),
                    textColor: Colors.white,
                    elevation: 5,
                    color: Colors.blue,
                  )
                ],
              );
            })
        : showCupertinoDialog(
            context: context,
            builder: (_) {
              return CupertinoAlertDialog(
                title: const Text('Add Band name:'),
                content: CupertinoTextField(
                  controller: textEditinController,
                ),
                actions: [
                  CupertinoDialogAction(
                    isDefaultAction: true,
                    child: const Text('Add'),
                    onPressed: () =>
                        _addBandToListTile(textEditinController.text),
                  ),
                  CupertinoDialogAction(
                    isDestructiveAction: true,
                    child: const Text('Dismiss'),
                    onPressed: () => Navigator.pop(context),
                  )
                ],
              );
            });
  }

  void _addBandToListTile(String name) {
    if (name.length > 1) {
      this._bands.add(
          new Band(id: DateTime.now().toString(), name: name, votes: '10'));
      setState(() {});
    }
    Navigator.pop(context);
  }
}
