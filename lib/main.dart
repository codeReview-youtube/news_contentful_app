import 'package:flutter/material.dart';
import 'package:news_tutorial/news_detail.dart';
import 'package:news_tutorial/news_modal.dart';
import 'package:news_tutorial/news_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Highlight'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final newsService;

  @override
  void initState() {
    newsService = NewsService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        margin: const EdgeInsets.all(10),
        child: FutureBuilder(
          future: newsService.getNews(),
          builder: (context, snapshot) {
            if (snapshot.data != null) {
              List<News> news = snapshot.data as List<News>;
              return ListView.builder(
                itemCount: news.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(news[index].title),
                    subtitle: Row(
                      children: [
                        Text(news[index].date),
                        const SizedBox(width: 10),
                        Text(news[index].source ?? ''),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NewsDetailPage(
                            news: news[index],
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
