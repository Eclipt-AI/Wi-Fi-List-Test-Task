part of 'wifi_options_cubit.dart';

@freezed
class WifiOptionsState with _$WifiOptionsState {
  const factory WifiOptionsState({
    @Default([]) List<WifiNetwork> networks,
    @Default(false) bool isRefreshing,
    @Default([]) List<Rect> positions,
  }) = _WifiOptionsState;
}
