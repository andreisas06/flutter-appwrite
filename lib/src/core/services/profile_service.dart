import 'package:injectable/injectable.dart';

import '../entities/profile/profile.dart';
import '../repositories/profile_repository.dart';

/// Service for managing user profiles.
@lazySingleton
class ProfileService {
  /// Creates a new [ProfileService] instance.
  const ProfileService(this._profileRepository);

  final ProfileRepository _profileRepository;

  /// Gets the signed in users [Profile].
  Future<Profile> getProfile() {
    return _profileRepository.getProfile();
  }

  /// Starts the rest password procedure for the given [email].
  Future<void> resetPassword(String email) {
    return _profileRepository.resetPassword(email);
  }
}
