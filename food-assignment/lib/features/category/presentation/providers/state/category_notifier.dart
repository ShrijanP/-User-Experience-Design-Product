import 'dart:convert';
// import 'package:ecommerce_assignment/features/category/presentation/providers/state/category_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_assignment/features/category/presentation/providers/state/category_state.dart';
import 'package:food_assignment/features/shared/data/local/hive_config.dart';
import 'package:food_assignment/features/shared/domain/models/category/category_response.dart';
import 'package:hive/hive.dart';
// import '../../../../../shared/constants/endpoint.dart';
// import '../../../../../shared/data/local/hive_config.dart';
// import '../../../../../shared/domain/models/category/category_response.dart';
import '../../../../shared/constants/endpoint.dart';
import '../../../domain/repositories/category_repository.dart';

class CategoryNotifier extends StateNotifier<CategoryState> {
  final CategoryRepository categoryRepository;

  CategoryNotifier({
    required this.categoryRepository,
  }) : super(const CategoryState.initial());


  Future<void> fetchCategory() async {
    Box box = HiveUtils.box;
    state = const CategoryState.loading();
    final response = await categoryRepository.fetchCategory();

    state = await response.fold(
      (failure) async {
        dynamic response = await box.get(CustomerEndpoints.category);
        return CategoryState.failure(
            failure, response != null? CategoryResponse.fromJson(jsonDecode(response)): CategoryResponse());
      },
      (data) async {
        box.put(CustomerEndpoints.category, jsonEncode(data));
        return CategoryState.success(data);
      },
    );
  }
}
