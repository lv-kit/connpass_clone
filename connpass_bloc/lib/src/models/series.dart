import 'package:equatable/equatable.dart';

class Series extends Equatable {
  final String url;
  final int id;
  final String title;

  Series({
    this.url,
    this.id,
    this.title
  }) : super([
    url,
    id,
    title
  ]);

  static Series fromJson(Map<String, dynamic> json) {
    return Series(
      url: json['url'] as String,
      id: json['id'] as int,
      title: json['title'] as String,
    );
  }
}