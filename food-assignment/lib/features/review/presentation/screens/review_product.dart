import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_assignment/features/review/presentation/screens/rating_widget.dart';
import 'package:food_assignment/features/shared/widgets/overlay_notification.dart';
import '../../../shared/utils/config.dart';
import '../../../home_page/presentation/providers/dashboard_state_provider.dart';
import '../../../shared/domain/models/review/review_response.dart';
import '../providers/review_product_provider.dart';
import '../providers/review_provider.dart';
import '../providers/state/reivew_state.dart';

class ReviewProduct extends ConsumerStatefulWidget {
  double rating = 0.0;
  String productId;
  ReviewProduct({super.key, required this.rating, required this.productId});

  @override
  ConsumerState<ReviewProduct> createState() => _ReviewProductState();
}

class _ReviewProductState extends ConsumerState<ReviewProduct> {
  TextEditingController reviewController = TextEditingController();
  final _formKey4 = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(getReviewStateNotifierProvider);
    final state2 = ref.watch(reviewStateNotifierProvider);

    ref.listen(
      reviewStateNotifierProvider.select((value) => value),
      ((previous, next) {
        //show Snackbar on failure
        if (next is Failure) {

          showTopOverlayNotificationError(title: "Failed to add review");
        } else if (next is Success) {

          showTopOverlayNotification(title: "Review Added Successfully");

          reviewController.clear();
          ref.refresh(getReviewStateNotifierProvider);

          ref
              .read(getReviewStateNotifierProvider.notifier)
              .getReview(widget.productId.toString());
        }
      }),
    );

    return Container(
      child: Form(
        key: _formKey4,
        child: RefreshIndicator(
          onRefresh: () {
            return ref
                .read(getReviewStateNotifierProvider.notifier)
                .getReview(widget.productId.toString());
          },
          child: ListView(
            shrinkWrap: true,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Reviews',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  RatingProductWidget(
                    rating: widget.rating,
                    productId: widget.productId,
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              state.when(
                initial: () => Container(),
                loading: () => const CupertinoActivityIndicator(),
                failure: (value) => buildReviewItem(value),
                success: (value) => buildReviewItem(value),
              ),
              const SizedBox(height: 16.0),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                        controller: reviewController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Review cannot be empty";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.blue,
                            ),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey,
                            ),
                          ),
                          focusedErrorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.red,
                            ),
                          ),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                            ),
                          ),
                          hintText: "Write your review",
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                        )),
                  ),
                  state2.maybeMap(
                    loading: (_) =>
                        const Center(child: CupertinoActivityIndicator()),
                    orElse: () => Expanded(
                      flex: 0,
                      child: IconButton(
                          onPressed: () {
                            if (!_formKey4.currentState!.validate()) {
                              return;
                            }
                            Map<String, dynamic> data = {
                              "product": widget.productId,
                              "rating": widget.rating,
                              "message": reviewController.text,
                            };

                            //   {
                            //     "product":"65d36a9a6bf58bf86f048813",
                            //   "rating": 4,
                            //   "message": "This is message"
                            // }

                            reviewController.clear();

                            ref
                                .read(reviewStateNotifierProvider.notifier)
                                .addReview(data);
                          },
                          icon: const Icon(Icons.send)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildReviewItem(ReviewResponse data) {
    return data.data != null
        ? ListView.builder(
            shrinkWrap: true,
            itemCount: data.data!.length,
            itemBuilder: (context, index) {
              var review = data.data![index];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundImage: Image.network(
                              "https://i.pinimg.com/564x/ad/11/e3/ad11e3a65d7a8c7029af1a691b52f289.jpg",
                              // width: 200,
                              // height: 200,
                              fit: BoxFit.contain,
                            ).image,
                          ),
                          const SizedBox(width: 10,),
                          Text(
                            "${review.user?.name.toString()}",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          review.rating != null
                              ? RatingStars(
                                  value: review.rating!.toDouble(),
                                  onValueChanged: (value) {
                                    Map<String, dynamic> data = {
                                      "product": widget.productId,
                                      "rating": value,
                                      "message": '',
                                    };

                                    setState(() {
                                      widget.rating = value;
                                      ref
                                          .read(reviewStateNotifierProvider
                                              .notifier)
                                          .addReview(data);

                                      ref.refresh(
                                          getReviewStateNotifierProvider);
                                      ref.refresh(dashboardNotifierProvider);

                                      ref
                                          .watch(getReviewStateNotifierProvider
                                              .notifier)
                                          .getReview(
                                              widget.productId.toString());
                                    });
                                  },
                                  starBuilder: (index, color) => Icon(
                                    Icons.star,
                                    color: color,
                                  ),
                                  starCount: 5,
                                  starSize: 20,
                                  // valueLabelRadius: 10,
                                  maxValue: 5,
                                  starSpacing: 2,
                                  maxValueVisibility: false,
                                  valueLabelVisibility: false,
                                  animationDuration:
                                      const Duration(milliseconds: 1000),
                                  starOffColor: const Color(0xffe7e8ea),
                                  starColor: Colors.yellow,
                                )
                              : const SizedBox(),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  Padding(
                    padding: const EdgeInsets.only(left: 55),
                    child: Text(review.message.toString()),
                  ),
                  const Divider(),
                ],
              );
            })
        : const Text("No Reviews Found");
  }
}
