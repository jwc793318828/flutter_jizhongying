// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SearchModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchModel _$SearchModelFromJson(Map<String, dynamic> json) {
  return SearchModel(
      json['count'] as int,
      json['error'] as bool,
      (json['results'] as List)
          ?.map((e) =>
              e == null ? null : Results.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$SearchModelToJson(SearchModel instance) =>
    <String, dynamic>{
      'count': instance.count,
      'error': instance.error,
      'results': instance.results
    };

Results _$ResultsFromJson(Map<String, dynamic> json) {
  return Results(
      json['desc'] as String,
      json['ganhuo_id'] as String,
      json['publishedAt'] as String,
      json['readability'] as String,
      json['type'] as String,
      json['url'] as String,
      json['who'] as String);
}

Map<String, dynamic> _$ResultsToJson(Results instance) => <String, dynamic>{
      'desc': instance.desc,
      'ganhuo_id': instance.ganhuo_id,
      'publishedAt': instance.publishedAt,
      'readability': instance.readability,
      'type': instance.type,
      'url': instance.url,
      'who': instance.who
    };
