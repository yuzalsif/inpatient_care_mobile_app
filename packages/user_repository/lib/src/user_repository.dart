import 'package:rxdart/rxdart.dart';

import 'package:domain_models/domain_models.dart';
import 'package:inpatient_api/inpatient_api.dart';
import 'package:user_repository/src/mappers/mappers.dart';
import 'package:user_repository/src/user_secure_storage.dart';

class UserRepository {
  UserRepository({
    required InpatientApi remoteApi,
    required UserSecureStorage secureStorage,
  }) : _remoteApi = remoteApi,
       _secureStorage = secureStorage;

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
        userUuid: apiUser.userUuid
      );

      final domainUser = apiUser.toDomainModel();

      _userSubject.add(
        domainUser,
      );
    } on InvalidCredentialsInpatientException catch (_) {
      throw InvalidCredentialsException();
    }
  }
}