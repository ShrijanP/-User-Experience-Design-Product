//
// import 'package:ecommerce_assignment/features/dashboard/domain/providers/dashboard_providers.dart';
// import 'package:ecommerce_assignment/features/dashboard/presentation/providers/state/dashboard_notifier.dart';
// import 'package:ecommerce_assignment/features/dashboard/presentation/providers/state/dashboard_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_assignment/features/home_page/presentation/providers/state/dashboard_notifier.dart';
import 'package:food_assignment/features/home_page/presentation/providers/state/dashboard_state.dart';

import '../../domain/providers/dashboard_providers.dart';

final dashboardNotifierProvider =
    StateNotifierProvider<DashboardNotifier, DashboardState>((ref) {
  final repository = ref.watch(dashboardRepositoryProvider);
  return DashboardNotifier(repository)..fetchProducts();
});

final categoryProductNotifierProvider =
StateNotifierProvider<DashboardNotifier, DashboardState>((ref) {
  final repository = ref.watch(dashboardRepositoryProvider);
  return DashboardNotifier(repository);
});
