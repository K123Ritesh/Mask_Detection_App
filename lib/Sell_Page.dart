import 'package:flutter/material.dart';

class Sell_Page extends StatefulWidget {
  const Sell_Page({super.key});

  @override
  State<Sell_Page> createState() => _Sell_PageState();
}

class _Sell_PageState extends State<Sell_Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          decoration: BoxDecoration(
              color: Colors.grey, borderRadius: BorderRadius.circular(15)),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              children: [
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Text("Sell"),
                  ),
                  decoration: BoxDecoration(
                      color: Colors.blueAccent[300],
                      borderRadius: BorderRadius.circular(15)),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(15)),
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Text("Buy"),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      body: ListView(children: [
        TextField(
          decoration: InputDecoration(prefixIcon: Icon(Icons.search)),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          height: 300,
          color: Colors.black,
        ),
        SizedBox(
          height: 15,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              Container(
                child: ListTile(),
              )
            ],
          ),
        )
      ]),
    );
  }
}
