import 'lock_model.dart';

class Rack {
  final String UUID;
  final String name;
  final String description;
  final int locks;
  final List<Lock> listOfLocks;

  Rack(this.UUID, this.name, this.description, this.locks, this.listOfLocks,);

  fromJSONtoRack(List<dynamic> JSON) {
//    for(int i = 0; i <= JSON.length; )
//    this.UUID = response
  }
}
