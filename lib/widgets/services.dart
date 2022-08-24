import 'package:flutter/material.dart';
import 'package:master_card_ui/constants/colors.dart';
import 'package:master_card_ui/constants/size.dart';

import 'package:master_card_ui/widgets/newfile.dart';

class Services extends StatelessWidget {
  const Services({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = SizeConfig.getWidth(context);
    var height = SizeConfig.getWidth(context);
    List<String> texts = ['View Pay Bills', 'Recharge'];
    int index = -1;

    List<Icon> icons = [
      Icon(Icons.arrow_upward, color: Colors.green[700], size: 30),
      Icon(Icons.payment_outlined, size: 30),
      Icon(Icons.account_balance_outlined, color: Colors.blue[700], size: 30),
      Icon(Icons.receipt_sharp, color: Colors.deepOrange[300], size: 30)
    ];

    return Container(
        height: height * 0.8,
        width: width * 0.8,
        child: GridView.count(
            crossAxisCount: 2,
            children: texts.map((text) {
              index = index + 1;
              return Container(
                  child: Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      height: height / 4,
                      width: width / 4,
                      margin: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.black54,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      height: height / 3,
                      width: width / 3,
                      margin: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.primaryWhite,
                        boxShadow: AppColors.neumorpShadow,
                      ),
                    ),
                  ),
                  Align(
                      alignment: Alignment.center,
                      child: Container(
                        padding: EdgeInsets.only(top: 50),
                        child: Column(children: [
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(_createRoute());
                            },
                            child: icons[index],
                          ),
                          SizedBox(height: 10),
                          Text(
                            text,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ]),
                      )),
                ],
              ));
            }).toList()));
  }

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => MyScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(0.0, 1.0);
        var end = Offset.zero;
        var curve = Curves.ease;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
