import 'package:flutter/material.dart';

class BankCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MyCustomForm1(),
    );
  }
}

class MyCustomForm1 extends StatefulWidget {
  MyCustomForm1({Key? key}) : super(key: key);

  @override
  State<MyCustomForm1> createState() => _MyCustomForm1State();
}

class _MyCustomForm1State extends State<MyCustomForm1> {
  TextEditingController yourControllerName = new TextEditingController();
  var valuess;
  var countss;
  var val = '';

  checkVal(c) {
    if (c < 5000) {
      print(c);
      AlertDialog alert = AlertDialog(
        title: Text("Enter balance is greater than 5000"),
      );
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    } else {
      return c;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        //void print(yourControllerName.text),
        Row(
          children: [
            Text("Balance:",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text(":",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text(val,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            // ElevatedButton(
            //     onPressed: () {
            //       getTodo();
            //     },
            //     child: Text("nbnnnn")), // Expanded(
            //     child:
            // FutureBuilder<List<ParseObject>>(
            //     future: getTodo(),
            //     builder: (context, snapshot) {
            //       switch (snapshot.connectionState) {
            //         case ConnectionState.none:
            //         case ConnectionState.waiting:
            //           return Center(
            //             child: Container(
            //                 width: 100,
            //                 height: 100,
            //                 child: CircularProgressIndicator()),
            //           );
            //         default:
            //           if (snapshot.hasError) {
            //             return Center(
            //               child: Text("Error..."),
            //             );
            //           }
            //           if (!snapshot.hasData) {
            //             return Center(
            //               child: Text("No Data..."),
            //             );
            //           } else {
            //             return ListView.builder(
            //                 padding: EdgeInsets.only(top: 10.0),
            //                 itemCount: snapshot.data!.length,
            //                 itemBuilder: (context, index) {
            //                   //*************************************
            //                   //Get Parse Object Values

            //                   final varTodo = snapshot.data![index];

            //                   final Amount = varTodo["txnamount"];

            //                   //*************************************

            //                   return ListTile(
            //                     title: Card(
            //                         child: Column(
            //                       mainAxisSize: MainAxisSize.max,
            //                       children: [
            //                         Row(
            //                           mainAxisSize: MainAxisSize.max,
            //                           children: [
            //                             Text('username'),
            //                             Text(":"),
            //                             Text(Amount),
            //                           ],
            //                         ),
            //                       ],
            //                     )),
            //                   );
            //                 });
            //           }
            //       }
            //     })
            //),
          ],
        ),

        Container(
          child: TextFormField(
            controller: yourControllerName,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Enter Amount',
            ),
            onChanged: (text) {
              setState(() {
                val = yourControllerName.text;
              });
            },
          ),
        ),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              new ElevatedButton(
                child: new Text("5000"),
                onPressed: () {
                  setState(() {
                    yourControllerName.clear();
                    val = "5000";
                  });
                  print(yourControllerName.text);
                },
              ),
              new ElevatedButton(
                child: new Text("10000"),
                onPressed: () {
                  setState(() {
                    yourControllerName.clear();
                    val = "10000";
                  });
                },
              ),
              new ElevatedButton(
                child: new Text("15000"),
                onPressed: () {
                  setState(() {
                    yourControllerName.clear();
                    val = "15000";
                  });
                },
              ),
            ],
          ),
        ),
        Center(
          child: ElevatedButton(
              onPressed: () {
                setState(() {
                  var c = int.parse(val);
                  checkVal(c);
                });
              },
              child: Text("Submit")),
        )
      ],
    );
  }
}
