import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final keyApplicationId = 'HKcQPmrhOID00WNhVSohjnWb7KtsaDXXODxE06G6';
  final keyClientKey = 'i5GDtq6FWinOwh3tmtzJFrYBGB0DiSOVz6tDptWD';
  final keyParseServerUrl = 'https://parseapi.back4app.com';

  await Parse().initialize(keyApplicationId, keyParseServerUrl,
      clientKey: keyClientKey, debug: true);

  runApp(MaterialApp(
    home: MyScreen(),
  ));
}

class MyScreen extends StatefulWidget {
  const MyScreen({Key? key}) : super(key: key);

  @override
  State<MyScreen> createState() => _MyScreenState();
}

class _MyScreenState extends State<MyScreen> {
  final todoController = TextEditingController();
  var countss;
  void addToDo() async {
    if (todoController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Empty title"),
        duration: Duration(seconds: 2),
      ));
      return;
    }
    await saveTodo(todoController.text);
    setState(() {
      todoController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Transaction History"),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
              child: FutureBuilder<List<ParseObject>>(
                  future: getTodo(),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                      case ConnectionState.waiting:
                        return Center(
                          child: Container(
                              width: 100,
                              height: 100,
                              child: CircularProgressIndicator()),
                        );
                      default:
                        if (snapshot.hasError) {
                          return Center(
                            child: Text("Error..."),
                          );
                        }
                        if (!snapshot.hasData) {
                          return Center(
                            child: Text("No Data..."),
                          );
                        } else {
                          return ListView.builder(
                              padding: EdgeInsets.only(top: 10.0),
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                //*************************************
                                //Get Parse Object Values

                                final varTodo = snapshot.data![index];
                                final username = varTodo["username"];
                                final Bankname = varTodo["bankname"];
                                final Currency = varTodo["currency"];
                                final debitamount = varTodo["txnamount1"];
                                final paymentMode = varTodo["paymentmode"];
                                final txndate = varTodo["txndate"];
                                final walletbalance = varTodo["walletbalance"];
                                final creditamount = varTodo["creditamount"];
                                final varDone = false;
                                //*************************************

                                return ListTile(
                                  title: Card(
                                      child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Text('username'),
                                          Text(":"),
                                          Text(username),
                                        ],
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Text('Bankname'),
                                          Text(":"),
                                          Text(Bankname),
                                        ],
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Text('Currency'),
                                          Text(":"),
                                          Text(Currency),
                                        ],
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Text('Debit Amount'),
                                          Text(":"),
                                          Text(debitamount),
                                        ],
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Text('Credit Amount'),
                                          Text(":"),
                                          Text(creditamount),
                                        ],
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Text('payment Mode'),
                                          Text(":"),
                                          Text(paymentMode),
                                        ],
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Text('Date'),
                                          Text(":"),
                                          Text(txndate),
                                        ],
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Text('MyRmc Wallet Balance',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20)),
                                          Text(":"),
                                          Text(walletbalance,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20)),
                                        ],
                                      ),
                                    ],
                                  )),
                                );
                              });
                        }
                    }
                  }))
        ],
      ),
    );
  }

  Future<void> saveTodo(String title) async {
    await Future.delayed(Duration(seconds: 1), () {});
  }

  Future<List<ParseObject>> getTodo() async {
    QueryBuilder<ParseObject> queryTodo =
        QueryBuilder<ParseObject>(ParseObject('jayadevi'));
    queryTodo.orderByDescending('createdAt');
    final ParseResponse apiResponse = await queryTodo.query();
    countss = apiResponse.count;
    print(countss);
    if (apiResponse.success && apiResponse.results != null) {
      // print(apiResponse.results);
      return apiResponse.results as List<ParseObject>;
    } else {
      return [];
    }
  }



  Future<void> updateTodo(String id, bool done) async {
    await Future.delayed(Duration(seconds: 1), () {});
  }

  Future<void> deleteTodo(String id) async {
    await Future.delayed(Duration(seconds: 1), () {});
  }
}
