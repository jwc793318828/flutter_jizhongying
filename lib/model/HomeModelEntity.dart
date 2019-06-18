class HomeModelEntity {
	List<dynamic> category;
	bool error;
	Map<String, dynamic> results;

	HomeModelEntity(this.category, this.error, this.results);

	HomeModelEntity.fromJson(Map<String, dynamic> json)
			: error = json['error'],
				category = json['category'],
				results = json['results'];
}

class HomeModelDataEntity {
	String createdAt;
	String publishedAt;
	String id;
	String source;
	bool used;
	String type;
	String url;
	String desc;
	String who;

	HomeModelDataEntity({this.createdAt, this.publishedAt, this.id, this.source, this.used, this.type, this.url, this.desc, this.who});

	HomeModelDataEntity.fromJson(Map<String, dynamic> json) {
		createdAt = json['createdAt'];
		publishedAt = json['publishedAt'];
		id = json['_id'];
		source = json['source'];
		used = json['used'];
		type = json['type'];
		url = json['url'];
		desc = json['desc'];
		who = json['who'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['createdAt'] = this.createdAt;
		data['publishedAt'] = this.publishedAt;
		data['_id'] = this.id;
		data['source'] = this.source;
		data['used'] = this.used;
		data['type'] = this.type;
		data['url'] = this.url;
		data['desc'] = this.desc;
		data['who'] = this.who;
		return data;
	}
}

