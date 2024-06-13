import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

import 'package:domain_models/domain_models.dart';
import 'package:inpatient_api/inpatient_api.dart';
import 'package:user_repository/src/mappers/mappers.dart';
import 'package:user_repository/src/user_secure_storage.dart';

class UserRepository {
  UserRepository({
    required InpatientApi remoteApi,
    @visibleForTesting UserSecureStorage? secureStorage,
  })  : _remoteApi = remoteApi,
        _secureStorage = secureStorage ?? const UserSecureStorage();

  final UserSecureStorage _secureStorage;
  final InpatientApi _remoteApi;
  final BehaviorSubject<User?> _userSubject = BehaviorSubject();

  Future<void> signIn({
    required String username,
    required String password,
    required String baseUrl,
  }) async {
    try {
      final apiUser = await _remoteApi.signIn(
        username: username,
        password: password,
        baseUrl: baseUrl,
      );

      await _secureStorage.upsertUserInfo(
          username: apiUser.username,
          sessionId: apiUser.sessionId,
          baseUrl: apiUser.baseUrl,
          userUuid: apiUser.userUuid);

      final domainUser = apiUser.toDomainModel();

      _userSubject.add(
        domainUser,
      );
    } on InvalidCredentialsInpatientException catch (_) {
      throw InvalidCredentialsException();
    }
  }

  Stream<User?> getUser() async* {
    if (!_userSubject.hasValue) {
      final userInfo = await Future.wait([
        _secureStorage.getUsername(),
        _secureStorage.getUserBaseUrl(),
        _secureStorage.getUserSessionId(),
        _secureStorage.getUserUuid(),
      ]);

      final username = userInfo[0];
      final userBaseUrl = userInfo[1];
      final userSessionId = userInfo[2];
      final userUid = userInfo[3];

      if (userBaseUrl != null &&
          username != null &&
          userSessionId != null &&
          userUid != null) {
        _userSubject.add(
          User(
            username: username,
            userUuid: userUid,
            sessionId: userSessionId,
            baseUrl: userBaseUrl,
          ),
        );
      } else {
        _userSubject.add(
          null,
        );
      }
    }

    yield* _userSubject.stream;
  }

  Future<String?> getUserSessionId() {
    return _secureStorage.getUserSessionId();
  }

  Future<void> signOut() async {
    await _remoteApi.signOut();
    await _secureStorage.deleteUserInfo();
    _userSubject.add(null);
  }
}
