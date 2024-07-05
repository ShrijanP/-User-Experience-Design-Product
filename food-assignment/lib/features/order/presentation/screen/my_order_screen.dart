import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../shared/domain/models/order/my_order_response.dart';
import '../../../shared/utils/config.dart';
import '../providers/my_order_state_providers.dart';

class MyOrderScreen extends ConsumerWidget {
  const MyOrderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(myOrderStateNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('My Order'),
      ),
      body: state.when(
          initial: () => const Center(
                child: Text("No Order Found"),
              ),
          loading: () => const Center(child: CircularProgressIndicator()),
          failure: (failure, data) => data.data == null || data.data!.isEmpty
              ? _buildNoCartFound(context, ref)
              : _buildBody(context, ref, data),
          success: (data) => data.data == null || data.data!.isEmpty
              ? _buildNoCartFound(context, ref)
              : _buildBody(context, ref, data)),
    );
  }

  Widget _buildBody(BuildContext context, WidgetRef ref, MyOrderResponse data) {
    return RefreshIndicator(
      onRefresh: () {
        return ref.read(myOrderStateNotifierProvider.notifier).fetchOrder();
      },
      child: ListView.builder(
          padding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          shrinkWrap: true,
          physics: const ScrollPhysics(),
          itemCount: data.data!.length,
          itemBuilder: (context, index) {
            var order = data.data![index];
            return Card(
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Image.network(
                            order.item!.images!.isNotEmpty
                                ? "${AppConfigs.imageUrl}${order.item!.images!.first.toString()}"
                                : "https://i.pinimg.com/564x/dd/f0/9d/ddf09d27fef66c6ca33e32446d9be544.jpg",
                            scale: 1.5,
                            height: 100,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(order.item!.name.toString()),
                              Text(
                                  "Rs. ${order.price.toString()} x ${order.quantity.toString()}"),
                              Text(DateFormat.MMMMEEEEd()
                                  .format(order.createdAt!)),
                              Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 2),
                                  decoration: const BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(5)),
                                  ),
                                  child: Text(
                                    order.status.toString(),
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12),
                                  )),
                              // Text(order.quantity.toString()),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }

  Widget _buildNoCartFound(BuildContext context, WidgetRef ref) {
    return RefreshIndicator(
      onRefresh: () {
        return ref.read(myOrderStateNotifierProvider.notifier).fetchOrder();
      },
      child: ListView(
        children: const [
          Center(
            child: Text("No Order Found"),
          ),
        ],
      ),
    );
  }
}
