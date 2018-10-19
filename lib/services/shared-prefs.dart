import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
	static final SharedPrefs _instance = new SharedPrefs._internal();
	SharedPreferences instance;

	factory SharedPrefs() {
		return _instance;
	}

	SharedPrefs._internal() {
		initSharedPrefs();
	}

	Future<SharedPreferences> initSharedPrefs() async {
		instance = await SharedPreferences.getInstance();
		return instance;
	}
}