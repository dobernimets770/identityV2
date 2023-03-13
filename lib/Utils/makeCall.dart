import 'package:url_launcher/url_launcher.dart';

Future<void> makePhoneCall(String phoneNumber) async {
  launchUrl(Uri.parse("tel://${phoneNumber ?? ""}"));
}
