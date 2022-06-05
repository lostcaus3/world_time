import 'dart:convert';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

class WorldTime {
  late String location;
  late String time;
  late String url;
  late String flag;
  late bool isDayTime;

  WorldTime({required this.location, required this.url, required this.flag});

  Future<void> getData() async {
    try {
      Response response =
          await get(Uri.parse("http://worldtimeapi.org/api/timezone/$url"));
      Map data = jsonDecode(response.body);

      //print(data);

      //get properties from data

      String dateTime = data['datetime'];
      String offsetChange = data['utc_offset'].substring(0, 1);
      String offsetHours = data['utc_offset'].substring(1, 3);
      String offsetMinutes = data['utc_offset'].substring(4, 6);
      print(offsetChange);

      DateTime now = DateTime.parse(dateTime);
      if (offsetChange == '+') {
        now = now.add(Duration(hours: int.parse(offsetHours)));
        now = now.add(Duration(minutes: int.parse(offsetMinutes)));
        time = time = DateFormat.jm().format(now);
        isDayTime = now.hour > 6 && now.hour < 19;
      } else if (offsetChange == '-') {
        now = now.subtract(Duration(hours: int.parse(offsetHours)));
        now = now.subtract(Duration(minutes: int.parse(offsetMinutes)));
        time = time = DateFormat.jm().format(now);
        isDayTime = now.hour > 6 && now.hour < 19;
      }
    } catch (e) {
      //print("Caught error: $e");
      time = "Could not get time";
    }
  }
}
