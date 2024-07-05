import 'package:flutter/material.dart';

import '../../../../shared/constants/size_config.dart';
// import 'package:food_assignment/features/home_page/components/size_config.dart';

class UserSection extends StatelessWidget {
  IconData icon_name;
  String section_text;
  Function() onTab;
  UserSection({required this.icon_name, required this.section_text, required this.onTab});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTab,
      child: Padding(
        padding: EdgeInsets.fromLTRB(
            SizeConfig.screenWidth! / 13.7, 0,
            SizeConfig.screenWidth! / 27.4,
            SizeConfig.screenHeight! / 34.15
            ),
        child: Row(
          children: [
            Icon(
              icon_name,
              color: Colors.black54,
            ),
            SizedBox(
              width: SizeConfig.screenWidth! / 41.1,
            ),
            Text(
              section_text,
              style: TextStyle(
                  color: Colors.black54,
                  fontSize: SizeConfig.screenHeight! / 42.68),
            ),
            Spacer(),
            Icon(
              Icons.keyboard_arrow_right,
              color: Colors.black45,
              size: SizeConfig.screenHeight! / 21.34,
            )
          ],
        ),
      ),
    );
  }
}
