import 'package:flutter/material.dart';
import 'package:shophimikat/domain/models/user_model.dart';
import 'package:shophimikat/presentation/cubits/userCubit/user_cubit.dart';
import 'package:shophimikat/presentation/pages/lkScreen/widgets/lk_content.dart';
import 'package:shophimikat/common/widgets/wrapperpage.dart';
import 'package:shophimikat/utils/helpers/routes.dart';

class LkScreen extends StatelessWidget {
  final Map lk;
  final UserModel user;
  final UserCubit cubit;
  const LkScreen(
      {super.key, required this.lk, required this.user, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return Wrapperpage(
        routName: '/lk',
        onTapBasket: () => Navigator.pushNamed(context, AppRoutes.basket),
        content: LkContent(
          lk: lk,
          user: user,
          cubit: cubit,
        ));
  }
}
