class RamStorage {
  static final RamStorage _singleton = RamStorage._internal();

  RamStorage._internal();

  factory RamStorage() {
    return _singleton;
  }

  bool _hasNetwork = false;

  bool hasNetwork() => _hasNetwork;

  void setHasNetwork(bool isOnline) {
    _hasNetwork = isOnline;
  }
}
