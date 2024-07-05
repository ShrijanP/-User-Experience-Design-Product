import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_assignment/features/home_page/presentation/screen/components/food_part.dart';
import 'package:food_assignment/features/home_page/presentation/screen/widgets/all_product_screen.dart';
import 'package:food_assignment/features/home_page/presentation/screen/widgets/categories.dart';
import 'package:food_assignment/features/home_page/presentation/screen/widgets/discount_cart.dart';
import 'package:food_assignment/features/home_page/presentation/screen/widgets/recommed.dart';
import 'package:food_assignment/features/home_page/presentation/screen/widgets/search_food.dart';
import 'package:food_assignment/features/home_page/presentation/screen/widgets/username_text.dart';
import '../../../shared/constants/size_config.dart';
import '../providers/dashboard_state_provider.dart';

class HomePageView extends ConsumerStatefulWidget {
  const HomePageView({Key? key}) : super(key: key);

  @override
  ConsumerState createState() => _HomePageViewState();
}

class _HomePageViewState extends ConsumerState<HomePageView> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const UserNameText(),
            const SearchFood(),
            const DiscountCard(),
            FoodPart(
              partName: "Categories",
              onTab: () {},
            ),
            const CategoriesFood(),
            FoodPart(
              partName: "Products",
              onTab: () {
                Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AllProductPage()))
                    .then((_) {
                  ref
                      .read(dashboardNotifierProvider.notifier)
                      .resetState(); // Reset the state
                  ref.read(dashboardNotifierProvider.notifier).fetchProducts();
                });
              },
            ),
            const RecommedFoods(),
            const SizedBox(
              height: 70,
            ),
          ],
        ),
      ),
    );
  }
}
