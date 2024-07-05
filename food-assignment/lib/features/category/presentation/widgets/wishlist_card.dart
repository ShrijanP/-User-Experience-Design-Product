import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/domain/models/wishlist/my_wishlist_response.dart';
import '../../../shared/utils/config.dart';

class WishlistCard extends ConsumerWidget {
  const WishlistCard({
    Key? key,
    required this.myWishlist,
  }) : super(key: key);

  final Datum myWishlist;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          SizedBox(
            width: 88,
            child: AspectRatio(
              aspectRatio: 0.88,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F6F9),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Image.network(myWishlist.product!.images!.isNotEmpty
                    ? "${AppConfigs.imageUrl}${myWishlist.product!.images!.first.toString()}"
                    : "https://i.pinimg.com/564x/dd/f0/9d/ddf09d27fef66c6ca33e32446d9be544.jpg"),
              ),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  myWishlist.product!.name.toString(),
                  style: const TextStyle(fontSize: 16),
                  maxLines: 2,
                ),
                const SizedBox(height: 8),
                Text.rich(
                  TextSpan(
                    text: "",
                    style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        // color: kPrimaryColor
                    ),
                    children: [
                      TextSpan(
                          text: "Rs. ${myWishlist.product!.price.toString()}",
                          style: Theme.of(context).textTheme.bodyLarge),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
