// import 'package:ecommerce_assignment/features/category/presentation/providers/state/category_notifier.dart';
// import 'package:ecommerce_assignment/features/category/presentation/providers/state/category_state.dart';
// import 'package:ecommerce_assignment/features/order/presentation/providers/state/order_notifier.dart';
// import 'package:ecommerce_assignment/features/order/presentation/providers/state/order_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_assignment/features/category/presentation/providers/state/category_notifier.dart';
import 'package:food_assignment/features/category/presentation/providers/state/category_state.dart';

import '../../domain/providers/category_provider.dart';
import '../../domain/repositories/category_repository.dart';

final categoryStateNotifierProvider =
    StateNotifierProvider<CategoryNotifier, CategoryState>(
  (ref) {
    final CategoryRepository categoryRepository =
        ref.watch(categoryRepositoryProvider);
    return CategoryNotifier(
      categoryRepository: categoryRepository,
    )..fetchCategory();
  },
);
