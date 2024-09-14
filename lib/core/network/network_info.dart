abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  @override
  Future<bool> get isConnected async {
    //TODO
    bool result = true;
    if (result) {
      return true;
    } else {
      return false;
    }
  }
}
