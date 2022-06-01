class Tunnel {
  static final Tunnel _tunnel = Tunnel._internal();
  String tunnelUrl = '';
  factory Tunnel() {
    return _tunnel;
  }
  Tunnel._internal();
}
