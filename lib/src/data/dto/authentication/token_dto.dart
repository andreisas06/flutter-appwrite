import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import '../../../../core.dart';

part 'token_dto.g.dart';

/// Date of birth related data.
@JsonSerializable(createToJson: true)
class TokenDTO {
  /// Creates a new [TokenDTO] instance.
  const TokenDTO({
    required this.accessToken,
    required this.refreshToken,
    required this.expiresAt,
  });

  /// Creates a new [TokenDTO] instance from an [encodedJson] string.
  factory TokenDTO.fromJson(String encodedJson) {
    final Map<String, dynamic> json =
        jsonDecode(encodedJson) as Map<String, dynamic>;
    return _$TokenDTOFromJson(json);
  }

  /// Creates a new [TokenDTO] instance from a [token] entity.
  factory TokenDTO.fromEntity(Token token) {
    return TokenDTO(
      accessToken: token.accessToken,
      refreshToken: token.refreshToken,
      expiresAt: token.expiresAt,
    );
  }

  /// The access token.
  final String accessToken;

  /// The refresh token.
  final String refreshToken;

  /// The total seconds until the token expires.
  final DateTime expiresAt;

  /// Converts the [TokenDTO] to an encoded json representation.
  String toJson() {
    return jsonEncode(_$TokenDTOToJson(this));
  }

  /// Turns the [TokenDTO] into a [Token] entity.
  Token toEntity() {
    return Token(
      accessToken: accessToken,
      refreshToken: refreshToken,
      expiresAt: expiresAt,
    );
  }
}
