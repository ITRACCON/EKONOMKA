import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shophimikat/domain/models/user_model.dart';
import 'package:shophimikat/presentation/cubits/userCubit/user_cubit.dart';
import 'package:shophimikat/presentation/pages/lkScreen/lk_screen.dart';

class LkCubitControllerScreen extends StatefulWidget {
  final String? category;
  const LkCubitControllerScreen({super.key, this.category});

  @override
  State<LkCubitControllerScreen> createState() =>
      _LkCubitControllerScreenStateWeb();
}

class _LkCubitControllerScreenStateWeb extends State<LkCubitControllerScreen> {
  late UserCubit userCubit;

  @override
  void initState() {
    super.initState();
    userCubit = UserCubit()..getIfoUser();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
        bloc: userCubit,
        builder: (context, state) {
          return state.when(
            initialLk: (Map lk, UserModel user) => LkScreen(
              lk: lk,
              user: user,
              cubit: userCubit,
            ),
            initial: (UserModel user) => Container(),
            loading: () => Container(),
            error: (String error) => Container(),
            success: (String text) => Container(),
            noUser: () => Container(),
          );
        });
  }
}
