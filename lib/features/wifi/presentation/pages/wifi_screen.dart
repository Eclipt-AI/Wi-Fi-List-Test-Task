import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wifi_List_Test_Task/features/wifi/presentation/bloc/wifi_options_cubit/wifi_options_cubit.dart';
import 'package:wifi_List_Test_Task/features/wifi/presentation/pages/widgets/network_item.dart';
import 'package:wifi_List_Test_Task/l10n/l10n.dart';

class WifiScreen extends StatefulWidget {
  const WifiScreen({super.key});

  @override
  State<WifiScreen> createState() => _WifiScreenState();
}

class _WifiScreenState extends State<WifiScreen> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WifiOptionsCubit(),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: BlocBuilder<WifiOptionsCubit, WifiOptionsState>(
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.l10n.welcome,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      context.l10n.lets_start_by_connecting_to_a_wifi_network,
                      style: const TextStyle(fontSize: 16),
                    ),
                    AnimatedList(
                      key: _listKey,
                      initialItemCount: state.networks.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index, animation) {
                        final network = state.networks[index];
                        return NetworkItem(
                          network: network,
                          animation: animation,
                          key: Key(network.name),
                        );
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32.0),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12,
                            ),
                          ),
                          onPressed: state.isRefreshing
                              ? null
                              : () => context.read<WifiOptionsCubit>().refreshNetworks(),
                          icon: state.isRefreshing
                              ? const SizedBox(
                                  width: 16,
                                  height: 16,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Icon(
                                  Icons.refresh,
                                  color: Colors.white,
                                ),
                          label: Text(
                            state.isRefreshing ? context.l10n.loading : context.l10n.reload,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
