import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SaveAppData with ChangeNotifier {
  SaveAppData() {
    _loadsettingsfromprefs();
  }
  List<String> _selectedlocations = [
    'Africa/Abidjan',
    'America/Nuuk',
    'Asia/Istanbul',
    'Europe/Athens'
  ];
  get selectedlocation => _selectedlocations;
  SharedPreferences? _preferences;
  _initializePrefs() async {
    _preferences ??= await SharedPreferences.getInstance();
  }

  _loadsettingsfromprefs() async {
    await _initializePrefs();
    _selectedlocations = _preferences?.getStringList('location') ??
        ['Africa/Abidjan', 'America/Nuuk', 'Asia/Istanbul', 'Europe/Athens'];
    notifyListeners();
  }

  _savelocationtoprefs() async {
    await _initializePrefs();
    _preferences?.setStringList('location', _selectedlocations);
  }

  addtoselectedlocation(String location) {
    List<String> updatedlocation = [];
    _selectedlocations.insert(0, location);
    updatedlocation = _selectedlocations;
    _setnewlocationlist(updatedlocation);
  }

  removefromselectedlocation(String location) {
    List<String> updatedlocation = [];
    _selectedlocations.remove(location);
    updatedlocation = _selectedlocations;
    _setnewlocationlist(updatedlocation);
  }

  _setnewlocationlist(List<String> updatedlocation) async {
    _selectedlocations = updatedlocation;
    _savelocationtoprefs();
    notifyListeners();
  }
}

//  Selector<UserService, bool>(
//             selector: (context, value) => value.busycreate,
//             builder: (context, value, child) {
//               return value ? const AppProgressIndicator() : Container();
//             },
//  selector.Consumer<TimeManager>(
//           builder: (context, value, child) {
//             return
