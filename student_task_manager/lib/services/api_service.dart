import 'dart:convert';
import 'package:http/http.dart' as http;
import '../utils/constants.dart';

class ApiService {
  Future<Map<String, String>> fetchDailyQuote() async {
    try {
      final response = await http.get(Uri.parse(AppConstants.quoteApiUrl));
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return {
          'content': data['quote'] ?? data['content'] ?? 'No quote available',
          'author': data['author'] ?? 'Unknown',
        };
      } else {
        throw Exception('Failed to load quote');
      }
    } catch (e) {
      return {
        'content': 'Could not fetch quote. Please check your connection.',
        'author': '',
      };
    }
  }
}
