import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:master_card_ui/constants/size.dart';
import 'package:http/http.dart' as http;
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:paytm/paytm.dart';

class CardWidget extends StatefulWidget {
  const CardWidget({Key? key}) : super(key: key);

  @override
  _CardWidgetState createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  var payment_response, swalletbalance;

  //Live
  String mid = "UtHtmi29121717560904";
  String PAYTM_MERCHANT_KEY = "IVuvbc0qm2klv2NB";
  String website = "WEBSTAGING";
  bool testing = true;
  var currency,
      bankname,
      paymentmode,
      txndate,
      midnum,
      txnamount1,
      myrmcwallet,
      updatedbalance;
  //Testing
  // String mid = "TEST_MID_HERE";
  // String PAYTM_MERCHANT_KEY = "TEST_KEY_HERE";
  // String website = "WEBSTAGING";
  // bool testing = true;

  double amount = 1;
  bool loading = false;
  var firstObject;
  TextEditingController yourControllerName = new TextEditingController();
  var valuess;
  var c;
  int countss = 0;
  int totvalue = 0;
  var val = '';
  var myrmcbalance;
  var retobjid;
  checkVal(c) {
    if (countss == 0) {
      AlertDialog alert = AlertDialog(
        title: Text("Add wallet balance"),
      );
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    } else if (c > countss) {
      print(c);
      AlertDialog alert = AlertDialog(
        title: Text("Entered amount is less than or equal to wallet balance"),
      );
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    } else {
      var firstObject2 = ParseObject('jayadevi')
        ..set('currency', "INR")
        ..set('bankname', "From Wallet")
        ..set('paymentmode', "Tc")
        ..set('txndate', DateTime.now().toString())
        ..set('MerchantId', "null")
        ..set('username', "jayadevi")
        ..set('walletbalance', updatedbalance.toString())
        ..set('creditamount', "Debited")
        ..set('txnamount1', c.toString());
      firstObject2.save();
      setState(() {
        getTodo1();
      });
      setState(() {});
      return c;
    }
  }

  void _incrementCounter(int valuet) {
    setState(() {
      totvalue += valuet;
    });
  }

  checkVal2(int totvalue) {
    if (totvalue > 0) {
      swalletbalance = countss + totvalue;
      print(swalletbalance);
      generateTxnToken(1);
      setState(() {
        getTodo1();
      });
    } else {
      AlertDialog alert = AlertDialog(
        title: Text("Add amount to your wallet 5000 or 10000 more.."),
      );
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }
  }

  @override
  void initState() {
    super.initState();
    getTodo1();
  }

  @override
  Widget build(BuildContext context) {
    //var height = SizeConfig.getHeight(context) * 0.2;
    var width = SizeConfig.getWidth(context) * 0.9;
    // double fontSize(double size) {
    //   return size * width / 414;
    // }
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: width / 20),
            alignment: Alignment.centerLeft,
            child: Container(
              child: SizedBox(
                height: 50,
                child: Row(
                  children: [
                    Text(
                      'MyRMC Wallet Balance: ',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    Text('${countss}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20)),
                  ],
                ),
              ),
            ),
          ),
          Row(
            children: [
              Text("Add More to Wallet",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Text(":",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Text('${totvalue}',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ],
          ),
          Container(
            padding: EdgeInsets.all(10),
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
                      int valuet = 5000;

                      _incrementCounter(valuet);
                    });
                    print(yourControllerName.text);
                  },
                ),
                new ElevatedButton(
                  child: new Text("10000"),
                  onPressed: () {
                    setState(() {
                      yourControllerName.clear();
                      int valuet = 10000;

                      _incrementCounter(valuet);
                    });
                  },
                ),
                new ElevatedButton(
                  child: new Text("15000"),
                  onPressed: () {
                    setState(() {
                      yourControllerName.clear();
                      int valuet = 15000;

                      _incrementCounter(valuet);
                    });
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    onPressed: () {
                      //  var xx = totvalue + countss;
                      // var vv = xx.toString();
                      // print(vv.runtimeType);
                      //updateTodo(retobjid, vv);
                      checkVal2(totvalue);
                    },
                    child: Text("Add")),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      c = int.parse(val);

                      updatedbalance = countss - c;
                      checkVal(c);
                    });
                  },
                  child: Text("Pay"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void generateTxnToken(int mode) async {
    setState(() {
      loading = true;
    });
    String orderId = DateTime.now().millisecondsSinceEpoch.toString();

    String callBackUrl = (testing
            ? 'https://securegw-stage.paytm.in'
            : 'https://securegw.paytm.in') +
        '/theia/paytmCallback?ORDER_ID=' +
        orderId;
    var url = 'https://desolate-anchorage-29312.herokuapp.com/generateTxnToken';
    var body = json.encode({
      "mid": mid,
      "key_secret": PAYTM_MERCHANT_KEY,
      "website": website,
      "orderId": orderId,
      "amount": totvalue,
      "callbackUrl": callBackUrl,
      "custId": "122",
      "mode": mode.toString(),
      "testing": testing ? 0 : 1
    });

    try {
      final response = await http.post(
        Uri.parse(url),
        body: body,
        headers: {'Content-type': "application/json"},
      );

      print("Response is");
      print(response.body);
      String txnToken = response.body;
      setState(() {
        payment_response = txnToken;
      });

      var paytmResponse = Paytm.payWithPaytm(
          mId: mid,
          orderId: orderId,
          txnToken: txnToken,
          txnAmount: amount.toString(),
          callBackUrl: callBackUrl,
          staging: testing,
          appInvokeEnabled: false);

      paytmResponse.then((value) {
        print(value);
        setState(() {
          loading = false;
          print("Value is ");
          print(value);
          if (value['error']) {
            payment_response = value['errorMessage'];
          } else {
            if (value['response'] != null) {
              payment_response = value['response']['STATUS'];
              currency = value['response']['CURRENCY'];
              bankname = value['response']['BANKNAME'];
              paymentmode = value['response']['PAYMENTMODE'];
              txndate = value['response']['TXNDATE'];
              midnum = value['response']['MID'];
              txnamount1 = value['response']['TXNAMOUNT'];
              print(currency);
              print(bankname);
              print(paymentmode);
              print(txndate);
              print(midnum);
              print(txnamount1.runtimeType);
              var firstObject2 = ParseObject('jayadevi')
                ..set('currency', currency)
                ..set('bankname', bankname)
                ..set('paymentmode', paymentmode)
                ..set('txndate', txndate)
                ..set('MerchantId', midnum)
                ..set('username', "jayadevi")
                ..set('walletbalance', swalletbalance.toString())
                ..set('creditamount', txnamount1)
                ..set('txnamount1', "credited");
              firstObject2.save();
            }
          }

          payment_response += "\n" + value.toString();
        });
      });
    } catch (e) {
      print(e);
    }
  }

  Future<List<ParseObject>> getTodo1() async {
    QueryBuilder<ParseObject> queryTodo1 =
        QueryBuilder<ParseObject>(ParseObject('jayadevi'));
    queryTodo1.orderByDescending('createdAt');
    queryTodo1.setLimit(1);

    final ParseResponse apiResponse = await queryTodo1.query();

    if (apiResponse.success && apiResponse.results != null) {
      // Let's show the results
      for (var o in apiResponse.results as List<ParseObject>) {
        print((o as ParseObject).toString());
        final object = o as ParseObject;
        print('${object.objectId} - ${object.get<String>('walletbalance')}');
        setState(() {
          var countss1 = object.get<String>('walletbalance');
          countss = int.parse(countss1!);
          retobjid = object.objectId;
          // print(countss.runtimeType);
        });
      }
    }
    return [];
  }

  Future<void> updateTodo(String id, String vv) async {
    var todo = ParseObject('jayadevi')
      ..objectId = retobjid
      ..set('walletbalance', vv);
    await todo.save();
  }
}
