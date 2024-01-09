import 'dart:convert';
import 'dart:io';
import 'package:expatrio_tax_task/core/core.dart';
import 'package:expatrio_tax_task/features/features.dart';
import 'package:http/http.dart' as http;

// fetch data from server side
abstract class AuthRemoteData {
  Future<User?> login(String email, String password);
}

class AuthRemoteDataImpl extends AuthRemoteData {
  final http.Client httpClient;
  AuthRemoteDataImpl({required this.httpClient});
  @override
  Future<User?> login(String email, String password) async {
    User? user;
    final response = await httpClient.post(
      Uri.parse(Constant().endPoint('auth/login')),
      headers: {HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'},
      body: json.encode(<String, String>{'email': email, 'password': password}),
    );
    print("response: ${response}");

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      user = UserModel.fromJson(data);
    } else {
      throw ServerException();
    }
    return user;
  }
}
