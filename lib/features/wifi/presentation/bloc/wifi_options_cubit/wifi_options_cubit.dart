import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:wifi_List_Test_Task/features/wifi/domain/models/wifi_network.dart';

part 'wifi_options_cubit.freezed.dart';

part 'wifi_options_state.dart';

@injectable
class WifiOptionsCubit extends Cubit<WifiOptionsState> {
  WifiOptionsCubit() : super(const WifiOptionsState()) {
    _initializeNetworks();
  }

  final List<WifiNetwork> _initialNetworks = [
    const WifiNetwork(
      name: 'Workspace-WLAN',
      strength: 4,
      isClickable: true,
      isLocked: false,
    ),
    const WifiNetwork(
      name: 'XYZ-WLAN',
      strength: 3,
      isClickable: true,
      isLocked: false,
    ),
    const WifiNetwork(
      name: 'Freifunk',
      strength: 2,
      isClickable: false,
      isLocked: false,
    ),
    const WifiNetwork(
      name: 'Telekom_FON',
      strength: 4,
      isClickable: false,
      isLocked: false,
    ),
    const WifiNetwork(
      name: 'FRITZ!Box 7590',
      strength: 3,
      isClickable: false,
      isLocked: false,
    ),
    const WifiNetwork(
      name: 'Vodafone Hotspot',
      strength: 2,
      isClickable: false,
      isLocked: false,
    ),
  ];

  void _initializeNetworks() {
    emit(state.copyWith(networks: _initialNetworks));
  }

  Future<void> refreshNetworks() async {
    emit(state.copyWith(isRefreshing: true));

    // Simulate network refresh delay
    await Future.delayed(const Duration(seconds: 1));

    // Shuffle existing networks
    final shuffledNetworks = List<WifiNetwork>.from(_initialNetworks)..shuffle();

    // Potentially add a new network
    if (Random().nextBool()) {
      shuffledNetworks.add(
        WifiNetwork(
          name: 'Neues Netzwerk ${Random().nextInt(100)}',
          strength: Random().nextInt(4) + 1,
          isClickable: false,
          isLocked: Random().nextBool(),
        ),
      );
    }

    emit(state.copyWith(
      networks: shuffledNetworks,
      isRefreshing: false,
    ));
  }

  void selectNetwork(String networkName) {
    emit(state.copyWith(selectedNetwork: networkName));
  }

  void togglePasswordVisibility() {
    emit(state.copyWith(obscurePassword: !state.obscurePassword));
  }

  void clearSelectedNetwork() {
    emit(state.copyWith(selectedNetwork: null));
  }
}
