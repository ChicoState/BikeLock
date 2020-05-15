class Lock {
  final String lockName;
  final String lockDescription;
  final String belongsToRack;
  bool available;

  Lock(this.lockName, this.lockDescription, this.belongsToRack, this.available);
}
