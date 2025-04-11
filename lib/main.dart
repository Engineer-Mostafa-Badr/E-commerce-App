import 'package:ecommerce_app/features/auth/ui/views/sign_in_view.dart';
import 'package:ecommerce_app/core/resources/sensitive_data.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ecommerce_app/core/resources/app_colors.dart';
import 'features/auth/logic/cubit/authentication_cubit.dart';
import 'package:ecommerce_app/core/resources/constans.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'features/nav_bar/ui/views/main_home_view.dart';
import 'core/widgets/custom_circular_indicator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/widgets/my_observer.dart';
import 'package:flutter/material.dart';

Future<void> initApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: SensitiveData.supaUrl,
    anonKey: SensitiveData.supabaseAnonKey,
  );
  Bloc.observer = MyObserver();
  CustomCircularIndicator.configLoading();
}

void main() async {
  await initApp();
  runApp(
    BlocProvider(
      create: (BuildContext context) => AuthenticationCubit()..getUserData(),
      child: const EcommerceApp(),
    ),
  );
}

class EcommerceApp extends StatelessWidget {
  const EcommerceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationCubit, AuthenticationState>(
      builder: (context, state) {
        SupabaseClient client = Supabase.instance.client;
        final isLoggedIn = client.auth.currentUser != null;

        return MaterialApp(
          builder: EasyLoading.init(),
          debugShowCheckedModeBanner: false,
          title: Constans.appName,
          theme: ThemeData(
            scaffoldBackgroundColor: AppColors.kScaffoldColor,
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          ),
          home:
              isLoggedIn
                  ? state is GetUserDataLoading
                      ? Scaffold(
                        body: const Center(child: CircularProgressIndicator()),
                      )
                      : MainHomeView(
                        userDataModel:
                            context.read<AuthenticationCubit>().userDataModel!,
                      )
                  : SignInView(),
        );
      },
    );
  }
}
