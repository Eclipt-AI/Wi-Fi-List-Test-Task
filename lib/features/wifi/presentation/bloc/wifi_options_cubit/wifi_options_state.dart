part of 'wifi_options_cubit.dart';

@freezed
class WifiOptionsState with _$WifiOptionsState {
  const factory WifiOptionsState({
    @Default([]) List<WifiNetwork> networks,
    @Default(false) bool isRefreshing,
    String? selectedNetwork,
    @Default(true) bool obscurePassword,
  }) = _WifiOptionsState;
}
