// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserData _$UserDataFromJson(Map<String, dynamic> json) => UserData(
      json['token'] as String?,
      json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserDataToJson(UserData instance) => <String, dynamic>{
      'user': instance.user,
      'token': instance.token,
    };

User _$UserFromJson(Map<String, dynamic> json) => User(
      json['id'] as int?,
      json['qualification'] as String?,
      json['email'] as String?,
      json['gender'] as String?,
      json['subject'] as String?,
      json['residency'] as String?,
      json['nationality'] as String?,
      json['image_url'] as String?,
      json['apps'] as String?,
      json['english_level'] as String?,
      json['field_of_study'] as String?,
      json['forename'] as String?,
      json['phone_number'] as String?,
      json['surname'] as String?,
      json['years_of_experience'] as String?,
      json['bio'] as String?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'bio': instance.bio,
      'forename': instance.forename,
      'surname': instance.surname,
      'phone_number': instance.phone_number,
      'email': instance.email,
      'image_url': instance.image_url,
      'gender': instance.gender,
      'nationality': instance.nationality,
      'residency': instance.residency,
      'years_of_experience': instance.years_of_experience,
      'qualification': instance.qualification,
      'field_of_study': instance.field_of_study,
      'english_level': instance.english_level,
      'subject': instance.subject,
      'apps': instance.apps,
    };
