import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_code_app/bloc/profile_page/profile_cubit.dart';

import '../../bottom_nav_bar.dart';
import '../../constants/constants.dart';
import '../../utils/custom_colors.dart';
import '../../utils/custom_text_styles.dart';
import '../../widget/lottie_widget.dart';
import 'profile_state.dart';

class ProfileView extends StatefulWidget {
  ProfileCubit viewModel;
  ProfileView({super.key, required this.viewModel});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

List<Image> images = [
  Image.asset('assets/images/turkish.png', height: 50, width: 50),
  Image.asset('assets/images/english.png', height: 50, width: 50),
  Image.asset('assets/images/german.png', height: 50, width: 50)
];

List<String> languages = ["Türkçe", "English", "Deutch"];
// List<Map<String, dynamic>> languages = [
//   {'image': Image.asset('assets/images/turkish.png', height: 50, width: 50), 'name': "Türkçe"},
//   {'image': Image.asset('assets/images/english.png', height: 50, width: 50), 'name': "English"},
//   {'image': Image.asset('assets/images/german.png', height: 50, width: 50), 'name': "Deutsch"},
// ];

int dropdownIndex = 0; // otherwise will be assign to the index 0 after clicks

class _ProfileViewState extends State<ProfileView> {
  int _selectedIndex = Pages.PROFILE.index;
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileCubit>(
      create: (context) => widget.viewModel,
      child: _buildScaffold(context),
    );
  }

  SafeArea _buildScaffold(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          // title: Text(LocaleKeys.home_appBarTitle.locale, style: CustomTextStyles2.appBarTextStyle(context)),
          title: Text('Profile', style: CustomTextStyles2.appBarTextStyle(context)),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: BlocConsumer<ProfileCubit, ProfileState>(
          listener: ((context, state) {}),
          builder: (context, state) {
            debugPrint('Scan View State is : $state');
            if (state is ProfileInitial) {
              // widget.viewModel.getData();
              return Container();
            } else if (state is ProfileLoading) {
              return _buildLoading();
            } else if (state is ProfileSuccess) {
              return Container();
            } else if (state is ProfileError) {
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

  Widget _buildSuccess(BuildContext context) {
    return Padding(
      padding: kAllPadding,
      child: Column(
        children: [
          _profileHeader(),
          // Box(size: BoxSize.LARGE, type: BoxType.VERTICAL),
          // _profileBody(),
        ],
      ),
    );
  }

  Row _profileHeader() {
    return Row(
      children: [
        Image.asset('assets/images/user.png', height: 40),
        TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/profile');
            },
            child: Text('${Constants.USER.userName} ${Constants.USER.userSurname}',
                style: CustomTextStyles2.titleSmallTextStyle(context, Colors.white))),
        const Spacer(),
        DropdownButtonHideUnderline(
          child: DropdownButton<Image>(
            value: images[dropdownIndex],
            dropdownColor: Colors.black,
            onChanged: (Image? value) {
              setState(() {
                dropdownIndex = images.indexOf(value!);
                context.setLocale(Localization.SUPPORTED_LANGUAGES[dropdownIndex]);
              });
            },
            items: images.map<DropdownMenuItem<Image>>((Image value) {
              return DropdownMenuItem<Image>(
                value: value,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Row(
                    children: [
                      value,
                      // Box(size: BoxSize.EXTRASMALL, type: BoxType.HORIZONTAL),
                      // Text(languages[images.indexOf(value)],
                      //     style: TextStyle(fontSize: SizeConfig.defaultSize! * 1.7, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        )
      ],
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
