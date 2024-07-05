import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../home_page/presentation/providers/dashboard_state_provider.dart';
import '../providers/review_product_provider.dart';
import '../providers/review_provider.dart';

class RatingProductWidget extends ConsumerStatefulWidget {
  double rating = 0.0;
  String? productId;
  RatingProductWidget({super.key, this.rating = 0.0, required this.productId});

  @override
  ConsumerState<RatingProductWidget> createState() => _RatingProductWidgetState();
}

class _RatingProductWidgetState extends ConsumerState<RatingProductWidget> {
  double starValue = 3.5;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: RatingStars(
        value: widget.rating,
        onValueChanged: (v) {

          Map<String, dynamic> data = {
            "product": widget.productId,
            "rating": v,
            "message": '',
          };

          setState(() {
            widget.rating = v;
            ref
                .read(reviewStateNotifierProvider.notifier)
                .addReview(data);

            ref.refresh(getReviewStateNotifierProvider);
            ref.refresh(dashboardNotifierProvider);

            ref.watch(getReviewStateNotifierProvider.notifier).getReview(widget.productId.toString());
          });
        },
        starBuilder: (index, color) => Icon(
          Icons.star,
          color: color,
        ),
        starCount: 5,
        starSize: 20,
        valueLabelColor: const Color(0xff9b9b9b),
        valueLabelTextStyle: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
            fontSize: 12.0),
        valueLabelRadius: 10,
        maxValue: 5,
        starSpacing: 2,
        maxValueVisibility: false,
        valueLabelVisibility: false,
        animationDuration: const Duration(milliseconds: 1000),
        valueLabelPadding:
            const EdgeInsets.symmetric(vertical: 1, horizontal: 8),
        valueLabelMargin: const EdgeInsets.only(right: 8),
        starOffColor: const Color(0xffe7e8ea),
        starColor: Colors.yellow,
      ),
    );
  }
}
