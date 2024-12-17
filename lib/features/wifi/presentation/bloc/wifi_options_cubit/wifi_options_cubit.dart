import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:wifi_List_Test_Task/core/styles/app_sizes.dart';
import 'package:wifi_List_Test_Task/features/wifi/domain/models/wifi_network.dart';

part 'wifi_options_cubit.freezed.dart';

part 'wifi_options_state.dart';

@injectable
class WifiOptionsCubit extends Cubit<WifiOptionsState> {
  WifiOptionsCubit() : super(const WifiOptionsState()) {
    _initializeNetworks();
  }

  final double itemHeight = AppSizes.networkHeight;

  final List<WifiNetwork> _initialNetworks = [
    const WifiNetwork(
      name: 'Workspace-WLAN',
      iconIndex: 0,
      isClickable: true,
      isLocked: false,
    ),
    const WifiNetwork(
      name: 'XYZ-WLAN',
      iconIndex: 3,
      isClickable: true,
      isLocked: false,
    ),
    const WifiNetwork(
      name: 'Freifunk',
      iconIndex: 2,
      isClickable: true,
      isLocked: false,
    ),
    const WifiNetwork(
      name: 'Telekom_FON',
      iconIndex: 0,
      isClickable: true,
      isLocked: false,
    ),
    const WifiNetwork(
      name: 'FRITZ!Box 7590',
      iconIndex: 3,
      isClickable: true,
      isLocked: false,
    ),
    const WifiNetwork(
      name: 'Vodafone Hotspot',
      iconIndex: 2,
      isClickable: true,
      isLocked: false,
    ),
  ];

  Rect getRectangle(int index, int length) {
    return Offset(0, index * itemHeight) & Size(788.68, itemHeight);
  }

  void _initializeNetworks() {
    late final List<Rect> positions = List.generate(
      _initialNetworks.length,
      (index) => getRectangle(
        index,
        _initialNetworks.length,
      ),
    );

    emit(
      state.copyWith(
        networks: _initialNetworks,
        positions: positions,
      ),
    );
  }

  Future<void> refreshNetworks() async {
    emit(state.copyWith(isRefreshing: true));

    final shuffledPositions = List<Rect>.from(state.positions)..shuffle();

    if (Random().nextBool()) {
      _initialNetworks.add(
        WifiNetwork(
          name: 'Neues Netzwerk ${Random().nextInt(100)}',
          iconIndex: Random().nextInt(4),
          isClickable: true,
          isLocked: Random().nextBool(),
        ),
      );
      shuffledPositions.add(getRectangle(_initialNetworks.length - 1, _initialNetworks.length));
    }

    emit(state.copyWith(
      positions: shuffledPositions,
      isRefreshing: false,
    ));
  }
}
