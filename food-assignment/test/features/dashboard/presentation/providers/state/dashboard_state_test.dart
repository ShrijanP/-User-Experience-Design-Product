// import 'package:flutter_project/features/dashboard/presentation/providers/state/dashboard_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:food_assignment/features/home_page/presentation/providers/state/dashboard_state.dart';

void main() {
  group('DashboardState Test\n', () {
    test('Should update concrete state', () {
      DashboardState dashboardState = const DashboardState();

      dashboardState =
          dashboardState.copyWith(message: 'DashboardConcreteState.loading');

      expect(dashboardState.message, equals('DashboardConcreteState.loading'));
    });
    test('Should return valid String', () {
      DashboardState dashboardState = const DashboardState();

      expect(
        dashboardState.toString(),
        'DashboardState(isLoading:${dashboardState.isLoading}, productLength: ${dashboardState.productList.length},total:${dashboardState.totalCount} page: ${dashboardState.page}, hasData: ${dashboardState.hasData}, state: ${dashboardState.state}, message: ${dashboardState.message})',
      );
    });
  });
}
