import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/standalone.dart' as tz;

class TimeManager with ChangeNotifier {
  TimeManager() {
    _loadsettingsfromprefs();
  }
  SharedPreferences? _preferences;
  _initializePrefs() async {
    _preferences ??= await SharedPreferences.getInstance();
  }

  _loadsettingsfromprefs() async {
    await _initializePrefs();
    _zone = _preferences?.getString('zone') ?? 'Africa/Abidjan';
    _selectedlocations = _preferences?.getStringList('location') ??
        ['Africa/Abidjan', 'America/Nuuk', 'Asia/Istanbul', 'Europe/Athens'];
    notifyListeners();
  }

  Timer? timer;
  DateTime _currentlocationtime = DateTime.now();
  get currentlocationtime => _currentlocationtime;
  var _now = DateTime.now();
  get now => _now;
  String _date = DateFormat('EEEE, d MMM, yyyy').format(DateTime.now());
  get date => _date;
  String _time = DateFormat.jm().format(DateTime.now());
  get time => _time;
  final _locations = tz.timeZoneDatabase.locations;
  changetime() {
    timer = Timer.periodic(const Duration(microseconds: 500), (timer) {
      var detroit = tz.getLocation(_zone);
      _now = tz.TZDateTime.now(detroit);
      _time = DateFormat.jm().format(now);
      _date = DateFormat('EEEE, d MMM, yyyy').format(now);
      _currentlocationtime = DateTime.now();
      notifyListeners();
    });
  }

  String _zone = 'Africa/Abidjan';
  get getzone => _zone;
  _savezone(String zone) async {
    await _initializePrefs();
    _preferences?.setString('zone', zone);
  }

  setnewzone(String zone) async {
    _zone = zone;
    _savezone(zone);
    notifyListeners();
  }

  List<String> _selectedlocations = [
    'Africa/Abidjan',
    'America/Nuuk',
    'Asia/Istanbul',
    'Europe/Athens'
  ];
  get selectedlocation => _selectedlocations;
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

  // ignore: non_constant_identifier_names
  late final List _all_locations = convertlocationtolist();
  convertlocationtolist() {
    var convertedlocation = [];
    for (int i = 0; i < _locations.length; i++) {
      String key = _locations.keys.elementAt(i);
      convertedlocation.add(key);
    }
    return convertedlocation;
  }

  late List searchresult = _all_locations;
  searchlocation(String searchword) {
    List result = [];
    if (searchword.isEmpty) {
      result = _all_locations;
    } else {
      for (var item in _all_locations) {
        if (item.toLowerCase().contains(searchword.toLowerCase().trim())) {
          result.add(item);
        }
      }
    }
    return result;
  }

  updatesearchlocation(String searchword) {
    searchresult = searchlocation(searchword);
    notifyListeners();
  }
}
