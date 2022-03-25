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
      String date_time = data['datetime'];
      String offset_hours = data['utc_offset'].substring(1, 3);
      String offset_minutes = data['utc_offset'].substring(4, 6);

      DateTime now = DateTime.parse(date_time);
      now = now.add(Duration(hours: int.parse(offset_hours)));
      now = now.add(Duration(minutes: int.parse(offset_minutes)));
      time = time = DateFormat.jm().format(now);
      isDayTime = now.hour > 6 && now.hour < 19;
    } catch (e) {
      print("Caugt error: $e");
      time = "could not get time";
    }
  }
}
