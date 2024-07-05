import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../home_page/presentation/providers/dashboard_state_provider.dart';
import '../../home_page/presentation/screen/components/colors.dart';
import '../../shared/constants/size_config.dart';

class RecentSearch extends ConsumerStatefulWidget {
  final String searchText;
  const RecentSearch({Key? key, required this.searchText}) : super(key: key);

  @override
  ConsumerState createState() => _RecentSearchState();
}

class _RecentSearchState extends ConsumerState<RecentSearch> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Recent Search",
              style: TextStyle(
                  fontSize: SizeConfig.screenHeight! / 37.95,
                  fontWeight: FontWeight.w400),
            ),
            GestureDetector(
              onTap: () {
                ref.watch(dashboardNotifierProvider.notifier).fetchProducts();
              },
              child: Text(
                "Clear All",
                style: TextStyle(
                    color: lightColor,
                    fontSize: SizeConfig.screenHeight! / 45.54),
              ),
            )
          ],
        ),
      ],
    );
  }
}
