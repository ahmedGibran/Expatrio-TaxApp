import 'dart:convert';
import 'package:expatrio_tax_task/core/core.dart';
import 'package:expatrio_tax_task/features/features.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class TaxLocalData {
  // get data when there data in present
  Future<Tax?> getTaxData();
  // should to save data when there no data from remote
  Future<void> cacheTaxData(Tax tax);
}

const String CACHED_TAX_DATA = "CACHED_TAX_DATA";

class TaxLocalDataImpl extends TaxLocalData {
  final FlutterSecureStorage storage;
  TaxLocalDataImpl({required this.storage});

  @override
  Future<void> cacheTaxData(Tax tax) async {
    try {
      await storage.write(
        key: CACHED_TAX_DATA,
        value: (tax as TaxModel).toJson().toString(),
      );
    } catch (_) {
      throw CacheException();
    }
  }

  @override
  Future<Tax?> getTaxData() async {
    Tax? tax;
    try {
      final value = await storage.read(key: CACHED_TAX_DATA);
      if (value != null) {
        final jsonData = json.decode(value);
        tax = TaxModel.fromJson(jsonData);
      }
    } catch (_) {
      throw CacheException();
    }
    return tax;
  }
}
