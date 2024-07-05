import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:food_assignment/features/home_page/components/size_config.dart';
import 'package:food_assignment/features/search_page/search_page_view.dart';

import '../../../../shared/constants/size_config.dart';
import '../../providers/dashboard_state_provider.dart';

class SearchFood extends ConsumerStatefulWidget {
  const SearchFood({Key? key}) : super(key: key);

  @override
  ConsumerState createState() => _SearchFoodState();
}

class _SearchFoodState extends ConsumerState<SearchFood> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          SizeConfig.screenWidth! / 20.55,
          SizeConfig.screenHeight! / 85.375,
          SizeConfig.screenWidth! / 20.55,
          SizeConfig.screenHeight! / 85.375,
        ),
        child: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const SearchPageView())).then((_) {
              ref
                  .read(dashboardNotifierProvider.notifier)
                  .resetState(); // Reset the state
              ref.read(dashboardNotifierProvider.notifier).fetchProducts();
            });
          },
          child: Container(
              height: SizeConfig.screenHeight! / 13.66,
              width: SizeConfig.screenWidth! / 1.068,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0, 4),
                      blurRadius: 4,
                      color: Colors.black.withOpacity(0.3),
                    )
                  ]),
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Icon(
                      Icons.search,
                      color: Colors.black26,
                    ),
                  ),
                  Text("Search",
                      style: TextStyle(
                          color: Color.fromARGB(66, 10, 10, 10),
                          fontSize: SizeConfig.screenHeight! / 42.69))
                ],
              )),
        ),
      ),
    );
  }
}
