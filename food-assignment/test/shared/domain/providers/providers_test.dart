import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:food_assignment/features/shared/data/remote/remote.dart';
import 'package:food_assignment/features/shared/domain/providers/dio_network_service_provider.dart';

void main() {
  test('dioNetwokServiceProvider is a NetworkService', () {
    final providerContainer = ProviderContainer();

    addTearDown(providerContainer.dispose);

    expect(
      providerContainer.read(networkServiceProvider),
      isA<NetworkService>(),
    );
  });
}
