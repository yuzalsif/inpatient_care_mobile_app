import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserSecureStorage {
  static const _sessionIdKey = 'inpatient-sessionId';
  static const _usernameKey = 'inpatient-username';
  static const _userUuidKey = 'inpatient-userUuid';
  static const _baseUrlKey = 'inpatient-baseUrl';

  const UserSecureStorage({
    FlutterSecureStorage? secureStorage,
  }) : _secureStorage = secureStorage ?? const FlutterSecureStorage();

  final FlutterSecureStorage _secureStorage;

  Future<void> upsertUserInfo({
    required String username,
    required String sessionId,
    required String userUuid,
    required String baseUrl,
  }) =>
      Future.wait([
        _secureStorage.write(
          key: _sessionIdKey,
          value: sessionId,
        ),
        _secureStorage.write(
          key: _usernameKey,
          value: username,
        ),
        _secureStorage.write(
          key: _userUuidKey,
          value: userUuid,
        ),
        _secureStorage.write(
          key: _baseUrlKey,
          value: baseUrl,
        )
      ]);

  Future<void> deleteUserInfo() => Future.wait([
        _secureStorage.delete(
          key: _sessionIdKey,
        ),
        _secureStorage.delete(
          key: _usernameKey,
        ),
        _secureStorage.delete(
          key: _userUuidKey,
        ),
        _secureStorage.delete(
          key: _baseUrlKey,
        ),
      ]);

  Future<String?> getUserBaseUrl() => _secureStorage.read(
        key: _baseUrlKey,
      );

  Future<String?> getUserSessionId() => _secureStorage.read(
        key: _sessionIdKey,
      );

  Future<String?> getUsername() => _secureStorage.read(
        key: _usernameKey,
      );

  Future<String?> getUserUuid() => _secureStorage.read(
        key: _userUuidKey,
      );
}
