class Article {
  int? id;
  String? text;
  String? title;
  String? imageUrl;
  String? authorName;
  String? url;
  int? premium;
  int? order;
  String? fullText;
  String? authorDescription;
  String? image;

  Article({
    this.id,
    this.text,
    this.title,
    this.imageUrl,
    this.authorName,
    this.url,
    this.premium,
    this.order,
    this.fullText,
    this.authorDescription,
    this.image,
  });

  Article.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    text = json['text'];
    title = json['title'];
    imageUrl = json['image_url'];
    authorName = json['author_name'];
    url = json['url'];
    premium = json['premium'];
    order = json['order'];
    fullText = json['full_text'];
    authorDescription = json['author_description'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['text'] = text;
    data['title'] = title;
    data['image_url'] = imageUrl;
    data['author_name'] = authorName;
    data['url'] = url;
    data['premium'] = premium;
    data['order'] = order;
    data['full_text'] = fullText;
    data['author_description'] = authorDescription;
    data['image'] = image;
    return data;
  }
}
