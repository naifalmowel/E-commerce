import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:url_launcher/url_launcher.dart';

class TelrPaymentPage extends StatefulWidget {
  final String paymentUrl;

  const TelrPaymentPage({super.key, required this.paymentUrl});

  @override
  TelrPaymentPageState createState() => TelrPaymentPageState();
}

class TelrPaymentPageState extends State<TelrPaymentPage> {
  InAppWebViewController? _webViewController;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _openWebPaymentIfNeeded();
  }

  void _openWebPaymentIfNeeded() async {
    if (kIsWeb) {
      if (await canLaunchUrl(Uri.parse(widget.paymentUrl))) {
        await launchUrl(Uri.parse(widget.paymentUrl), mode: LaunchMode.externalApplication);
      } else {
        debugPrint("❌ Could not launch payment URL");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return Scaffold(
        appBar: AppBar(title: const Text("Payment")),
        body: const Center(child: Text("🔄 Redirecting to payment...")),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Payment")),
      body: Stack(
        children: [
          InAppWebView(
            initialUrlRequest: URLRequest(url: WebUri(widget.paymentUrl)),
            initialSettings: InAppWebViewSettings(
              javaScriptEnabled: true,
              useShouldOverrideUrlLoading: true,
            ),
            onWebViewCreated: (controller) {
              _webViewController = controller;
            },
            onLoadStart: (controller, url) {
              setState(() => isLoading = true);
            },
            onLoadStop: (controller, url) async {
              setState(() => isLoading = false);

              if (url.toString().contains("cancel")) {
                Navigator.pop(context, "❌ Payment Canceled");
              } else if (url.toString().contains("success")) {
                Navigator.pop(context, "✅ Payment Successful");
              }
            },
          ),
          if (isLoading) const Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}
