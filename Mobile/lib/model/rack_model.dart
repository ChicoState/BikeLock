import 'lock_model.dart';

class Rack {
  final String rackName;
  final String rackDescription;
  final int totalLocks;
  final List<Lock> listOfLocks;

  Rack(this.rackName, this.rackDescription, this.totalLocks, this.listOfLocks);
}
