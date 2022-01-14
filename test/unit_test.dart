import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:subtiga_restaurant/data/api/api_service.dart';
import 'package:subtiga_restaurant/data/api/url.dart';

import 'unit_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group('getRestaurantList', () {
    test('return all restaurant if the http call completes successfully',
            () async {
          final apiService = ApiService();
          final client = MockClient();
          var response =
              '{"error": false, "message": "success", "count": 20, "restaurants": []}';

          when(
            client.get(Uri.parse(ApiUrl.list)),
          ).thenAnswer((_) async => http.Response(response, 200));

          var restaurant = await apiService.getRestaurantResult(client);
          expect(restaurant.message, 'success');
        });

    test('throw exception if http error',
            () async {
          final apiService = ApiService();
          final client = MockClient();

          when(
            client.get(Uri.parse(ApiUrl.list)),
          ).thenAnswer((_) async => http.Response('Not Found', 404));

          var restaurant = apiService.getRestaurantResult(client);
          expect(restaurant, throwsException);
        });

    test('throw exception if http error',
            () async {
          final apiService = ApiService();
          final client = MockClient();

          when(
            client.get(Uri.parse(ApiUrl.list)),
          ).thenAnswer((_) async => throw const SocketException('No Internet Connection'));

          var restaurant = apiService.getRestaurantResult(client);
          expect(restaurant, throwsException);
        });


  });
}