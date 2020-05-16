class Lock {
  final int lockID;
  final String name;
  final String description;
  final String rackUUID;
  bool available;

  Lock(this.lockID, this.name, this.description, this.rackUUID, this.available);

  fromJSONtoLock() {

  }
}
