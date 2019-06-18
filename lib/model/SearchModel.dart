import 'package:json_annotation/json_annotation.dart';

part 'SearchModel.g.dart';


@JsonSerializable()
class SearchModel {

  int count;

  bool error;

   List<Results> results;

  SearchModel(this.count,this.error,this.results,);

  factory SearchModel.fromJson(Map<String, dynamic> srcJson) => _$SearchModelFromJson(srcJson);

}


@JsonSerializable()
class Results {

  String desc;

  String ganhuo_id;

  String publishedAt;

  String readability;

  String type;

  String url;

  String who;

  Results(this.desc,this.ganhuo_id,this.publishedAt,this.readability,this.type,this.url,this.who,);

  factory Results.fromJson(Map<String, dynamic> srcJson) => _$ResultsFromJson(srcJson);

}


