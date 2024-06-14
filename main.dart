import 'package:flutter/material.dart';
import './avl_tree.dart';
import 'dart:math';
import './CirclePainter.dart';

void main() {
  runApp(App());
}

class App extends StatefulWidget {
  @override
  AppState createState() => AppState();
}

class AppState extends State<App> with SingleTickerProviderStateMixin {
  final AVLTree avlTree = AVLTree();
  final TextEditingController controller = TextEditingController();
  String message = '';
  AnimationController? animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  void insert() {
    final int? value = int.tryParse(controller.text);
    if (value != null) {
      setState(() {
        avlTree.root = avlTree.insertNode(avlTree.root, value);
        animationController?.forward(from: 0.5);
      });
    }
  }

  void delete() {
    final int? value = int.tryParse(controller.text);
    if (value != null) {
      setState(() {
        avlTree.root = avlTree.deleteNode(avlTree.root, value);
        animationController?.forward(from: 0.5);
      });
    }
  }

  void search() {
    final int? value = int.tryParse(controller.text);
    if (value != null) {
      final foundNode = avlTree.search(avlTree.root, value);
      setState(() {
        message = foundNode != null ? '$value found in this tree' : '$value not found in this tree';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AVL_Tree',
      home: Scaffold(
        appBar: AppBar(
          title: Text('AVL_Tree'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(
                    width: 200,
                    child: TextField(
                      controller: controller,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter a number',
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: insert,
                    child: Text('Insert'),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: delete,
                    child: Text('Delete'),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: search,
                    child: Text('Search'),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                message,
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
              SizedBox(),
              Expanded(
                child: AnimatedBuilder(
                  animation: animationController!,
                  builder: (context, child) {
                    return CustomPaint(
                      painter: CirclePainter(avlTree, animationController!.value),
                      size: Size(double.infinity, double.infinity),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
