import 'package:hive/hive.dart';
import 'model.dart';

class Boxes{
  static Box<LocationData> getBox() => Hive.box<LocationData>('location');
}