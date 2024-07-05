// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:food_assignment/features/shared/domain/models/product/product_model.dart';
// import 'package:ecommerce_assignment/shared/domain/models/product/product_model.dart';

enum MyCartConcreteState {
  initial,
  loading,
  loaded,
  failure,
}

class MyCartState extends Equatable {
  final List<Product> productList;
  final MyCartConcreteState state;
  final String msg;
  final bool isLoading;


  const MyCartState({
    this.productList = const [],
    this.isLoading = false,
    this.state = MyCartConcreteState.initial,
    this.msg = '',
  });

  const MyCartState.initial({
    this.productList = const [],
    this.isLoading = false,
    this.msg = '',
    this.state = MyCartConcreteState.initial,

  });

  MyCartState copyWith({
    List<Product>? productList,
    MyCartConcreteState? state,
    String? message,
    bool? isLoading,
  }) {
    return MyCartState(
      isLoading: isLoading ?? this.isLoading,
      productList: productList ?? this.productList,
      state: state ?? this.state,
    );
  }

  @override
  String toString() {
    return 'MyCartState(isLoading:$isLoading, productLength: ${productList.length}, state: $state, message: $msg)';
  }

  @override
  List<Object?> get props => [productList, state, msg];
}
