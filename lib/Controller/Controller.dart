import 'package:flutter/cupertino.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../Pages/home_page/home_page.dart';

class WebController extends ChangeNotifier {
  bool canBack = false;
  bool canForward = false;
  String googleURL = 'https://www.google.co.in/';
  String webURL = '';
  PullToRefreshController pullToRefreshController = PullToRefreshController();

  late InAppWebViewController webViewController;
  String groupValue = 'Google';

  void chromeWeb({required val}) {
    googleURL = val;
    print(googleURL);
    webViewController.loadUrl(
      urlRequest: URLRequest(
        url: WebUri.uri(
          Uri.parse(
            googleURL,
          ),
        ),
      ),
    );
    notifyListeners();
  }

  void onWebViewCreated(InAppWebViewController controller) {
    webViewController = controller;
  }

  Future<void> checkNavigations() async {
    canBack = await webViewController.canGoBack();
    canForward = await webViewController.canGoForward();
    notifyListeners();
  }

  void onLoadStop(controller, uri) {
    webViewController = controller;
    pullToRefreshController.endRefreshing();

    checkNavigations();
  }

  void googlePullToRefresh() {
    pullToRefreshController.endRefreshing();
  }

  void back() {
    webViewController.goBack();
    print(googleURL);
  }

  void forward() {
    webViewController.goForward();
    print(googleURL);
  }

  Future<void> reload() async {
    await webViewController.reload();
    await checkNavigations();
  }

  void searchEngine(val) {
    groupValue = val;
    notifyListeners();
  }

  void textOnSubmitted(val) {
    if (groupValue == 'Google') {
      googleURL =
          'https://www.google.com/search?q=$val&oq=$val&gs_lcrp=EgZjaHJvbWUqDggAEEUYJxg7GIAEGIoFMg4IABBFGCcYOxiABBiKBTIOCAEQRRgnGDsYgAQYigUyBggCEEUYOzIMCAMQABhDGIAEGIoFMg8IBBAAGEMYsQMYgAQYigUyDAgFEAAYQxiABBiKBTISCAYQABhDGIMBGLEDGIAEGIoFMgYIBxBFGDsyBggIEEUYOzIMCAkQABhDGIAEGIoFqAIIsAIB&sourceid=chrome&ie=UTF-8';
    } else if (groupValue == 'Yahoo') {
      googleURL =
          'https://search.yahoo.com/search?p=$val&fr=yfp-t&fr2=p%3Afp%2Cm%3Asb&ei=UTF-8&fp=1';
    } else if (groupValue == 'Bing') {
      googleURL =
          'https://www.bing.com/search?q=$val&form=QBLH&sp=-1&lq=0&pq=$val&sc=11-7&qs=n&sk=&cvid=94BEE7C3D3054F9FBDDF90DF23C77AA6&ghsh=0&ghacc=0&ghpl=';
    } else {
      googleURL = 'https://duckduckgo.com/?q=$val&ia=web';
    }
    webViewController.loadUrl(
      urlRequest: URLRequest(
        url: WebUri.uri(
          Uri.parse(
            googleURL,
          ),
        ),
      ),
    );
  }
}
