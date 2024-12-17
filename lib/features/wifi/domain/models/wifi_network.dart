import 'package:freezed_annotation/freezed_annotation.dart';

part 'wifi_network.freezed.dart';

@freezed
class WifiNetwork with _$WifiNetwork {
  const factory WifiNetwork({
    required String name,
    required int strength,
    required bool isClickable,
    required bool isLocked,
  }) = _WifiNetwork;
}