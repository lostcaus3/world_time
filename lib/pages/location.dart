import 'package:flutter/material.dart';
import 'package:world_time/main.dart';
import 'package:world_time/services/world_time.dart';

void main() => runApp(Location());

class Location extends StatefulWidget {
  const Location({Key? key}) : super(key: key);

  @override
  _LocationState createState() => _LocationState();
}

class _LocationState extends State<Location> {
  List<WorldTime> locations = [
    WorldTime(location: 'Athens', url: 'Europe/Athens', flag: 'greece.png'),
    WorldTime(location: 'Berlin', url: 'Europe/Berlin', flag: 'germany.png'),
    WorldTime(location: 'Cairo', url: 'Africa/Cairo', flag: 'egypt.png'),
    WorldTime(location: 'Chicago', url: 'America/Chicago', flag: 'usa.png'),
    WorldTime(location: 'Kolkata', url: 'Asia/Kolkata', flag: 'india.png'),
    WorldTime(location: 'London', url: 'Europe/London', flag: 'uk.png'),
    WorldTime(location: 'Jakarta', url: 'Asia/Jakarta', flag: 'indonesia.png'),
    WorldTime(location: 'Nairobi', url: 'Africa/Nairobi', flag: 'kenya.png'),
    WorldTime(location: 'New York', url: 'America/New_York', flag: 'usa.png'),
    WorldTime(location: 'Seoul', url: 'Asia/Seoul', flag: 'south_korea.png')
  ];

  void updateTime(index) async {
    WorldTime instance = locations[index];
    await instance.getData();
    Navigator.pop(context, {
      'location': instance.location,
      'flag': instance.flag,
      'time': instance.time,
      'isDayTime': instance.isDayTime
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Choose a Location'),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: ListView.builder(
            itemCount: locations.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  onTap: () {
                    updateTime(index);
                  },
                  title: Text(locations[index].location),
                  leading: CircleAvatar(
                    backgroundImage:
                        AssetImage('assets/images/${locations[index].flag}'),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
