import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bottom_nav_bar.dart';
import '../../constants/constants.dart';

import '../../models/card_model.dart';
import '../../size_config.dart';
import '../../utils/box_constrains.dart';
import '../../utils/custom_colors.dart';
import '../../utils/custom_text_styles.dart';
import '../../widget/box.dart';
import '../../widget/container.dart';
import '../../widget/fabs.dart';
import '../../widget/lottie_widget.dart';
import 'home_cubit.dart';
import 'home_state.dart';

class HomeView extends StatefulWidget {
  // outside world of our constractor
  HomeCubit viewModel;
  HomeView({super.key, required this.viewModel});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedIndex = Pages.HOME.index; // creating index field for our state
  // static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.w600, color: Colors.white);
  // static List<Widget> _widgetOptions = <Widget>[
  //   Text(LocaleKeys.home_appBarTitle.locale, style: optionStyle),
  //   Text(LocaleKeys.about_us_appBarTitle.locale, style: optionStyle),
  //   Text(LocaleKeys.contact_appBarTitle.locale, style: optionStyle),
  //   Text(LocaleKeys.profile_appBarTitle.locale, style: optionStyle),
  // ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeCubit>(create: (_) => widget.viewModel, child: _buildScaffold(context));
  }

  SafeArea _buildScaffold(BuildContext context) {
    // debugPrint("important: ${context.locale}");
    SizeConfig().init(context);
    return SafeArea(
        child: Scaffold(
      // appBar: AppBar(
      //   // title: Text(LocaleKeys.home_appBarTitle.locale, style: CustomTextStyles2.appBarTextStyle(context)),
      //   title: Text('Home', style: CustomTextStyles2.appBarTextStyle(context)),
      //   centerTitle: true,
      //   automaticallyImplyLeading: false,
      // ),

      backgroundColor: Colors.white,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FABs.buildCreateFab(context),
      // drawer: const Navbar(),
      // bottomNavigationBar: CustomBottomNavBar(),
      body: SingleChildScrollView(
          child: BlocConsumer<HomeCubit, HomeState>(
        listener: ((context, state) {}),
        builder: (context, state) {
          debugPrint('Home View State is : $state');
          if (state is HomeInitial) {
            // widget.viewModel.getData();
            widget.viewModel.getCards();
            return Container();
          } else if (state is HomeLoading) {
            return _buildLoading();
          } else if (state is HomeSuccess) {
            return _buildSuccess(context, state);
          } else if (state is HomeError) {
            return _buildError(context);
          }
          return Container();
        },
      )),
      bottomNavigationBar: buildBottomNavigationBar,
    ));
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

  Widget _buildSuccess(BuildContext context, HomeSuccess state) {
    return Padding(
      padding: kAllPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: _profileHeader(state.cardResource.data!.length),
          ),
          Padding(
            padding: kVerticalPadding,
            child: _horizontalCards(state.cardResource.data!),
          ),
          Text('Scan History',
              // LocaleKeys.home_myServicesTitle.locale,
              style: CustomTextStyles2.titleLargeTextStyle(context, Colors.black)),
          Padding(
            padding: kVerticalPadding,
            child: _verticalCards(state.cardResource.data!),
          ),
        ],
      ),
    );
  }

  Row _profileHeader(int length) {
    return Row(
      children: [
        Text('My Cards',
            // LocaleKeys.home_servicesTitle.locale,
            style: CustomTextStyles2.titleLargeTextStyle(context, Colors.black)),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('(${length} items)',
              // LocaleKeys.home_servicesTitle.locale,
              style: CustomTextStyles2.titleSmallTextStyle(context, Colors.black)),
        ),
        const Spacer(),
        Icon(Icons.add_circle, color: Colors.black, size: 40),
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

  Widget _horizontalCards(List<CardModel> cards) {
    if (cards.isEmpty) {
      return Column(
        children: [
          Icon(Icons.error_outline, color: CustomColors.bwyYellow),
          const Box(size: BoxSize.EXTRASMALL, type: BoxType.VERTICAL),
          Text(
            'Bulunamadı',
            textAlign: TextAlign.center,
            style: CustomTextStyles2.titleSmallTextStyle(context, Colors.grey),
          )
        ],
      );
    }
    return Container(
        height: 200,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: cards.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final card = cards[index];

            return Padding(
              padding: const EdgeInsets.only(right: 10),
              child: MyContainer(
                backgroundColor: Color(int.parse("0xff${card.cardBgColor}")),
                child: Container(
                  width: 350,
                  child: ListTile(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          card.displayName,
                          style: CustomTextStyles2.titleMediumTextStyle(context, Colors.black),
                        ),
                        Text(
                          card.jobTitle,
                          style: CustomTextStyles2.titleExtraSmallTextStyle(context, CustomColors.mediumGray),
                        ),
                        Box(size: BoxSize.LARGE, type: BoxType.VERTICAL),
                        Text(
                          '${card.websiteUrl}',
                          style: CustomTextStyles2.titleExtraSmallTextStyle(context, CustomColors.darkGray),
                        ),
                      ],
                    ),
                    trailing: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.more_horiz, size: 24),
                        Icon(Icons.close, size: 24),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ));
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
