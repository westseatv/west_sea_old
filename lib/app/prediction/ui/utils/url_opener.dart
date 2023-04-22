import 'package:url_launcher/url_launcher.dart';

Future openUrl({required String url}) async {
  var uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    launchUrl(
      uri,
      mode: LaunchMode.inAppWebView,
    );
  }
}
