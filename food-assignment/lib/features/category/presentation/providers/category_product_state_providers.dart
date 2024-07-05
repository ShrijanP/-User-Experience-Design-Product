// import 'package:ecommerce_assignment/features/category/presentation/providers/state/category_product_notifier.dart';
// import 'package:ecommerce_assignment/features/category/presentation/providers/state/category_product_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_assignment/features/category/presentation/providers/state/category_product_notifier.dart';
import 'package:food_assignment/features/category/presentation/providers/state/category_product_state.dart';

import '../../domain/providers/category_product_provider.dart';
import '../../domain/repositories/category_product_repository.dart';

final categoryProviderStateNotifierProvider =
StateNotifierProvider<CategoryProductNotifier, CategoryProductState>(
      (ref) {
    final CategoryProductRepository categoryProductRepository =
    ref.watch(categoryProductRepositoryProvider);
    return CategoryProductNotifier(categoryProductRepository);
  },
);
