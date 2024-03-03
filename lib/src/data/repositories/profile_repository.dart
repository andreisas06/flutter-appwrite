import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../core.dart';
import '../clients/profile_client.dart';
import '../dto/profile/profile_dto.dart';

/// Concrete implementation of the [ProfileRepository] interface.
@Injectable(as: ProfileRepository)
class ApiProfileRepository implements ProfileRepository {
  final ProfileClient _profileClient = ProfileClient(
    Dio(),
    baseUrl: AppConfig.baseUrl,
  );

  @override
  Future<Profile> getProfile() async {
    try {
      final ProfileDTO profileDTO = await _profileClient.getRandomUser();
      return profileDTO.toEntity();
    } catch (e) {
      if (e is DioException) {
        throw switch (e.response?.statusCode.toDataResponseCode()) {
          _ => UnknownException(
              e.message ?? 'Unhandled code ${e.response?.statusCode}',
            ),
        };
      }
      throw const UnknownException('Non dio exception');
    }
  }

  @override
  Future<void> resetPassword(String email) {
    return Future<void>.value();
  }
}
