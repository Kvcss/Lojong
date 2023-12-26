class Video {
  int? id;
  String? name;
  String? description;
  String? file;  
  String? url;
  String? url2;
  String? awsUrl;
  String? image;
  String? imageUrl;
  int? premium;
  int? order;

  Video({
    this.id,
    this.name,
    this.description,
    this.file,
    this.url,
    this.url2,
    this.awsUrl,
    this.image,
    this.imageUrl,
    this.premium,
    this.order,
  });

  Video.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    file = json['file'];
    url = json['url'];
    url2 = json['url2'];
    awsUrl = json['aws_url'];
    image = json['image'];
    imageUrl = json['image_url'];
    premium = json['premium'];
    order = json['order'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['file'] = file;
    data['url'] = url;
    data['url2'] = url2;
    data['aws_url'] = awsUrl;
    data['image'] = image;
    data['image_url'] = imageUrl;
    data['premium'] = premium;
    data['order'] = order;
    return data;
  }
}
