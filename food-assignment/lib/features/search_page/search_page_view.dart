import 'package:flutter/material.dart';
import 'package:food_assignment/features/search_page/widgets/past_search.dart';
import 'package:food_assignment/features/search_page/widgets/product_search_page.dart';
import 'package:food_assignment/features/search_page/widgets/recent_search.dart';
import 'package:food_assignment/features/search_page/widgets/search_textfield.dart';

class SearchPageView extends StatefulWidget {
  const SearchPageView({Key? key}) : super(key: key);

  @override
  _SearchPageViewState createState() => _SearchPageViewState();
}

class _SearchPageViewState extends State<SearchPageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Search",
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Column(
        children: [
          SearchTextField(hint_text: "Search"),
          // const RecentSearch(),
          const Expanded(
              child: SingleChildScrollView(child: ProductSearchPage())),
        ],
      ),
    );
  }
}
