import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';

import 'package:news_tutorial/news_modal.dart';

class NewsService {
  final formatter = DateFormat("yyyy-MM-dd hh:mm");

  Future<List<News>> getNews() async {
    const spaceId = String.fromEnvironment('SPACE_ID', defaultValue: '');
    const accessToken =
        String.fromEnvironment('ACCESS_TOKEN', defaultValue: '');
    const entryId = String.fromEnvironment('ENTRY_ID', defaultValue: '');

    final uri = Uri.https(
      'cdn.contentful.com',
      '/spaces/$spaceId/environments/master/entries/$entryId',
      {'access_token': accessToken},
    );
    try {
      var response = await http.get(uri);
      var jsonData = json.decode(response.body);
      List<News> news = [];
      for (var item in jsonData['fields']['news']) {
        news.add(News(
          item['id'],
          item['title'],
          formatter.format(DateTime.parse(item['publishedAt'])),
          item['image'],
          description: item['description'],
          sourceUrl: item['sourceUrl'],
          source: item['source'],
          content: item['content'],
        ));
      }
      return news;
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }
}
