class Articles {
  bool? hasMore;
  int? currentPage;
  int? lastPage;
  int? nextPage;
  List<ListItem>? listItems;

  Articles(
      {this.hasMore,
      this.currentPage,
      this.lastPage,
      this.nextPage,
      this.listItems});

  Articles.fromJson(Map<String, dynamic> json) {
    hasMore = json['has_more'];
    currentPage = json['current_page'];
    lastPage = json['last_page'];
    nextPage = json['next_page'];
    if (json['list'] != null) {
      listItems = <ListItem>[];
      json['list'].forEach((v) {
        listItems!.add(new ListItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['has_more'] = hasMore;
    data['current_page'] = currentPage;
    data['last_page'] = lastPage;
    data['next_page'] = nextPage;
    if (listItems != null) {
      data['list'] = listItems!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ListItem {
  int? id;
  String? text;
  String? title;
  String? imageUrl;
  String? authorName;
  String? url;
  int? premium;
  int? order;
  String? image;

  ListItem(
      {this.id,
      this.text,
      this.title,
      this.imageUrl,
      this.authorName,
      this.url,
      this.premium,
      this.order,
      this.image});

  ListItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    text = json['text'];
    title = json['title'];
    imageUrl = json['image_url'];
    authorName = json['author_name'];
    url = json['url'];
    premium = json['premium'];
    order = json['order'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['text'] = text;
    data['title'] = title;
    data['image_url'] = imageUrl;
    data['author_name'] = authorName;
    data['url'] = url;
    data['premium'] = premium;
    data['order'] = order;
    data['image'] = image;
    return data;
  }
}
