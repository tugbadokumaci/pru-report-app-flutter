import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_code_app/utils/box_constrains.dart';
import 'package:qr_code_app/widget/button.dart';
import 'package:qr_code_app/widget/container.dart';

import '../../bottom_nav_bar.dart';
import '../../constants/constants.dart';
import '../../utils/custom_colors.dart';
import '../../utils/custom_text_styles.dart';
import '../../widget/box.dart';
import '../../widget/lottie_widget.dart';
import 'scan_cubit.dart';
import 'scan_state.dart';

class ScanView extends StatefulWidget {
  final ScanCubit viewModel;
  const ScanView({super.key, required this.viewModel});

  @override
  State<ScanView> createState() => _ScanViewState();
}

class _ScanViewState extends State<ScanView> {
  int _selectedIndex = Pages.SCAN.index;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ScanCubit>(create: (_) => widget.viewModel, child: _buildScaffold(context));
  }

  SafeArea _buildScaffold(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Scan'),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
            child: BlocConsumer<ScanCubit, ScanState>(
          listener: ((context, state) {}),
          builder: (context, state) {
            debugPrint('Scan View State is : $state');
            if (state is ScanInitial) {
              // widget.viewModel.getData();
              return _buildInitial(context);
            } else if (state is ScanLoading) {
              return _buildLoading();
            } else if (state is ScanSuccess) {
              return _buildSuccess(context);
            } else if (state is ScanError) {
              return _buildError(context);
            }
            return Container();
          },
        )),
        bottomNavigationBar: buildBottomNavigationBar,
      ),
    );
  }

  CustomBottomNavigationBar get buildBottomNavigationBar {
    return CustomBottomNavigationBar(
      onTabChange: (int index) {
        setState(() {
          _selectedIndex = index;
        });
        switch (index) {
          case 0:
            Navigator.pushNamed(context, '/home');
          case 1:
            Navigator.pushNamed(context, '/scan', arguments: -1);
          case 2:
            Navigator.pushNamed(context, '/saved');
          case 3:
            Navigator.pushNamed(context, '/profile');
        }
      },
      selectedIndex: _selectedIndex,
    );
  }

  Widget _buildInitial(BuildContext context) {
    return Padding(
      padding: kAllPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          MyContainer(
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Scan QR Code', style: CustomTextStyles2.titleMediumTextStyle(context, Colors.black)),
                    Text('You can save that card by scanning the QR code of a card and access it later.',
                        style: CustomTextStyles2.titleExtraSmallTextStyle(context, CustomColors.darkGray)),
                  ],
                ),
              ),
              backgroundColor: CustomColors.lightGray),
          Box(size: BoxSize.SMALL, type: BoxType.VERTICAL),
          Image(image: AssetImage('assets/images/qr_preview.png')),
          Box(size: BoxSize.MEDIUM, type: BoxType.VERTICAL),
          MyButtonWidget(
            content: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Text('Scan', style: CustomTextStyles2.titleMediumTextStyle(context, CustomColors.darkGray)),
            ),
            onPressed: () {
              // widget.viewModel.scanQR();
            },
            context: context,
            buttonColor: CustomColors.lightGray,
          ),
        ],
      ),
    );
  }

  Widget _buildSuccess(BuildContext context) {
    return Padding(
      padding: kAllPadding,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          MyContainer(
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.check_circle, color: Colors.black, size: 50.0),
                    Box(size: BoxSize.SMALL, type: BoxType.VERTICAL),
                    Text('Scanned Successfully', style: CustomTextStyles2.titleMediumTextStyle(context, Colors.black)),
                    Box(size: BoxSize.SMALL, type: BoxType.VERTICAL),
                    Text('"Rik Samuel Vienna" was scanned successfully.',
                        textAlign: TextAlign.center,
                        style: CustomTextStyles2.titleExtraSmallTextStyle(context, CustomColors.darkGray)),
                  ],
                ),
              ),
              backgroundColor: CustomColors.lightGray),
          Box(size: BoxSize.LARGE, type: BoxType.VERTICAL),
          MyButtonWidget(
            content: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Text('Scan', style: CustomTextStyles2.titleMediumTextStyle(context, CustomColors.darkGray)),
            ),
            onPressed: () {
              // widget.viewModel.scanQR();
            },
            context: context,
            buttonColor: CustomColors.lightGray,
          ),
          Box(size: BoxSize.MEDIUM, type: BoxType.VERTICAL),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Scan a new card',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      decoration: TextDecoration.underline)),
              Icon(Icons.arrow_forward, color: Colors.black, size: 30.0)
            ],
          )
        ],
      ),
    );
  }

  Widget _buildLoading() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LinearProgressIndicator(
          color: Colors.yellow,
          backgroundColor: Colors.white,
        ),
      ],
    );
  }

  Widget _buildError(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Hata ile karşılaşıldı', style: CustomTextStyles2.titleMediumTextStyle(context, CustomColors.bwyYellow)),
        Container(
            color: Colors.black,
            child: const Align(
              alignment: Alignment.center,
              child: LottieWidget(path: 'error_animation'),
            )),
      ],
    );
  }
}

enum Pages {
  HOME,
  SCAN,
  SAVED,
  PROFILE,
}
