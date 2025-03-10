import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:viralize/core/models/http_response_mode.dart';

abstract class IHttpClient {
  Future<HttpResponse> get({required String url});
  Future<HttpResponse> delete({required String url});
  Future<HttpResponse> post({
    required String url,
    required Map<String, dynamic> body,
  });
  Future<HttpResponse> put({
    required String url,
    required Map<String, dynamic> body,
  });
}

class HttpClientImpl implements IHttpClient {
  final http.Client client;

  HttpClientImpl(this.client);

  @override
  Future<HttpResponse> get({required String url}) async {
    final response = await client.get(Uri.parse(url));
    return _handleResponse(response);
  }

  @override
  Future<HttpResponse> post({
    required String url,
    required Map<String, dynamic> body,
  }) async {
    final response = await client.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(body),
    );
    return _handleResponse(response);
  }

  @override
  Future<HttpResponse> put({
    required String url,
    required Map<String, dynamic> body,
  }) async {
    final response = await client.put(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(body),
    );
    return _handleResponse(response);
  }

  @override
  Future<HttpResponse> delete({
    required String url,
  }) async {
    final response = await client.delete(Uri.parse(url));
    return _handleResponse(response);
  }

  HttpResponse _handleResponse(http.Response response) {
    return HttpResponse(
      statusCode: response.statusCode,
      body: json.decode(response.body),
    );
  }
}
