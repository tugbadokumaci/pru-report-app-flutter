import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html_table/flutter_html_table.dart';
import 'package:qr_code_app/bloc/projects_page/projects_cubit.dart';
import 'package:qr_code_app/bloc/projects_page/projects_state.dart';
import 'package:qr_code_app/models/eu_project_model.dart';
import 'package:qr_code_app/utils/eu_news_card.dart';
import 'package:qr_code_app/utils/eu_events_card.dart';

import '../../constants/constants.dart';
import '../../enum/pages_enum.dart';
import '../../utils/custom_bottom_nav_bar.dart';
import '../../utils/custom_colors.dart';
import '../../utils/custom_text_styles.dart';
import '../../utils/eu_projects_card.dart';
import '../../widget/lottie_widget.dart';

class ProjectsView extends StatefulWidget {
  final ProjectsCubit viewModel;

  const ProjectsView({Key? key, required this.viewModel}) : super(key: key);

  @override
  State<ProjectsView> createState() => _ProjectsViewState();
}

class _ProjectsViewState extends State<ProjectsView> {
  @override
  void initState() {
    super.initState();
    widget.viewModel.getAllProjects();
  }

  int _selectedIndex = Pages.HOME.index;

  final int _selectedIndexDrawer = 3;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProjectsCubit>(
      create: (_) => widget.viewModel,
      child: BlocConsumer<ProjectsCubit, ProjectsState>(
        listener: (context, state) {
          if (state is ProjectsDetail) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EUProjectsDetailPage(project: state.project),
              ),
            ).then((_) {
              // Haber detayından geri dönüldüğünde haber listesini yenile
              context.read<ProjectsCubit>().getAllProjects();
            });
          }
        },
        builder: (context, state) {
          if (state is ProjectsLoading) {
            return _buildLoading(context);
          } else if (state is ProjectsSuccess) {
            return _buildSuccess(context, state);
          } else if (state is ProjectsError) {
            return _buildError(context);
          }
          return Container();
        },
      ),
    );
  }

  Widget _buildSuccess(BuildContext context, ProjectsSuccess state) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Projeler', style: TextStyle(color: Colors.black)),
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
      body: Padding(
        padding: kAllPadding,
        child: ListView.builder(
          itemCount: state.projectsResource.data?.length ?? 0,
          itemBuilder: (context, index) {
            EUProjectModel project = state.projectsResource.data![index];
            return EUProjectsCard(
              project: project,
              onTap: () {
                widget.viewModel.showProjectsDetail(project);
              },
            );
          },
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
                title: const Text("Avrupa Birliği Projeleri"),
                onTap: () {
                  Navigator.pushNamed(context, '/projectsRoute');
                },
              ),
              ListTile(
                title: const Text("Tübitak Projeleri"),
                onTap: () {
                  Navigator.pushNamed(context, '/home');
                },
              ),
              ListTile(
                title: const Text("BAP Projeleri"),
                onTap: () {
                  Navigator.pushNamed(context, '/home');
                },
              ),
              ListTile(
                title: const Text("Sanayi-Üniversite İşbirliği Projeleri"),
                onTap: () {
                  Navigator.pushNamed(context, '/home');
                },
              ),
              ListTile(
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
      body: Center(
        child: Text(
          'Bir hata oluştu.',
          style: CustomTextStyles2.titleMediumTextStyle(context, CustomColors.bwyYellow),
        ),
      ),
    );
  }
}

class EUProjectsDetailPage extends StatelessWidget {
  dynamic getEUMetaDataValue(List<EUMetaData?>? metaDataList, String key) {
    if (metaDataList == null) return null;
    for (var metaData in metaDataList) {
      if (metaData != null && metaData.metaKey == key) {
        return metaData.metaValue as String?;
      }
    }
    return null;
  }

  final EUProjectModel project;

  const EUProjectsDetailPage({Key? key, required this.project}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(project.getGeneralInfoValue('Genel-Bilgiler-Baslik') ?? 'Proje Detayı'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: kAllPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Genel Bilgiler', style: CustomStyles.sectionTitle(context)),
              CustomStyles.sectionDivider(),
              const SizedBox(height: 10),
              _buildGeneralInfo(context),
              const SizedBox(height: 20),
              Text('Etkinlikler', style: CustomStyles.sectionTitle(context)),
              CustomStyles.sectionDivider(),
              _buildEvents(context),
              const SizedBox(height: 20),
              Text('Haberler', style: CustomStyles.sectionTitle(context)),
              CustomStyles.sectionDivider(),
              _buildNews(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGeneralInfo(BuildContext context) {
    return Html(
      data: project.getGeneralInfoValue('genel-bilgiler-icerik') ??
          'Genel Bilgiler İçeriği'.replaceAll('\r\n\r\n', '<br>'),
      style: {
        "body": Style(
          color: Colors.black,
          fontSize: FontSize(14),
        ),
      },
      extensions: [
        TagExtension(
          tagsToExtend: {"img"},
          builder: (extensionContext) {
            // Resmin genişlik ve yükseklik oranını koruyarak boyutlandırma
            return Image.network(
              extensionContext.attributes['src']!,
              width: MediaQuery.of(extensionContext.buildContext!).size.width * 0.95,
              fit: BoxFit.contain, // Oranları korur ve küçültür
            );
          },
        ),
      ],
    );
  }

  Widget _buildEvents(BuildContext context) {
    return Padding(
      padding: kAllPadding,
      child: project.events?.isEmpty ?? true
          ? Center(
              child: Text(
                'Etkinlik bulunmamaktadır.',
              ),
            )
          : ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(), // Kaydırma davranışı devre dışı
              itemCount: project.events?.length ?? 0,
              itemBuilder: (context, index) {
                final event = project.events![index]; // eventList yerine event
                return GestureDetector(
                  child: EUEventsCard(
                    event: event,
                    project: project,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EUEventsDetailPage(event: event),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }

  Widget _buildNews(BuildContext context) {
    return Padding(
      padding: kAllPadding,
      child: project.news?.isEmpty ?? true
          ? Center(
              child: Text(
                'Haber bulunmamaktadır.',
              ),
            )
          : ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(), // Kaydırma davranışı devre dışı
              itemCount: project.news?.length ?? 0,
              itemBuilder: (context, index) {
                final news = project.news![index];
                return GestureDetector(
                  child: EUNewsCard(
                    news: news,
                    project: project,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EUNewsDetailPage(news: news),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}

class EUNewsDetailPage extends StatelessWidget {
  dynamic getEUMetaDataValue(List<EUMetaData?>? metaDataList, String key) {
    if (metaDataList == null) return null;
    for (var metaData in metaDataList) {
      if (metaData != null && metaData.metaKey == key) {
        return metaData.metaValue as dynamic;
      }
    }
    return null;
  }

  final List<EUMetaData?>? news;

  const EUNewsDetailPage({Key? key, required this.news}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String appTitle = getEUMetaDataValue(news, 'genel_haberler-basligi') ?? 'App Title';
    String title = getEUMetaDataValue(news, 'haberler-baslik') ?? 'News Title';
    String description = getEUMetaDataValue(news, 'haberler-aciklama') ?? 'News Description';
    List<String> images = (getEUMetaDataValue(news, 'haberler-gorseller') as List<dynamic>?)?.cast<String>() ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text(appTitle),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title),
            Html(
              data: description,
              style: {
                "body": Style(
                  color: Colors.black,
                  fontSize: FontSize(14),
                ),
              },
              extensions: const [TableHtmlExtension()],
            ),
            const SizedBox(height: 16),
            images.isNotEmpty
                ? Column(
                    children: images.map((image) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Image.network(image),
                      );
                    }).toList(),
                  )
                : const Text('No images available'),
          ],
        ),
      ),
    );
  }
}

class EUEventsDetailPage extends StatelessWidget {
  dynamic getEUMetaDataValue(List<EUMetaData?>? metaDataList, String key) {
    if (metaDataList == null) return null;
    for (var metaData in metaDataList) {
      if (metaData != null && metaData.metaKey == key) {
        return metaData.metaValue as dynamic;
      }
    }
    return null;
  }

  final List<EUMetaData?>? event;

  const EUEventsDetailPage({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String appTitle = getEUMetaDataValue(event, 'genel_etkinlik_basligi') ?? 'App Title';
    String title = getEUMetaDataValue(event, 'etkinlik-baslik') ?? 'Event Title';
    String description = getEUMetaDataValue(event, 'etkinlik-icerik') ?? 'Event Description';
    List<String> images = (getEUMetaDataValue(event, 'etkinlik-gorseller') as List<dynamic>).cast<String>() ?? [];
    return Scaffold(
      appBar: AppBar(
        title: Text(appTitle),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title),
            Html(
              data: description.replaceAll('\r\n\r\n', '<br>'),
              style: {
                "body": Style(
                  color: Colors.black,
                  fontSize: FontSize(14),
                ),
                "img": Style(
                  display: Display.inlineBlock, // Resimleri satır içine yerleştirir
                  width: Width(200), // Resim genişliğini %90 ile sınırlar
                ),
              },
              extensions: [
                TagExtension(
                  tagsToExtend: {"img"},
                  builder: (extensionContext) {
                    // Resmin genişlik ve yükseklik oranını koruyarak boyutlandırma
                    return Image.network(
                      extensionContext.attributes['src']!,
                      width: 200,
                      fit: BoxFit.contain, // Oranları korur ve küçültür
                    );
                  },
                ),
              ],
            ),
            SizedBox(height: 16),
            images.isNotEmpty
                ? Column(
                    children: images.map((image) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Image.network(image),
                      );
                    }).toList(),
                  )
                : Text('No images available'),
          ],
        ),
      ),
    );
  }
}
