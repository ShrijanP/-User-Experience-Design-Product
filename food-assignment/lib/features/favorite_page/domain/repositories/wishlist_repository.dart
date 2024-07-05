

import 'package:food_assignment/features/shared/domain/models/either.dart';
import 'package:food_assignment/features/shared/exceptions/http_exception.dart';

import '../../../shared/domain/models/wishlist/my_wishlist_response.dart';

abstract class WishlistRepository {
  Future<Either<AppException, String>> addToWishlist({required String requestData});
  Future<Either<AppException, WishlistResponse>> fetchWishlist();
}
