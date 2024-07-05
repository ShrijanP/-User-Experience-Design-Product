import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_assignment/features/shared/domain/models/either.dart';
import 'package:food_assignment/features/shared/domain/models/paginated_response.dart';
import 'package:hive/hive.dart';
import '../../../../shared/constants/endpoint.dart';
import '../../../../shared/data/local/hive_config.dart';
import '../../../../shared/domain/models/product/product_model.dart';
import '../../../../shared/exceptions/http_exception.dart';
import '../../../../shared/globals.dart';
import '../../../domain/repositories/dashboard_repository.dart';
import 'dashboard_state.dart';

class DashboardNotifier extends StateNotifier<DashboardState> {
  final DashboardRepository dashboardRepository;

  DashboardNotifier(
    this.dashboardRepository,
  ) : super(const DashboardState.initial());

  bool get isFetching =>
      state.state != DashboardConcreteState.loading &&
      state.state != DashboardConcreteState.fetchingMore;

  Future<void> fetchProducts() async {
    if (isFetching &&
        state.state != DashboardConcreteState.fetchedAllProducts) {
      state = state.copyWith(
        state: state.page > 0
            ? DashboardConcreteState.fetchingMore
            : DashboardConcreteState.loading,
        isLoading: true,
      );

      final response = await dashboardRepository.fetchProducts(
          skip: state.page * PRODUCTS_PER_PAGE);

      updateStateFromResponse(response);
    } else {
      state = state.copyWith(
        state: DashboardConcreteState.fetchedAllProducts,
        message: 'No more products available',
        isLoading: false,
      );
    }
  }

  Future<void> searchProducts(String query) async {
    print("FETCH PRODCUT:::${query.toString()}");
    if (isFetching &&
        state.state != DashboardConcreteState.fetchedAllProducts) {
      print("fetch more prodcut category::");
      state = state.copyWith(
        state: state.page > 0
            ? DashboardConcreteState.fetchingMore
            : DashboardConcreteState.loading,
        isLoading: true,
      );

      final response = await dashboardRepository.searchProducts(
        skip: state.page * PRODUCTS_PER_PAGE,
        query: query,
      );

      print("SEARCHED PRODCUT::${response.toString()}");

      updateStateFromResponse(response);
    } else {
      state = state.copyWith(
        state: DashboardConcreteState.fetchedAllProducts,
        message: 'No more products available',
        isLoading: false,
      );
    }
  }

  void updateStateFromResponse(
      Either<AppException, PaginatedResponse<dynamic>> response) {
    Box box = HiveUtils.box;
    response.fold((failure) => handleFailure(failure, box), (data) {
      final productList = data.data.map((e) => Product.fromJson(e)).toList();

      int totalProductsLength = data.totalCount;

      final totalProducts = [...state.productList, ...productList];

      box.put(CustomerEndpoints.product, totalProducts);

      state = state.copyWith(
        productList: totalProducts,
        state: totalProducts.length == totalProductsLength
            ? DashboardConcreteState.fetchedAllProducts
            : DashboardConcreteState.loaded,
        hasData: true,
        message: totalProducts.isEmpty ? 'No products found' : '',
        page: totalProducts.length ~/ PRODUCTS_PER_PAGE,
        total: totalProductsLength,
        isLoading: false,
      );
    });
  }

  void resetState() {
    state = const DashboardState.initial();
  }

  Future<void> handleFailure(AppException failure, Box box) async {
    print("PRODUCT FETCHED FAILED::");
    DashboardState response = await getCachedProductInfo(box);
    state = response;
  }

  Future<DashboardState> getCachedProductInfo(Box box) async {

    print("GETTING LOCAL DATA::");
    dynamic response = await box.get(CustomerEndpoints.product);

    //decode
    List<dynamic> responseDecode = jsonDecode(response);

    print("RESPONSE FROM CACHE::${responseDecode.runtimeType}");

    List<Product> productList =
        responseDecode.map((e) => Product.fromJson(e)).toList();

    final totalProducts = [...productList];

    state = state.copyWith(
      productList: totalProducts,
      state: DashboardConcreteState.failure,
      message: "Failed to load products",
      isLoading: false,
    );

    return state;
  }
}
