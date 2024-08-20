import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shophimikat/presentation/pages/adminPanel/home_screen.dart';
import 'package:shophimikat/presentation/pages/authScreen/login_screen.dart';
import 'package:shophimikat/presentation/pages/authScreen/reg_screen.dart';
import 'package:shophimikat/presentation/pages/basketScreen/basket_cubit_controller.dart';
import 'package:shophimikat/presentation/pages/catalogScreen/catalog_cubit_controller.dart';
import 'package:shophimikat/presentation/pages/contactsScreen/contact_screen.dart';
import 'package:shophimikat/presentation/pages/homescreen/home_cubit_controller.dart';
import 'package:shophimikat/presentation/pages/homescreen/home_screen.dart';
import 'package:shophimikat/presentation/pages/lkScreen/lk_cubit_controller.dart';
import 'package:shophimikat/utils/constants/colors.dart';
import 'package:shophimikat/utils/helpers/routes.dart';
import 'package:sizer/sizer.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _WebAppState();
}

class _WebAppState extends State<App> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
          shortcuts: {
            LogicalKeySet(LogicalKeyboardKey.space): const ActivateIntent()
          },
          color: AppColors.primary,
          theme: ThemeData(
            primaryColor: AppColors.primary,
            textSelectionTheme: const TextSelectionThemeData(
              cursorColor: AppColors.primary,
            ),
          ),
          debugShowCheckedModeBanner: false,
          routes: {
            AppRoutes.home: (BuildContext context) =>
                const HomeCubitControllerScreen(),
            AppRoutes.signin: (BuildContext context) => const LoginScreen(),
            AppRoutes.signup: (BuildContext context) => const RegScreen(),
            AppRoutes.basket: (BuildContext context) =>
                const BasketCubitControllerScreen(),
            AppRoutes.profile: (BuildContext context) =>
                const LkCubitControllerScreen(),
            AppRoutes.admin: (BuildContext context) => const AdminHome(),
            AppRoutes.contact: (BuildContext context) => const ContactScreen(),
          },
          onGenerateRoute: (routeSettings) {
            var path = routeSettings.name!.split('/');
            if (path[1] == AppRoutes.catalog) {
              return MaterialPageRoute(
                builder: (context) =>
                    CatalogCubitControllerScreen(category: path[2]),
                settings: routeSettings,
              );
            }
            return null;
          });
    });
  }
}
