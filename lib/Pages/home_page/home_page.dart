import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:search_engine/Controller/Controller.dart';

String searchData = '';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    WebController provider = Provider.of<WebController>(context);
    WebController nonProvider =
        Provider.of<WebController>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('My Browser'),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => Container(
                      width: 500,
                      height: 1000,
                      child: TextButton(
                        child: Text('DISMISS'),
                        onPressed: () {},
                      ),
                    ),
                  );
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(
                      CupertinoIcons.bookmark_fill,
                      color: Colors.grey,
                    ),
                    Text(
                      'All Bookmarks',
                    ),
                  ],
                ),
              ),
              PopupMenuItem(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Search Engine'),
                      actions: [
                        RadioListTile(
                          title: const Text('Google'),
                          value: 'Google',
                          groupValue: provider.groupValue,
                          onChanged: (val) {
                            nonProvider.searchEngine(val);
                            nonProvider.chromeWeb(
                                val: 'https://www.google.co.in/');
                            Navigator.pop(context);
                          },
                        ),
                        RadioListTile(
                          title: const Text('Yahoo'),
                          value: 'Yahoo',
                          groupValue: provider.groupValue,
                          onChanged: (val) {
                            nonProvider.searchEngine(val);
                            nonProvider.chromeWeb(
                                val: 'https://www.yahoo.com/');
                            Navigator.pop(context);
                          },
                        ),
                        RadioListTile(
                          title: const Text('Bing'),
                          value: 'Bing',
                          groupValue: provider.groupValue,
                          onChanged: (val) {
                            nonProvider.searchEngine(val);
                            nonProvider.chromeWeb(val: 'https://www.bing.com/');
                            Navigator.pop(context);
                          },
                        ),
                        RadioListTile(
                          title: const Text('Duck Duck Go'),
                          value: 'Duck Duck Go',
                          groupValue: provider.groupValue,
                          onChanged: (val) {
                            nonProvider.searchEngine(val);
                            nonProvider.chromeWeb(
                                val: 'https://duckduckgo.com/');
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  );
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(
                      Icons.screen_search_desktop_outlined,
                      color: Colors.grey,
                    ),
                    Text(
                      'Search Engine',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            flex: 8,
            child: InAppWebView(
              pullToRefreshController: provider.pullToRefreshController,
              onLoadStop: provider.onLoadStop,
              onWebViewCreated: provider.onWebViewCreated,
              initialUrlRequest: URLRequest(
                url: WebUri.uri(
                  Uri.parse(provider.googleURL),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onSubmitted: (val) {
                nonProvider.textOnSubmitted(val);
              },
              decoration: InputDecoration(
                suffixIcon: const Icon(
                  Icons.search,
                ),
                labelText: 'Search or Type Web Address',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.home_filled,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.bookmark_add,
                ),
              ),
              IconButton(
                onPressed: provider.canBack
                    ? () {
                        provider.back();
                      }
                    : null,
                icon: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                ),
              ),
              IconButton(
                onPressed: () {
                  provider.reload();
                },
                icon: const Icon(
                  Icons.refresh,
                ),
              ),
              IconButton(
                onPressed: provider.canForward
                    ? () {
                        provider.forward();
                      }
                    : null,
                icon: const Icon(
                  Icons.arrow_forward_ios_rounded,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
