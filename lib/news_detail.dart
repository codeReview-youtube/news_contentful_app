import 'package:flutter/material.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:news_tutorial/news_modal.dart';

class NewsDetailPage extends StatelessWidget {
  final News news;

  const NewsDetailPage({Key? key, required this.news}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final blog = ModalRoute.of(context)!.settings.arguments as Blog; // you can pass as an argument in the route

    return Scaffold(
      appBar: AppBar(
        // title: Text(this.blog.title),
        title: Text(news.source ?? news.id),
      ),
      body: Container(
        margin: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Text(
                news.title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.network(
                    news.image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Text(
                news.description ?? '',
                style: TextStyle(
                  color: Colors.grey[800],
                ),
              ),
              const SizedBox(height: 5),
              Container(
                alignment: Alignment.topLeft,
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  'Published at: ${news.date}',
                  style: TextStyle(
                    color: Colors.grey[500],
                  ),
                ),
              ),
              Text(news.content ?? ''),
              const SizedBox(height: 10),
              Container(
                alignment: Alignment.topLeft,
                child: TextButton(
                  onPressed: () => _launchURL(news.sourceUrl ?? '', context),
                  child: const Text(
                    'Read the original article',
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _launchURL(String url, BuildContext context) async {
    print('Url: $url');

    try {
      await launch(
        url,
        customTabsOption: CustomTabsOption(
          toolbarColor: Theme.of(context).primaryColor,
          enableDefaultShare: true,
          enableUrlBarHiding: true,
          showPageTitle: true,
          animation: CustomTabsSystemAnimation.slideIn(),
          extraCustomTabs: const <String>[
            // ref. https://play.google.com/store/apps/details?id=org.mozilla.firefox
            'org.mozilla.firefox',
            // ref. https://play.google.com/store/apps/details?id=com.microsoft.emmx
            'com.microsoft.emmx',
          ],
        ),
        safariVCOption: SafariViewControllerOption(
          preferredBarTintColor: Theme.of(context).primaryColor,
          preferredControlTintColor: Colors.white,
          barCollapsingEnabled: true,
          entersReaderIfAvailable: false,
          dismissButtonStyle: SafariViewControllerDismissButtonStyle.close,
        ),
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
