import 'package:flutter/material.dart';

void main() => runApp(Homepage());

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  dynamic data = {};
  @override
  Widget build(BuildContext context) {
    data = data.isNotEmpty ? data : ModalRoute.of(context)?.settings.arguments;
    print(data);

    String bgImage = data['isDayTime'] ? 'day.png' : 'night.png';

    return Scaffold(
        body: SafeArea(
            child: Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/$bgImage'), fit: BoxFit.cover)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton.icon(
              onPressed: () async {
                dynamic result =
                    await Navigator.pushNamed(context, '/location');
                setState(() {
                  data = {
                    'time': result['time'],
                    'location': result['location'],
                    'isDayTime': result['isDayTime'],
                    'flag': result['flag']
                  };
                });
              },
              style: TextButton.styleFrom(primary: Colors.white),
              icon: Icon(Icons.edit_location_sharp),
              label: Text('Edit Location')),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                data['location'],
                style: TextStyle(
                    fontSize: 28, letterSpacing: 2.0, color: Colors.white),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            data['time'],
            style: TextStyle(
                fontSize: 64, letterSpacing: 2.0, color: Colors.white),
          ),
        ],
      ),
    )));
  }
}
