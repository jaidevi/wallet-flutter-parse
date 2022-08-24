import 'package:flutter/material.dart';
import 'package:master_card_ui/constants/colors.dart';

import 'package:master_card_ui/widgets/card_widget.dart';
import 'package:master_card_ui/widgets/services.dart';


class HomeCard extends StatelessWidget {
  const HomeCard({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //var height = SizeConfig.getHeight(context);

    return Scaffold(
      body: Container(
        color: AppColors.primaryWhite,
        child: SafeArea(
          child: Column(
            children: [
            
              Expanded(child: CardWidget()),
              Expanded(child: Services())
            ],
          ),
        ),
      ),
    );
  }
}