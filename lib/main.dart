import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const Calculator(title: 'Тооны машин'),
    );
  }
}

class Calculator extends StatefulWidget {
  const Calculator({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  int total = 0;
  int activeField = 0;
  TextEditingController num1 = TextEditingController();
  TextEditingController num2 = TextEditingController();

  void calc(String action) {
    switch (action) {
      case 'НЭМЭХ':
        setState(() {
          total = int.parse(num1.text) + int.parse(num2.text);
        });
        break;
      case 'ХАСАХ':
        setState(() {
          total = int.parse(num1.text) - int.parse(num2.text);
        });
        break;
      case 'ҮРЖИХ':
        setState(() {
          total = int.parse(num1.text) * int.parse(num2.text);
        });
        break;
      case 'ХУВААХ':
        setState(() {
          // ~/ ene buhel toogoor awna
          total = int.parse(num1.text) ~/ int.parse(num2.text);
        });
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          // Here we take the value from the Calculator object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
        ),
        body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              TextField(
                decoration: const InputDecoration(hintText: '1-р тоо'),
                onTap: () {
                  activeField = 1;
                },
                keyboardType: TextInputType.number,
                controller: num1,
              ),
              TextField(
                decoration: const InputDecoration(hintText: '2-р тоо'),
                onTap: () {
                  activeField = 2;
                },
                keyboardType: TextInputType.number,
                controller: num2,
              ),
              const SizedBox(
                height: 8,
              ),
              SizedBox(
                width: double.infinity,
                child: GridView(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5, crossAxisSpacing: 8),
                  children: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
                      .map((e) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: TextButton(
                                onPressed: () {
                                  if (activeField == 1)
                                    num1.text += e.toString();
                                  if (activeField == 2)
                                    num2.text += e.toString();
                                },
                                child: Text('$e')),
                          ))
                      .toList(),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              SizedBox(
                width: double.infinity,
                child: ListView(
                  // scroll zogsoono
                  physics: const NeverScrollableScrollPhysics(),
                  // children ii urtaar ondortei bolno
                  shrinkWrap: true,
                  children: ["НЭМЭХ", 'ХАСАХ', "ҮРЖИХ", "ХУВААХ"]
                      .map((e) => Container(
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            color: Colors.purple,
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: TextButton(
                                onPressed: () {
                                  calc(e);
                                },
                                child: Text(
                                  e,
                                  style: const TextStyle(color: Colors.white),
                                )),
                          ))
                      .toList(),
                ),
              ),
              Text(
                'Total: $total',
                style: const TextStyle(fontSize: 30, color: Colors.purple),
              )
            ],
          ),
        ));
  }
}
