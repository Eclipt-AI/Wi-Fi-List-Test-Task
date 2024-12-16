part of 'app.dart';

// all blocs
final providers = <BlocProvider>[
  BlocProvider<WifiOptionsCubit>(
    create: (context) => getIt<WifiOptionsCubit>(),
  ),
];
