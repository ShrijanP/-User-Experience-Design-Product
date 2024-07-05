import 'package:flutter/material.dart';

import '../../../../shared/constants/size_config.dart';

class FoodPart extends StatelessWidget {
  String partName;
  void Function() onTab;
  FoodPart({required this.partName, required this.onTab});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
          SizeConfig.screenWidth! / 27.4,
          SizeConfig.screenHeight! / 68.3,
          SizeConfig.screenWidth! / 41.1,
          SizeConfig.screenHeight! / 68.3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            partName,
            style: TextStyle(
                fontSize: SizeConfig.screenHeight! / 45.15,
                fontWeight: FontWeight.w500,
                color: Colors.black87),
          ),

          GestureDetector(
            onTap: onTab,
            child: Icon(
              Icons.keyboard_arrow_right,
              color: Colors.black45,
              size: SizeConfig.screenHeight! / 21.35,
            ),
          )

        ],
      ),
    );
  }
}
