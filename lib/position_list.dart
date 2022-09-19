import 'package:flutter/material.dart';
import 'package:hive_demo/boxes.dart';
import 'model.dart';

class LocationList extends StatefulWidget {
  const LocationList({Key? key}) : super(key: key);

  @override
  State<LocationList> createState() => _LocationListState();
}

class _LocationListState extends State<LocationList> {

  @override
  Widget build(BuildContext context) {
    final box = Boxes.getBox();
    final data = box.values.toList();
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text('Saved Data')),
      body: ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => setState(() => box.put(data[index].key,
                  LocationData(latitude: 0.0, longitude: 0.0))),
              onDoubleTap: () => setState(() => box.delete(data[index].key)),
              child: Card(
                  elevation: 8,
                  child: Column(
                    children: [
                      ListTile(
                        title: Text("id: ${data[index].key.toString()}"),
                      ),
                      ListTile(
                        title: Text(
                            "longitude: ${data[index].longitude.toString()}"),
                      ),
                      ListTile(
                        title: Text(
                            "latitude: ${data[index].latitude.toString()}"),
                      )
                    ],
                  )),
            );
          }),
    );
  }
}
