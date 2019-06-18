class ClassifyModel {
	int count;
	bool error;
	List<ClassifyModelResult> results;

	ClassifyModel({this.count, this.error, this.results});

	ClassifyModel.fromJson(Map<String, dynamic> json) {
		count = json['count'];
		error = json['error'];
		if (json['results'] != null) {
			results = new List<ClassifyModelResult>();(json['results'] as List).forEach((v) { results.add(new ClassifyModelResult.fromJson(v)); });
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['count'] = this.count;
		data['error'] = this.error;
		if (this.results != null) {
      data['results'] =  this.results.map((v) => v.toJson()).toList();
    }
		return data;
	}
}

class ClassifyModelResult {
	String readability;
	String publishedAt;
	String ganhuoId;
	String type;
	String url;
	String desc;
	String who;

	ClassifyModelResult({this.readability, this.publishedAt, this.ganhuoId, this.type, this.url, this.desc, this.who});

	ClassifyModelResult.fromJson(Map<String, dynamic> json) {
		readability = json['readability'];
		publishedAt = json['publishedAt'];
		ganhuoId = json['ganhuo_id'];
		type = json['type'];
		url = json['url'];
		desc = json['desc'];
		who = json['who'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['readability'] = this.readability;
		data['publishedAt'] = this.publishedAt;
		data['ganhuo_id'] = this.ganhuoId;
		data['type'] = this.type;
		data['url'] = this.url;
		data['desc'] = this.desc;
		data['who'] = this.who;
		return data;
	}
}
