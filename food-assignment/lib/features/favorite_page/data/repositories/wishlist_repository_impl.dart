

import 'package:food_assignment/features/shared/exceptions/http_exception.dart';

import '../../../shared/domain/models/either.dart';
import '../../../shared/domain/models/wishlist/my_wishlist_response.dart';
import '../../domain/repositories/wishlist_repository.dart';
import '../datasource/wishlist_remote_data_source.dart';

class WishlistRepositoryImpl extends WishlistRepository {
  final WishlistDataSource dataSource;

  WishlistRepositoryImpl(this.dataSource);

  @override
  Future<Either<AppException, String>> addToWishlist({required String requestData}) {
    return dataSource.addWishlist(id: requestData);
  }

  @override
  Future<Either<AppException, WishlistResponse>> fetchWishlist() {
    return dataSource.fetchWishlist();
  }
}
