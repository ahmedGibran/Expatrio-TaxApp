// Mocks generated by Mockito 5.4.4 from annotations
// in expatrio_tax_task/test/features/infrastructure/repositories/auth_repository_impl_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;

import 'package:expatrio_tax_task/core/core.dart' as _i2;
import 'package:expatrio_tax_task/features/features.dart' as _i4;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

/// A class which mocks [NetworkInfo].
///
/// See the documentation for Mockito's code generation for more information.
class MockNetworkInfo extends _i1.Mock implements _i2.NetworkInfo {
  MockNetworkInfo() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<bool> get isConnected => (super.noSuchMethod(
        Invocation.getter(#isConnected),
        returnValue: _i3.Future<bool>.value(false),
      ) as _i3.Future<bool>);
}

/// A class which mocks [AuthRemoteData].
///
/// See the documentation for Mockito's code generation for more information.
class MockAuthRemoteData extends _i1.Mock implements _i4.AuthRemoteData {
  MockAuthRemoteData() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<_i4.User?> login(
    String? email,
    String? password,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #login,
          [
            email,
            password,
          ],
        ),
        returnValue: _i3.Future<_i4.User?>.value(),
      ) as _i3.Future<_i4.User?>);
}

/// A class which mocks [AuthLocalData].
///
/// See the documentation for Mockito's code generation for more information.
class MockAuthLocalData extends _i1.Mock implements _i4.AuthLocalData {
  MockAuthLocalData() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<_i4.User?> getUserData() => (super.noSuchMethod(
        Invocation.method(
          #getUserData,
          [],
        ),
        returnValue: _i3.Future<_i4.User?>.value(),
      ) as _i3.Future<_i4.User?>);

  @override
  _i3.Future<void> cacheUserData(_i4.User? user) => (super.noSuchMethod(
        Invocation.method(
          #cacheUserData,
          [user],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);
}
