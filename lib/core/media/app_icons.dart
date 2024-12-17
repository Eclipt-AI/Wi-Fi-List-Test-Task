class AppIcons {
  static String _buildPath(String name) => 'assets/icons/$name.png';
  static String _buildPathSvg(String name) => 'assets/icons/$name.svg';
  static final String sync = _buildPathSvg('sync');
  static final String wifiSignal2 = _buildPath('wifi-signal-2');
  static final String wifiSignal3 = _buildPath('wifi-signal-3');
  static final String wifiSignalLocked1 = _buildPath('wifi-signal-locked-1');
  static final String wifiSignalLocked2 = _buildPath('wifi-signal-locked-2');
}
