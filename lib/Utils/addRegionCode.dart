import 'package:phone_number/phone_number.dart';
//import 'package:shared_preferences/shared_preferences.dart';

addRegionCode(String phone) async {
  // final prefs = await SharedPreferences.getInstance();
  // String? regionCode = prefs.getString("regionCode");
  String? regionCode = "US";

  String cleanPhone = phone.replaceAll(RegExp(r'[^\d+]'), "");
  PhoneNumber? phoneNumberFormat;

  try {
    phoneNumberFormat = await PhoneNumberUtil().parse(cleanPhone);
    return phoneNumberFormat.e164;
  } catch (err) {
    print(err);
  }

  try {
    phoneNumberFormat =
        await PhoneNumberUtil().parse(cleanPhone, regionCode: regionCode);
    return phoneNumberFormat.e164;
  } catch (err) {
    print(err);
  }

  return cleanPhone;
}
