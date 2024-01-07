import 'dart:convert';
import 'package:expatrio_tax_task/features/features.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../../fixture/fixture_reader.dart';

//flutter test test/features/infrastructure/model/user_subject_model_test.dart
void main() {
  // make instance from user subject model and set the default params.
  const UserSubjectModel userSubjectModel = UserSubjectModel(
    userId: 113875,
    userUuid: "7fe524e1-9575-4050-b209-8ebaf7094347",
    lastName: "Ba Cba Aion",
    firstName: "Bobon",
    fullName: "Bobon Ba Cba Aion",
    email: "tito+bs792@expatrio.com",
    role: "CUSTOMER",
    isAdmin: false,
  );

  test("fromJson", () async {
    // get data from local json file
    final Map<String, dynamic> mapData =
        json.decode(fixture("cached_user_subject_data.json"));
    UserSubjectModel result;
    // result will take the mappedData from the user subject json file
    result = UserSubjectModel.fromJson(mapData);
    // here we can check so if it is confirmed or not
    expect(result, userSubjectModel);
  });

  test("toJson", () async {
    final result = userSubjectModel.toJson();

    // mapping data
    Map<String, dynamic> mapOfData = {
      "userId": 113875,
      "userUuid": "7fe524e1-9575-4050-b209-8ebaf7094347",
      "lastName": "Ba Cba Aion",
      "firstName": "Bobon",
      "fullName": "Bobon Ba Cba Aion",
      "email": "tito+bs792@expatrio.com",
      "role": "CUSTOMER",
      "isAdmin": false,
    };
    // here we can check so if it is confirmed or not
    expect(result, mapOfData);
  });
}
