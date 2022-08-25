import 'package:shared_preferences/shared_preferences.dart';

class DiskRepo {
  String retrivepath = '';

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  retrieve1() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    retrivepath = prefs.getString('frontpath').toString();
    return retrivepath;
  }

  retrieve2() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    retrivepath = prefs.getString('backpath').toString();
    return retrivepath;
  }
}
