class Quotes {
  bool? hasMore;
  int? currentPage;
  int? lastPage;
  int? nextPage;
  List<Quote>? list;

  Quotes({
    this.hasMore,
    this.currentPage,
    this.lastPage,
    this.nextPage,
    this.list,
  });

  Quotes.fromJson(Map<String, dynamic> json) {
    hasMore = json['has_more'];
    currentPage = json['current_page'];
    lastPage = json['last_page'];
    nextPage = json['next_page'];
    if (json['list'] != null) {
      list = <Quote>[];
      json['list'].forEach((v) {
        list!.add(Quote.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['has_more'] = hasMore;
    data['current_page'] = currentPage;
    data['last_page'] = lastPage;
    data['next_page'] = nextPage;
    if (list != null) {
      data['list'] = list!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Quote {
  int? id;
  String? text;
  String? author;
  int? order;

  Quote({
    this.id,
    this.text,
    this.author,
    this.order,
  });

  Quote.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    text = json['text'];
    author = json['author'];
    order = json['order'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['text'] = text;
    data['author'] = author;
    data['order'] = order;
    return data;
  }
}
