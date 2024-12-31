import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_code_app/extension/context_extension.dart';

import '../../utils/box_constrains.dart';
import '../../utils/custom_colors.dart';
import '../../utils/custom_text_styles.dart';
import '../../widget/box.dart';
import '../../widget/button.dart';
import '../../widget/lottie_widget.dart';
import 'welcome_cubit.dart';
import 'welcome_state.dart';

class WelcomeView extends StatelessWidget {
  final WelcomeCubit viewModel;
  const WelcomeView({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    viewModel.initialize(context);

    return BlocProvider<WelcomeCubit>(create: (_) => viewModel, child: _buildScaffold(context));
  }

  Widget _buildScaffold(BuildContext context) {
    return BlocConsumer<WelcomeCubit, WelcomeState>(
      listener: (context, state) {
        if (state is WelcomeInitial) {}
      },
      builder: (context, state) {
        debugPrint('The state is $state');
        if (state is WelcomeSuccess) {
          return _buildSuccess(context);
        } else if (state is WelcomeLoading) {
          return _buildLoading(context);
        }

        return Container();
      },
    );
  }

  Scaffold _buildLoading(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.bgLila,
      body: const Center(
        child: LottieWidget(path: 'loading_animation'),
      ),
    );
  }

  Scaffold _buildSuccess(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: context.paddingAllLarge,
        child: Align(
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Box(size: BoxSize.MEDIUM, type: BoxType.VERTICAL),
                Image.asset(
                  'assets/images/logo.png',
                  width: 150,
                ),

                // Text(
                //   " Bursa Web Tasarım",
                //   style: Theme.of(context)
                //       .textTheme
                //       .headlineSmall!
                //       .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                // ),
                const Box(size: BoxSize.MEDIUM, type: BoxType.VERTICAL),
                Text('Welcome',
                    style: context.theme.textTheme.headlineMedium!
                        .copyWith(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25)),
                const Box(size: BoxSize.MEDIUM, type: BoxType.VERTICAL),

                // MyButtonWidget(
                //   context: context,
                //   height: 50,
                //   width: 350,
                //   content: Row(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: [
                //       Text('Oturum açın', style: CustomTextStyles.buttonTextStyle(context, Colors.black)),
                //     ],
                //   ),
                //   buttonColor: Colors.white,
                //   onPressed: () {},
                // ),
                // const Box(size: BoxSize.SMALL, type: BoxType.VERTICAL),
                // MyButtonWidget(
                //   context: context,
                //   height: 50,
                //   width: 350,
                //   content: Row(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: [
                //       Text('Kaydolun', style: CustomTextStyles.buttonTextStyle(context, Colors.black)),
                //     ],
                //   ),
                //   onPressed: () {},
                //   buttonColor: Colors.white,
                // ),
                // Row(
                //   children: <Widget>[
                //     Expanded(
                //       child: Container(
                //         margin: const EdgeInsets.only(left: 10.0, right: 15.0),
                //         child: Divider(
                //           color: CustomColors.lightGray,
                //           height: 50,
                //         ),
                //       ),
                //     ),
                //     const Text("veya"),
                //     Expanded(
                //       child: Container(
                //         margin: const EdgeInsets.only(left: 15.0, right: 10.0),
                //         child: Divider(
                //           color: CustomColors.lightGray,
                //           height: 50,
                //         ),
                //       ),
                //     ),
                //   ],
                // ),

                MyButtonWidget(
                  context: context,
                  content: Text('Hesap oluştur', style: CustomTextStyles2.buttonTextStyle(context, Colors.white)),
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/signUp');
                  },
                  buttonColor: CustomColors.bwyRed,
                ),
                Text(
                  'Zaten bir hesabın var mı?',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const Box(size: BoxSize.SMALL, type: BoxType.VERTICAL),
                MyButtonWidget(
                  context: context,
                  content: Text('Giriş yap', style: CustomTextStyles2.buttonTextStyle(context, Colors.black)),
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/logIn');
                  },
                  buttonColor: Colors.white,
                  // borderColor: Colors.wite,
                ),
                const Box(size: BoxSize.SMALL, type: BoxType.VERTICAL),

                MyButtonWidget(
                  context: context,
                  content: Text('Home', style: CustomTextStyles2.buttonTextStyle(context, Colors.black)),
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/home');
                  },
                  buttonColor: Colors.white,
                  // borderColor: Colors.wite,
                ),
                // const Box(size: BoxSize.MEDIUM, type: BoxType.VERTICAL),
                // Image.asset(
                //   'assets/images/welcome_page.jpeg',
                //   // fit: BoxFit.fitWidth,
                //   height: 500,
                //   width: MediaQuery.of(context).size.width,
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
