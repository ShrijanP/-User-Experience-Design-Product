import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_assignment/configuration/category.dart';
import 'package:food_assignment/configuration/food_list.dart';
import 'package:food_assignment/features/shared/domain/models/category/category_response.dart';
import '../../../../category/presentation/providers/category_product_state_providers.dart';
import '../../../../category/presentation/providers/category_state_providers.dart';
import '../../../../category/presentation/providers/state/category_product_state.dart';
import '../../../../category/presentation/screen/category_product_screen.dart';
import '../../../../shared/constants/size_config.dart';

class CategoriesFood extends ConsumerStatefulWidget {
  const CategoriesFood({Key? key}) : super(key: key);

  @override
  ConsumerState createState() => _CategoriesFoodState();
}

class _CategoriesFoodState extends ConsumerState<CategoriesFood> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(categoryStateNotifierProvider);
    return state.when(
        initial: () => const Center(
              child: Text("No Category Found"),
            ),
        loading: () => const Center(child: CircularProgressIndicator()),
        failure: (failure, data) => _buildBody(context, ref, data),
        success: (data) => _buildBody(context, ref, data));
  }

  Widget _buildBody(
      BuildContext context, WidgetRef ref, CategoryResponse data) {
    return data.data == null || data.data!.isEmpty
        ? const Text("No Category Found")
        : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: SizeConfig.screenHeight! / 8.04,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: data.data?.length,
                    itemBuilder: (context, indeks) {
                      final category = data.data?[indeks];
                      return category == null
                          ? Container()
                          : Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    ref
                                        .watch(
                                            categoryProviderStateNotifierProvider
                                                .notifier)
                                        .fetchCategoryProducts(
                                            categoryId: category.id.toString());

                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                CategoryProductScreen(
                                                  categoryId:
                                                      category.id.toString(),
                                                  categoryName:
                                                      category.name.toString(),
                                                )));
                                  },
                                  child: Container(
                                    margin: EdgeInsets.fromLTRB(
                                      SizeConfig.screenWidth! / 34.25,
                                      SizeConfig.screenHeight! / 170.75,
                                      SizeConfig.screenWidth! / 20.55,
                                      SizeConfig.screenHeight! / 170.75,
                                    ),
                                    height: SizeConfig.screenHeight! / 15.18,
                                    width: SizeConfig.screenWidth! / 9.14,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(getCategoryImage(
                                            category.name.toString())),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ),
                                Row(children: [
                                  Text(
                                    category.name.toString(),
                                    style: TextStyle(
                                        fontSize:
                                            SizeConfig.screenHeight! / 52.54,
                                        color: Colors.black45),
                                  )
                                ]),
                              ],
                            );
                    },
                  ),
                ),
              ],
            ),
          );
  }

  String getCategoryImage(String categoryName) {
    var c1 = Category(
        categoryId: 1,
        categoryName: "Chicken",
        categoryImage: "assets/category/chicken.png");
    var c2 = Category(
        categoryId: 2,
        categoryName: "Bakery",
        categoryImage: "assets/category/bakery.png");
    var c3 = Category(
        categoryId: 3,
        categoryName: "Fast Food",
        categoryImage: "assets/category/fastfood.png");
    var c4 = Category(
        categoryId: 4,
        categoryName: "Fish",
        categoryImage: "assets/category/fish.png");
    var c5 = Category(
        categoryId: 5,
        categoryName: "Fruit",
        categoryImage: "assets/category/fruit.png");
    var c6 = Category(
        categoryId: 6,
        categoryName: "Soup",
        categoryImage: "assets/category/soup.png");
    var c7 = Category(
        categoryId: 7,
        categoryName: "Vegetable",
        categoryImage: "assets/category/vegetable.png");

    // List of categories
    List<Category> categories = [
      c1,
      c2,
      c3,
      c4,
      c5,
      c6,
      c7,
    ];

    Category? matchedCategory = categories.firstWhere(
      (category) =>
          category.categoryName.toLowerCase() == categoryName.toLowerCase(),
      orElse: () => Category(
        categoryId: -1,
        categoryName: "Unknown",
        categoryImage: "assets/category/vegetable.png",
      ),
    );

    if (matchedCategory != null) {
      return matchedCategory.categoryImage;
    } else {
      return "assets/category/vegetable.png";
    }
  }
}
