import 'package:flutter/material.dart';
import 'package:master_card_ui/widgets/get_started.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final keyApplicationId = 'HKcQPmrhOID00WNhVSohjnWb7KtsaDXXODxE06G6';
  final keyClientKey = 'i5GDtq6FWinOwh3tmtzJFrYBGB0DiSOVz6tDptWD';
  final keyParseServerUrl = 'https://parseapi.back4app.com';

  await Parse().initialize(keyApplicationId, keyParseServerUrl,
      clientKey: keyClientKey, autoSendSessionId: true);

  print('done');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MasterCard UI',
      debugShowCheckedModeBanner: false,
      home: GetStarted(),
    );
  }
}
