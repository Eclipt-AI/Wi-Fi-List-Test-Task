import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wifi_List_Test_Task/core/media/app_icons.dart';
import 'package:wifi_List_Test_Task/core/media/app_images.dart';
import 'package:wifi_List_Test_Task/core/styles/app_colors.dart';
import 'package:wifi_List_Test_Task/core/styles/app_sizes.dart';
import 'package:wifi_List_Test_Task/core/styles/app_text_styles.dart';
import 'package:wifi_List_Test_Task/features/wifi/presentation/bloc/wifi_options_cubit/wifi_options_cubit.dart';
import 'package:wifi_List_Test_Task/features/wifi/presentation/pages/widgets/network_item.dart';
import 'package:wifi_List_Test_Task/l10n/l10n.dart';

class WifiScreen extends StatelessWidget {
  const WifiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WifiOptionsCubit(),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 75),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image.asset(
                  AppImages.logo,
                  width: 528,
                  height: 193,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 86),
                  child: SizedBox(
                    height: 686,
                    child: VerticalDivider(
                      thickness: 1,
                      color: AppColors.black,
                      width: 2,
                    ),
                  ),
                ),
                BlocBuilder<WifiOptionsCubit, WifiOptionsState>(
                  builder: (context, state) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Spacer(),
                        Text(
                          context.l10n.welcome,
                          style: AppTextStyles.title,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          context.l10n.lets_start_by_connecting_to_a_wifi_network,
                          style: AppTextStyles.subtitle,
                        ),
                        const SizedBox(height: 40),
                        SizedBox(
                          height: 442.56,
                          width: 788.68,
                          child: SingleChildScrollView(
                            child: SizedBox(
                              height: state.networks.length * AppSizes.networkHeight,
                              child: Stack(
                                fit: StackFit.loose,
                                alignment: Alignment.center,
                                children: List.generate(state.networks.length, (index) {
                                  final network = state.networks[index];
                                  return AnimatedPositioned.fromRect(
                                    rect: state.positions[index],
                                    duration: const Duration(milliseconds: 500),
                                    child: NetworkItem(
                                      network: network,
                                      key: Key(network.name),
                                    ),
                                  );
                                }),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 64,
                        ),
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(31.0),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 4,
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
                              : SvgPicture.asset(
                                  AppIcons.sync,
                                  width: 33,
                                  height: 45,
                                ),
                          label: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              state.isRefreshing ? context.l10n.loading : context.l10n.reload,
                              style: AppTextStyles.refresh,
                            ),
                          ),
                        ),
                        const Spacer(),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
