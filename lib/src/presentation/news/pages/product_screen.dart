import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:latest_news/core/constants/app_color.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

import 'package:webview_flutter_android/webview_flutter_android.dart';

import '../widgets/loading_widget.dart';

class ProductScreen extends StatefulWidget {
  // final String productName;
  final String url;

  const ProductScreen({
    super.key,
    // required this.productName,
    required this.url,
  });

  static Route<void> route(
    String productName,
    String url,
  ) {
    return CupertinoPageRoute(
      builder: (context) => ProductScreen(
        // productName: productName,
        url: url,
      ),
    );
  }

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  late WebViewController _controller;
  bool isLoading = true;

  @override
  void initState() {
    initWebView();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.scaffoldBackgroundColor,
        appBar: AppBar(
          title: const Text(
            // widget.productName ?? "",
            "",
            overflow: TextOverflow.ellipsis,
          ),
        ),
        body: isLoading
            ? const LoadingWidget()
            : WebViewWidget(
              controller: _controller,
            ),
      ),
    );
  }

  void initWebView() {
    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    final WebViewController controller = WebViewController.fromPlatformCreationParams(params);

    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            debugPrint('WebView is loading (progress : $progress%)');
          },
          onPageStarted: (String url) {
            debugPrint('Page started loading: $url');
          },
          onPageFinished: (String url) {
            isLoading = false;
            if (mounted) {
              setState(() {});
            }
            debugPrint('Page finished loading: $url');
          },
          onWebResourceError: (WebResourceError error) {
            isLoading = false;
            if (mounted) {
              setState(() {});
            }
            debugPrint(
                "Page resource error: code: ${error.errorCode}\ndescription: ${error.description}\nerrorType: ${error.errorType}\nisForMainFrame: ${error.isForMainFrame}");
          },
          onNavigationRequest: (NavigationRequest request) {
            debugPrint('allowing navigation to ${request.url}');
            if (request.url.startsWith("https://my.click.uz/") || request.url.startsWith("https://checkout.paycom.uz/")) {
              return NavigationDecision.prevent;
            } else {
              return NavigationDecision.navigate;
            }
          },
          onUrlChange: (UrlChange change) {
            debugPrint('url change to ${change.url}');
          },
        ),
      )
      ..addJavaScriptChannel(
        'Toaster',
        onMessageReceived: (JavaScriptMessage message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        },
      )
      ..loadRequest(Uri.parse(widget.url));

    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController).setMediaPlaybackRequiresUserGesture(false);
    }

    _controller = controller;
  }
}
