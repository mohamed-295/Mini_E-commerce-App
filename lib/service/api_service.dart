import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl ='';//APi url hidden for some reasons

  ApiService();

  Future<dynamic> fetchData(String endpoint, {String? token, int? id,String? name}) async {
    final queryParameters = {
      if (name != null) 'name': name,
      if (id != null) 'id': id.toString(),
      if (token != null) 'token': token,
    };

    final uri = Uri.parse('$baseUrl/$endpoint').replace(queryParameters: queryParameters);

    final response = await http.get(
      uri,
      headers: {
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final decodedBody = json.decode(response.body);
      if (decodedBody is List) {
        return decodedBody;
      } else if (decodedBody['state'] == true) {
        return decodedBody['data'];
      } else {
        throw "${decodedBody['message']}\n${decodedBody['data']}";
      }
    } else {
      final decodedBody = json.decode(response.body);
      throw "${decodedBody['message']}\n${decodedBody['data']}";
    }
  }

  Future<dynamic> postData(String endpoint, Map<String, dynamic> data, {String? token}) async {
    final uri = Uri.parse('$baseUrl/$endpoint').replace(queryParameters: {
      if (token != null) 'token': token,
    });

    final response = await http.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: json.encode(data),
    );

    if (response.statusCode == 200) {
      final decodedBody = json.decode(response.body);
      if (decodedBody['state'] == true) {
        return decodedBody['data'];
      } else {
        throw "${decodedBody['message']}\n${decodedBody['data']}";
      }
    } else {
      final decodedBody = json.decode(response.body);
      throw "${decodedBody['message']}\n${decodedBody['data']}";
    }
  }
}