import 'package:flutter_test/flutter_test.dart';
import 'package:food_assignment/features/shared/domain/models/paginated_response.dart';

import '../../../fixtures/dashboard/dummy_productlist.dart';

void main() {
  test('Should calculate the page from the response data', () {
    final PaginatedResponse paginatedResponse = ktestPaginatedResponse();

    expect(paginatedResponse.toString(),
        'PaginatedResponse(total:${paginatedResponse.totalCount}, skip:${paginatedResponse.size}, data:${paginatedResponse.data.length})');
  });
}
