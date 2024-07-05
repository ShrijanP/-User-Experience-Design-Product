import 'package:equatable/equatable.dart';
import 'package:food_assignment/features/shared/domain/models/product/product_model.dart';

enum CategoryProductConcreteState {
  initial,
  loading,
  loaded,
  failure,
  fetchingMore,
  fetchedAllProducts
}

class CategoryProductState extends Equatable {
  final List<Product> productList;
  final int totalCount;
  final String categoryId;
  final int page;
  final bool hasData;
  final CategoryProductConcreteState state;
  final String message;
  final bool isLoading;
  const CategoryProductState({
    this.productList = const [],
    this.categoryId = '',
    this.isLoading = false,
    this.hasData = false,
    this.state = CategoryProductConcreteState.initial,
    this.message = '',
    this.page = 0,
    this.totalCount = 0,
  });

  const CategoryProductState.initial({
    this.productList = const [],
    this.totalCount = 0,
    this.categoryId = '',
    this.page = 0,
    this.isLoading = false,
    this.hasData = false,
    this.state = CategoryProductConcreteState.initial,
    this.message = '',
  });

  CategoryProductState copyWith({
    List<Product>? productList,
    int? total,
    String? categoryId,
    int? page,
    bool? hasData,
    CategoryProductConcreteState? state,
    String? message,
    bool? isLoading,
  }) {
    return CategoryProductState(
      isLoading: isLoading ?? this.isLoading,
      productList: productList ?? this.productList,
      categoryId: categoryId ?? this.categoryId,
      totalCount: total ?? this.totalCount,
      page: page ?? this.page,
      hasData: hasData ?? this.hasData,
      state: state ?? this.state,
      message: message ?? this.message,
    );
  }

  @override
  String toString() {
    return 'State(isLoading:$isLoading, productLength: ${productList.length},total:$totalCount page: $page, hasData: $hasData, state: $state, message: $message)';
  }

  @override
  List<Object?> get props => [productList, page, hasData, state, message];
}
