import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:io';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Program',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  String text = '123';

  final items = List.generate(5, (index) => 'Item ${index + 1}');
  final items1 = List.generate(5, (index) => 'Item ${index + 1}');
  final items2 = List.generate(5, (index) => 'Item ${index + 1}');

  void addItem() {
    setState(() {
      if (_selectedIndex == 0) {
        items.add('Item ${items.length + 1}');
      }
      if (_selectedIndex == 1){
        items1.add('Item ${items1.length + 1}');
      }
      if (_selectedIndex == 2) {
        items2.add('Item ${items2.length + 1}');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      _selectedIndex = 0;
      text = 'This is web';
    }
    else if (Platform.isWindows){
      text = 'This is Windows desktop app';
      _selectedIndex = 1;
    }
    else if (Platform.isAndroid){
      text = 'This is Android app';
      _selectedIndex = 2;
    }
    List<Widget> widgetOptions = <Widget>[
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: items.asMap().entries.map((entry) {
                  int index = entry.key;
                  String item = entry.value;
                  return SizedBox(
                    width: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(item),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            setState(() {
                              items.removeAt(index);
                            });
                          },
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          Center(
            child: ListView(
              shrinkWrap: true,
              children: items1
                  .map((item) => Center(
                  child: GestureDetector(
                      key: ValueKey(item),
                      onTap: () => setState(() => items1.remove(item)),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(item),
                      )
                  )
              )
              )
                  .toList(),
            ),
          ),
        ]
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24
            )
          ),
          Center(
            child: ListView.separated(
              shrinkWrap: true,
              itemBuilder: (_, position) {
                final item = items2[position];
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      items2.removeAt(position);
                    });
                  },
                  child: Text(
                    item,
                    key: ValueKey(item),
                  ),
                );
              },
              separatorBuilder: (_, __) => const Divider(),
              itemCount: items2.length,
            ),
          ),
        ]
      )
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Program'),
      ),
      body: widgetOptions.elementAt(_selectedIndex),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: addItem,
            tooltip: 'Add',
            child: const Icon(Icons.add),
          ),
          const SizedBox(height: 16),
        ],
      ),

    );
  }
}
