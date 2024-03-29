import 'dart:convert';
import 'package:expatrio_tax_task/core/core.dart';
import 'package:expatrio_tax_task/features/features.dart';
import 'package:http/http.dart' as http;

abstract class TaxRemoteData {
  Future<Tax?> getTaxData();
  Future<void> updateTaxData(Tax tax);
}

class TaxRemoteDataImpl extends TaxRemoteData {
  final http.Client httpClient;
  TaxRemoteDataImpl({required this.httpClient});

  @override
  Future<Tax?> getTaxData() async {
    Tax? tax;
    final response = await httpClient.get(Uri.parse(Constant().endPoint('v3/customers/:id/tax-data')),
        headers: Constant().getHttpClientHeader());
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      tax = TaxModel.fromJson(data);
    } else {
      throw ServerException();
    }
    return tax;
  }

  @override
  Future<void> updateTaxData(Tax tax) async {
    final response = await httpClient.put(
      Uri.parse(Constant().endPoint('v3/customers/:id/tax-data')),
      headers: Constant().getHttpClientHeader(),
      body: json.encode((tax as TaxModel).toJson()),
    );
    if (response.statusCode == 200) {
      return;
    } else {
      throw ServerException();
    }
  }
}
