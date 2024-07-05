import 'dart:convert';
// import 'package:ecommerce_assignment/shared/domain/models/either.dart';
// import 'package:ecommerce_assignment/shared/domain/models/paginated_response.dart';
// import 'package:ecommerce_assignment/shared/domain/models/product/product_model.dart';
// import 'package:ecommerce_assignment/shared/exceptions/http_exception.dart';
// import 'package:ecommerce_assignment/shared/globals.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_assignment/features/shared/data/local/hive_config.dart';
import 'package:food_assignment/features/shared/domain/models/either.dart';
import 'package:food_assignment/features/shared/domain/models/paginated_response.dart';
import 'package:food_assignment/features/shared/domain/models/product/product_model.dart';
import 'package:food_assignment/features/shared/exceptions/http_exception.dart';
import 'package:food_assignment/features/shared/globals.dart';
import 'package:hive/hive.dart';
// import '../../../../../shared/constants/endpoint.dart';
// import '../../../../../shared/data/local/hive_config.dart';
import '../../../domain/repositories/category_product_repository.dart';
import 'category_product_state.dart';

class CategoryProductNotifier extends StateNotifier<CategoryProductState> {
  final CategoryProductRepository categoryProductRepository;

  CategoryProductNotifier(
    this.categoryProductRepository,
  ) : super(const CategoryProductState.initial());

  bool get isFetching =>
      state.state != CategoryProductConcreteState.loading &&
      state.state != CategoryProductConcreteState.fetchingMore;

  Future<void> fetchCategoryProducts({required String categoryId}) async {
    if (isFetching &&
        state.state != CategoryProductConcreteState.fetchedAllProducts) {
      state = state.copyWith(
        state: state.page > 0
            ? CategoryProductConcreteState.fetchingMore
            : CategoryProductConcreteState.loading,
        isLoading: true,
      );

      final response = await categoryProductRepository.fetchCategoryProducts(
          skip: state.page * PRODUCTS_PER_PAGE, categoryId: categoryId);

      updateStateFromResponse(response, categoryId);
    } else {
      state = state.copyWith(
        state: CategoryProductConcreteState.fetchedAllProducts,
        message: 'No more products available',
        isLoading: false,
      );
    }
  }

  void updateStateFromResponse(
      Either<AppException, PaginatedResponse<dynamic>> response,
      String categoryId) {
    Box box = HiveUtils.box;
    response.fold((failure) => handleFailure(failure, box, categoryId), (data) {
      final productList = data.data.map((e) => Product.fromJson(e)).toList();
      int totalProductsLength = data.totalCount;

      print("categoty page list:: ${state.page}");

      if (state.categoryId != categoryId) {
        state = state.copyWith(
          productList: [],
          state: CategoryProductConcreteState.loading,
          hasData: false,
          message: '',
          page: 0,
          total: 0,
          isLoading: true,
        );
      }

      final List<Product> combinedProducts = [
        ...state.productList,
        ...productList
      ];

      final List<Product> uniqueProducts = [];

      for (final product in combinedProducts) {
        if (!uniqueProducts
            .any((uniqueProduct) => uniqueProduct.id == product.id)) {
          uniqueProducts.add(product);
        }
      }

      final List<Product> totalProducts = [...uniqueProducts];

      box.put("/category/$categoryId", jsonEncode(totalProducts));

      state = state.copyWith(
        productList: totalProducts,
        state: totalProducts.length == totalProductsLength
            ? CategoryProductConcreteState.fetchedAllProducts
            : CategoryProductConcreteState.loaded,
        hasData: true,
        message: totalProducts.isEmpty ? 'No products found' : '',
        page: totalProducts.length ~/ PRODUCTS_PER_PAGE,
        total: totalProductsLength,
        isLoading: false,
        categoryId: categoryId,
      );
    });
  }

  void resetState() {
    state = const CategoryProductState.initial();
  }

  Future<void> handleFailure(
      AppException failure, Box box, String categoryId) async {
    print("PRODUCT FETCHED FAILED::");
    CategoryProductState response = await getCachedProductInfo(box, categoryId);
    state = response;
  }

  Future<CategoryProductState> getCachedProductInfo(
      Box box, String categoryId) async {
    dynamic response = await box.get("/category/$categoryId");

    //decode
    List<dynamic> responseDecode = jsonDecode(response);

    print("RESPONSE FROM CACHE::${responseDecode.runtimeType}");

    List<Product> productList =
        responseDecode.map((e) => Product.fromJson(e)).toList();

    final totalProducts = [...productList];

    state = state.copyWith(
      productList: totalProducts,
      state: CategoryProductConcreteState.failure,
      message: "Failed to load products",
      isLoading: false,
    );

    return state;
  }
}
