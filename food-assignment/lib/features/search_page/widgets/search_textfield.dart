import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_assignment/features/search_page/widgets/recent_search.dart';

import '../../home_page/presentation/providers/dashboard_state_provider.dart';
import '../../home_page/presentation/screen/components/colors.dart';
import '../../shared/constants/size_config.dart';

class SearchTextField extends ConsumerStatefulWidget {
  String hint_text;
  SearchTextField({required this.hint_text});

  @override
  ConsumerState createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends ConsumerState<SearchTextField> {
  final scrollController = ScrollController();
  final TextEditingController searchController = TextEditingController();
  bool isSearchActive = false;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(scrollControllerListener);
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  void scrollControllerListener() {
    if (scrollController.position.maxScrollExtent == scrollController.offset) {
      final notifier = ref.read(dashboardNotifierProvider.notifier);
      if (isSearchActive) {
        notifier.searchProducts(searchController.text);
      } else {
        notifier.fetchProducts();
      }
    }
  }

  void refreshScrollControllerListener() {
    scrollController.removeListener(scrollControllerListener);
    scrollController.addListener(scrollControllerListener);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(SizeConfig.screenWidth! / 20.55, 0,
          SizeConfig.screenWidth! / 20.55, SizeConfig.screenHeight! / 85.38),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 172, 171, 171),
                borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 3),
                    blurRadius: 4,
                    color: Colors.black.withOpacity(0.2),
                  )
                ]),
            child: TextField(
              style: TextStyle(color: textColor),
              cursorColor: textColor,
              controller: searchController,
              onSubmitted: (value) {
                ref
                    .read(dashboardNotifierProvider.notifier)
                    .searchProducts(value);
                refreshScrollControllerListener();
              },
              onEditingComplete: () {
                ref.read(dashboardNotifierProvider.notifier).resetState();
                ref
                    .read(dashboardNotifierProvider.notifier)
                    .searchProducts(searchController.text);
                refreshScrollControllerListener();
              },
              decoration: InputDecoration(
                prefixIcon: const Icon(
                  Icons.search,
                  color: Colors.black26,
                ),
                enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  borderSide: BorderSide(width: 1, color: Colors.transparent),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                hintText: widget.hint_text,
                hintStyle:
                    const TextStyle(color: Color.fromARGB(66, 10, 10, 10)),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          RecentSearch(
            searchText: searchController.text,
          ),
        ],
      ),
    );
  }
}
