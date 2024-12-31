import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/constants.dart';

import '../../enum/pages_enum.dart';
import '../../models/news_model.dart';
import '../../size_config.dart';
import '../../utils/box_constrains.dart';
import '../../utils/custom_bottom_nav_bar.dart';
import '../../utils/custom_colors.dart';
import '../../utils/custom_text_styles.dart';
import '../../utils/news_card.dart';
import '../../widget/box.dart';
import '../../widget/lottie_widget.dart';
import '../news_page/news_view.dart';
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
  @override
  void initState() {
    super.initState();
    widget.viewModel.getAllNews();
  }

  int _selectedIndex = Pages.HOME.index; // creating index field for our state
  // static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.w600, color: Colors.white);
  // static List<Widget> _widgetOptions = <Widget>[
  //   Text(LocaleKeys.home_appBarTitle.locale, style: optionStyle),
  //   Text(LocaleKeys.about_us_appBarTitle.locale, style: optionStyle),
  //   Text(LocaleKeys.contact_appBarTitle.locale, style: optionStyle),
  //   Text(LocaleKeys.profile_appBarTitle.locale, style: optionStyle),
  // ];

  final int _selectedIndexDrawer = -1;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeCubit>(create: (_) => widget.viewModel, child: _buildScaffold(context));
  }

  SafeArea _buildScaffold(BuildContext context) {
    // debugPrint("important: ${context.locale}");
    SizeConfig().init(context);
    return SafeArea(
        child: BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is HomeNewsDetail) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewsDetailView(news: state.news),
            ),
          ).then((_) {
            // Haber detayından geri dönüldüğünde haber listesini yenile
            context.read<HomeCubit>().getAllNews();
          });
        }
      },
      builder: (context, state) {
        debugPrint('Home View State is : $state');
        if (state is HomeInitial) {
          // widget.viewModel.getAllNews();
          return Container();
        } else if (state is HomeLoading) {
          return _buildLoading(context);
        } else if (state is HomeSuccess) {
          return _buildSuccess(context, state);
        } else if (state is HomeError) {
          return _buildError(context);
        }
        return Container();
      },
    ));
  }

  Widget _buildSuccess(BuildContext context, HomeSuccess state) {
    return Scaffold(
      appBar: AppBar(
        // title: Text(LocaleKeys.home_appBarTitle.locale, style: CustomTextStyles2.appBarTextStyle(context)),
        title: Text('Ana Sayfa', style: CustomTextStyles2.appBarTextStyle(context)),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: Icon(Icons.menu, color: CustomColors.pruBlue),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      backgroundColor: CustomColors.bgGray,
      body: SingleChildScrollView(
        child: Padding(
          padding: kAllPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: _profileHeader(),
              ),
              // Padding(
              //   padding: kVerticalPadding,
              //   child: _horizontalCards(state.pageResource.data!),
              // ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: _profileHeader2(context),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: _profileHeader3(context), //haberler
              ),

              Padding(
                padding: kVerticalPadding,
                child: _horizontalCards2(state.newsResource.data!), //haberler slider
              ),

              // Padding(
              //   padding: kVerticalPadding,
              //   child: _pages(state),
              // ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: _profileHeader4(context),
              ),
              Padding(
                padding: kVerticalPadding,
                child: _container2(),
              ),
              // Padding(
              //   padding: kVerticalPadding,
              //   child: _container(),
              // ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomNavigationBar(
          selectedIndex: _selectedIndex,
          onTabChange: (int index) {
            setState(() {
              _selectedIndex = index;
            });
          }),
      drawer: Drawer(
          child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Color(0xff1E376E),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('PRUSAM', style: CustomTextStyles2.drawerTitleTextStyle(context)),
                Text('PÎRÎ REİS ÜNİVERSİTESİ', style: CustomTextStyles2.drawerTitleTextStyle(context)),
                Text('SÜRDÜRÜLEBİLİRLİK ARAŞTIRMA VE UYGULAMA MERKEZİ',
                    style: CustomTextStyles2.drawerTitleTextStyle(context)),
              ],
            ),
          ),
          ListTile(
            title: const Text('Hakkımızda'),
            selected: _selectedIndexDrawer == 0,
            onTap: () {
              // Update the state of the app
              _onItemTapped(0);
              // Then close the drawer
              Navigator.pushNamed(context, '/aboutUs');
            },
          ),
          ExpansionTile(
            title: const Text('Araştırma'),
            children: <Widget>[
              ListTile(
                contentPadding: const EdgeInsets.only(left: 32.0), // Girinti eklendi
                title: const Text("Avrupa Birliği Projeleri"),
                onTap: () {
                  Navigator.pushNamed(context, '/projectsRoute');
                },
              ),
              ListTile(
                contentPadding: const EdgeInsets.only(left: 32.0),
                title: const Text("Tübitak Projeleri"),
                onTap: () {
                  Navigator.pushNamed(context, '/projhomeects');
                },
              ),
              ListTile(
                contentPadding: const EdgeInsets.only(left: 32.0),
                title: const Text("BAP Projeleri"),
                onTap: () {
                  Navigator.pushNamed(context, '/home');
                },
              ),
              ListTile(
                contentPadding: const EdgeInsets.only(left: 32.0),
                title: const Text("Sanayi-Üniversite İşbirliği Projeleri"),
                onTap: () {
                  Navigator.pushNamed(context, '/home');
                },
              ),
              ListTile(
                contentPadding: const EdgeInsets.only(left: 32.0),
                title: const Text("Diğer Projeler"),
                onTap: () {
                  Navigator.pushNamed(context, '/home');
                },
              ),
            ],
          ),
          ListTile(
            title: const Text('Etkinlikler'),
            onTap: () {
              _onItemTapped(2);
              Navigator.pop(context);
              // Navigator.pushNamed(context, '/sampleReport');
              Navigator.pushNamed(context, '/home');
            },
            selected: _selectedIndexDrawer == 2,
          ),
          ListTile(
            title: const Text('Haberler'),
            onTap: () {
              _onItemTapped(2);
              Navigator.pop(context);
              // Navigator.pushNamed(context, '/sampleReport');
              Navigator.pushNamed(context, '/newsRoute');
            },
            selected: _selectedIndexDrawer == 3,
          ),
          ListTile(
            title: const Text('Bültenler'),
            onTap: () {
              _onItemTapped(2);
              Navigator.pop(context);
              // Navigator.pushNamed(context, '/sampleReport');
              Navigator.pushNamed(context, '/bulletinRoute');
            },
            selected: _selectedIndexDrawer == 4,
          ),
          ListTile(
            title: const Text('Kütüphane'),
            onTap: () {
              _onItemTapped(2);
              Navigator.pop(context);
              Navigator.pushNamed(context, '/home');
            },
            selected: _selectedIndexDrawer == 5,
          ),
          ListTile(
            title: const Text('İletişim'),
            onTap: () {
              _onItemTapped(2);
              Navigator.pop(context);
              Navigator.pushNamed(context, '/contact');
            },
            selected: _selectedIndexDrawer == 6,
          ),
        ],
      )),
    );
  }

  Column _profileHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Araştırma Merkezi',
            // LocaleKeys.home_servicesTitle.locale,
            style: CustomTextStyles2.titleLargeTextStyle(context, Colors.black)),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child:
              Image.network('https://prusam.pirireis.edu.tr/wp-content/uploads/2024/09/Piri-Reis-Universitesi-12.jpg'),
        ),
        const Text(
            'PRUSAM (Piri Reis Üniversitesi Sürdürülebilirlik Araştırma ve Uygulama Merkezi), sürdürülebilirlik ve Net Sıfır hedefleri doğrultusunda çalışmalar yürüten bir araştırma merkezi olarak, denizcilik sektörü başta olmak üzere enerji yönetimi, karbonsuzlaştırma ve dijitalleşme alanlarında yenilikçi çözümler geliştirmeyi amaçlamaktadır. Merkez, sürdürülebilir liman operasyonlarından sektörel dijital dönüşüme kadar geniş bir yelpazede araştırmalar yaparak, çevresel etkilerin azaltılması ve sürdürülebilir kalkınma hedeflerine ulaşılması için stratejiler üretmektedir. PRUSAM, bu alanlardaki akademik bilgi birikimi ve sektörel iş birlikleriyle geleceğin denizcilik ve enerji yönetiminde önemli bir rol oynamayı hedeflemektedir.')
      ],
    );
  }

  // Widget _horizontalCards(List<PageModel> cards) {
  //   if (cards.isEmpty) {
  //     return Column(
  //       children: [
  //         Icon(Icons.error_outline, color: CustomColors.bwyYellow),
  //         const Box(size: BoxSize.EXTRASMALL, type: BoxType.VERTICAL),
  //         Text(
  //           'Bulunamadı',
  //           textAlign: TextAlign.center,
  //           style: CustomTextStyles2.titleSmallTextStyle(context, Colors.grey),
  //         )
  //       ],
  //     );
  //   }
  //   return SizedBox(
  //       height: 200,
  //       child: ListView.builder(
  //         scrollDirection: Axis.horizontal,
  //         itemCount: 4,
  //         shrinkWrap: true,
  //         itemBuilder: (context, index) {
  //           return Padding(
  //             padding: const EdgeInsets.all(8.0),
  //             child: SizedBox(
  //               width: 370,
  //               child: Image.asset('assets/images/slider$index.png', height: 200, fit: BoxFit.fitWidth),
  //             ),
  //           );
  //         },
  //       ));
  // }

  // Widget _pages(HomeSuccess state) {
  //   return SizedBox(
  //     height: 400,
  //     width: 400,
  //     child: ListView.builder(
  //       itemCount: state.pageResource.data!.length,
  //       itemBuilder: (context, index) {
  //         PageModel page = state.pageResource.data![index];
  //         return ListTile(
  //           title: Text(page.pageId.toString()),
  //           subtitle: Text(page.post_title),
  //           onTap: () {
  //             //widget.viewModel.goToDetail(page);
  //           },
  //         );
  //       },
  //     ),
  //   );
  // }

  Widget _profileHeader3(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Haberler',
            // LocaleKeys.home_myServicesTitle.locale,
            style: CustomTextStyles2.titleLargeTextStyle(context, Colors.black)),
        const Text(
            'Modern görselleştirilme teknikleri ile hazırladığımız analizlerimizi okuyucuya daha etkili sunuyoruz. ')
      ],
    );
  }

  Widget _horizontalCards2(List<News> news) {
    if (news.isEmpty) {
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

    return SizedBox(
      height: 266,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: news.length,
        itemBuilder: (context, index) {
          News newsItem = news[index];
          return NewsCard(
            news: newsItem,
            onTap: () {
              context.read<HomeCubit>().showNewsDetail(newsItem); // Buraya istediğiniz fonksiyonu verebilirsiniz
            },
          );
        },
      ),
    );
  }

  Widget _profileHeader2(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Araştırma Alanları',
            // LocaleKeys.home_myServicesTitle.locale,
            style: CustomTextStyles2.titleLargeTextStyle(context, Colors.black)),
        const ExpansionTile(
          title: Text('SEKTÖREL DİJİTALLEŞME'),
          children: <Widget>[
            ListTile(
                title: Text(
                    'Denizcilikte sektörel dijitalleşme, Endüstri 4.0 ile hız kazanan otomasyon, veri analitiği ve yapay zeka gibi teknolojilerin entegrasyonu ile gerçekleşmektedir. Dijital tersaneler, gemi inşa süreçlerinde verimliliği artırırken, akıllı gemiler ve otonom sistemler denizcilik operasyonlarını optimize ederek daha sürdürülebilir ve rekabetçi bir sektör yaratmayı hedefler.'))
          ],
        ),
        const ExpansionTile(
          title: Text('ENERJİ YÖNETİMİ VE ENERJİ VERİMLİLİĞİ'),
          children: <Widget>[
            ListTile(
                title: Text(
                    'Denizcilikte sektörel dijitalleşme, Endüstri 4.0 ile hız kazanan otomasyon, veri analitiği ve yapay zeka gibi teknolojilerin entegrasyonu ile gerçekleşmektedir. Dijital tersaneler, gemi inşa süreçlerinde verimliliği artırırken, akıllı gemiler ve otonom sistemler denizcilik operasyonlarını optimize ederek daha sürdürülebilir ve rekabetçi bir sektör yaratmayı hedefler.'))
          ],
        ),
        const ExpansionTile(
          title: Text('NET SIFIR ÇERÇEVESİ'),
          children: <Widget>[
            ListTile(
                title: Text(
                    'Denizcilikte sektörel dijitalleşme, Endüstri 4.0 ile hız kazanan otomasyon, veri analitiği ve yapay zeka gibi teknolojilerin entegrasyonu ile gerçekleşmektedir. Dijital tersaneler, gemi inşa süreçlerinde verimliliği artırırken, akıllı gemiler ve otonom sistemler denizcilik operasyonlarını optimize ederek daha sürdürülebilir ve rekabetçi bir sektör yaratmayı hedefler.'))
          ],
        ),
        const ExpansionTile(
          title: Text('LİMANLARIN SÜRDÜRÜLEBİLİRLİĞİ'),
          children: <Widget>[
            ListTile(
                title: Text(
                    'Denizcilikte sektörel dijitalleşme, Endüstri 4.0 ile hız kazanan otomasyon, veri analitiği ve yapay zeka gibi teknolojilerin entegrasyonu ile gerçekleşmektedir. Dijital tersaneler, gemi inşa süreçlerinde verimliliği artırırken, akıllı gemiler ve otonom sistemler denizcilik operasyonlarını optimize ederek daha sürdürülebilir ve rekabetçi bir sektör yaratmayı hedefler.'))
          ],
        ),
        const ExpansionTile(
          title: Text('KARBONSUZLAŞTIRMA'),
          children: <Widget>[
            ListTile(
                title: Text(
                    'Denizcilikte sektörel dijitalleşme, Endüstri 4.0 ile hız kazanan otomasyon, veri analitiği ve yapay zeka gibi teknolojilerin entegrasyonu ile gerçekleşmektedir. Dijital tersaneler, gemi inşa süreçlerinde verimliliği artırırken, akıllı gemiler ve otonom sistemler denizcilik operasyonlarını optimize ederek daha sürdürülebilir ve rekabetçi bir sektör yaratmayı hedefler.'))
          ],
        ),
      ],
    );
  }

  Widget _container() {
    return Image.asset('assets/images/graphics.png');
  }

  Widget _profileHeader4(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('İşbirliklerimiz',
            // LocaleKeys.home_myServicesTitle.locale,
            style: CustomTextStyles2.titleLargeTextStyle(context, Colors.black)),
        const Text(
            'Kurduğumuz işbirlikleri, sürdürülebilirlik alanında yenilikçi çözümler üretme ve toplumsal farkındalık yaratma sürecimizi güçlendirmektedir.')
      ],
    );
  }

  Widget _container2() {
    return const Column(
      children: [
        // Image.asset('assets/images/graphics2.png'),
        ExpansionTile(
          title: Text('Kurumlar'),
          subtitle: Text('Kurumlar ile işbirliklerimizi inceleyin'),
          controlAffinity: ListTileControlAffinity.leading,
          children: <Widget>[
            ListTile(title: Text('Kurum 1')),
          ],
        ),
        ExpansionTile(
          title: Text('Şirketler'),
          subtitle: Text('Şİrketler ile işbirliklerimizi inceleyin'),
          controlAffinity: ListTileControlAffinity.leading,
          children: <Widget>[
            ListTile(title: Text('Şirket 1')),
          ],
        ),
        ExpansionTile(
          title: Text('Üniversiteler'),
          subtitle: Text('Üniversiteler ile işbirliklerimizi inceleyin'),
          controlAffinity: ListTileControlAffinity.leading,
          children: <Widget>[
            ListTile(title: Text('Üniversite 1')),
          ],
        ),
      ],
    );
  }

  Widget _buildLoading(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: const Color(0xff315891),
          width: double.infinity,
          height: double.infinity,
        ),
        Align(
          // Ortalamak için eklenen Align widget
          alignment: Alignment.center,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center, // Varsayılan olarak ortalar
            children: [
              const LottieWidget(path: 'compass_loading'),
              const SizedBox(height: 20),
              Text(
                'Yükleniyor..',
                style: CustomTextStyles2.titleMediumTextStyle(context, Colors.white),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildError(BuildContext context) {
    return Scaffold(
        body: Column(
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
    ));
  }
}
