// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import '../models/quotes.dart';
import '../widgets/card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // ده List جميع الاقتباسات هتكون موجوده داخل
  List AllQuotes = [];

// يقوم بالحذف floatingActionButton يقوم بحذف القائيمه عند الضغط علي ايقون
  delete(Quotes item) {
    setState(() {
      AllQuotes.remove(item);
    });
  }

//  يستخدم لارسال البيانات داخل حقل الادخال لاضافه اقتباس
  final myController = TextEditingController();
  final myControllerName = TextEditingController();

// يستخدم لاضافه اقتباس جديد
  addNewQuote() {
    setState(() {
      AllQuotes.add(
        Quotes(author: myControllerName.text, title: myController.text),
      );
      // قم بمسح البيانات المدخلة بعد الإضافة
      myController.clear();
      myControllerName.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 50, 57, 121),
        title: const Text(
          'أفضل اقتباسات',
          style: TextStyle(fontSize: 25),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: AllQuotes.map((item) => CardWidget(
                item: item,
                delete: delete,
              )).toList(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return Padding(
                  padding: const EdgeInsets.all(22),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextField(
                        controller: myController,
                        decoration: const InputDecoration(
                            hintText: "إضافة اقتباس جديد"),
                        maxLength: 30,
                      ),
                      const SizedBox(
                        height: 22,
                      ),
                      TextField(
                        controller: myControllerName,
                        decoration:
                            const InputDecoration(hintText: "إضافة اسم مؤلف"),
                        maxLength: 20,
                      ),
                      const SizedBox(
                        height: 22,
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            addNewQuote();
                          },
                          child: const Text(
                            "إضافة",
                            style: TextStyle(fontSize: 22),
                          ))
                    ],
                  ),
                );
              },
              isScrollControlled: true);
        },
        backgroundColor: Colors.redAccent,
        child: const Icon(Icons.add),
      ),
    );
  }
}
