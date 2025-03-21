
import 'dart:convert';

import 'package:http/http.dart' as http;


class ShippingService {
  static const String apiUrl = "https://67dc2bfc1fd9e43fe4778501.mockapi.io/api/shippingrates";



  static Future<List<Map<String, dynamic>>> fetchRates() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        return List<Map<String, dynamic>>.from(json.decode(response.body));
      } else {
        throw Exception("Failed to load data");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }

  static Future<int?> calculateRate(String pickup, String delivery, String courier) async {
    try {
      final data = await fetchRates();
      var matchedRate = data.firstWhere(
            (rate) =>
        rate['pickup'] == pickup &&
            rate['delivery'] == delivery &&
            rate['courier'] == courier,
        orElse: () => {"price": -1},
      );

      return matchedRate["price"] != -1 ? matchedRate["price"] : null;
    } catch (e) {
      throw Exception("Error calculating rate: $e");
    }
  }
}
