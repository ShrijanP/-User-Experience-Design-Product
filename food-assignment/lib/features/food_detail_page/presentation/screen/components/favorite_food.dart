import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../favorite_page/presentation/providers/state/wishlist_state.dart';
import '../../../../favorite_page/presentation/providers/wishlist_state_providers.dart';
import '../../../../shared/constants/size_config.dart';
import '../../../../shared/widgets/overlay_notification.dart';

class FavoriteFood extends ConsumerStatefulWidget {
  final String productId;
  const FavoriteFood({Key? key, required this.productId}) : super(key: key);

  @override
  ConsumerState createState() => _FavoriteFoodState();
}

class _FavoriteFoodState extends ConsumerState<FavoriteFood> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(addToWishlistStateNotifierProvider);
    ref.listen(
      addToWishlistStateNotifierProvider.select((value) => value),
      ((previous, next) {
        if (next is Failure) {
          showTopOverlayNotificationError(
              title: next.exception.message.toString());
        } else if (next is Success) {
          showTopOverlayNotification(
              title: "Wishlist has been Successfully Added");
          ref.read(myWishlistStateNotifierProvider.notifier).fetchWishlist();
        }
      }),
    );

    SizeConfig().init(context);
    return Container(
      decoration: BoxDecoration(border: Border.all(color: Colors.black)),
      child: IconButton(
        onPressed: () {
          ref
              .read(addToWishlistStateNotifierProvider.notifier)
              .addToWishlist(widget.productId.toString());
          ref.read(myWishlistStateNotifierProvider.notifier).fetchWishlist();
        },
        icon: const Icon(Icons.favorite),
        color: Colors.black,
        iconSize: SizeConfig.screenHeight! / 22.77,
      ),
    );
  }
}
