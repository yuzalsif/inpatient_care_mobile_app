import 'package:domain_models/domain_models.dart';
import 'package:inpatient_api/inpatient_api.dart';

extension UserRMToDomain on UserRM {
  User toDomain() {
    return User(
      sessionId: sessionId,
      username: username,
      userUuid: userUuid,
      baseUrl: baseUrl,
    );
  }
}
