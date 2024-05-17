import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bottom_nav_bar.dart';
import '../../constants/constants.dart';
import '../../models/card_model.dart';
import '../../utils/box_constrains.dart';
import '../../utils/custom_colors.dart';
import '../../utils/custom_text_styles.dart';
import '../../widget/box.dart';
import '../../widget/container.dart';
import '../../widget/lottie_widget.dart';
import 'saved_cubit.dart';
import 'saved_state.dart';

class SavedView extends StatefulWidget {
  SavedCubit viewModel;

  SavedView({super.key, required this.viewModel});

  @override
  State<SavedView> createState() => _SavedViewState();
}

class _SavedViewState extends State<SavedView> {
  int _selectedIndex = Pages.SAVED.index;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SavedCubit>(create: (_) => widget.viewModel, child: _buildScaffold(context));
  }

  SafeArea _buildScaffold(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   title: Text('Saved'),
        //   centerTitle: true,
        //   automaticallyImplyLeading: false,
        // ),
        body: SingleChildScrollView(
            child: BlocConsumer<SavedCubit, SavedState>(
          listener: ((context, state) {}),
          builder: (context, state) {
            debugPrint('Saved View State is : $state');
            if (state is SavedInitial) {
              widget.viewModel.getSavedCards();
              return Container();
            } else if (state is SavedLoading) {
              return _buildLoading();
            } else if (state is SavedSuccess) {
              return _buildSuccess(context, state);
            } else if (state is SavedError) {
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

  Widget _buildSuccess(BuildContext context, SavedSuccess state) {
    return Padding(
      padding: kAllPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: _profileHeader(state.savedCardResource.data!.length),
          ),
          Padding(
            padding: kVerticalPadding,
            child: _verticalCards(state.savedCardResource.data!),
          ),
        ],
      ),
    );
  }

  Row _profileHeader(int length) {
    return Row(
      children: [
        Text('Saved',
            // LocaleKeys.home_servicesTitle.locale,
            style: CustomTextStyles2.titleLargeTextStyle(context, Colors.black)),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('(${length} items)',
              // LocaleKeys.home_servicesTitle.locale,
              style: CustomTextStyles2.titleSmallTextStyle(context, Colors.black)),
        ),
      ],
    );
  }

  Widget _verticalCards(List<CardModel> cards) {
    if (cards.isEmpty) {
      return Column(
        children: [
          Icon(Icons.error_outline, color: CustomColors.bwyYellow),
          const Box(size: BoxSize.EXTRASMALL, type: BoxType.VERTICAL),
          Text('Bulunamadı',
              // LocaleKeys.home_noServiceFound.locale,
              textAlign: TextAlign.center,
              style: CustomTextStyles2.titleSmallTextStyle(context, Colors.grey))
        ],
      );
    }
    return ListView.builder(
      scrollDirection: Axis.vertical,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: cards.length,
      shrinkWrap: true, // unless put sizedbox with a fixed height
      itemBuilder: (context, index) {
        final card = cards[index];

        return Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: MyContainer(
            backgroundColor: Color(int.parse("0xff${card.cardBgColor}")),
            // backgroundImage: Image.asset('assets/images/bwy_history_tile_5.png', height: 200, fit: BoxFit.fitHeight),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  title: Padding(
                    padding: const EdgeInsets.only(bottom: 50),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(card.displayName, style: CustomTextStyles2.titleMediumTextStyle(context, Colors.black)),
                        Text(card.jobTitle,
                            style: CustomTextStyles2.titleExtraSmallTextStyle(context, CustomColors.mediumGray)),
                      ],
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Box(size: BoxSize.EXTRASMALL, type: BoxType.HORIZONTAL),
                      Text('${card.websiteUrl}',
                          style: CustomTextStyles2.titleExtraSmallTextStyle(context, CustomColors.darkGray))
                    ],
                  ),
                  trailing: const Row(
                    mainAxisSize: MainAxisSize.min, // Önerilen
                    children: [
                      Icon(Icons.more_horiz, size: 24),
                      Icon(Icons.close, size: 24),
                    ],
                  ),
                ),
                // subtitle: Text('Hizmet No: #${service.productId}')),
              ],
            ),
          ),
        );
      },
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
